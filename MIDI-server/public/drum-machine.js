/* ── EW909 Drum Machine ──────────────────────────────────────
   Sample-based 16-step sequencer, synced to the shared
   epoch-based transport from client.js.
   Follows the same enable/disable + scheduler pattern as
   piano-roll.js.
   ──────────────────────────────────────────────────────────── */

const DM_TICK_MS = 10;
const DM_LOOKAHEAD = 50;

// ── Kit registry ───────────────────────────────────────────
// Each kit is a folder under samples/. To add a new kit:
// 1. Create the folder (e.g. samples/707/)
// 2. Add an entry here with the filenames
const DM_KITS = {
  "909": [
    "kick-1.wav", "kick-2.wav", "snare-1.wav",
    "tom-low-1.wav", "tom-high-1.wav", "clap-1.wav",
    "hihat-open-1.wav", "hihat-close-1.wav",
    "cymbal-1.wav", "rim-1.wav", "ride-1.wav",
  ],
  "808": [
    "kick-1.wav", "kick-2.wav", "kick-3.wav", "kick-4.wav",
    "kick-5.wav", "kick-6.wav", "kick-7.wav", "kick-8.wav",
    "kick-9.wav", "kick-10.wav",
    "snare-1.wav", "snare-2.wav", "snare-3.wav", "snare-4.wav",
    "snare-5.wav", "snare-6.wav", "snare-7.wav", "snare-8.wav",
    "snare-9.wav", "snare-10.wav",
    "clap-1.wav", "clap-2.wav", "clap-4.wav", "clap-5.wav",
    "clap-6.wav", "clap-7.wav", "clap-8.wav", "clap-9.wav",
    "clap-10.wav",
    "hihat-close-1.wav", "hihat-close-2.wav", "hihat-close-3.wav",
    "hihat-close-4.wav", "hihat-close-5.wav", "hihat-close-6.wav",
    "hihat-close-7.wav", "hihat-close-8.wav", "hihat-close-9.wav",
    "hihat-close-10.wav",
    "hihat-open-1.wav", "hihat-open-2.wav", "hihat-open-3.wav",
    "hihat-open-4.wav", "hihat-open-5.wav", "hihat-open-6.wav",
    "hihat-open-7.wav", "hihat-open-8.wav",
    "tom-low-1.wav", "tom-low-2.wav", "tom-low-3.wav", "tom-low-4.wav",
    "tom-high-1.wav", "tom-high-2.wav",
    "clave-1.wav", "clave-2.wav", "clave-3.wav", "clave-4.wav",
  ],
};

// Build flat list of all sample paths: "909/kick-1.wav", "808/snare-3.wav", etc.
const DM_ALL_SAMPLES = [];
for (const [kit, files] of Object.entries(DM_KITS)) {
  for (const file of files) {
    DM_ALL_SAMPLES.push(`${kit}/${file}`);
  }
}

const DM_INSTRUMENTS = [
  { name: "KICK",   sample: "kick",       file: "909/kick-1.wav",       note: 36 },
  { name: "SNARE",  sample: "snare",      file: "909/snare-1.wav",      note: 38 },
  { name: "TOM-L",  sample: "tomL",       file: "909/tom-low-1.wav",    note: 43 },
  { name: "TOM-H",  sample: "tomH",       file: "909/tom-high-1.wav",   note: 48 },
  { name: "CLAP",   sample: "clap",       file: "909/clap-1.wav",       note: 39 },
  { name: "HH-O",   sample: "hihatOpen",  file: "909/hihat-open-1.wav", note: 46 },
  { name: "HH-C",   sample: "hihatClose", file: "909/hihat-close-1.wav",note: 42 },
  { name: "CYMBAL", sample: "cymbal",     file: "909/cymbal-1.wav",     note: 49 },
  { name: "RIM",    sample: "rim",        file: "909/rim-1.wav",        note: 37 },
  { name: "RIDE",   sample: "ride",       file: "909/ride-1.wav",       note: 51 },
];

let dmSteps = 16;
const DM_PAT_COUNT = 16;

// Pattern storage: 10 arrays of dmSteps booleans
const dmPattern = DM_INSTRUMENTS.map(() => Array(dmSteps).fill(false));

