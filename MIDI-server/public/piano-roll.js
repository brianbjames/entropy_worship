/* /-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\ */
/* |                                                                         | */
/* \ @@@@@@@@  @@@  @@@  @@@@@@@  @@@@@@@    @@@@@@   @@@@@@@   @@@ @@@      / */
/* - @@@@@@@@  @@@@ @@@  @@@@@@@  @@@@@@@@  @@@@@@@@  @@@@@@@@  @@@ @@@      - */
/* / @@!       @@!@!@@@    @@!    @@!  @@@  @@!  @@@  @@!  @@@  @@! !@@      \ */
/* | !@!       !@!!@!@!    !@!    !@!  @!@  !@!  @!@  !@!  @!@  !@! @!!      | */
/* \ @!!!:!    @!@ !!@!    @!!    @!@!!@!   @!@  !@!  @!@@!@!    !@!@!       / */
/* - !!!!!:    !@!  !!!    !!!    !!@!@!    !@!  !!!  !!@!!!      @!!!       - */
/* / !!:       !!:  !!!    !!:    !!: :!!   !!:  !!!  !!:         !!:        \ */
/* | :!:       :!:  !:!    :!:    :!:  !:!  :!:  !:!  :!:         :!:        | */
/* \  :: ::::   ::   ::     ::    ::   :::  ::::: ::   ::          ::        / */
/* - : :: ::   ::    :      :      :   : :   : :  :    :           :         - */
/* /                                                                         \ */
/* |                                                                         | */
/* \ @@@  @@@  @@@   @@@@@@   @@@@@@@    @@@@@@   @@@  @@@  @@@  @@@@@@@     / */
/* - @@@  @@@  @@@  @@@@@@@@  @@@@@@@@  @@@@@@@   @@@  @@@  @@@  @@@@@@@@    - */
/* / @@!  @@!  @@!  @@!  @@@  @@!  @@@  !@@       @@!  @@@  @@!  @@!  @@@    \ */
/* | !@!  !@!  !@!  !@!  @!@  !@!  @!@  !@!       !@!  @!@  !@!  !@!  @!@    | */
/* \ @!!  !!@  @!@  @!@  !@!  @!@!!@!   !!@@!!    @!@!@!@!  !!@  @!@@!@!     / */
/* - !@!  !!!  !@!  !@!  !!!  !!@!@!     !!@!!!   !!!@!!!!  !!!  !!@!!!      - */
/* / !!:  !!:  !!:  !!:  !!!  !!: :!!        !:!  !!:  !!!  !!:  !!:         \ */
/* | :!:  :!:  :!:  :!:  !:!  :!:  !:!      !:!   :!:  !:!  :!:  :!:         | */
/* \  :::: :: :::   ::::: ::  ::   :::  :::: ::   ::   :::   ::   ::         / */
/* -   :: :  : :     : :  :    :   : :  :: : :     :   : :  :     :          - */
/* /                                                                         \ */
/* |                                                                         | */
/* \-/|\-/|\-/|\-/|\-/|\-/|\-/|\-/|\-/|\-/|\-/|\-/|\-/|\-/|\-/|\-/|\-/|\-/|\-/ */
// ============================================================
// piano-roll.js — Piano Roll editor + MIDI import/export
// Shares global scope with client.js (no ES modules)
// ============================================================

// ── Constants ────────────────────────────────────────────────
const PR_NOTE_MIN = 21; // A0
const PR_NOTE_MAX = 108; // C8
const PR_KEYS_W = 52; // px: left key panel width
const PR_RULER_H = 24; // px: top ruler height
const PR_LOOKAHEAD = 100; // ms: matches client.js LOOKAHEAD_MS
const PR_TICK_MS = 20; // ms: matches client.js SCHEDULER_MS
const WHITE_SEMIS_PR = new Set([0, 2, 4, 5, 7, 9, 11]);
const NOTE_NAMES_PR = [
  "C",
  "C#",
  "D",
  "D#",
  "E",
  "F",
  "F#",
  "G",
  "G#",
  "A",
  "A#",
  "B",
];

// ── State ────────────────────────────────────────────────────
const prNotes = []; // { note, beatStart, beatDur, ch, vel }
let prEnabled = false;
let prBars = 4;
let prScrollPitch = 49; // MIDI note at top of viewport — centers around C2 (36)
let prScrollBeat = 0; // beat offset at left edge
let prZoom = 0; // set to prMinZoom() on first prResize()
let prRowH = 10; // px per semitone
let prLastPrIdx = -1;
let prDrag = null; // { noteIdx, offsetBeat, origNote } | { adding, note }
let prKeysCtx, prRulerCtx, prGridCtx;
let prGridW = 1,
  prGridH = 1; // logical (CSS) grid dimensions
let prDpr = 1;

// ── Pattern bank ────────────────────────────────────────────
const PR_PAT_COUNT = 16;
const prBank = Array.from({ length: PR_PAT_COUNT }, () => []);
const prBankBars = Array(PR_PAT_COUNT).fill(4); // bar length per pattern
let prCurrentPat = 0;
let prQueuedPat = null;
let prQueueMode = false; // false = instant, true = queue at loop end

