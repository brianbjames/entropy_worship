// ============================================================
// MIDI-server — client.js
// NTP clock sync + Tone.js sequencer + Web MIDI relay
// ============================================================

// ── AudioContext unlock ──────────────────────────────────────
// Browsers block AudioContext until a user gesture occurs.
// The overlay forces a click before any audio is used.
document.getElementById('unlock-btn').addEventListener('click', async () => {
  await Tone.start();
  document.getElementById('unlock-overlay').style.display = 'none';
  initUI();
});

// ── Clock Sync (NTP-style) ───────────────────────────────────
//
// Protocol:
//   Client → { type:'ping', t0: clientMs }
//   Server → { type:'pong', t0, t1: serverMs, t2: serverMs }
//   Client records t3 = Date.now() on receipt
//
//   RTT    = (t3 - t0) - (t2 - t1)
//   offset = ((t1 - t0) + (t2 - t3)) / 2
//            (add to Date.now() to get server time)
//
// We keep 8 samples and use the median to reduce outliers.

let serverTimeOffset = 0;  // ms: Date.now() + offset ≈ serverTime
let rttMs = 0;
const syncSamples = [];

function sendPing() {
  if (ws.readyState === WebSocket.OPEN) {
    ws.send(JSON.stringify({ type: 'ping', t0: Date.now() }));
  }
}

function handlePong({ t0, t1, t2 }) {
  const t3 = Date.now();
  rttMs = (t3 - t0) - (t2 - t1);
  const sample = ((t1 - t0) + (t2 - t3)) / 2;
  syncSamples.push(sample);
  if (syncSamples.length > 8) syncSamples.shift();
  const sorted = [...syncSamples].sort((a, b) => a - b);
  serverTimeOffset = sorted[Math.floor(sorted.length / 2)];

  document.getElementById('latency').textContent    = `${Math.round(rttMs / 2)} ms`;
  document.getElementById('clock-offset').textContent = `Δ${Math.round(serverTimeOffset)} ms`;
}

/**
 * Convert a server-side Date.now() timestamp (ms) to an
 * AudioContext time (seconds) for use with Tone.js scheduling.
 */
function serverToAudio(serverMs) {
  const localMs = serverMs - serverTimeOffset;
  return Tone.context.currentTime + (localMs - Date.now()) / 1000;
}

// ── Sequencer State ──────────────────────────────────────────
const TRACKS = ['kick', 'snare', 'hihat', 'synth'];
const LABELS  = { kick: 'Kick', snare: 'Snare', hihat: 'Hi-Hat', synth: 'Synth' };
const COLORS  = { kick: '#e74c3c', snare: '#3498db', hihat: '#f1c40f', synth: '#2ecc71' };

const state = {
  playing:     false,
  bpm:         120,
  currentStep: -1,
  steps: {
    kick:  [1,0,0,0, 1,0,0,0, 1,0,0,0, 1,0,0,0],
    snare: [0,0,0,0, 1,0,0,0, 0,0,0,0, 1,0,0,0],
    hihat: [1,0,1,0, 1,0,1,0, 1,0,1,0, 1,0,1,0],
    synth: [0,0,0,0, 0,0,0,0, 0,0,0,0, 0,0,0,0],
  },
};

// ── Tone.js Instruments ──────────────────────────────────────
const kickSynth = new Tone.MembraneSynth({
  pitchDecay: 0.05, octaves: 6,
  envelope: { attack: 0.001, decay: 0.25, sustain: 0, release: 0.1 },
}).toDestination();

const snareSynth = new Tone.NoiseSynth({
  noise: { type: 'white' },
  envelope: { attack: 0.001, decay: 0.13, sustain: 0, release: 0.05 },
}).toDestination();

const hihatSynth = new Tone.MetalSynth({
  frequency: 400, harmonicity: 5.1, modulationIndex: 32,
  resonance: 4000, octaves: 1.5,
  envelope: { attack: 0.001, decay: 0.04, release: 0.01 },
}).toDestination();

const padSynth = new Tone.PolySynth(Tone.Synth, {
  oscillator: { type: 'triangle' },
  envelope: { attack: 0.02, decay: 0.1, sustain: 0.4, release: 0.2 },
}).toDestination();

kickSynth.volume.value  = -4;
snareSynth.volume.value = -10;
hihatSynth.volume.value = -12;
padSynth.volume.value   = -8;

// One note per 16th-step position for the synth track
const SCALE_NOTES = ['C4','D4','E4','G4','A4','C5','D5','E5',
                     'G5','A5','C4','D4','E4','G4','A4','C5'];

function fireStep(track, step, time) {
  switch (track) {
    case 'kick':  kickSynth.triggerAttackRelease('C1', '8n', time);              break;
    case 'snare': snareSynth.triggerAttackRelease('8n', time);                   break;
    case 'hihat': hihatSynth.triggerAttackRelease('32n', time);                  break;
    case 'synth': padSynth.triggerAttackRelease(SCALE_NOTES[step], '8n', time);  break;
  }
}

