/* ── Mixer ────────────────────────────────────────────────────
   Inline volume faders placed next to the synth they control.
   Master in transport, pad/click in keyboard, drums in grid rows.
   ──────────────────────────────────────────────────────────── */

function mixerBuildFader(getChannel, label) {
  const wrap = document.createElement("span");
  wrap.className = "mx-inline";

  const lbl = document.createElement("span");
  lbl.className = "mx-inline-label";
  lbl.textContent = label;
  wrap.appendChild(lbl);

  const fader = document.createElement("input");
  fader.type = "range";
  fader.className = "mx-inline-fader";
  fader.min = -40;
  fader.max = 6;
  fader.step = 0.5;
  const ch = getChannel();
  fader.value = ch ? ch.volume.value : 0;
  fader.addEventListener("input", () => {
    const c = getChannel();
    if (c) c.volume.value = +fader.value;
    db.textContent = fader.value > 0 ? `+${fader.value}` : fader.value;
  });
  wrap.appendChild(fader);

  const db = document.createElement("span");
  db.className = "mx-inline-db";
  const v = ch ? ch.volume.value : 0;
  db.textContent = v > 0 ? `+${v}` : v;
  wrap.appendChild(db);

  const mute = document.createElement("button");
  mute.className = "mx-inline-mute";
  mute.textContent = "M";
  mute.addEventListener("click", () => {
    const c = getChannel();
    if (!c) return;
    c.mute = !c.mute;
    mute.classList.toggle("active", c.mute);
  });
  wrap.appendChild(mute);

  return wrap;
}

function mixerBuildUI() {
  // Master fader in transport
  const masterEl = document.getElementById("mx-master-strip");
  if (masterEl) {
    masterEl.innerHTML = "";
    masterEl.appendChild(mixerBuildFader(() => masterChannel, "MST"));
  }

  // Pad synth fader in keyboard section
  const padEl = document.getElementById("mx-pad-strip");
  if (padEl) {
    padEl.innerHTML = "";
    padEl.appendChild(mixerBuildFader(() => padChannel, "PAD"));
  }

  // Click fader in keyboard section
  const clickEl = document.getElementById("mx-click-strip");
  if (clickEl) {
    clickEl.innerHTML = "";
    clickEl.appendChild(mixerBuildFader(() => clickChannel, "CLK"));
  }
}

// Drum faders are built per-row inside dmRenderGrid via this helper
function mixerBuildDrumFader(sampleKey) {
  return mixerBuildFader(() => dmChannelMap[sampleKey], "VOL");
}

mixerBuildUI();
