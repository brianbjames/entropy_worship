/* ── EW909 Drum Machine ──────────────────────────────────────
   Sample-based 16-step sequencer, synced to the shared
   epoch-based transport from client.js.
   Follows the same enable/disable + scheduler pattern as
   piano-roll.js.
   ──────────────────────────────────────────────────────────── */

const DM_TICK_MS = 20;
const DM_LOOKAHEAD = 100;

const DM_INSTRUMENTS = [
  { name: "KICK",   sample: "kick",       file: "kick.wav" },
  { name: "SNARE",  sample: "snare",      file: "snare.wav" },
  { name: "TOM-L",  sample: "tomL",       file: "tom-l.wav" },
  { name: "TOM-H",  sample: "tomH",       file: "tom-h.wav" },
  { name: "CLAP",   sample: "clap",       file: "clap.wav" },
  { name: "HH-O",   sample: "hihatOpen",  file: "hihat-open.wav" },
  { name: "HH-C",   sample: "hihatClose", file: "hihat-close.wav" },
  { name: "CYMBAL", sample: "cymbal",     file: "cymbal.wav" },
  { name: "RIM",    sample: "rim",        file: "rim.wav" },
  { name: "RIDE",   sample: "ride",       file: "ride.wav" },
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
const dmPlayerMap = {};  // keyed by sample name
const dmChannelMap = {}; // keyed by sample name — Tone.Channel per drum
let dmLoaded = false;

// ── Load samples via individual Tone.Player + Channel ───────
function dmLoadSamples() {
  DM_INSTRUMENTS.forEach((inst) => {
    dmPlayerMap[inst.sample] = new Tone.Player(`samples/${inst.file}`);
  });
  Tone.loaded().then(() => { dmLoaded = true; });
}

// Called after masterChannel exists (from initSynths → initMixerChannels)
function dmConnectChannels() {
  DM_INSTRUMENTS.forEach((inst) => {
    if (dmChannelMap[inst.sample]) return; // already connected
    dmChannelMap[inst.sample] = new Tone.Channel({ volume: 0 }).connect(masterChannel);
    dmPlayerMap[inst.sample].connect(dmChannelMap[inst.sample]);
  });
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
  dmLastIdx = -1;
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
        const player = dmPlayerMap[DM_INSTRUMENTS[i].sample];
        if (player && player.loaded) player.start(audioT);
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
  document.getElementById("dm-chain-pos").textContent =
    dmChainEnabled && dmChain[dmChainPos] >= 0
      ? `${dmChainPos + 1}/${DM_CHAIN_LEN}`
      : "";
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

// ── Init ────────────────────────────────────────────────────
dmLoadSamples();
dmRenderGrid();
dmRenderPatternBtns();
dmRenderChainSlots();