// Pattern bank: 16 slots, each a deep copy of dmPattern
const dmBank = Array.from({ length: DM_PAT_COUNT }, () =>
  DM_INSTRUMENTS.map(() => Array(dmSteps).fill(false))
);
let dmCurrentPat = 0;
let dmQueuedPat = null;
let dmQueueMode = false; // false = instant, true = queue at loop end
const dmBankSteps = Array(DM_PAT_COUNT).fill(16); // step length per pattern

// Chain sequencer: play patterns in order
const DM_CHAIN_LEN = 16;
const dmChain = Array(DM_CHAIN_LEN).fill(-1); // -1 = empty slot
let dmChainEnabled = false;
let dmChainPos = 0; // current position in chain

let dmEnabled = false;
let dmLastIdx = -1;
const dmBufferMap = {};  // keyed by sample path → Tone.ToneAudioBuffer
const dmChannelMap = {}; // keyed by instrument sample name — Tone.Channel per drum
let dmLoaded = false;

// Per-row sample assignment — indexes match DM_INSTRUMENTS
const dmInstrumentFile = DM_INSTRUMENTS.map(inst => inst.file);

// Per-row MIDI note assignment — GM drum map defaults
const dmInstrumentNote = DM_INSTRUMENTS.map(inst => inst.note);

// MIDI channel for drum output/input (0-indexed, default ch 10 = index 9)
let dmMidiChannel = 9;

// Velocity for MIDI output (1-127)
let dmVelocity = 100;

// ── Load ALL samples as audio buffers ───────────────────────
function dmLoadSamples() {
  DM_ALL_SAMPLES.forEach((samplePath) => {
    if (!dmBufferMap[samplePath]) {
      dmBufferMap[samplePath] = new Tone.ToneAudioBuffer(`samples/${samplePath}`);
    }
  });
  Tone.loaded().then(() => { dmLoaded = true; });
}

// Called after masterChannel exists (from initSynths → initMixerChannels)
function dmConnectChannels() {
  DM_INSTRUMENTS.forEach((inst) => {
    if (!dmChannelMap[inst.sample]) {
      dmChannelMap[inst.sample] = new Tone.Channel({ volume: 0 }).connect(masterChannel);
    }
  });
}

// ── One-shot sample trigger ─────────────────────────────────
function dmTrigger(rowIdx, time) {
  const buf = dmBufferMap[dmInstrumentFile[rowIdx]];
  const inst = DM_INSTRUMENTS[rowIdx];
  const ch = dmChannelMap[inst.sample];
  if (!buf || !buf.loaded || !ch) return;
  const src = new Tone.ToneBufferSource(buf).connect(ch);
  src.start(time);
}

// ── Swap sample for a drum row ──────────────────────────────
function dmSwapSample(rowIdx, filename) {
  dmInstrumentFile[rowIdx] = filename;
}

// ── Pattern bank helpers ────────────────────────────────────
function dmSaveCurrent() {
  dmBankSteps[dmCurrentPat] = dmSteps;
  for (let i = 0; i < DM_INSTRUMENTS.length; i++) {
    dmBank[dmCurrentPat][i] = dmPattern[i].slice();
  }
}

function dmLoadPattern(idx) {
  dmSteps = dmBankSteps[idx] || 16;
  document.getElementById("dm-steps").value = dmSteps;
  for (let i = 0; i < DM_INSTRUMENTS.length; i++) {
    const src = dmBank[idx][i];
    dmPattern[i].length = dmSteps;
    for (let s = 0; s < dmSteps; s++) {
      dmPattern[i][s] = src[s] || false;
    }
  }
  dmCurrentPat = idx;
  dmQueuedPat = null;
  dmRenderGrid();
  dmUpdatePatternBtns();
}

function dmSwitchPattern(idx) {
  if (idx === dmCurrentPat && dmQueuedPat === null) return;
  dmSaveCurrent();
  if (dmQueueMode && dmEnabled && typeof epochMs !== "undefined" && epochMs !== null) {
    dmQueuedPat = idx;
    dmUpdatePatternBtns();
  } else {
    dmLoadPattern(idx);
  }
}

// ── Wrap startSequencer / stopSequencer ─────────────────────
const _dmOrigStart = startSequencer;
const _dmOrigStop = stopSequencer;
window.startSequencer = function (epoch) {
  const beatMs = (60 / state.bpm) * 1000;
  const subMs = beatMs * 0.25;
  dmLastIdx = Math.floor((Date.now() + serverTimeOffset - epoch) / subMs) - 1;
  _dmOrigStart(epoch);
};
window.stopSequencer = function (upd) {
  dmLastIdx = -1;
  _dmOrigStop(upd);
};

