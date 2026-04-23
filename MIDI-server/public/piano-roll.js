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
let prScrollPitch = 84; // MIDI note at top of viewport (C6)
let prScrollBeat = 0; // beat offset at left edge
let prZoom = 80; // px per beat
let prRowH = 10; // px per semitone
let prLastPrIdx = -1;
let prDrag = null; // { noteIdx, offsetBeat, origNote } | { adding, note }
let prKeysCtx, prRulerCtx, prGridCtx;
let prGridW = 1,
  prGridH = 1; // logical (CSS) grid dimensions
let prDpr = 1;

// ── Helpers ──────────────────────────────────────────────────
function prVisibleRows() {
  return Math.ceil(prGridH / prRowH);
}
function prTotalBeat() {
  return prBars * 4;
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

    // Octave label at each C
    if (semi === 0) {
      const oct = Math.floor(n / 12) - 1;
      ctx.fillStyle = "#05af90";
      ctx.font = '7px "Courier New", monospace';
      ctx.fillText(`C${oct}`, 2, y + prRowH - 2);
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
  const beatEnd = Math.ceil(prScrollBeat + prGridW / prZoom) + 1;

  for (let b = beatStart; b <= beatEnd; b++) {
    const x = prBeatToX(b);
    if (x < 0 || x > prGridW) continue;
    const bar = Math.floor(b / 4);
    const beatInBar = b % 4;
    const isBar = beatInBar === 0;

    ctx.strokeStyle = isBar ? "rgba(255,34,34,0.7)" : "rgba(255,34,34,0.3)";
    ctx.lineWidth = 1;
    ctx.beginPath();
    ctx.moveTo(x, isBar ? 0 : h * 0.5);
    ctx.lineTo(x, h);
    ctx.stroke();

    if (isBar) {
      ctx.fillStyle = "#ff3c3c";
      ctx.font = '9px "Courier New", monospace';
      ctx.fillText(`${bar + 1}`, x + 3, h - 5);
    } else {
      ctx.fillStyle = "rgba(102,12,12,0.8)";
      ctx.font = '7px "Courier New", monospace';
      ctx.fillText(`${beatInBar + 1}`, x + 2, h - 4);
    }

    // 1/16th subdivision ticks
    for (let sub = 1; sub < 4; sub++) {
      const sx = x + (sub / 4) * prZoom;
      if (sx < 0 || sx > prGridW) continue;
      ctx.strokeStyle = "rgba(102,12,12,0.3)";
      ctx.beginPath();
      ctx.moveTo(sx, h * 0.75);
      ctx.lineTo(sx, h);
      ctx.stroke();
    }
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
  const beatEnd = Math.ceil(prScrollBeat + w / prZoom) + 1;

  for (let b = beatStart; b <= beatEnd; b++) {
    const x = prBeatToX(b);
    if (x < 0 || x > w) continue;
    const isBar = b % 4 === 0;
    ctx.strokeStyle = isBar ? "rgba(255,34,34,0.22)" : "rgba(102,12,12,0.18)";
    ctx.lineWidth = 1;
    ctx.beginPath();
    ctx.moveTo(x, 0);
    ctx.lineTo(x, h);
    ctx.stroke();

    // 1/16 subdivisions
    for (let sub = 1; sub < 4; sub++) {
      const sx = x + (sub / 4) * prZoom;
      if (sx < 0 || sx > w) continue;
      ctx.strokeStyle = "rgba(102,12,12,0.08)";
      ctx.beginPath();
      ctx.moveTo(sx, 0);
      ctx.lineTo(sx, h);
      ctx.stroke();
    }
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

  prGridW = wrap.clientWidth - PR_KEYS_W;
  prGridH = wrap.clientHeight - PR_RULER_H;

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
    const end = prClamp(prSnapBeat(beat), 0.25, prTotalBeat());
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
    prZoom = prClamp(prZoom * (delta > 0 ? 0.85 : 1.18), 20, 400);
  } else if (e.shiftKey) {
    prScrollBeat = prClamp(prScrollBeat + delta / prZoom, 0, prTotalBeat());
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

  // Auto-set prBars
  const barsNeeded = Math.ceil(maxBeat / 4);
  prBars = [1, 2, 4, 8, 16, 32].find((v) => v >= barsNeeded) ?? 32;
  const barsSel = document.getElementById("pr-bars");
  barsSel.value = Math.min(prBars, 8).toString();
  if (!barsSel.value) {
    // value > 8: add a temporary option
    const opt = document.createElement("option");
    opt.value = prBars;
    opt.textContent = prBars;
    barsSel.appendChild(opt);
    barsSel.value = prBars;
  }

  // BPM sync
  const fileBpm = Math.round(60_000_000 / tempoUs);
  if (fileBpm >= 60 && fileBpm <= 200) {
    state.bpm = fileBpm;
    document.getElementById("bpm").value = fileBpm;
    document.getElementById("bpm-val").textContent = fileBpm;
    if (typeof ws !== "undefined" && ws.readyState === WebSocket.OPEN)
      ws.send(JSON.stringify({ type: "bpm", bpm: fileBpm }));
  }

  // Scroll to centroid
  if (prNotes.length) {
    const avg = prNotes.reduce((s, n) => s + n.note, 0) / prNotes.length;
    prScrollPitch = prClamp(
      Math.round(avg) + Math.floor(prVisibleRows() / 2),
      PR_NOTE_MIN + prVisibleRows(),
      PR_NOTE_MAX,
    );
    prScrollBeat = 0;
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
    drawAll();
  });
  document.getElementById("pr-bars").addEventListener("change", (e) => {
    prBars = +e.target.value;
    drawAll();
  });
  document.getElementById("pr-vel").addEventListener("input", (e) => {
    document.getElementById("pr-vel-val").textContent = e.target.value;
  });
  document
    .getElementById("pr-export-btn")
    .addEventListener("click", exportPrMid);
  document.getElementById("pr-file-input").addEventListener("change", (e) => {
    const file = e.target.files[0];
    if (!file) return;
    if (file.size > 2_000_000) { console.warn('MIDI file too large (>2MB)'); return; }
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
    e.target.value = "";
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

  // Initial resize + observe
  prResize();
  window.addEventListener("resize", prResize);
})();
