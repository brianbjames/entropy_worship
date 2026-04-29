// ============================================================
// EW Object Base — ew-object-base.js
// Core module for the EW distributed modular audio system.
// Handles WebSocket rooms, NTP clock sync, signal I/O, ports.
// ============================================================

// Production WebSocket server
const WS_PROD = "wss://ew-objects-production.up.railway.app";
const WS_LOCAL_PORT = 3001;

function resolveWsBase() {
  const IS_LOCAL =
    location.hostname === "localhost" || location.hostname === "127.0.0.1";
  if (IS_LOCAL) {
    const proto = location.protocol === "https:" ? "wss:" : "ws:";
    return `${proto}//${location.hostname}:${WS_LOCAL_PORT}`;
  }
  return WS_PROD;
}

function sanitizeRoom(name) {
  return (name || "")
    .trim()
    .replace(/[^a-zA-Z0-9_-]/g, "")
    .slice(0, 32);
}

function randomRoom(prefix) {
  const id = Math.random().toString(36).slice(2, 8).toUpperCase();
  return prefix ? `${prefix}-${id}` : id;
}

// ── Single WebSocket connection with NTP sync ────────────────

class RoomConnection {
  constructor(wsBase, roomName, handlers = {}) {
    this.wsBase = wsBase;
    this.roomName = roomName;
    this.handlers = handlers; // { onSignal, onState, onPeers, onOpen, onClose, onObjectList }
    this.ws = null;
    this.clientId = null;
    this.serverTimeOffset = 0;
    this.rttMs = 0;
    this._syncSamples = [];
    this._pingTimer = null;
    this._reconnectTimer = null;
    this._destroyed = false;
  }

  connect() {
    if (this._destroyed) return;
    const url = `${this.wsBase}?room=${encodeURIComponent(this.roomName)}`;
    this.ws = new WebSocket(url);

    this.ws.onopen = () => {
      this._sendPing();
      this._pingTimer = setInterval(() => this._sendPing(), 4000);
      if (this.handlers.onOpen) this.handlers.onOpen(this);
    };

    this.ws.onclose = () => {
      this._cleanup();
      if (this.handlers.onClose) this.handlers.onClose(this);
      // Auto-reconnect after 3s
      if (!this._destroyed) {
        this._reconnectTimer = setTimeout(() => this.connect(), 3000);
      }
    };

    this.ws.onerror = () => {
      // onclose will fire after onerror
    };

    this.ws.onmessage = ({ data }) => {
      let msg;
      try {
        msg = JSON.parse(data);
      } catch {
        return;
      }
      this._handleMessage(msg);
    };
  }

  send(msg) {
    if (this.ws && this.ws.readyState === WebSocket.OPEN) {
      this.ws.send(JSON.stringify(msg));
    }
  }

  destroy() {
    this._destroyed = true;
    this._cleanup();
    if (this.ws) {
      this.ws.onclose = null; // prevent reconnect
      this.ws.close();
      this.ws = null;
    }
  }

  get connected() {
    return this.ws && this.ws.readyState === WebSocket.OPEN;
  }

  getServerTime() {
    return Date.now() + this.serverTimeOffset;
  }

  // ── Internal ───────────────────────────────────────────────

  _cleanup() {
    if (this._pingTimer) {
      clearInterval(this._pingTimer);
      this._pingTimer = null;
    }
    if (this._reconnectTimer) {
      clearTimeout(this._reconnectTimer);
      this._reconnectTimer = null;
    }
  }

  _sendPing() {
    this.send({ type: "ping", t0: Date.now() });
  }

  _handlePong({ t0, t1, t2 }) {
    const t3 = Date.now();
    this.rttMs = t3 - t0 - (t2 - t1);
    const sample = (t1 - t0 + (t2 - t3)) / 2;
    this._syncSamples.push(sample);
    if (this._syncSamples.length > 8) this._syncSamples.shift();
    const sorted = [...this._syncSamples].sort((a, b) => a - b);
    this.serverTimeOffset = sorted[Math.floor(sorted.length / 2)];

    // Report RTT to server
    this.send({ type: "latency", rtt: this.rttMs });
  }

  _handleMessage(msg) {
    switch (msg.type) {
      case "pong":
        this._handlePong(msg);
        break;

      case "state":
        this.clientId = msg.clientId;
        if (this.handlers.onState) this.handlers.onState(msg, this);
        break;

      case "peers":
        if (this.handlers.onPeers) this.handlers.onPeers(msg, this);
        break;

      case "signal":
        if (this.handlers.onSignal) this.handlers.onSignal(msg, this);
        break;

      case "objectList":
        if (this.handlers.onObjectList) this.handlers.onObjectList(msg, this);
        break;

      case "rooms":
        if (this.handlers.onRooms) this.handlers.onRooms(msg, this);
        break;

      case "roomPrivate":
        if (this.handlers.onRoomPrivate) this.handlers.onRoomPrivate(msg, this);
        break;

      default:
        // Forward any unhandled message types
        if (this.handlers.onMessage) this.handlers.onMessage(msg, this);
        break;
    }
  }
}

