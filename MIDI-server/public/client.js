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

// ── Sequencer Transport ──────────────────────────────────────
let seq = null;

function startSequencer(audioStartTime) {
  stopSequencer(/* updateUI= */ false);
  Tone.Transport.bpm.value = state.bpm;
  Tone.Transport.cancel();

  seq = new Tone.Sequence((time, step) => {
    state.currentStep = step;
    TRACKS.forEach(track => {
      if (state.steps[track][step]) fireStep(track, step, time);
    });
  }, [...Array(16).keys()], '16n');

  seq.start(0);
  // Clamp: never schedule in the past
  const at = Math.max(audioStartTime, Tone.context.currentTime + 0.05);
  Tone.Transport.start(at);
  state.playing = true;
  updateTransportUI();
}

function stopSequencer(updateUI = true) {
  Tone.Transport.stop();
  Tone.Transport.cancel();
  if (seq) { seq.stop(); seq.dispose(); seq = null; }
  state.playing     = false;
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

// RAF loop: syncs the playhead highlight to audio scheduling
let prevDisplayStep = -1;
function renderLoop() {
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

function logMidi(note, vel, remote) {
  const el  = document.getElementById('midi-log');
  const div = document.createElement('div');
  div.className = 'mlog' + (remote ? ' rem' : '');
  div.textContent = `${remote ? '← ' : '→ '}note ${note}  vel ${vel}`;
  el.prepend(div);
  if (el.children.length > 16) el.removeChild(el.lastChild);
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
      // Grid may not exist yet if unlock hasn't happened
      if (document.getElementById('sequencer').children.length) buildGrid();
      break;

    case 'play': {
      const at = serverToAudio(msg.startAt);
      startSequencer(at);
      break;
    }
    case 'stop':
      stopSequencer();
      break;

    case 'bpm':
      state.bpm = msg.bpm;
      Tone.Transport.bpm.value = msg.bpm;
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

    // MIDI note relayed from another client → play locally
    case 'midi':
      if (msg.midiType === 'noteon') {
        padSynth.triggerAttackRelease(
          Tone.Frequency(msg.note, 'midi').toFrequency(), '8n'
        );
        logMidi(msg.note, msg.velocity, /* remote= */ true);
      }
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
      const access = await navigator.requestMIDIAccess();
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

// ── Web MIDI input ───────────────────────────────────────────
let midiAccess = null;
let selectedPortId = null;  // null = no device selected

function populateMidiDevices(access) {
  midiAccess = access;
  const select = document.getElementById('midi-device');
  const prevValue = select.value;

  // Rebuild options
  select.innerHTML = '<option value="">— select device —</option>';
  access.inputs.forEach(port => {
    const opt = document.createElement('option');
    opt.value = port.id;
    opt.textContent = port.name;
    if (port.state === 'disconnected') opt.textContent += ' (disconnected)';
    select.appendChild(opt);
  });

  // Restore previous selection if still available
  if (prevValue && [...access.inputs.keys()].includes(prevValue)) {
    select.value = prevValue;
  }

  select.style.display = access.inputs.size > 0 ? 'inline-block' : 'none';

  // Re-attach listener to whichever port is selected
  selectMidiDevice(select.value);
}

function selectMidiDevice(portId) {
  if (!midiAccess) return;
  selectedPortId = portId;

  // Detach from all ports first
  midiAccess.inputs.forEach(port => { port.onmidimessage = null; });

  // Attach to selected port only
  if (portId) {
    const port = midiAccess.inputs.get(portId);
    if (port) port.onmidimessage = onMidiMessage;
  }
}

document.getElementById('midi-device').addEventListener('change', e => {
  selectMidiDevice(e.target.value);
});

function onMidiMessage(e) {
  const [status, note, vel] = e.data;
  const type = status & 0xf0;

  // Note On (with non-zero velocity)
  if (type === 0x90 && vel > 0) {
    padSynth.triggerAttackRelease(
      Tone.Frequency(note, 'midi').toFrequency(), '8n', Tone.now(), vel / 127
    );
    logMidi(note, vel, /* remote= */ false);
    ws.send(JSON.stringify({ type: 'midi', midiType: 'noteon', note, velocity: vel }));
  }
  // Note Off (or Note On with vel=0)
  else if (type === 0x80 || (type === 0x90 && vel === 0)) {
    ws.send(JSON.stringify({ type: 'midi', midiType: 'noteoff', note, velocity: 0 }));
  }
}

// Transport UI disabled on load (before unlock)
updateTransportUI();
