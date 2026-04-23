// ============================================================
// MIDI-server — client.js
// NTP clock sync + Tone.js sequencer + Web MIDI relay
// ============================================================

// ── AudioContext unlock ──────────────────────────────────────
document.getElementById('unlock-btn').addEventListener('click', async () => {
  await Tone.start();
  document.getElementById('unlock-overlay').style.display = 'none';
  initUI();
});

// ── Clock Sync (NTP-style) ───────────────────────────────────
let serverTimeOffset = 0;
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

  document.getElementById('latency').textContent     = `${Math.round(rttMs / 2)} ms`;
  document.getElementById('clock-offset').textContent = `Δ${Math.round(serverTimeOffset)} ms`;

  // Report RTT to server so it can broadcast to all peers in the room
  if (ws.readyState === WebSocket.OPEN) {
    ws.send(JSON.stringify({ type: 'latency', rtt: rttMs }));
  }
}

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

// ── Session state ────────────────────────────────────────────
let myClientId        = null;
let clockRelayEnabled = false;

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
const LOOKAHEAD_MS = 100;
const SCHEDULER_MS = 20;

let epochMs          = null;
let schedulerTimer   = null;
let lastScheduledIdx = -1;

function stepDurationMs() {
  return (60 / state.bpm) * 1000 / 4;
}

function schedulerTick() {
  if (epochMs === null) return;
  const serverNow  = Date.now() + serverTimeOffset;
  const stepMs     = stepDurationMs();
  const horizonIdx = Math.floor((serverNow + LOOKAHEAD_MS - epochMs) / stepMs);

  for (let idx = Math.max(0, lastScheduledIdx + 1); idx <= horizonIdx; idx++) {
    const step        = idx % 16;
    const stepServerMs = epochMs + idx * stepMs;
    const audioT      = serverToAudio(stepServerMs);
    if (audioT < Tone.context.currentTime) continue;
    TRACKS.forEach(track => {
      if (state.steps[track][step]) fireStep(track, step, audioT);
    });
    lastScheduledIdx = idx;
  }
}