// Chain sequencer
const PR_CHAIN_LEN = 16;
const prChain = Array(PR_CHAIN_LEN).fill(-1);
let prChainEnabled = false;
let prChainPos = 0;

// ── Helpers ──────────────────────────────────────────────────
function prVisibleRows() {
  return Math.ceil(prGridH / prRowH);
}
function prTotalBeat() {
  return prBars * 4;
}
// Minimum zoom level — allow zooming out to see 2x the pattern length
function prMinZoom() {
  return prGridW > 0 ? Math.max(4, prGridW / (prTotalBeat() * 2)) : 4;
}
function prBeatToX(beat) {
  return (beat - prScrollBeat) * prZoom;
}
function prNoteToY(note) {
  return (prScrollPitch - note) * prRowH;
}
function prXToBeat(x) {
  return prScrollBeat + x / prZoom;
}
function prYToNote(y) {
  return Math.round(prScrollPitch - y / prRowH);
}
function prClamp(v, lo, hi) {
  return Math.max(lo, Math.min(hi, v));
}
function prSnapBeat(b) {
  return Math.round(b / 0.25) * 0.25;
} // 1/16 snap

function prZoomTo(newZoom) {
  prZoom = prClamp(newZoom, prMinZoom(), 400);
  const visBts = prGridW / prZoom;
  const maxScroll = Math.max(0, prTotalBeat() + visBts * 0.5 - visBts);
  prScrollBeat = prClamp(prScrollBeat, 0, maxScroll);
  drawAll();
}

function prFitZoom() {
  prZoomTo(prGridW / prTotalBeat());
  prScrollBeat = 0;
  drawAll();
}

// ── Pattern bank helpers ────────────────────────────────────
function prSaveCurrent() {
  prBankBars[prCurrentPat] = prBars;
  prBank[prCurrentPat] = prNotes.map((n) => ({ ...n }));
}

function prLoadPattern(idx) {
  prBars = prBankBars[idx] || 4;
  document.getElementById("pr-bars").value = prBars;
  prNotes.length = 0;
  prBank[idx].forEach((n) => prNotes.push({ ...n }));
  prCurrentPat = idx;
  prQueuedPat = null;
  prScrollBeat = 0;
  prZoom = prClamp(prGridW / prTotalBeat(), prMinZoom(), 400);
  drawAll();
  prUpdatePatternBtns();
}

function prSwitchPattern(idx) {
  if (idx === prCurrentPat && prQueuedPat === null) return;
  prSaveCurrent();
  if (prQueueMode && prEnabled && typeof epochMs !== "undefined" && epochMs !== null) {
    prQueuedPat = idx;
    prUpdatePatternBtns();
  } else {
    prLoadPattern(idx);
  }
}

function prUpdatePatternBtns() {
  document.querySelectorAll("#pr-pattern-btns .pat-btn").forEach((btn) => {
    const i = +btn.dataset.pat;
    btn.classList.toggle("active", i === prCurrentPat);
    btn.classList.toggle("queued", i === prQueuedPat);
  });
}

// ── Chain helpers ────────────────────────────────────────────
function prChainAdvance() {
  for (let i = 1; i <= PR_CHAIN_LEN; i++) {
    const pos = (prChainPos + i) % PR_CHAIN_LEN;
    if (prChain[pos] >= 0) return pos;
  }
  return null;
}

function prChainFirstActive() {
  for (let i = 0; i < PR_CHAIN_LEN; i++) {
    if (prChain[i] >= 0) return i;
  }
  return null;
}

function prRenderChainSlots() {
  const container = document.getElementById("pr-chain-slots");
  container.innerHTML = "";
  for (let i = 0; i < PR_CHAIN_LEN; i++) {
    const slot = document.createElement("select");
    slot.className = "chain-slot";
    slot.dataset.idx = i;

    const emptyOpt = document.createElement("option");
    emptyOpt.value = "-1";
    emptyOpt.textContent = "--";
    slot.appendChild(emptyOpt);

    for (let p = 0; p < PR_PAT_COUNT; p++) {
      const opt = document.createElement("option");
      opt.value = p;
      opt.textContent = p + 1;
      slot.appendChild(opt);
    }

    slot.value = prChain[i];
    slot.addEventListener("change", (e) => {
      prChain[i] = +e.target.value;
    });
    container.appendChild(slot);
  }
}

function prUpdateChainUI() {
  document.querySelectorAll("#pr-chain-slots .chain-slot").forEach((slot) => {
    slot.classList.toggle("chain-active", prChainEnabled && +slot.dataset.idx === prChainPos && prChain[prChainPos] >= 0);
  });
  document.getElementById("pr-chain-pos").textContent =
    prChainEnabled && prChain[prChainPos] >= 0
      ? `${prChainPos + 1}/${PR_CHAIN_LEN}`
      : "";
}