// ── Scheduler tick (fires every 20ms) ───────────────────────
function dmSchedulerTick() {
  if (!dmEnabled || !dmLoaded) return;
  if (typeof epochMs === "undefined" || epochMs === null) return;

  const beatMs = (60 / state.bpm) * 1000;
  const subMs = beatMs * 0.25; // 16th-note resolution
  const serverNow = Date.now() + serverTimeOffset;
  const elapsed = serverNow + DM_LOOKAHEAD - epochMs;
  if (elapsed < 0) return;

  const horizonIdx = Math.floor(elapsed / subMs);

  for (let idx = Math.max(0, dmLastIdx + 1); idx <= horizonIdx; idx++) {
    const step = idx % dmSteps;

    // Queue / chain resolution at loop boundary
    if (step === 0) {
      if (dmChainEnabled) {
        dmSaveCurrent();
        const nextPos = dmChainAdvance();
        if (nextPos !== null) {
          dmLoadPattern(dmChain[nextPos]);
          dmChainPos = nextPos;
          dmUpdateChainUI();
        }
      } else if (dmQueuedPat !== null) {
        dmSaveCurrent();
        dmLoadPattern(dmQueuedPat);
      }
    }

    const stepServerMs = epochMs + idx * subMs;
    const audioT = serverToAudio(stepServerMs);
    if (audioT < Tone.context.currentTime - 0.01) continue;

    for (let i = 0; i < DM_INSTRUMENTS.length; i++) {
      if (dmPattern[i][step]) {
        dmTrigger(i, audioT);

        // Send MIDI Note On/Off to hardware output + log
        const midiNote = dmInstrumentNote[i];
        const delayMs = Math.max(0, (audioT - Tone.context.currentTime) * 1000);
        setTimeout(() => {
          const onBytes = [0x90 | dmMidiChannel, midiNote, dmVelocity];
          logMidiRow("Note On", dmMidiChannel + 1, midiNoteName(midiNote), `v:${dmVelocity}`, false);
          sendToOutput(onBytes);
          setTimeout(() => {
            logMidiRow("Note Off", dmMidiChannel + 1, midiNoteName(midiNote), "", false);
            sendToOutput([0x80 | dmMidiChannel, midiNote, 0]);
          }, subMs * 0.9);
        }, delayMs);
      }
    }
    dmLastIdx = idx;
  }
}

setInterval(dmSchedulerTick, DM_TICK_MS);

// ── Playhead highlight (rAF) ────────────────────────────────
(function dmRenderLoop() {
  if (dmEnabled && typeof epochMs !== "undefined" && epochMs !== null) {
    const beatMs = (60 / state.bpm) * 1000;
    const subMs = beatMs * 0.25;
    const elapsed = Date.now() + serverTimeOffset - epochMs;
    const currentStep = Math.floor(elapsed / subMs) % dmSteps;
    if (currentStep >= 0) dmHighlightStep(currentStep);
  } else {
    dmHighlightStep(-1);
  }
  requestAnimationFrame(dmRenderLoop);
})();