function startSequencer(epoch) {
  stopSequencer(false);
  epochMs = epoch;
  lastScheduledIdx = Math.floor(
    (Date.now() + serverTimeOffset - epochMs) / stepDurationMs()
  ) - 1;
  schedulerTick();
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

let prevDisplayStep = -1;
function renderLoop() {
  if (epochMs !== null && state.playing) {
    const elapsed = Date.now() + serverTimeOffset - epochMs;
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
const WS_SERVER = 'wss://midi-server-production.up.railway.app';
const ROOM      = new URLSearchParams(location.search).get('room') || 'default';

// ── Room join — wired immediately, no unlock required ────────
document.getElementById('room-input').value = ROOM;
document.getElementById('room-join-btn').addEventListener('click', () => {
  const name = document.getElementById('room-input').value
    .trim().replace(/[^a-zA-Z0-9_-]/g, '').slice(0, 32) || 'default';
  location.search = `?room=${encodeURIComponent(name)}`;
});
document.getElementById('room-input').addEventListener('keydown', e => {
  if (e.key === 'Enter') document.getElementById('room-join-btn').click();
});

const wsProto = location.protocol === 'https:' ? 'wss:' : 'ws:';
const wsBase  = WS_SERVER || `${wsProto}//${location.host}`;
const wsUrl   = `${wsBase}?room=${encodeURIComponent(ROOM)}`;
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

    case 'state':
      myClientId        = msg.clientId;
      clockRelayEnabled = msg.clockRelay || false;
      state.bpm   = msg.bpm;
      state.steps = msg.steps;
      document.getElementById('bpm').value          = msg.bpm;
      document.getElementById('bpm-val').textContent = msg.bpm;
      document.getElementById('room-name').textContent = msg.room || ROOM;
      document.getElementById('clock-relay-btn').classList.toggle('active', clockRelayEnabled);
      if (document.getElementById('sequencer').children.length) buildGrid();
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
      document.getElementById('bpm').value           = msg.bpm;
      document.getElementById('bpm-val').textContent = msg.bpm;
      break;

    case 'step': {
      state.steps[msg.track][msg.step] = msg.value;
      const cell = document.querySelector(`.cell[data-t="${msg.track}"][data-s="${msg.step}"]`);
      if (cell) cell.classList.toggle('on', !!msg.value);
      break;
    }

    case 'peers': {
      const count = msg.count || msg.peers.length;
      document.getElementById('players').textContent =
        `${count} player${count !== 1 ? 's' : ''}`;
      const bar = document.getElementById('peers-bar');
      bar.innerHTML = msg.peers.map(p => {
        const ms  = p.rtt > 0 ? Math.round(p.rtt / 2) : null;
        const cls = ['peer', p.id === myClientId ? 'me' : '', ms != null && ms > 150 ? 'peer-hi' : ''].filter(Boolean).join(' ');
        const label = p.id === myClientId ? 'you' : `p${p.id}`;
        const latStr = ms != null ? `<span class="peer-rtt"> ${ms}ms</span>` : '';
        return `<span class="${cls}">${label}${latStr}</span>`;
      }).join('');
      break;
    }

    case 'clockRelay':
      clockRelayEnabled = msg.enabled;
      document.getElementById('clock-relay-btn').classList.toggle('active', clockRelayEnabled);
      break;

    case 'midi':
      if (Array.isArray(msg.data)) handleMidiData(msg.data, /* remote= */ true);
      break;
  }
};

// ── Controls ────────────────────────────────────────────────
function initUI() {
  document.getElementById('bpm').value           = state.bpm;
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
    document.getElementById('bpm-val').textContent = bpm;
    ws.send(JSON.stringify({ type: 'bpm', bpm }));
  });

  document.getElementById('panic-btn').addEventListener('click', panic);

  // Clock relay
  document.getElementById('clock-relay-btn').addEventListener('click', () => {
    clockRelayEnabled = !clockRelayEnabled;
    document.getElementById('clock-relay-btn').classList.toggle('active', clockRelayEnabled);
    ws.send(JSON.stringify({ type: 'clockRelay', enabled: clockRelayEnabled }));
  });

  // MIDI access
  document.getElementById('midi-btn').addEventListener('click', async () => {
    if (!navigator.requestMIDIAccess) {
      alert('Web MIDI is not supported in this browser.\nTry Chrome or Edge.');
      return;
    }
    try {
      const access = await navigator.requestMIDIAccess({ sysex: true });
      const btn = document.getElementById('midi-btn');
      btn.textContent = 'MIDI';
      btn.classList.add('active');
      btn.disabled = true;

      populateMidiDevices(access);
      populateMidiOutputs(access);
      populateChannelSelects();
      document.getElementById('clock-relay-btn').style.display = 'inline-block';

      access.onstatechange = () => {
        populateMidiDevices(access);
        populateMidiOutputs(access);
      };
    } catch (err) {
      alert('MIDI access denied: ' + err.message);
    }
  });

  // Virtual keyboard
  const vkbCh = document.getElementById('vkb-ch');
  for (let i = 1; i <= 16; i++) {
    const opt = document.createElement('option');
    opt.value = i;
    opt.textContent = `ch ${i}`;
    vkbCh.appendChild(opt);
  }
  buildVirtualKeyboard();
  document.getElementById('vkb-oct').addEventListener('change', buildVirtualKeyboard);
  document.getElementById('vkb-vel').addEventListener('input', e => {
    document.getElementById('vkb-vel-val').textContent = e.target.value;
  });

  // Recording
  document.getElementById('rec-btn').addEventListener('click', startRecording);
  document.getElementById('rec-stop-btn').addEventListener('click', stopRecording);
  document.getElementById('rec-export-btn').addEventListener('click', exportMid);
}

// ── Web MIDI ─────────────────────────────────────────────────
let midiAccess      = null;
let selectedInputId = null;
let selectedOutput  = null;
let thruEnabled     = false;
let filterChannel   = 0;
let remapChannel    = 0;
let clockTickTimes  = [];

function midiNoteName(n) {
  return ['C','C#','D','D#','E','F','F#','G','G#','A','A#','B'][n % 12] + (Math.floor(n / 12) - 1);
}