// ── Draw: keys panel ─────────────────────────────────────────
function drawKeys() {
  const ctx = prKeysCtx;
  const w = PR_KEYS_W,
    h = prGridH;
  ctx.clearRect(0, 0, w, h);

  for (let n = PR_NOTE_MIN; n <= PR_NOTE_MAX; n++) {
    const y = prNoteToY(n);
    if (y + prRowH < 0 || y > prGridH) continue;
    const semi = n % 12;
    const isBlack = !WHITE_SEMIS_PR.has(semi);

    ctx.fillStyle = isBlack ? "#140a0a" : "rgba(210,195,195,0.88)";
    ctx.fillRect(0, y, isBlack ? w * 0.6 : w - 1, prRowH - (isBlack ? 0 : 1));

    // White key bottom border
    if (!isBlack) {
      ctx.fillStyle = "rgba(102,12,12,0.3)";
      ctx.fillRect(0, y + prRowH - 1, w - 1, 1);
    }

    // Octave label at each C, note number on all keys
    if (semi === 0) {
      const oct = Math.floor(n / 12) - 1;
      ctx.fillStyle = "#05af90";
      ctx.font = '7px "Courier New", monospace';
      ctx.fillText(`C${oct}`, 2, y + prRowH - 2);
      ctx.fillStyle = "rgba(5,175,144,0.5)";
      ctx.fillText(n, w - 16, y + prRowH - 2);
    } else if (prRowH >= 8) {
      ctx.fillStyle = isBlack ? "rgba(255,255,255,0.25)" : "rgba(0,0,0,0.3)";
      ctx.font = '6px "Courier New", monospace';
      ctx.fillText(n, isBlack ? w * 0.6 + 2 : w - 16, y + prRowH - 2);
    }
  }

  // Right border
  ctx.fillStyle = "rgba(255,34,34,0.35)";
  ctx.fillRect(w - 1, 0, 1, h);
}

// ── Draw: ruler ───────────────────────────────────────────────
function drawRuler() {
  const ctx = prRulerCtx;
  const w = prGridW,
    h = PR_RULER_H;
  ctx.clearRect(0, 0, w, h);

  ctx.fillStyle = "rgba(0,0,0,0.8)";
  ctx.fillRect(0, 0, w, h);

  const beatStart = Math.floor(prScrollBeat);
  const patternEnd = prTotalBeat();
  const beatEnd = Math.ceil(prScrollBeat + prGridW / prZoom) + 1;

  for (let b = beatStart; b <= beatEnd; b++) {
    const x = prBeatToX(b);
    if (x < 0 || x > prGridW) continue;
    const bar = Math.floor(b / 4);
    const beatInBar = b % 4;
    const isBar = beatInBar === 0;
    const pastEnd = b >= patternEnd;

    ctx.strokeStyle = pastEnd
      ? (isBar ? "rgba(102,12,12,0.4)" : "rgba(102,12,12,0.15)")
      : (isBar ? "rgba(255,34,34,0.7)" : "rgba(255,34,34,0.3)");
    ctx.lineWidth = 1;
    ctx.beginPath();
    ctx.moveTo(x, isBar ? 0 : h * 0.5);
    ctx.lineTo(x, h);
    ctx.stroke();

    if (isBar) {
      ctx.fillStyle = pastEnd ? "rgba(102,12,12,0.5)" : "#ff3c3c";
      ctx.font = '9px "Courier New", monospace';
      ctx.fillText(`${bar + 1}`, x + 3, h - 5);
    } else if (!isBar) {
      ctx.fillStyle = "rgba(102,12,12,0.8)";
      ctx.font = '7px "Courier New", monospace';
      ctx.fillText(`${beatInBar + 1}`, x + 2, h - 4);
    }

    // 1/16th subdivision ticks
    for (let sub = 1; sub < 4; sub++) {
      const sx = x + (sub / 4) * prZoom;
      if (sx < 0 || sx > prGridW) continue;
      ctx.strokeStyle = pastEnd ? "rgba(102,12,12,0.1)" : "rgba(102,12,12,0.3)";
      ctx.beginPath();
      ctx.moveTo(sx, h * 0.75);
      ctx.lineTo(sx, h);
      ctx.stroke();
    }
  }

  // Shade dead zone beyond pattern end
  const endX = prBeatToX(patternEnd);
  if (endX < w - 1) {
    ctx.fillStyle = "rgba(0,0,0,0.55)";
    ctx.fillRect(Math.max(0, endX), 0, w - Math.max(0, endX), h);
  }

  // Bottom border
  ctx.strokeStyle = "rgba(255,34,34,0.4)";
  ctx.lineWidth = 1;
  ctx.beginPath();
  ctx.moveTo(0, h - 1);
  ctx.lineTo(w, h - 1);
  ctx.stroke();
}