// ── UI: build the 10 x 16 step grid ────────────────────────
function dmRenderGrid() {
  const grid = document.getElementById("dm-grid");
  grid.innerHTML = "";

  DM_INSTRUMENTS.forEach((inst, rowIdx) => {
    const row = document.createElement("div");
    row.className = "dm-row";

    const label = document.createElement("span");
    label.className = "dm-row-label";
    label.textContent = inst.name;
    row.appendChild(label);

    // Sample selector dropdown
    const sel = document.createElement("select");
    sel.className = "dm-sample-sel";
    DM_ALL_SAMPLES.forEach((samplePath) => {
      const opt = document.createElement("option");
      opt.value = samplePath;
      // Display as "909 / kick-1" style
      const parts = samplePath.split("/");
      opt.textContent = parts[0] + " / " + parts[1].replace(/\.wav$/, "");
      sel.appendChild(opt);
    });
    sel.value = dmInstrumentFile[rowIdx];
    sel.addEventListener("change", (e) => {
      dmSwapSample(rowIdx, e.target.value);
    });
    row.appendChild(sel);

    // MIDI note number input
    const noteInput = document.createElement("input");
    noteInput.type = "number";
    noteInput.className = "dm-note-input";
    noteInput.min = 0;
    noteInput.max = 127;
    noteInput.value = dmInstrumentNote[rowIdx];
    noteInput.title = "MIDI note number";
    noteInput.addEventListener("change", (e) => {
      dmInstrumentNote[rowIdx] = Math.max(0, Math.min(127, +e.target.value || 0));
      e.target.value = dmInstrumentNote[rowIdx];
    });
    row.appendChild(noteInput);

    for (let s = 0; s < dmSteps; s++) {
      const btn = document.createElement("button");
      btn.className = "dm-step";
      btn.dataset.row = rowIdx;
      btn.dataset.step = s;
      if (dmPattern[rowIdx][s]) btn.classList.add("active");
      btn.addEventListener("click", () => {
        dmPattern[rowIdx][s] = !dmPattern[rowIdx][s];
        btn.classList.toggle("active", dmPattern[rowIdx][s]);
      });
      row.appendChild(btn);
    }

    // Volume fader for this drum voice
    if (typeof mixerBuildDrumFader === "function") {
      row.appendChild(mixerBuildDrumFader(inst.sample));
    }

    grid.appendChild(row);
  });
}

function dmHighlightStep(step) {
  const allSteps = document.querySelectorAll(".dm-step");
  allSteps.forEach((el) => {
    const s = +el.dataset.step;
    el.classList.toggle("playing", s === step);
  });
}

// ── Toggle + clear ──────────────────────────────────────────
document.getElementById("dm-toggle-btn").addEventListener("click", () => {
  dmEnabled = !dmEnabled;
  document.getElementById("dm-toggle-btn").classList.toggle("active", dmEnabled);
  if (!dmEnabled) dmLastIdx = -1;
});

document.getElementById("dm-clear-btn").addEventListener("click", () => {
  dmPattern.forEach((row) => row.fill(false));
  dmSaveCurrent();
  document.querySelectorAll(".dm-step").forEach((el) => el.classList.remove("active"));
});

// ── Steps resize ────────────────────────────────────────────
function dmResizeSteps(newLen) {
  newLen = Math.min(64, Math.max(1, Math.round(newLen) || 16));
  dmSaveCurrent();
  dmSteps = newLen;
  // Resize working pattern
  for (let i = 0; i < DM_INSTRUMENTS.length; i++) {
    if (dmPattern[i].length < dmSteps) {
      dmPattern[i].push(...Array(dmSteps - dmPattern[i].length).fill(false));
    } else {
      dmPattern[i].length = dmSteps;
    }
  }
  // Resize all bank slots
  for (let p = 0; p < DM_PAT_COUNT; p++) {
    for (let i = 0; i < DM_INSTRUMENTS.length; i++) {
      if (dmBank[p][i].length < dmSteps) {
        dmBank[p][i].push(...Array(dmSteps - dmBank[p][i].length).fill(false));
      } else {
        dmBank[p][i].length = dmSteps;
      }
    }
  }
  dmRenderGrid();
}

document.getElementById("dm-steps").addEventListener("change", (e) => {
  dmResizeSteps(+e.target.value);
  e.target.value = dmSteps;
});

// ── Pattern selector UI ─────────────────────────────────────
function dmRenderPatternBtns() {
  const container = document.getElementById("dm-pattern-btns");
  container.innerHTML = "";
  for (let i = 0; i < DM_PAT_COUNT; i++) {
    const btn = document.createElement("button");
    btn.className = "pat-btn";
    btn.textContent = i + 1;
    btn.dataset.pat = i;
    if (i === dmCurrentPat) btn.classList.add("active");
    btn.addEventListener("click", () => dmSwitchPattern(i));
    container.appendChild(btn);
  }
}

function dmUpdatePatternBtns() {
  document.querySelectorAll("#dm-pattern-btns .pat-btn").forEach((btn) => {
    const i = +btn.dataset.pat;
    btn.classList.toggle("active", i === dmCurrentPat);
    btn.classList.toggle("queued", i === dmQueuedPat);
  });
}