// ── Input devices ────────────────────────────────────────────
function populateMidiDevices(access) {
  midiAccess = access;
  const select  = document.getElementById('midi-input-device');
  const prevVal = select.value || localStorage.getItem('midi-input-id') || '';
  select.innerHTML = '<option value="">— input —</option>';
  access.inputs.forEach(port => {
    const opt = document.createElement('option');
    opt.value = port.id;
    opt.textContent = port.name + (port.state === 'disconnected' ? ' (disconnected)' : '');
    select.appendChild(opt);
  });
  if (prevVal && [...access.inputs.keys()].includes(prevVal)) select.value = prevVal;
  select.style.display = access.inputs.size > 0 ? 'inline-block' : 'none';
  selectMidiInput(select.value);
}

function selectMidiInput(portId) {
  if (!midiAccess) return;
  selectedInputId = portId;
  if (portId) localStorage.setItem('midi-input-id', portId);
  else localStorage.removeItem('midi-input-id');
  midiAccess.inputs.forEach(port => { port.onmidimessage = null; });
  if (portId) {
    const port = midiAccess.inputs.get(portId);
    if (port) port.onmidimessage = onMidiMessage;
  }
}

document.getElementById('midi-input-device').addEventListener('change', e => {
  selectMidiInput(e.target.value);
});

// ── Output devices ────────────────────────────────────────────
function populateMidiOutputs(access) {
  const select  = document.getElementById('midi-output-device');
  const prevVal = select.value || localStorage.getItem('midi-output-id') || '';
  const arrow   = document.getElementById('midi-arrow');
  select.innerHTML = '<option value="">— output —</option>';
  access.outputs.forEach(port => {
    const opt = document.createElement('option');
    opt.value = port.id;
    opt.textContent = port.name + (port.state === 'disconnected' ? ' (disconnected)' : '');
    select.appendChild(opt);
  });
  const hasOutputs = access.outputs.size > 0;
  select.style.display = hasOutputs ? 'inline-block' : 'none';
  arrow.style.display  = hasOutputs ? 'inline' : 'none';
  document.getElementById('thru-btn').style.display = hasOutputs ? 'inline-block' : 'none';
  if (prevVal && [...access.outputs.keys()].includes(prevVal)) select.value = prevVal;
  selectMidiOutput(select.value);
}

function selectMidiOutput(portId) {
  if (!midiAccess) return;
  selectedOutput = portId ? (midiAccess.outputs.get(portId) || null) : null;
  if (portId) localStorage.setItem('midi-output-id', portId);
  else localStorage.removeItem('midi-output-id');
}

function sendToOutput(bytes) {
  if (selectedOutput && selectedOutput.state !== 'disconnected') {
    try { selectedOutput.send(bytes); } catch (_) {}
  }
}

document.getElementById('midi-output-device').addEventListener('change', e => {
  selectMidiOutput(e.target.value);
});

document.getElementById('thru-btn').addEventListener('click', () => {
  thruEnabled = !thruEnabled;
  document.getElementById('thru-btn').classList.toggle('active', thruEnabled);
});

// ── Panic ─────────────────────────────────────────────────────
function panic() {
  padSynth.releaseAll();
  if (selectedOutput) {
    for (let ch = 0; ch < 16; ch++) {
      selectedOutput.send([0xB0 | ch, 120, 0]);
      selectedOutput.send([0xB0 | ch, 123, 0]);
    }
  }
}

// ── Channel filter / remap ────────────────────────────────────
function populateChannelSelects() {
  ['filter-ch', 'remap-ch'].forEach(id => {
    const sel = document.getElementById(id);
    while (sel.options.length > 1) sel.remove(1);
    for (let i = 1; i <= 16; i++) {
      const opt = document.createElement('option');
      opt.value = i;
      opt.textContent = `ch ${i}`;
      sel.appendChild(opt);
    }
  });
  document.getElementById('midi-channel-row').style.display = 'flex';
}

document.getElementById('filter-ch').addEventListener('change', e => {
  filterChannel = +e.target.value;
});
document.getElementById('remap-ch').addEventListener('change', e => {
  remapChannel = +e.target.value;
});