// ── Epoch-based scheduler ────────────────────────────────────
//
// Instead of Tone.Transport (which drifts independently on each client),
// every step is derived from a shared Unix epoch:
//
//   step index  = floor((serverNow - epochMs) / stepMs)
//   step time   = epochMs + index * stepMs   (as AudioContext seconds)
//
// Each client independently calculates "what step is due next" from the
// same epoch, so they self-correct on every beat rather than drifting.

const LOOKAHEAD_MS  = 100;  // schedule this far ahead of wall clock
const SCHEDULER_MS  = 20;   // how often the scheduler ticks

let epochMs          = null; // server Unix ms that step 0 starts at
let schedulerTimer   = null;
let lastScheduledIdx = -1;   // absolute (non-wrapping) step index

function stepDurationMs() {
  return (60 / state.bpm) * 1000 / 4;  // duration of one 16th note in ms
}

function schedulerTick() {
  if (epochMs === null) return;

  const serverNow  = Date.now() + serverTimeOffset;
  const stepMs     = stepDurationMs();
  const horizonIdx = Math.floor((serverNow + LOOKAHEAD_MS - epochMs) / stepMs);

  for (let idx = Math.max(0, lastScheduledIdx + 1); idx <= horizonIdx; idx++) {
    const step       = idx % 16;
    const stepServerMs = epochMs + idx * stepMs;
    const audioT     = serverToAudio(stepServerMs);

    if (audioT < Tone.context.currentTime) continue;  // already passed

    TRACKS.forEach(track => {
      if (state.steps[track][step]) fireStep(track, step, audioT);
    });

    lastScheduledIdx = idx;
  }
}

function startSequencer(epoch) {
  stopSequencer(/* updateUI= */ false);
  epochMs = epoch;
  // Start the index just before now so the first tick schedules the right step
  lastScheduledIdx = Math.floor(
    (Date.now() + serverTimeOffset - epochMs) / stepDurationMs()
  ) - 1;
  schedulerTick();  // immediate first pass
  schedulerTimer = setInterval(schedulerTick, SCHEDULER_MS);
  state.playing  = true;
  updateTransportUI();
}

function stopSequencer(updateUI = true) {
  if (schedulerTimer) { clearInterval(schedulerTimer); schedulerTimer = null; }
  epochMs          = null;
  lastScheduledIdx = -1;
  state.playing    = false;
  state.currentStep = -1;
  if (updateUI) updateTransportUI();
}

// ── UI ───────────────────────────────────────────────────────
function buildGrid() {
  const container = document.getElementById('sequencer');
  container.innerHTML = '';

  TRACKS.forEach(track => {
    const row = document.createElement('div');
    row.className = 'row';

    const lbl = document.createElement('span');
    lbl.className = 'lbl';
    lbl.textContent = LABELS[track];
    lbl.style.borderLeftColor = COLORS[track];
    row.appendChild(lbl);

    const grid = document.createElement('div');
    grid.className = 'grid';

    for (let i = 0; i < 16; i++) {
      const btn = document.createElement('button');
      btn.className = 'cell' + (state.steps[track][i] ? ' on' : '') + (i % 4 === 0 ? ' beat' : '');
      btn.dataset.t = track;
      btn.dataset.s = i;
      btn.style.setProperty('--c', COLORS[track]);

      btn.addEventListener('click', () => {
        const v = state.steps[track][i] ? 0 : 1;
        state.steps[track][i] = v;
        btn.classList.toggle('on', !!v);
        ws.send(JSON.stringify({ type: 'step', track, step: i, value: v }));
      });

      grid.appendChild(btn);
    }
    row.appendChild(grid);
    container.appendChild(row);
  });
}

// RAF loop: derives the visual playhead position from the epoch,
// independently of the audio scheduler, so display and audio stay locked.
let prevDisplayStep = -1;
function renderLoop() {
  if (epochMs !== null && state.playing) {
    const serverNow = Date.now() + serverTimeOffset;
    const elapsed   = serverNow - epochMs;
    state.currentStep = elapsed >= 0 ? Math.floor(elapsed / stepDurationMs()) % 16 : -1;
  }

  const s = state.currentStep;
  if (s !== prevDisplayStep) {
    document.querySelectorAll('.cell').forEach(c => {
      c.classList.toggle('now', parseInt(c.dataset.s) === s);
    });
    prevDisplayStep = s;
  }
  requestAnimationFrame(renderLoop);
}

function updateTransportUI() {
  document.getElementById('play-btn').disabled = state.playing;
  document.getElementById('stop-btn').disabled = !state.playing;
}