// ── Draw: grid + notes + playhead ────────────────────────────
function drawGrid(playBeat) {
  const ctx = prGridCtx;
  const w = prGridW,
    h = prGridH;
  ctx.clearRect(0, 0, w, h);

  // Background
  ctx.fillStyle = "rgba(4,2,2,0.95)";
  ctx.fillRect(0, 0, w, h);

  // Horizontal pitch lanes
  for (let n = PR_NOTE_MIN; n <= PR_NOTE_MAX; n++) {
    const y = prNoteToY(n);
    if (y + prRowH < 0 || y > h) continue;
    const semi = n % 12;
    if (!WHITE_SEMIS_PR.has(semi)) {
      ctx.fillStyle = "rgba(0,0,0,0.4)";
      ctx.fillRect(0, y, w, prRowH);
    }
    if (semi === 0) {
      ctx.fillStyle = "rgba(255,34,34,0.12)";
      ctx.fillRect(0, y, w, 1);
    }
  }

  // Vertical beat/bar lines
  const beatStart = Math.floor(prScrollBeat);
  const patternEnd = prTotalBeat();
  const beatEnd = Math.ceil(prScrollBeat + w / prZoom) + 1;

  for (let b = beatStart; b <= beatEnd; b++) {
    const x = prBeatToX(b);
    if (x < 0 || x > w) continue;
    const isBar = b % 4 === 0;
    const pastEnd = b >= patternEnd;
    ctx.strokeStyle = pastEnd
      ? (isBar ? "rgba(102,12,12,0.1)" : "rgba(102,12,12,0.06)")
      : (isBar ? "rgba(255,34,34,0.22)" : "rgba(102,12,12,0.18)");
    ctx.lineWidth = 1;
    ctx.beginPath();
    ctx.moveTo(x, 0);
    ctx.lineTo(x, h);
    ctx.stroke();

    // 1/16 subdivisions
    for (let sub = 1; sub < 4; sub++) {
      const sx = x + (sub / 4) * prZoom;
      if (sx < 0 || sx > w) continue;
      ctx.strokeStyle = pastEnd ? "rgba(102,12,12,0.03)" : "rgba(102,12,12,0.08)";
      ctx.beginPath();
      ctx.moveTo(sx, 0);
      ctx.lineTo(sx, h);
      ctx.stroke();
    }
  }

  // Dead zone: shade area past pattern end
  const endX = prBeatToX(patternEnd);
  if (endX < w - 1) {
    ctx.fillStyle = "rgba(0,0,0,0.55)";
    ctx.fillRect(Math.max(0, endX), 0, w - Math.max(0, endX), h);
  }

  // Notes
  for (const n of prNotes) {
    const x = prBeatToX(n.beatStart);
    const y = prNoteToY(n.note);
    const nw = Math.max(3, n.beatDur * prZoom - 1);
    const nh = prRowH - 1;
    if (x + nw < 0 || x > w || y + nh < 0 || y > h) continue;

    const hue = n.ch === 9 ? 165 : (n.ch * 37) % 360;
    ctx.fillStyle = n.ch === 9 ? "#05af90" : `hsl(${hue},80%,52%)`;
    ctx.globalAlpha = 0.88;
    ctx.fillRect(x, y, nw, nh);

    // Bright left-edge highlight
    ctx.fillStyle = "rgba(255,255,255,0.35)";
    ctx.fillRect(x, y, Math.min(2, nw), nh);
    ctx.globalAlpha = 1;
  }

  // Playhead
  if (playBeat !== undefined) {
    const px = prBeatToX(playBeat % prTotalBeat());
    if (px >= 0 && px <= w) {
      ctx.strokeStyle = "rgba(255,255,255,0.75)";
      ctx.lineWidth = 1.5;
      ctx.beginPath();
      ctx.moveTo(px, 0);
      ctx.lineTo(px, h);
      ctx.stroke();
    }
  }
}

function drawAll(playBeat) {
  drawKeys();
  drawRuler();
  drawGrid(playBeat);
}

// ── Resize ────────────────────────────────────────────────────
function prResize() {
  prDpr = window.devicePixelRatio || 1;
  const wrap = document.getElementById("pr-canvas-wrap");
  const keys = document.getElementById("pr-keys");
  const ruler = document.getElementById("pr-ruler");
  const grid = document.getElementById("pr-grid");

  prGridW = Math.floor(wrap.clientWidth - PR_KEYS_W);
  prGridH = Math.floor(wrap.clientHeight - PR_RULER_H);

  // Clamp zoom to minimum after resize; on first load fit to pattern
  if (prZoom === 0) {
    prZoom = prGridW > 0 ? prGridW / prTotalBeat() : prMinZoom();
  }
  prZoom = Math.max(prZoom, prMinZoom());
  const visibleBeats = prGridW / prZoom;
  const maxScroll = Math.max(0, prTotalBeat() + visibleBeats * 0.5 - visibleBeats);
  prScrollBeat = Math.min(prScrollBeat, maxScroll);

  // Keys
  keys.style.width = `${PR_KEYS_W}px`;
  keys.style.height = `${prGridH}px`;
  keys.width = PR_KEYS_W * prDpr;
  keys.height = prGridH * prDpr;
  prKeysCtx = keys.getContext("2d");
  prKeysCtx.scale(prDpr, prDpr);

  // Ruler
  ruler.style.width = `${prGridW}px`;
  ruler.style.height = `${PR_RULER_H}px`;
  ruler.width = prGridW * prDpr;
  ruler.height = PR_RULER_H * prDpr;
  prRulerCtx = ruler.getContext("2d");
  prRulerCtx.scale(prDpr, prDpr);

  // Grid
  grid.style.width = `${prGridW}px`;
  grid.style.height = `${prGridH}px`;
  grid.width = prGridW * prDpr;
  grid.height = prGridH * prDpr;
  prGridCtx = grid.getContext("2d");
  prGridCtx.scale(prDpr, prDpr);

  drawAll();
}