// ── Unified MIDI handler ─────────────────────────────────────
function handleMidiData(bytes, remote) {
  const status = bytes[0];

  // SysEx (variable-length)
  if (status === 0xF0) {
    logMidiRow('SysEx', null, `${bytes.length}b`, '', remote);
    if (!remote) sendToOutput(bytes);
    return;
  }

  const msgType = status & 0xf0;
  const ch      = (status & 0x0f) + 1;
  const d1      = bytes[1] ?? 0;
  const d2      = bytes[2] ?? 0;

  switch (msgType) {
    case 0x90:
      if (d2 > 0) {
        remote
          ? padSynth.triggerAttackRelease(Tone.Frequency(d1, 'midi').toFrequency(), '8n')
          : padSynth.triggerAttackRelease(Tone.Frequency(d1, 'midi').toFrequency(), '8n', Tone.now(), d2 / 127);
        logMidiRow('Note On', ch, midiNoteName(d1), `v:${d2}`, remote);
        break;
      }
      // fall through: velocity 0 = Note Off
    case 0x80:
      logMidiRow('Note Off', ch, midiNoteName(d1), '', remote);
      break;
    case 0xB0:
      handleCC(ch, d1, d2, remote);
      break;
    case 0xC0:
      logMidiRow('PGM', ch, `#${d1 + 1}`, '', remote);
      break;
    case 0xD0:
      logMidiRow('Pressure', ch, `v:${d1}`, '', remote);
      break;
    case 0xE0: {
      const bend = ((d2 << 7) | d1) - 8192;
      padSynth.set({ detune: (bend / 8192) * 200 });
      logMidiRow('Pitch', ch, bend >= 0 ? `+${bend}` : `${bend}`, '', remote);
      break;
    }
    case 0xF0:
      handleSysMsg(status, bytes, remote);
      break;
  }

  // Record channel-voice events (skip system messages)
  if (msgType < 0xF0) recordEvent(bytes);

  // Route remote MIDI to physical output when Thru is on
  if (remote && thruEnabled) sendToOutput(bytes);
}

function handleCC(ch, cc, val, remote) {
  switch (cc) {
    case 1:  padSynth.set({ detune: (val / 127) * 50 }); break;
    case 7:
    case 11: padSynth.volume.value = -40 + (val / 127) * 32; break;
    case 64: /* sustain — pass through */ break;
    case 120:
    case 123: padSynth.releaseAll(); break;
  }
  updateCCViz(ch, cc, val);
  logMidiRow('CC', ch, `#${cc}`, `v:${val}`, remote);
}