document.getElementById("dm-queue-btn").addEventListener("click", () => {
  dmQueueMode = !dmQueueMode;
  const btn = document.getElementById("dm-queue-btn");
  btn.textContent = dmQueueMode ? "QUEUE" : "INSTANT";
  btn.classList.toggle("active", dmQueueMode);
});

// ── Chain sequencer ─────────────────────────────────────────
function dmChainAdvance() {
  // Find next non-empty slot after current position
  for (let i = 1; i <= DM_CHAIN_LEN; i++) {
    const pos = (dmChainPos + i) % DM_CHAIN_LEN;
    if (dmChain[pos] >= 0) return pos;
  }
  return null; // all empty
}

function dmChainFirstActive() {
  for (let i = 0; i < DM_CHAIN_LEN; i++) {
    if (dmChain[i] >= 0) return i;
  }
  return null;
}

function dmRenderChainSlots() {
  const container = document.getElementById("dm-chain-slots");
  container.innerHTML = "";
  for (let i = 0; i < DM_CHAIN_LEN; i++) {
    const slot = document.createElement("select");
    slot.className = "chain-slot";
    slot.dataset.idx = i;

    const emptyOpt = document.createElement("option");
    emptyOpt.value = "-1";
    emptyOpt.textContent = "--";
    slot.appendChild(emptyOpt);

    for (let p = 0; p < DM_PAT_COUNT; p++) {
      const opt = document.createElement("option");
      opt.value = p;
      opt.textContent = p + 1;
      slot.appendChild(opt);
    }

    slot.value = dmChain[i];
    slot.addEventListener("change", (e) => {
      dmChain[i] = +e.target.value;
    });
    container.appendChild(slot);
  }
}

function dmUpdateChainUI() {
  document.querySelectorAll("#dm-chain-slots .chain-slot").forEach((slot) => {
    slot.classList.toggle("chain-active", dmChainEnabled && +slot.dataset.idx === dmChainPos && dmChain[dmChainPos] >= 0);
  });
}

document.getElementById("dm-chain-btn").addEventListener("click", () => {
  dmChainEnabled = !dmChainEnabled;
  document.getElementById("dm-chain-btn").classList.toggle("active", dmChainEnabled);
  if (dmChainEnabled) {
    const first = dmChainFirstActive();
    if (first !== null) {
      dmChainPos = first;
      dmSaveCurrent();
      dmLoadPattern(dmChain[first]);
    }
  }
  dmUpdateChainUI();
});

// ── MIDI input: trigger drum voice by note ──────────────────
function dmHandleMidiNote(note, vel) {
  if (!dmLoaded) return;
  for (let i = 0; i < DM_INSTRUMENTS.length; i++) {
    if (dmInstrumentNote[i] === note && vel > 0) {
      dmTrigger(i, Tone.now() + DM_LOOKAHEAD / 1000);
      return;
    }
  }
}

// ── MIDI export ─────────────────────────────────────────────
function dmExportMid() {
  const division = 480;
  const microsBeat = Math.round(60_000_000 / state.bpm);
  const tpb = division;
  const stepTicks = tpb / 4; // 1/16th note in ticks
  const noteDurTicks = Math.max(1, Math.round(stepTicks * 0.9));

  const trackData = [];
  // Tempo meta event
  trackData.push(
    ...vlq(0), 0xff, 0x51, 0x03,
    (microsBeat >> 16) & 0xff,
    (microsBeat >> 8) & 0xff,
    microsBeat & 0xff,
  );

  const events = [];
  for (let i = 0; i < DM_INSTRUMENTS.length; i++) {
    const midiNote = dmInstrumentNote[i];
    for (let s = 0; s < dmSteps; s++) {
      if (dmPattern[i][s]) {
        const onTick = s * stepTicks;
        const offTick = onTick + noteDurTicks;
        events.push({ tick: onTick, bytes: [0x90 | dmMidiChannel, midiNote, dmVelocity] });
        events.push({ tick: offTick, bytes: [0x80 | dmMidiChannel, midiNote, 0] });
      }
    }
  }
  if (events.length === 0) return;

  events.sort((a, b) => a.tick - b.tick || a.bytes[0] - b.bytes[0]);

  let prev = 0;
  for (const { tick, bytes } of events) {
    trackData.push(...vlq(Math.max(0, tick - prev)), ...bytes);
    prev = tick;
  }
  trackData.push(...vlq(0), 0xff, 0x2f, 0x00);

  const buf = [
    0x4d, 0x54, 0x68, 0x64, 0x00, 0x00, 0x00, 0x06,
    0x00, 0x00, 0x00, 0x01,
    (division >> 8) & 0xff, division & 0xff,
    0x4d, 0x54, 0x72, 0x6b,
    (trackData.length >> 24) & 0xff, (trackData.length >> 16) & 0xff,
    (trackData.length >> 8) & 0xff, trackData.length & 0xff,
    ...trackData,
  ];

  const blob = new Blob([new Uint8Array(buf)], { type: "audio/midi" });
  const url = URL.createObjectURL(blob);
  const a = document.createElement("a");
  a.href = url;
  a.download = `drums-${new Date().toISOString().slice(0, 19).replace(/:/g, "-")}.mid`;
  a.click();
  URL.revokeObjectURL(url);
}