// ── EWObject — Main class ────────────────────────────────────

export class EWObject {
  /**
   * @param {Object} config
   * @param {string} config.name - Display name (e.g. "OSC-1")
   * @param {string} config.objectType - Module type (e.g. "oscillator")
   * @param {Array}  config.inputs  - Input port definitions [{port, type, unit, min, max, default}]
   * @param {Array}  config.outputs - Output port definitions [{port, type, unit}]
   * @param {string} [config.roomPrefix] - Prefix for auto-generated room names
   */
  constructor({ name, objectType, inputs = [], outputs = [], roomPrefix }) {
    this.name = name;
    this.objectType = objectType;
    this.inputDefs = inputs;
    this.outputDefs = outputs;
    this.roomPrefix = roomPrefix || objectType || "ew";

    this._wsBase = resolveWsBase();
    this._outputConn = null;
    this._outputRoom = null;
    this._inputConns = new Map(); // roomName → { conn, portMapping }
    this._inputCallbacks = new Map(); // portName → [callbacks]
    this._outputValues = {}; // portName → current value
    this._eventHandlers = {}; // event → [handlers]

    // Throttle state for setOutput
    this._throttleTimers = new Map(); // portName → timer
    this._throttlePending = new Map(); // portName → {value, unit}
    this._THROTTLE_MS = 33; // ~30Hz

    // Initialize output values from defaults
    for (const def of inputs) {
      if (def.default !== undefined) {
        this._outputValues[def.port] = def.default;
      }
    }
  }

  // ── Room / Connection ──────────────────────────────────────

  /**
   * Connect to the output room. Call this once on initialization.
   * @param {string} [roomName] - Room name. Auto-generated if omitted.
   */
  connectOutput(roomName) {
    if (this._outputConn) {
      this._outputConn.destroy();
    }

    this._outputRoom =
      sanitizeRoom(roomName) || randomRoom(this.roomPrefix);

    // Update URL bar with room name
    const url = new URL(location.href);
    url.searchParams.set("room", this._outputRoom);
    history.replaceState(null, "", url.toString());

    this._outputConn = new RoomConnection(
      this._wsBase,
      this._outputRoom,
      {
        onOpen: () => {
          this._emit("connected", {
            room: this._outputRoom,
            type: "output",
          });
          // Announce ourselves
          this._sendObjectInfo();
          // Broadcast current state to late joiners
          this._broadcastFullState();
        },
        onClose: () => {
          this._emit("disconnected", {
            room: this._outputRoom,
            type: "output",
          });
        },
        onState: (msg) => {
          this._emit("stateSync", msg);
        },
        onPeers: (msg) => {
          this._emit("peers", msg);
        },
        onSignal: (msg) => {
          // Signals arriving on the output room (from other objects publishing here)
          this._routeIncomingSignal(msg);
        },
        onObjectList: (msg) => {
          this._emit("objectList", msg);
        },
        onRooms: (msg) => {
          this._emit("rooms", msg);
        },
        onRoomPrivate: (msg) => {
          this._emit("roomPrivate", msg);
        },
      }
    );

    this._outputConn.connect();
    return this._outputRoom;
  }

  /**
   * Returns the current output room name.
   */
  getOutputRoom() {
    return this._outputRoom;
  }

  /**
   * Returns the full WebSocket URL for the output room.
   */
  getOutputURL() {
    if (!this._outputRoom) return null;
    return `${this._wsBase}?room=${encodeURIComponent(this._outputRoom)}`;
  }

  /**
   * Toggle room privacy.
   */
  setPrivate(isPrivate) {
    if (!this._outputConn) return;
    this._outputConn.send({ type: "setPrivate", private: isPrivate });
  }

  // ── Input Subscriptions ────────────────────────────────────