function handleSysMsg(status, bytes, remote) {
  switch (status) {
    case 0xF1: {
      const mt = bytes[1] ?? 0;
      logMidiRow('MTC', null, `t:${mt >> 4}`, `v:${mt & 0xf}`, remote);
      return;
    }
    case 0xF2: {
      const pos = ((bytes[2] ?? 0) << 7) | (bytes[1] ?? 0);
      logMidiRow('SPP', null, `beat:${pos}`, '', remote);
      return;
    }
    case 0xF3:
      logMidiRow('SongSel', null, `#${bytes[1] ?? 0}`, '', remote);
      return;
    case 0xF6:
      logMidiRow('Tune', null, '', '', remote);
      return;
    case 0xF8: {
      const now = performance.now();
      clockTickTimes.push(now);
      if (clockTickTimes.length > 24) clockTickTimes.shift();
      return;
    }
    case 0xFA: logMidiRow('Clock', null, 'Start',    '', remote); break;
    case 0xFB: logMidiRow('Clock', null, 'Continue', '', remote); break;
    case 0xFC: clockTickTimes = []; logMidiRow('Clock', null, 'Stop', '', remote); break;
    case 0xFE: return; // Active Sensing
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

  if (status === 0xFE) { handleSysMsg(status, bytes, false); return; }

  if (status === 0xF8) {
    handleSysMsg(status, bytes, false);
    if (clockRelayEnabled && ws.readyState === WebSocket.OPEN) {
      ws.send(JSON.stringify({ type: 'midi', data: [0xF8] }));
    }
    return;
  }

  // Channel filter
  if (filterChannel !== 0 && (status & 0xf0) !== 0xf0) {
    if ((status & 0x0f) + 1 !== filterChannel) return;
  }

  // Channel remap
  let outBytes = bytes;
  if (remapChannel !== 0 && (status & 0xf0) !== 0xf0) {
    outBytes = [...bytes];
    outBytes[0] = (status & 0xf0) | (remapChannel - 1);
  }

  handleMidiData(outBytes, false);
  if (thruEnabled) sendToOutput(outBytes);
  if (ws.readyState === WebSocket.OPEN) {
    ws.send(JSON.stringify({ type: 'midi', data: outBytes }));
  }
}

// ── CC Visualizer ────────────────────────────────────────────
const ccValues = {}; // key: `${ch}-${cc}`

function updateCCViz(ch, cc, val) {
  ccValues[`${ch}-${cc}`] = { ch, cc, val };
  renderCCViz();
}

function renderCCViz() {
  const el = document.getElementById('cc-viz');
  if (!el) return;
  const entries = Object.values(ccValues)
    .sort((a, b) => a.ch !== b.ch ? a.ch - b.ch : a.cc - b.cc);
  if (entries.length === 0) {
    el.innerHTML = '<span class="muted" style="font-size:0.78rem">no CC received yet</span>';
    return;
  }
  el.innerHTML = '';
  entries.forEach(({ ch, cc, val }) => {
    const pct = Math.round(val / 127 * 100);
    const row = document.createElement('div');
    row.className = 'cc-row';
    row.innerHTML =
      `<span class="cc-label">ch${ch} CC${cc}</span>` +
      `<div class="cc-bar-bg"><div class="cc-bar" style="width:${pct}%"></div></div>` +
      `<span class="cc-val">${val}</span>`;
    el.appendChild(row);
  });
}

// ── Virtual Keyboard ─────────────────────────────────────────
// White key semitones within an octave (C=0…B=11)
const VKB_WHITE = [0, 2, 4, 5, 7, 9, 11];
// Black keys: semitone + index of white key to their left
const VKB_BLACK = [
  { semi: 1, after: 0 },
  { semi: 3, after: 1 },
  { semi: 6, after: 3 },
  { semi: 8, after: 4 },
  { semi: 10, after: 5 },
];
const activeVKBNotes = new Set();

function buildVirtualKeyboard() {
  const el  = document.getElementById('vkb');
  const oct = +document.getElementById('vkb-oct').value;
  const NUM_OCTAVES = 2;
  const totalWhite  = NUM_OCTAVES * 7;
  el.innerHTML = '';

  for (let o = 0; o < NUM_OCTAVES; o++) {
    // White keys
    VKB_WHITE.forEach((semi, wi) => {
      const note = (oct + o) * 12 + 12 + semi;
      const key  = document.createElement('div');
      key.className  = 'vkey';
      key.dataset.note = note;
      key.style.left  = `${(o * 7 + wi) / totalWhite * 100}%`;
      key.style.width = `${1 / totalWhite * 100}%`;
      attachVKBEvents(key);
      el.appendChild(key);
    });

    // Black keys (positioned relative to surrounding white keys)
    const blackW = (1 / totalWhite) * 0.6 * 100; // % of container
    VKB_BLACK.forEach(({ semi, after }) => {
      const note  = (oct + o) * 12 + 12 + semi;
      const key   = document.createElement('div');
      key.className    = 'vkey black';
      key.dataset.note = note;
      const rightEdgePct = (o * 7 + after + 1) / totalWhite * 100;
      key.style.left  = `calc(${rightEdgePct}% - ${blackW / 2}%)`;
      key.style.width = `${blackW}%`;
      attachVKBEvents(key);
      el.appendChild(key);
    });
  }
}

function attachVKBEvents(key) {
  const note = +key.dataset.note;
  key.addEventListener('mousedown',  e => { e.preventDefault(); vkbOn(note); });
  key.addEventListener('mouseenter', e => { if (e.buttons & 1) vkbOn(note); });
  key.addEventListener('mouseup',    () => vkbOff(note));
  key.addEventListener('mouseleave', () => vkbOff(note));
  key.addEventListener('touchstart', e => { e.preventDefault(); vkbOn(note); }, { passive: false });
  key.addEventListener('touchend',   e => { e.preventDefault(); vkbOff(note); }, { passive: false });
}

function vkbOn(note) {
  if (activeVKBNotes.has(note)) return;
  activeVKBNotes.add(note);
  const vel   = +document.getElementById('vkb-vel').value;
  const ch    = +document.getElementById('vkb-ch').value - 1;
  const bytes = [0x90 | ch, note, vel];
  handleMidiData(bytes, false);
  if (ws.readyState === WebSocket.OPEN) ws.send(JSON.stringify({ type: 'midi', data: bytes }));
  document.querySelectorAll(`.vkey[data-note="${note}"]`).forEach(k => k.classList.add('active'));
}

function vkbOff(note) {
  if (!activeVKBNotes.has(note)) return;
  activeVKBNotes.delete(note);
  const ch    = +document.getElementById('vkb-ch').value - 1;
  const bytes = [0x80 | ch, note, 0];
  handleMidiData(bytes, false);
  if (ws.readyState === WebSocket.OPEN) ws.send(JSON.stringify({ type: 'midi', data: bytes }));
  document.querySelectorAll(`.vkey[data-note="${note}"]`).forEach(k => k.classList.remove('active'));
}

// ── MIDI Recording ───────────────────────────────────────────
let recording  = false;
let recStart   = null;
let recEvents  = [];    // [{ ms, bytes }]

function recordEvent(bytes) {
  if (recording) recEvents.push({ ms: Date.now() - recStart, bytes: [...bytes] });
}

function startRecording() {
  recording = true;
  recStart  = Date.now();
  recEvents = [];
  document.getElementById('rec-btn').classList.add('recording');
  document.getElementById('rec-btn').disabled      = true;
  document.getElementById('rec-stop-btn').disabled = false;
  document.getElementById('rec-export-btn').disabled = true;
  document.getElementById('rec-status').textContent  = '● REC';
}

function stopRecording() {
  recording = false;
  document.getElementById('rec-btn').classList.remove('recording');
  document.getElementById('rec-btn').disabled        = false;
  document.getElementById('rec-stop-btn').disabled   = true;
  document.getElementById('rec-export-btn').disabled = recEvents.length === 0;
  document.getElementById('rec-status').textContent  =
    recEvents.length > 0 ? `${recEvents.length} events` : '';
}

// Variable-length quantity encoder (SMF delta time format)
function vlq(n) {
  if (n === 0) return [0];
  const bytes = [];
  bytes.unshift(n & 0x7f);
  n >>= 7;
  while (n > 0) { bytes.unshift((n & 0x7f) | 0x80); n >>= 7; }
  return bytes;
}

function exportMid() {
  const division     = 480;
  const bpm          = state.bpm;
  const microsPerBeat = Math.round(60_000_000 / bpm);
  const ticksPerMs    = division / (microsPerBeat / 1000);

  const trackData = [];

  // Tempo meta event
  trackData.push(...vlq(0), 0xFF, 0x51, 0x03,
    (microsPerBeat >> 16) & 0xFF,
    (microsPerBeat >>  8) & 0xFF,
     microsPerBeat        & 0xFF);

  let prevMs = 0;
  for (const { ms, bytes } of recEvents) {
    const deltaTicks = Math.max(0, Math.round((ms - prevMs) * ticksPerMs));
    trackData.push(...vlq(deltaTicks), ...bytes);
    prevMs = ms;
  }

  // End of track
  trackData.push(...vlq(0), 0xFF, 0x2F, 0x00);

  // Assemble SMF (format 0, 1 track)
  const buf = [
    0x4D, 0x54, 0x68, 0x64,  // "MThd"
    0x00, 0x00, 0x00, 0x06,  // chunk length
    0x00, 0x00,              // format 0
    0x00, 0x01,              // 1 track
    (division >> 8) & 0xFF, division & 0xFF,
    0x4D, 0x54, 0x72, 0x6B,  // "MTrk"
    (trackData.length >> 24) & 0xFF,
    (trackData.length >> 16) & 0xFF,
    (trackData.length >>  8) & 0xFF,
     trackData.length        & 0xFF,
    ...trackData,
  ];

  const blob = new Blob([new Uint8Array(buf)], { type: 'audio/midi' });
  const url  = URL.createObjectURL(blob);
  const a    = document.createElement('a');
  a.href     = url;
  a.download = `session-${new Date().toISOString().slice(0,19).replace(/:/g,'-')}.mid`;
  a.click();
  URL.revokeObjectURL(url);
}

// Transport UI disabled on load (before unlock)
updateTransportUI();