// ── Mouse ─────────────────────────────────────────────────────
function prHitNote(beat, note) {
  for (let i = prNotes.length - 1; i >= 0; i--) {
    const n = prNotes[i];
    if (
      note === n.note &&
      beat >= n.beatStart &&
      beat < n.beatStart + n.beatDur
    )
      return i;
  }
  return -1;
}

function prOnMouseDown(e) {
  e.preventDefault();
  const rect = e.currentTarget.getBoundingClientRect();
  const x = e.clientX - rect.left;
  const y = e.clientY - rect.top;
  const beat = prXToBeat(x);
  const note = prClamp(prYToNote(y), PR_NOTE_MIN, PR_NOTE_MAX);

  if (e.button === 2) {
    const idx = prHitNote(beat, note);
    if (idx >= 0) prNotes.splice(idx, 1);
    drawAll();
    return;
  }

  const idx = prHitNote(beat, note);
  if (idx >= 0) {
    prDrag = {
      mode: "move",
      idx,
      offsetBeat: beat - prNotes[idx].beatStart,
      origNote: prNotes[idx].note,
      didMove: false,
    };
  } else {
    const ch = +document.getElementById("pr-ch").value;
    const vel = +document.getElementById("pr-vel").value;
    const bs = prClamp(prSnapBeat(beat), 0, prTotalBeat() - 0.25);
    prNotes.push({ note, beatStart: bs, beatDur: 0.25, ch, vel });
    prDrag = { mode: "add", idx: prNotes.length - 1, origBeat: bs };
  }
  drawAll();
}

function prOnMouseMove(e) {
  if (!prDrag) return;
  const rect = document.getElementById("pr-grid").getBoundingClientRect();
  const x = e.clientX - rect.left;
  const y = e.clientY - rect.top;
  const beat = prXToBeat(x);
  const note = prClamp(prYToNote(y), PR_NOTE_MIN, PR_NOTE_MAX);
  const n = prNotes[prDrag.idx];
  if (!n) return;

  if (prDrag.mode === "move") {
    n.beatStart = prClamp(
      prSnapBeat(beat - prDrag.offsetBeat),
      0,
      prTotalBeat() - n.beatDur,
    );
    n.note = note;
    prDrag.didMove = true;
  } else if (prDrag.mode === "add") {
    const endSnap = Math.ceil(beat / 0.25) * 0.25;
    const end = prClamp(endSnap, 0.25, prTotalBeat());
    n.beatDur = Math.max(0.25, end - prDrag.origBeat);
  }
  drawAll();
}

function prOnMouseUp() {
  if (prDrag && prDrag.mode === "move" && !prDrag.didMove) {
    prNotes.splice(prDrag.idx, 1);
    drawAll();
  }
  prDrag = null;
}

function prOnWheel(e) {
  e.preventDefault();
  const delta = e.deltaY;
  if (e.ctrlKey || e.metaKey) {
    prZoom = prClamp(prZoom * (delta > 0 ? 0.85 : 1.18), prMinZoom(), 400);
    // Clamp scroll — allow scrolling half a screen past the pattern end
    const visBts = prGridW / prZoom;
    const maxScroll = Math.max(0, prTotalBeat() + visBts * 0.5 - visBts);
    prScrollBeat = prClamp(prScrollBeat, 0, maxScroll);
  } else if (e.shiftKey) {
    const visBts = prGridW / prZoom;
    const maxScroll = Math.max(0, prTotalBeat() + visBts * 0.5 - visBts);
    prScrollBeat = prClamp(prScrollBeat + delta / prZoom, 0, maxScroll);
  } else {
    prScrollPitch = prClamp(
      prScrollPitch + (delta > 0 ? -2 : 2),
      PR_NOTE_MIN + prVisibleRows(),
      PR_NOTE_MAX,
    );
  }
  drawAll();
}

// ── Scheduler integration ─────────────────────────────────────
// Wrap startSequencer/stopSequencer to reset piano roll index
const _prOrigStart = startSequencer;
const _prOrigStop = stopSequencer;
window.startSequencer = function (epoch) {
  prLastPrIdx = -1;
  _prOrigStart(epoch);
};
window.stopSequencer = function (upd) {
  prLastPrIdx = -1;
  _prOrigStop(upd);
};