// ── WebSocket connection ─────────────────────────────────────
// In production: set this to your Railway URL, e.g.:
//   const WS_SERVER = 'wss://jam-sync-production.up.railway.app';
// Leave as null to connect to the same host (local dev).
const WS_SERVER = 'wss://midi-server-production.up.railway.app';

const wsProto = location.protocol === 'https:' ? 'wss:' : 'ws:';
const wsUrl   = WS_SERVER || `${wsProto}//${location.host}`;
const ws = new WebSocket(wsUrl);

ws.onopen = () => {
  document.getElementById('status').className   = 'connected';
  document.getElementById('status').textContent = 'connected';
  sendPing();
  setInterval(sendPing, 4000);
};
ws.onclose = () => {
  document.getElementById('status').className   = 'disconnected';
  document.getElementById('status').textContent = 'disconnected';
};
ws.onerror = () => {
  document.getElementById('status').textContent = 'error';
};

ws.onmessage = ({ data }) => {
  const msg = JSON.parse(data);
  switch (msg.type) {

    case 'pong':
      handlePong(msg);
      break;

    // Server sends full state on connect
    case 'state':
      state.bpm   = msg.bpm;
      state.steps = msg.steps;
      document.getElementById('bpm').value        = msg.bpm;
      document.getElementById('bpm-val').textContent = msg.bpm;
      if (document.getElementById('sequencer').children.length) buildGrid();
      // Sync into a running session on late join
      if (msg.playing && msg.epoch) startSequencer(msg.epoch);
      break;

    case 'play':
      startSequencer(msg.epoch);
      break;

    case 'stop':
      stopSequencer();
      break;

    case 'bpm':
      state.bpm = msg.bpm;
      document.getElementById('bpm').value          = msg.bpm;
      document.getElementById('bpm-val').textContent = msg.bpm;
      break;

    case 'step': {
      state.steps[msg.track][msg.step] = msg.value;
      const cell = document.querySelector(`.cell[data-t="${msg.track}"][data-s="${msg.step}"]`);
      if (cell) cell.classList.toggle('on', !!msg.value);
      break;
    }

    case 'clients':
      document.getElementById('players').textContent =
        `${msg.count} player${msg.count !== 1 ? 's' : ''}`;
      break;

    // MIDI relayed from another client → handle locally
    case 'midi':
      if (Array.isArray(msg.data)) handleMidiData(msg.data, /* remote= */ true);
      break;
  }
};

// ── Controls (wired after unlock) ───────────────────────────
function initUI() {
  // Apply any state already received before unlock
  document.getElementById('bpm').value          = state.bpm;
  document.getElementById('bpm-val').textContent = state.bpm;
  buildGrid();
  renderLoop();
  updateTransportUI();

  document.getElementById('play-btn').addEventListener('click', () => {
    ws.send(JSON.stringify({ type: 'play' }));
  });

  document.getElementById('stop-btn').addEventListener('click', () => {
    ws.send(JSON.stringify({ type: 'stop' }));
  });

  document.getElementById('bpm').addEventListener('input', e => {
    const bpm = +e.target.value;
    state.bpm = bpm;
    Tone.Transport.bpm.value = bpm;
    document.getElementById('bpm-val').textContent = bpm;
    ws.send(JSON.stringify({ type: 'bpm', bpm }));
  });

  document.getElementById('midi-btn').addEventListener('click', async () => {
    if (!navigator.requestMIDIAccess) {
      alert('Web MIDI is not supported in this browser.\nTry Chrome or Edge.');
      return;
    }
    try {
      const access = await navigator.requestMIDIAccess({ sysex: false });
      const btn = document.getElementById('midi-btn');
      btn.textContent = 'MIDI';
      btn.classList.add('active');
      btn.disabled = true;

      populateMidiDevices(access);

      // Update device list when devices are plugged/unplugged
      access.onstatechange = () => populateMidiDevices(access);
    } catch (err) {
      alert('MIDI access denied: ' + err.message);
    }
  });
}

// ── Web MIDI ─────────────────────────────────────────────────
let midiAccess     = null;
let selectedPortId = null;
let clockTickTimes = [];

// MIDI note number → name (e.g. 60 → "C4")
function midiNoteName(n) {
  return ['C','C#','D','D#','E','F','F#','G','G#','A','A#','B'][n % 12] + (Math.floor(n / 12) - 1);
}

function populateMidiDevices(access) {
  midiAccess = access;
  const select   = document.getElementById('midi-device');
  const prevVal  = select.value;

  select.innerHTML = '<option value="">— select device —</option>';
  access.inputs.forEach(port => {
    const opt = document.createElement('option');
    opt.value = port.id;
    opt.textContent = port.name + (port.state === 'disconnected' ? ' (disconnected)' : '');
    select.appendChild(opt);
  });

  if (prevVal && [...access.inputs.keys()].includes(prevVal)) select.value = prevVal;
  select.style.display = access.inputs.size > 0 ? 'inline-block' : 'none';
  selectMidiDevice(select.value);
}

