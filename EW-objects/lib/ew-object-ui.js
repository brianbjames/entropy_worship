// ============================================================
// EW Object UI — ew-object-ui.js
// Shared UI helpers for EW object pages.
// Builds standard header bars, port panels, status indicators.
// ============================================================

/**
 * Build the standard header bar for an EW object page.
 * @param {EWObject} ewObj - The EWObject instance
 * @param {string} title - Page title (e.g. "OSCILLATOR")
 * @param {HTMLElement} container - Container element to append into
 */
export function buildHeaderBar(ewObj, title, container) {
  const header = document.createElement("header");
  header.innerHTML = `
    <h1 class="hud-title">EW // ${title}</h1>
    <div id="meta">
      <span class="status-item">
        <span class="status-dot offline" id="ew-status-dot"></span>
        <span id="ew-status-text">OFFLINE</span>
      </span>
      <span id="ew-room-display"></span>
      <span id="ew-peers">0 PLR</span>
      <span id="ew-latency"></span>
    </div>
  `;
  container.appendChild(header);

  // Wire up events
  ewObj.on("connected", () => {
    const dot = document.getElementById("ew-status-dot");
    const text = document.getElementById("ew-status-text");
    dot.className = "status-dot live";
    text.textContent = "ONLINE";
    document.getElementById("ew-room-display").textContent =
      ewObj.getOutputRoom();
  });

  ewObj.on("disconnected", () => {
    const dot = document.getElementById("ew-status-dot");
    const text = document.getElementById("ew-status-text");
    dot.className = "status-dot error";
    text.textContent = "OFFLINE";
  });

  ewObj.on("peers", (msg) => {
    const count = msg.count || msg.peers.length;
    document.getElementById("ew-peers").textContent = `${count} PLR`;
    // Show our own latency
    if (ewObj._outputConn) {
      const ms = Math.round(ewObj.getRTT() / 2);
      document.getElementById("ew-latency").textContent =
        ms > 0 ? `${ms} ms` : "";
    }
  });
}

/**
 * Build the output panel showing the room URL with copy button.
 * @param {EWObject} ewObj
 * @param {HTMLElement} container
 */
export function buildOutputPanel(ewObj, container) {
  const panel = document.createElement("div");
  panel.className = "hud-panel clip-br";
  panel.innerHTML = `
    <div class="section-title mint">// OUTPUT ROOM //</div>
    <div style="display:flex; gap:10px; align-items:center; margin-bottom:10px">
      <span class="type-mono" id="ew-output-room" style="flex:1; word-break:break-all"></span>
      <button class="btn btn-sm btn-mint" id="ew-copy-room">COPY</button>
    </div>
    <div class="stats-row" id="ew-output-stats"></div>
  `;
  container.appendChild(panel);

  // Wire copy button
  panel.querySelector("#ew-copy-room").addEventListener("click", () => {
    const room = ewObj.getOutputRoom();
    if (room) {
      navigator.clipboard.writeText(room).then(() => {
        const btn = document.getElementById("ew-copy-room");
        btn.textContent = "COPIED";
        setTimeout(() => (btn.textContent = "COPY"), 1500);
      });
    }
  });

  // Update room display when connected
  ewObj.on("connected", () => {
    document.getElementById("ew-output-room").textContent =
      ewObj.getOutputRoom();
  });
}

/**
 * Build output stats row showing current port values.
 * @param {EWObject} ewObj
 * @param {Array} ports - Array of {port, label, unit, formatter} objects
 */
export function updateOutputStats(ewObj, ports) {
  const el = document.getElementById("ew-output-stats");
  if (!el) return;

  el.innerHTML = ports
    .map((p) => {
      const val = ewObj.getOutput(p.port);
      const display = p.formatter ? p.formatter(val) : val;
      const unit = p.unit || "";
      return `
      <div class="stat-block">
        <div class="stat-label">${p.label || p.port}</div>
        <div class="stat-val">${display}<span class="stat-unit">${unit}</span></div>
      </div>`;
    })
    .join("");
}

/**
 * Build the input ports panel.
 * @param {EWObject} ewObj
 * @param {HTMLElement} container
 */