function prSchedulerTick() {
  if (!prEnabled || typeof epochMs === "undefined" || epochMs === null) return;
  if (prNotes.length === 0) return;

  const beatMs = (60 / state.bpm) * 1000;
  const subDiv = 0.25; // schedule at 1/16th resolution
  const subMs = beatMs * subDiv;
  const serverNow = Date.now() + serverTimeOffset;
  const elapsed = serverNow + PR_LOOKAHEAD - epochMs;
  if (elapsed < 0) return;

  const horizonIdx = Math.floor(elapsed / subMs);
  const totalBeat = prTotalBeat();

  for (let idx = Math.max(0, prLastPrIdx + 1); idx <= horizonIdx; idx++) {
    const patBeat = (idx * subDiv) % totalBeat;

    // Queue / chain resolution at loop boundary
    if (patBeat < subDiv) {
      if (prChainEnabled) {
        prSaveCurrent();
        const nextPos = prChainAdvance();
        if (nextPos !== null) {
          prChainPos = nextPos;
          const patIdx = prChain[nextPos];
          prBars = prBankBars[patIdx] || 4;
          document.getElementById("pr-bars").value = prBars;
          prNotes.length = 0;
          prBank[patIdx].forEach((n) => prNotes.push({ ...n }));
          prCurrentPat = patIdx;
          drawAll();
          prUpdatePatternBtns();
          prUpdateChainUI();
        }
      } else if (prQueuedPat !== null) {
        prSaveCurrent();
        prBars = prBankBars[prQueuedPat] || 4;
        document.getElementById("pr-bars").value = prBars;
        prNotes.length = 0;
        prBank[prQueuedPat].forEach((n) => prNotes.push({ ...n }));
        prCurrentPat = prQueuedPat;
        prQueuedPat = null;
        drawAll();
        prUpdatePatternBtns();
      }
    }

    const slotEnd = patBeat + subDiv;
    const stepServerMs = epochMs + idx * subMs;
    const audioT = serverToAudio(stepServerMs);
    if (audioT < Tone.context.currentTime - 0.01) continue;

    for (const n of prNotes) {
      if (n.beatStart >= patBeat && n.beatStart < slotEnd) {
        const durSec = Math.max(0.05, (n.beatDur * beatMs) / 1000);
        const freq = Tone.Frequency(n.note, "midi").toFrequency();
        padSynth.triggerAttackRelease(freq, durSec, audioT, n.vel / 127);

        const delayMs = Math.max(0, (audioT - Tone.context.currentTime) * 1000);
        const offMs = delayMs + n.beatDur * beatMs;
        const ch = n.ch & 0xf;
        const note = n.note,
          vel = n.vel;
        setTimeout(() => {
          sendToOutput([0x90 | ch, note, vel]);
          setTimeout(
            () => sendToOutput([0x80 | ch, note, 0]),
            n.beatDur * beatMs,
          );
        }, delayMs);
      }
    }
    prLastPrIdx = idx;
  }
}

setInterval(prSchedulerTick, PR_TICK_MS);

// ── Playhead rAF ──────────────────────────────────────────────
(function prRenderLoop() {
  if (typeof epochMs !== "undefined" && epochMs !== null && prEnabled) {
    const beatMs = (60 / state.bpm) * 1000;
    const elapsed = Date.now() + serverTimeOffset - epochMs;
    const playBeat = Math.max(0, elapsed / beatMs) % prTotalBeat();

    // Auto-scroll: keep playhead in view
    const playX = prBeatToX(playBeat);
    if (playX > prGridW * 0.85)
      prScrollBeat = prClamp(
        playBeat - (prGridW * 0.15) / prZoom,
        0,
        prTotalBeat(),
      );
    if (playX < 0) prScrollBeat = prClamp(playBeat, 0, prTotalBeat());

    drawGrid(playBeat);
  }
  requestAnimationFrame(prRenderLoop);
})();