  /**
   * Subscribe to another object's room.
   * @param {string} roomName - Remote room name to subscribe to
   * @param {Object} portMapping - Maps remote output ports to local input ports
   *                               e.g. { "frequency": "frequency", "gain": "gain" }
   *                               Keys = remote port names, Values = local port names
   * @returns {boolean} success
   */
  subscribe(roomName, portMapping = {}) {
    const clean = sanitizeRoom(roomName);
    if (!clean) return false;

    // Don't subscribe to own output room
    if (clean === this._outputRoom) return false;

    // If already subscribed to this room, merge the port mapping
    const existing = this._inputConns.get(clean);
    if (existing) {
      Object.assign(existing.portMapping, portMapping);
      this._emit("inputConnected", { room: clean, portMapping: existing.portMapping });
      return true;
    }

    const mergedMapping = { ...portMapping };
    const conn = new RoomConnection(this._wsBase, clean, {
      onOpen: () => {
        this._emit("inputConnected", { room: clean, portMapping: mergedMapping });
      },
      onClose: () => {
        this._emit("inputDisconnected", { room: clean });
      },
      onSignal: (msg) => {
        this._routeSubscribedSignal(msg, clean, mergedMapping);
      },
    });

    this._inputConns.set(clean, { conn, portMapping: mergedMapping });
    conn.connect();
    return true;
  }

  /**
   * Unsubscribe a specific port from a room, or the entire room.
   * @param {string} roomName
   * @param {string} [localPort] - If provided, only remove this port's mapping.
   *                                Disconnects the room if no mappings remain.
   */
  unsubscribe(roomName, localPort) {
    const clean = sanitizeRoom(roomName);
    const entry = this._inputConns.get(clean);
    if (!entry) return;

    if (localPort) {
      // Remove only the mappings that target this local port
      for (const [remote, local] of Object.entries(entry.portMapping)) {
        if (local === localPort) {
          delete entry.portMapping[remote];
        }
      }
      // If no mappings remain, disconnect entirely
      if (Object.keys(entry.portMapping).length === 0) {
        entry.conn.destroy();
        this._inputConns.delete(clean);
        this._emit("inputDisconnected", { room: clean });
      }
    } else {
      // Disconnect entirely
      entry.conn.destroy();
      this._inputConns.delete(clean);
      this._emit("inputDisconnected", { room: clean });
    }
  }

  /**
   * List active input subscriptions.
   */
  getSubscriptions() {
    const subs = [];
    for (const [room, { conn, portMapping }] of this._inputConns) {
      subs.push({
        room,
        connected: conn.connected,
        portMapping,
        rtt: conn.rttMs,
      });
    }
    return subs;
  }

  // ── Signal I/O ─────────────────────────────────────────────

  /**
   * Set an output value and broadcast to the output room.
   * Throttled to ~30Hz for continuous parameters.
   * @param {string} port - Output port name
   * @param {*} value - Current value
   * @param {Object} [opts] - { unit, immediate }
   */
  setOutput(port, value, opts = {}) {
    this._outputValues[port] = value;

    if (opts.immediate) {
      this._sendSignal(port, value, opts.unit);
      return;
    }

    // Throttle continuous updates
    this._throttlePending.set(port, { value, unit: opts.unit });
    if (!this._throttleTimers.has(port)) {
      this._throttleTimers.set(
        port,
        setTimeout(() => {
          this._throttleTimers.delete(port);
          const pending = this._throttlePending.get(port);
          if (pending) {
            this._throttlePending.delete(port);
            this._sendSignal(port, pending.value, pending.unit);
          }
        }, this._THROTTLE_MS)
      );
    }
  }

  /**
   * Broadcast full state bundle.
   */
  setOutputBundle(bundle) {
    // Update local values
    for (const [port, data] of Object.entries(bundle)) {
      this._outputValues[port] = data.value !== undefined ? data.value : data;
    }
    this._broadcastFullState();
  }

  /**
   * Register a callback for incoming values on an input port.
   * @param {string} port - Input port name
   * @param {Function} callback - fn(value, meta) where meta = { from, room, port }
   */
  onInput(port, callback) {
    if (!this._inputCallbacks.has(port)) {
      this._inputCallbacks.set(port, []);
    }
    this._inputCallbacks.get(port).push(callback);
  }

  /**
   * Get the current value of an output port.
   */
  getOutput(port) {
    return this._outputValues[port];
  }

  // ── Clock Sync ─────────────────────────────────────────────

  /**
   * Returns current NTP-synced server time (ms).
   */
  getServerTime() {
    return this._outputConn ? this._outputConn.getServerTime() : Date.now();
  }

  /**
   * Returns current round-trip time (ms) for the output connection.
   */
  getRTT() {
    return this._outputConn ? this._outputConn.rttMs : 0;
  }

  /**
   * Returns the server time offset (ms).
   */
  getClockOffset() {
    return this._outputConn ? this._outputConn.serverTimeOffset : 0;
  }

  // ── Events ─────────────────────────────────────────────────

