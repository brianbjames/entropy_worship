/* ── Mixer ────────────────────────────────────────────────────
   Per-channel Volume, Pan, Mute, Solo for all instruments.
   Compact vertical layout — one row per channel.
   ──────────────────────────────────────────────────────────── */

const MIXER_STRIPS = [
  { id: "master", label: "MST",    get ch() { return masterChannel; } },
  { id: "pad",    label: "PAD",    get ch() { return padChannel; } },
  { id: "click",  label: "CLK",    get ch() { return clickChannel; } },
  { id: "kick",   label: "KICK",   get ch() { return dmChannelMap.kick; } },
  { id: "snare",  label: "SNR",    get ch() { return dmChannelMap.snare; } },
  { id: "tomL",   label: "TML",    get ch() { return dmChannelMap.tomL; } },
  { id: "tomH",   label: "TMH",    get ch() { return dmChannelMap.tomH; } },
  { id: "clap",   label: "CLP",    get ch() { return dmChannelMap.clap; } },
  { id: "hhO",    label: "HHO",    get ch() { return dmChannelMap.hihatOpen; } },
  { id: "hhC",    label: "HHC",    get ch() { return dmChannelMap.hihatClose; } },
  { id: "cymbal", label: "CYM",    get ch() { return dmChannelMap.cymbal; } },
  { id: "rim",    label: "RIM",    get ch() { return dmChannelMap.rim; } },
  { id: "ride",   label: "RDE",    get ch() { return dmChannelMap.ride; } },
];

function mixerBuildUI() {
  const container = document.getElementById("mixer-strips");
  container.innerHTML = "";

  MIXER_STRIPS.forEach((strip) => {
    const row = document.createElement("div");
    row.className = "mx-row";
    if (strip.id === "master") row.classList.add("mx-master");

    // Label
    const label = document.createElement("span");
    label.className = "mx-label";
    label.textContent = strip.label;
    row.appendChild(label);

    // Mute
    const mute = document.createElement("button");
    mute.className = "mx-mute";
    mute.textContent = "M";
    mute.addEventListener("click", () => {
      if (!strip.ch) return;
      strip.ch.mute = !strip.ch.mute;
      mute.classList.toggle("active", strip.ch.mute);
    });
    row.appendChild(mute);

    // Solo
    const solo = document.createElement("button");
    solo.className = "mx-solo";
    solo.textContent = "S";
    solo.addEventListener("click", () => {
      if (!strip.ch) return;
      strip.ch.solo = !strip.ch.solo;
      solo.classList.toggle("active", strip.ch.solo);
    });
    row.appendChild(solo);

    // Volume fader
    const fader = document.createElement("input");
    fader.type = "range";
    fader.className = "mx-fader";
    fader.min = -40;
    fader.max = 6;
    fader.step = 0.5;
    fader.value = strip.ch ? strip.ch.volume.value : 0;
    fader.addEventListener("input", () => {
      if (strip.ch) strip.ch.volume.value = +fader.value;
      db.textContent = fader.value > 0 ? `+${fader.value}` : fader.value;
    });
    row.appendChild(fader);

    // dB
    const db = document.createElement("span");
    db.className = "mx-db";
    const v = strip.ch ? strip.ch.volume.value : 0;
    db.textContent = v > 0 ? `+${v}` : v;
    row.appendChild(db);

    // Pan
    const pan = document.createElement("input");
    pan.type = "range";
    pan.className = "mx-pan";
    pan.min = -1;
    pan.max = 1;
    pan.step = 0.05;
    pan.value = strip.ch ? strip.ch.pan.value : 0;
    pan.addEventListener("input", () => {
      if (strip.ch) strip.ch.pan.value = +pan.value;
    });
    row.appendChild(pan);

    container.appendChild(row);
  });
}

mixerBuildUI();