// ── MIDI file parser ──────────────────────────────────────────
function parseMidi(buffer) {
  const b = new Uint8Array(buffer);
  let pos = 0;

  const r1 = () => b[pos++];
  const r2 = () => {
    const v = (b[pos] << 8) | b[pos + 1];
    pos += 2;
    return v;
  };
  const r4 = () => {
    const v = (r2() << 16) | r2();
    return v >>> 0;
  };
  const rVLQ = () => {
    let v = 0,
      byte;
    do {
      byte = r1();
      v = (v << 7) | (byte & 0x7f);
    } while (byte & 0x80);
    return v;
  };

  if (b[0] !== 0x4d || b[1] !== 0x54 || b[2] !== 0x68 || b[3] !== 0x64)
    return null;
  pos = 4;
  r4(); // skip 'MThd' + length
  const format = r2();
  const numTracks = r2();
  const division = r2();
  if (division & 0x8000) return null; // SMPTE not supported

  let tempoUs = 500000; // default 120 BPM
  const allNoteEvts = [];

  for (let t = 0; t < numTracks; t++) {
    if (
      b[pos] !== 0x4d ||
      b[pos + 1] !== 0x54 ||
      b[pos + 2] !== 0x72 ||
      b[pos + 3] !== 0x6b
    )
      break;
    pos += 4;
    const trkLen = r4();
    const trkEnd = pos + trkLen;
    let absT = 0,
      rs = 0;
    const open = {};

    while (pos < trkEnd) {
      absT += rVLQ();
      let status = b[pos];
      if (status & 0x80) {
        rs = status;
        pos++;
      } else {
        status = rs;
      }

      if (status === 0xff) {
        const mtype = r1(),
          mlen = rVLQ();
        if (mtype === 0x51 && mlen >= 3)
          ((tempoUs = (r1() << 16) | (r1() << 8) | r1()), (pos += mlen - 3));
        else pos += mlen;
      } else if (status === 0xf0 || status === 0xf7) {
        pos += rVLQ();
      } else {
        const msg = status & 0xf0,
          ch = status & 0x0f;
        if (msg === 0x90 || msg === 0x80) {
          const note = r1(),
            vel = r1();
          const isOn = msg === 0x90 && vel > 0;
          const key = `${ch}-${note}`;
          if (isOn) {
            open[key] = { absT, vel, ch, note };
          } else if (open[key]) {
            allNoteEvts.push({
              note,
              ch,
              vel: open[key].vel,
              tickOn: open[key].absT,
              tickOff: absT,
            });
            delete open[key];
          }
        } else if (msg === 0xa0 || msg === 0xb0 || msg === 0xe0) {
          pos += 2;
        } else if (msg === 0xc0 || msg === 0xd0) {
          pos += 1;
        }
      }
    }
    // Close any hanging notes at track end
    for (const k in open) {
      const o = open[k];
      allNoteEvts.push({
        note: o.note,
        ch: o.ch,
        vel: o.vel,
        tickOn: o.absT,
        tickOff: absT,
      });
    }
    pos = trkEnd;
  }

  return { tempoUs, division, notes: allNoteEvts };
}

function importParsedMidi({ tempoUs, division, notes }) {
  prNotes.length = 0;
  const bpt = 1 / division; // beats per tick
  let maxBeat = 0;

  for (const { note, ch, vel, tickOn, tickOff } of notes) {
    if (note < PR_NOTE_MIN || note > PR_NOTE_MAX) continue;
    const beatStart = tickOn * bpt;
    const beatDur = Math.max(0.0625, (tickOff - tickOn) * bpt);
    prNotes.push({ note, beatStart, beatDur, ch, vel });
    maxBeat = Math.max(maxBeat, beatStart + beatDur);
  }

  // Auto-set prBars — clamp to 1-32
  const barsNeeded = Math.ceil(maxBeat / 4);
  prBars = Math.min(32, Math.max(1, barsNeeded));
  document.getElementById("pr-bars").value = prBars;

  // Fit zoom so the full pattern fills the canvas with no gap on the right
  prScrollBeat = 0;
  prZoom = prClamp(prGridW / prTotalBeat(), prMinZoom(), 400);

  // BPM sync
  const fileBpm = Math.round(60_000_000 / tempoUs);
  if (fileBpm >= 60 && fileBpm <= 200) {
    state.bpm = fileBpm;
    document.getElementById("bpm").value = fileBpm;
    document.getElementById("bpm-val").textContent = fileBpm;
    if (typeof ws !== "undefined" && ws.readyState === WebSocket.OPEN)
      ws.send(JSON.stringify({ type: "bpm", bpm: fileBpm }));
  }

  // Scroll pitch to centroid of imported notes
  if (prNotes.length) {
    const avg = prNotes.reduce((s, n) => s + n.note, 0) / prNotes.length;
    prScrollPitch = prClamp(
      Math.round(avg) + Math.floor(prVisibleRows() / 2),
      PR_NOTE_MIN + prVisibleRows(),
      PR_NOTE_MAX,
    );
  }

  drawAll();
}

// ── Export ────────────────────────────────────────────────────
function exportPrMid() {
  if (prNotes.length === 0) return;
  const division = 480;
  const microsBeat = Math.round(60_000_000 / state.bpm);
  const tpb = division; // ticks per beat

  const trackData = [];
  trackData.push(
    ...vlq(0),
    0xff,
    0x51,
    0x03,
    (microsBeat >> 16) & 0xff,
    (microsBeat >> 8) & 0xff,
    microsBeat & 0xff,
  );

  const events = [];
  for (const n of prNotes) {
    const onTick = Math.round(n.beatStart * tpb);
    const offTick = Math.round((n.beatStart + n.beatDur) * tpb);
    events.push({ tick: onTick, bytes: [0x90 | (n.ch & 0xf), n.note, n.vel] });
    events.push({ tick: offTick, bytes: [0x80 | (n.ch & 0xf), n.note, 0] });
  }
  events.sort((a, b) => a.tick - b.tick || a.bytes[0] - b.bytes[0]);

  let prev = 0;
  for (const { tick, bytes } of events) {
    trackData.push(...vlq(Math.max(0, tick - prev)), ...bytes);
    prev = tick;
  }
  trackData.push(...vlq(0), 0xff, 0x2f, 0x00);

  const buf = [
    0x4d,
    0x54,
    0x68,
    0x64,
    0x00,
    0x00,
    0x00,
    0x06,
    0x00,
    0x00,
    0x00,
    0x01,
    (division >> 8) & 0xff,
    division & 0xff,
    0x4d,
    0x54,
    0x72,
    0x6b,
    (trackData.length >> 24) & 0xff,
    (trackData.length >> 16) & 0xff,
    (trackData.length >> 8) & 0xff,
    trackData.length & 0xff,
    ...trackData,
  ];

  const blob = new Blob([new Uint8Array(buf)], { type: "audio/midi" });
  const url = URL.createObjectURL(blob);
  const a = document.createElement("a");
  a.href = url;
  a.download = `piano-roll-${new Date().toISOString().slice(0, 19).replace(/:/g, "-")}.mid`;
  a.click();
  URL.revokeObjectURL(url);
}