  /**
   * Register an event handler.
   * Events: 'connected', 'disconnected', 'peers', 'input',
   *         'inputConnected', 'inputDisconnected', 'stateSync',
   *         'objectList', 'rooms'
   */
  on(event, handler) {
    if (!this._eventHandlers[event]) {
      this._eventHandlers[event] = [];
    }
    this._eventHandlers[event].push(handler);
  }

  /**
   * Remove an event handler.
   */
  off(event, handler) {
    const handlers = this._eventHandlers[event];
    if (handlers) {
      const idx = handlers.indexOf(handler);
      if (idx >= 0) handlers.splice(idx, 1);
    }
  }

  // ── Lifecycle ──────────────────────────────────────────────

  /**
   * Destroy all connections and clean up.
   */
  destroy() {
    if (this._outputConn) {
      this._outputConn.destroy();
      this._outputConn = null;
    }
    for (const { conn } of this._inputConns.values()) {
      conn.destroy();
    }
    this._inputConns.clear();
    for (const timer of this._throttleTimers.values()) {
      clearTimeout(timer);
    }
    this._throttleTimers.clear();
    this._throttlePending.clear();
    this._eventHandlers = {};
  }

  // ── Internal ───────────────────────────────────────────────

  _emit(event, data) {
    const handlers = this._eventHandlers[event];
    if (handlers) {
      for (const h of handlers) {
        try {
          h(data);
        } catch (e) {
          console.error(`[EWObject] Event handler error (${event}):`, e);
        }
      }
    }
  }

  _sendSignal(port, value, unit) {
    if (!this._outputConn) return;
    const data = { port, value };
    if (unit) data.unit = unit;
    this._outputConn.send({ type: "signal", data });
  }

  _broadcastFullState() {
    if (!this._outputConn) return;
    const bundle = {};
    for (const def of this.outputDefs) {
      const val = this._outputValues[def.port];
      if (val !== undefined) {
        bundle[def.port] = { value: val };
        if (def.unit) bundle[def.port].unit = def.unit;
      }
    }
    this._outputConn.send({ type: "signal", data: { bundle } });
  }

  _sendObjectInfo() {
    if (!this._outputConn) return;
    this._outputConn.send({
      type: "objectInfo",
      info: {
        name: this.name,
        objectType: this.objectType,
        inputs: this.inputDefs.map((d) => ({
          port: d.port,
          type: d.type,
          unit: d.unit,
          min: d.min,
          max: d.max,
        })),
        outputs: this.outputDefs.map((d) => ({
          port: d.port,
          type: d.type,
          unit: d.unit,
        })),
      },
    });
  }

  _routeIncomingSignal(msg) {
    const { data } = msg;
    if (!data) return;

    if (data.bundle) {
      for (const [port, info] of Object.entries(data.bundle)) {
        this._fireInputCallbacks(port, info.value, {
          from: msg.from,
          room: this._outputRoom,
          port,
          unit: info.unit,
        });
      }
    } else if (data.port !== undefined) {
      this._fireInputCallbacks(data.port, data.value, {
        from: msg.from,
        room: this._outputRoom,
        port: data.port,
        unit: data.unit,
      });
    }
  }

  _routeSubscribedSignal(msg, roomName, portMapping) {
    const { data } = msg;
    if (!data) return;

    // Check if "signal" is mapped — if so, skip non-signal ports that
    // map to the same local port (signal modulation takes priority)
    const signalTarget = portMapping["signal"];

    if (data.bundle) {
      for (const [remotePort, info] of Object.entries(data.bundle)) {
        const localPort = portMapping[remotePort];
        if (localPort === undefined) continue;
        // If signal is mapped to this local port, skip non-signal sources
        if (signalTarget === localPort && remotePort !== "signal") continue;
        this._fireInputCallbacks(localPort, info.value, {
          from: msg.from,
          room: roomName,
          port: remotePort,
          unit: info.unit,
        });
      }
    } else if (data.port !== undefined) {
      const localPort = portMapping[data.port];
      if (localPort === undefined) return;
      // If signal is mapped to this local port, skip non-signal sources
      if (signalTarget === localPort && data.port !== "signal") return;
      this._fireInputCallbacks(localPort, data.value, {
        from: msg.from,
        room: roomName,
        port: data.port,
        unit: data.unit,
      });
    }
  }

  _fireInputCallbacks(port, value, meta) {
    const callbacks = this._inputCallbacks.get(port);
    if (callbacks) {
      for (const cb of callbacks) {
        try {
          cb(value, meta);
        } catch (e) {
          console.error(`[EWObject] Input callback error (${port}):`, e);
        }
      }
    }
    // Also emit a generic 'input' event
    this._emit("input", { port, value, ...meta });
  }
}

// ── Utility exports ──────────────────────────────────────────

export { RoomConnection, sanitizeRoom, randomRoom, resolveWsBase };