// ── MIDI import ─────────────────────────────────────────────
function dmImportMidi(parsed) {
  const { division, notes } = parsed;
  const bpt = 1 / division; // beats per tick

  // Build note-to-row lookup
  const noteToRow = {};
  for (let i = 0; i < DM_INSTRUMENTS.length; i++) {
    noteToRow[dmInstrumentNote[i]] = i;
  }

  // Clear current pattern
  dmPattern.forEach((row) => row.fill(false));

  let maxStep = 0;
  for (const { note, tickOn } of notes) {
    const rowIdx = noteToRow[note];
    if (rowIdx === undefined) continue;
    const beat = tickOn * bpt;
    const step = Math.round(beat / 0.25);
    if (step < 0) continue;
    maxStep = Math.max(maxStep, step);
    if (step < dmSteps) {
      dmPattern[rowIdx][step] = true;
    }
  }

  // Auto-resize steps if pattern is longer
  if (maxStep >= dmSteps) {
    const newSteps = Math.min(64, maxStep + 1);
    dmResizeSteps(newSteps);
    document.getElementById("dm-steps").value = dmSteps;
    // Re-import into resized pattern
    dmPattern.forEach((row) => row.fill(false));
    for (const { note, tickOn } of notes) {
      const rowIdx = noteToRow[note];
      if (rowIdx === undefined) continue;
      const step = Math.round((tickOn * bpt) / 0.25);
      if (step >= 0 && step < dmSteps) {
        dmPattern[rowIdx][step] = true;
      }
    }
  }

  dmSaveCurrent();
  dmRenderGrid();
}

// ── Init ────────────────────────────────────────────────────
dmLoadSamples();
dmRenderGrid();
dmRenderPatternBtns();
dmRenderChainSlots();

// Channel selector
(function () {
  const chSel = document.getElementById("dm-ch");
  for (let i = 0; i < 16; i++) {
    const o = document.createElement("option");
    o.value = i;
    o.textContent = `ch ${i + 1}`;
    chSel.appendChild(o);
  }
  chSel.value = dmMidiChannel;
  chSel.addEventListener("change", (e) => { dmMidiChannel = +e.target.value; });
})();

// Export button
document.getElementById("dm-export-btn").addEventListener("click", dmExportMid);

// Velocity slider
document.getElementById("dm-vel").addEventListener("input", (e) => {
  dmVelocity = +e.target.value;
  document.getElementById("dm-vel-val").textContent = dmVelocity;
});

// Drag-and-drop MIDI import
(function () {
  const dropZone = document.getElementById("dm-drop-zone");
  dropZone.addEventListener("dragover", (e) => {
    e.preventDefault();
    dropZone.classList.add("drag-over");
  });
  dropZone.addEventListener("dragleave", () => {
    dropZone.classList.remove("drag-over");
  });
  dropZone.addEventListener("drop", (e) => {
    e.preventDefault();
    dropZone.classList.remove("drag-over");
    const file = e.dataTransfer.files[0];
    if (!file) return;
    if (file.size > 2_000_000) { console.warn("MIDI file too large (>2MB)"); return; }
    const reader = new FileReader();
    reader.onload = (ev) => {
      try {
        const parsed = parseMidi(ev.target.result);
        if (parsed) dmImportMidi(parsed);
      } catch (err) {
        console.error("MIDI parse error", err);
      }
    };
    reader.readAsArrayBuffer(file);
  });
})();