// ── Init ──────────────────────────────────────────────────────
(function initPianoRoll() {
  // Channel select
  const chSel = document.getElementById("pr-ch");
  for (let i = 0; i < 16; i++) {
    const o = document.createElement("option");
    o.value = i;
    o.textContent = i === 9 ? "ch 10 (drums)" : `ch ${i + 1}`;
    chSel.appendChild(o);
  }

  // Toolbar wiring
  document.getElementById("pr-toggle-btn").addEventListener("click", () => {
    prEnabled = !prEnabled;
    document
      .getElementById("pr-toggle-btn")
      .classList.toggle("active", prEnabled);
    if (!prEnabled) prLastPrIdx = -1;
  });
  document.getElementById("pr-clear-btn").addEventListener("click", () => {
    prNotes.length = 0;
    prSaveCurrent();
    drawAll();
  });
  document.getElementById("pr-bars").addEventListener("change", (e) => {
    prBars = Math.min(32, Math.max(1, Math.round(+e.target.value) || 4));
    e.target.value = prBars; // normalise display
    prScrollBeat = 0;
    // Fit all bars in view so bars beyond 4 are immediately reachable
    prZoom = prClamp(prGridW / prTotalBeat(), prMinZoom(), 400);
    drawAll();
  });
  document.getElementById("pr-vel").addEventListener("input", (e) => {
    document.getElementById("pr-vel-val").textContent = e.target.value;
  });
  document
    .getElementById("pr-export-btn")
    .addEventListener("click", exportPrMid);

  // Zoom controls
  document.getElementById("pr-zoom-in").addEventListener("click", () => prZoomTo(prZoom * 1.4));
  document.getElementById("pr-zoom-out").addEventListener("click", () => prZoomTo(prZoom * 0.7));
  document.getElementById("pr-zoom-fit").addEventListener("click", prFitZoom);

  // Drag-and-drop MIDI import
  const dropZone = document.getElementById("pr-drop-zone");
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
        if (parsed) importParsedMidi(parsed);
      } catch (err) {
        console.error("MIDI parse error", err);
      }
    };
    reader.readAsArrayBuffer(file);
  });

  // Grid mouse events
  const grid = document.getElementById("pr-grid");
  grid.addEventListener("mousedown", prOnMouseDown);
  grid.addEventListener("mousemove", prOnMouseMove);
  grid.addEventListener("mouseup", prOnMouseUp);
  grid.addEventListener("mouseleave", prOnMouseUp);
  grid.addEventListener("contextmenu", (e) => {
    e.preventDefault();
    prOnMouseDown(e);
  });
  grid.addEventListener("wheel", prOnWheel, { passive: false });

  // Initial resize — run immediately, then again after first paint in case
  // the layout wasn't fully resolved yet (e.g. scrollbars, flex reflow)
  prResize();
  requestAnimationFrame(prResize);
  window.addEventListener("resize", prResize);

  // ── Pattern selector UI ─────────────────────────────────────
  (function prInitPatternBtns() {
    const container = document.getElementById("pr-pattern-btns");
    for (let i = 0; i < PR_PAT_COUNT; i++) {
      const btn = document.createElement("button");
      btn.className = "pat-btn";
      btn.textContent = i + 1;
      btn.dataset.pat = i;
      if (i === prCurrentPat) btn.classList.add("active");
      btn.addEventListener("click", () => prSwitchPattern(i));
      container.appendChild(btn);
    }
  })();

  document.getElementById("pr-queue-btn").addEventListener("click", () => {
    prQueueMode = !prQueueMode;
    const btn = document.getElementById("pr-queue-btn");
    btn.textContent = prQueueMode ? "QUEUE" : "INSTANT";
    btn.classList.toggle("active", prQueueMode);
  });

  // ── Chain sequencer UI ──────────────────────────────────────
  prRenderChainSlots();

  document.getElementById("pr-chain-btn").addEventListener("click", () => {
    prChainEnabled = !prChainEnabled;
    document.getElementById("pr-chain-btn").classList.toggle("active", prChainEnabled);
    if (prChainEnabled) {
      const first = prChainFirstActive();
      if (first !== null) {
        prChainPos = first;
        prSaveCurrent();
        prLoadPattern(prChain[first]);
      }
    }
    prUpdateChainUI();
  });
})();