function selectMidiDevice(portId) {
  if (!midiAccess) return;
  selectedPortId = portId;
  midiAccess.inputs.forEach(port => { port.onmidimessage = null; });
  if (portId) {
    const port = midiAccess.inputs.get(portId);
    if (port) port.onmidimessage = onMidiMessage;
  }
}

document.getElementById('midi-device').addEventListener('change', e => {
  selectMidiDevice(e.target.value);
});

// ── Unified MIDI handler (local + remote) ────────────────────
function handleMidiData(bytes, remote) {
  const status  = bytes[0];
  const msgType = status & 0xf0;
  const ch      = (status & 0x0f) + 1;   // 1-based
  const d1      = bytes[1] ?? 0;
  const d2      = bytes[2] ?? 0;

  switch (msgType) {

    case 0x90:  // Note On
      if (d2 > 0) {
        remote
          ? padSynth.triggerAttackRelease(Tone.Frequency(d1, 'midi').toFrequency(), '8n')
          : padSynth.triggerAttackRelease(Tone.Frequency(d1, 'midi').toFrequency(), '8n', Tone.now(), d2 / 127);
        logMidiRow('Note On',  ch, midiNoteName(d1), `v:${d2}`, remote);
        break;
      }
      // velocity 0 = Note Off, fall through

    case 0x80:  // Note Off
      logMidiRow('Note Off', ch, midiNoteName(d1), '', remote);
      break;

    case 0xB0:  // Control Change
      handleCC(ch, d1, d2, remote);
      break;

    case 0xC0:  // Program Change
      logMidiRow('PGM', ch, `#${d1 + 1}`, '', remote);
      break;

    case 0xD0:  // Channel Pressure
      logMidiRow('Pressure', ch, `v:${d1}`, '', remote);
      break;

    case 0xE0: { // Pitch Bend  (-8192 … +8191)
      const bend = ((d2 << 7) | d1) - 8192;
      padSynth.set({ detune: (bend / 8192) * 200 });  // ±200 cents
      logMidiRow('Pitch', ch, bend >= 0 ? `+${bend}` : `${bend}`, '', remote);
      break;
    }

    case 0xF0:  // System Real-Time / SysEx
      handleSysMsg(status, remote);
      break;
  }
}

function handleCC(ch, cc, val, remote) {
  switch (cc) {
    case 1:           // Mod wheel → subtle detune
      padSynth.set({ detune: (val / 127) * 50 });
      break;
    case 7:           // Channel Volume
    case 11:          // Expression
      padSynth.volume.value = -40 + (val / 127) * 32;
      break;
    case 120:         // All Sound Off
    case 123:         // All Notes Off
      padSynth.releaseAll();
      break;
  }
  logMidiRow('CC', ch, `#${cc}`, `v:${val}`, remote);
}

function handleSysMsg(status, remote) {
  switch (status) {
    case 0xF8: {  // MIDI Clock tick — 24 per beat, measure locally only
      const now = performance.now();
      clockTickTimes.push(now);
      if (clockTickTimes.length > 24) clockTickTimes.shift();
      return;  // never log or relay clock ticks
    }
    case 0xFA: logMidiRow('Clock', null, 'Start',    '', remote); break;
    case 0xFB: logMidiRow('Clock', null, 'Continue', '', remote); break;
    case 0xFC:
      clockTickTimes = [];
      logMidiRow('Clock', null, 'Stop', '', remote);
      break;
    case 0xFE: return;  // Active Sensing — ignore
    case 0xFF: logMidiRow('Sys',   null, 'Reset',    '', remote); break;
  }
}

function logMidiRow(label, ch, val1, val2, remote) {
  const el  = document.getElementById('midi-log');
  const div = document.createElement('div');
  div.className = 'mlog' + (remote ? ' rem' : '');
  const chStr = ch != null ? `ch${String(ch).padStart(2)}` : '    ';
  div.textContent = `${remote ? '←' : '→'} ${label.padEnd(8)} ${chStr}  ${val1}${val2 ? '  ' + val2 : ''}`;
  el.prepend(div);
  if (el.children.length > 20) el.removeChild(el.lastChild);
}

function onMidiMessage(e) {
  const bytes  = Array.from(e.data);
  const status = bytes[0];

  // MIDI Clock and Active Sensing: handle locally, never relay
  if (status === 0xF8 || status === 0xFE) {
    handleSysMsg(status, false);
    return;
  }

  handleMidiData(bytes, /* remote= */ false);

  if (ws.readyState === WebSocket.OPEN) {
    ws.send(JSON.stringify({ type: 'midi', data: bytes }));
  }
}

// Transport UI disabled on load (before unlock)
updateTransportUI();