export function buildInputPanel(ewObj, container) {
  const panel = document.createElement("div");
  panel.className = "hud-panel";
  panel.innerHTML = `
    <div class="section-title rose">// INPUT CONNECTIONS //</div>
    <div id="ew-input-ports"></div>
  `;
  container.appendChild(panel);

  const portsEl = panel.querySelector("#ew-input-ports");
  for (const def of ewObj.inputDefs) {
    const portEl = document.createElement("div");
    portEl.className = "control-group";
    portEl.setAttribute("data-port", def.port);
    portEl.innerHTML = `
      <div class="control-label" style="display:flex; justify-content:space-between; align-items:center">
        <span>${def.port.toUpperCase()} ${def.unit ? `(${def.unit})` : ""}</span>
        <span class="status-item" style="gap:4px">
          <span class="status-dot offline" id="ew-input-dot-${def.port}"></span>
          <span class="type-dim" id="ew-input-src-${def.port}">—</span>
        </span>
      </div>
      <div style="display:flex; gap:8px; align-items:center">
        <input type="text" id="ew-input-room-${def.port}" placeholder="PASTE ROOM NAME..." style="flex:1">
        <button class="btn btn-sm btn-mint" id="ew-input-connect-${def.port}">LINK</button>
        <button class="btn btn-sm btn-rose" id="ew-input-disconnect-${def.port}" style="display:none">UNLINK</button>
      </div>
    `;
    portsEl.appendChild(portEl);

    // Wire connect/disconnect buttons
    const connectBtn = portEl.querySelector(
      `#ew-input-connect-${def.port}`
    );
    const disconnectBtn = portEl.querySelector(
      `#ew-input-disconnect-${def.port}`
    );
    const input = portEl.querySelector(`#ew-input-room-${def.port}`);
    const dot = portEl.querySelector(`#ew-input-dot-${def.port}`);
    const src = portEl.querySelector(`#ew-input-src-${def.port}`);

    connectBtn.addEventListener("click", () => {
      const room = input.value.trim();
      if (!room) return;
      // Map both the matching port name AND "signal" to this local port.
      // This way a source sending waveform data on "signal" (bipolar)
      // or parameter data on the same port name both arrive here.
      const mapping = { [def.port]: def.port, signal: def.port };
      const ok = ewObj.subscribe(room, mapping);
      if (ok) {
        dot.className = "status-dot warn";
        src.textContent = room;
        connectBtn.style.display = "none";
        disconnectBtn.style.display = "";
        input.disabled = true;
      }
    });

    disconnectBtn.addEventListener("click", () => {
      const room = input.value.trim();
      ewObj.unsubscribe(room);
      dot.className = "status-dot offline";
      src.textContent = "—";
      disconnectBtn.style.display = "none";
      connectBtn.style.display = "";
      input.disabled = false;
    });

    // Enter key to connect
    input.addEventListener("keydown", (e) => {
      if (e.key === "Enter") connectBtn.click();
    });
  }

  // Update dots when input connections change state
  ewObj.on("inputConnected", ({ room, portMapping }) => {
    for (const localPort of Object.values(portMapping)) {
      const dot = document.getElementById(`ew-input-dot-${localPort}`);
      if (dot) dot.className = "status-dot live";
    }
  });

  ewObj.on("inputDisconnected", ({ room }) => {
    // Reset any dots that were connected to this room
    for (const def of ewObj.inputDefs) {
      const dot = document.getElementById(`ew-input-dot-${def.port}`);
      const src = document.getElementById(`ew-input-src-${def.port}`);
      if (src && src.textContent === room) {
        if (dot) dot.className = "status-dot offline";
        src.textContent = "—";
      }
    }
  });
}

/**
 * Build the AudioContext unlock overlay.
 * @param {string} title - Object title
 * @param {Function} onUnlock - Callback when user clicks to unlock
 */
export function buildUnlockOverlay(title, onUnlock) {
  const overlay = document.createElement("div");
  overlay.id = "unlock-overlay";
  overlay.style.cssText = `
    position: fixed; top:0; left:0; right:0; bottom:0;
    background: rgba(0,0,0,0.92); z-index: 10000;
    display: flex; flex-direction: column;
    align-items: center; justify-content: center;
    cursor: pointer;
  `;
  overlay.innerHTML = `
    <div class="type-h2" style="margin-bottom:12px; color:var(--accent); animation:title-glow 3s ease-in-out infinite">
      EW // ${title}
    </div>
    <button class="btn btn-lg" id="unlock-btn" style="font-size:1.2rem; padding:12px 36px">
      ▶ ENTER
    </button>
    <div class="type-dim" style="margin-top:12px">click to enable audio context</div>
  `;
  document.body.appendChild(overlay);

  overlay.querySelector("#unlock-btn").addEventListener("click", async () => {
    await onUnlock();
    overlay.style.display = "none";
  });
}

/**
 * Wire a range slider to update its CSS --val custom property
 * and display the current value in a readout element.
 * @param {string} sliderId - Range input element ID
 * @param {string} displayId - Readout element ID
 * @param {Function} [formatter] - Format value for display
 */
export function wireRange(sliderId, displayId, formatter) {
  const slider = document.getElementById(sliderId);
  const display = document.getElementById(displayId);
  if (!slider) return;

  function update() {
    const pct =
      ((slider.value - slider.min) / (slider.max - slider.min)) * 100;
    slider.style.setProperty("--val", pct + "%");
    if (display) {
      display.textContent = formatter
        ? formatter(+slider.value)
        : slider.value;
    }
  }

  slider.addEventListener("input", update);
  update(); // Set initial state
}
