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
// MIDI-server — server.js
// Rooms, clock sync, sequencer state, MIDI relay
// ============================================================

const http = require("http");
const fs = require("fs");
const path = require("path");
const { WebSocketServer, WebSocket } = require("ws");

const PUBLIC = path.join(__dirname, "public");
const MIME = {
  ".html": "text/html",
  ".css": "text/css",
  ".js": "application/javascript",
};

// ── HTTP static file server ──────────────────────────────────
const httpServer = http.createServer((req, res) => {
  let pathname;
  try {
    pathname = new URL(req.url, "http://localhost").pathname;
  } catch {
    pathname = "/";
  }
  const filePath = path.join(
    PUBLIC,
    pathname === "/" ? "index.html" : pathname,
  );
  if (!filePath.startsWith(PUBLIC)) {
    res.writeHead(403);
    res.end();
    return;
  }
  fs.readFile(filePath, (err, data) => {
    if (err) {
      res.writeHead(404);
      res.end("Not found");
      return;
    }
    res.writeHead(200, {
      "Content-Type": MIME[path.extname(filePath)] || "text/plain",
    });
    res.end(data);
  });
});

// ── Room management ──────────────────────────────────────────
const rooms = new Map();
let nextId = 1;

function makeRoom(name) {
  return {
    name,
    seqState: {
      playing: false,
      bpm: 120,
      epoch: null,
      clockRelay: false,
      private: false,
    },
    clients: new Map(), // clientId → { ws, rtt }
  };
}

function getRoom(name) {
  if (!rooms.has(name)) rooms.set(name, makeRoom(name));
  return rooms.get(name);
}

function parseRoom(req) {
  try {
    const name =
      (
        new URL(req.url, "http://localhost").searchParams.get("room") ||
        "default"
      )
        .replace(/[^a-zA-Z0-9_-]/g, "")
        .slice(0, 32) || "default";
    return name;
  } catch {
    return "default";
  }
}

// ── Helpers ──────────────────────────────────────────────────
function send(ws, msg) {
  if (ws.readyState === WebSocket.OPEN) ws.send(JSON.stringify(msg));
}

function broadcastRoom(room, msg, excludeId = null) {
  for (const [id, { ws }] of room.clients) {
    if (id !== excludeId) send(ws, msg);
  }
}

function broadcastAll(room, msg) {
  for (const { ws } of room.clients.values()) send(ws, msg);
}

function broadcastPeers(room) {
  const peers = [...room.clients.entries()].map(([id, { rtt }]) => ({
    id,
    rtt,
  }));
  for (const { ws } of room.clients.values()) {
    send(ws, { type: "peers", count: peers.length, peers });
  }
}

function broadcastPublicRooms() {
  const list = [...rooms.values()]
    .filter((r) => !r.seqState.private && r.clients.size > 0)
    .map((r) => ({
      name: r.name,
      players: r.clients.size,
      bpm: r.seqState.bpm,
      playing: r.seqState.playing,
    }));
  const msg = { type: "rooms", rooms: list };
  for (const room of rooms.values())
    for (const { ws } of room.clients.values()) send(ws, msg);
}

// ── WebSocket server ─────────────────────────────────────────
const wss = new WebSocketServer({ server: httpServer });

wss.on("connection", (ws, req) => {
  const roomName = parseRoom(req);
  const room = getRoom(roomName);
  const clientId = String(nextId++);
  room.clients.set(clientId, { ws, rtt: 0 });
  console.log(
    `[+] ${clientId} → room "${roomName}" (${room.clients.size} total)`,
  );

  send(ws, {
    type: "state",
    clientId,
    room: roomName,
    bpm: room.seqState.bpm,
    playing: room.seqState.playing,
    epoch: room.seqState.epoch,
    clockRelay: room.seqState.clockRelay,
    private: room.seqState.private,
  });
  broadcastPeers(room);
  broadcastPublicRooms();

  ws.on("message", (raw) => {
    let msg;
    try {
      msg = JSON.parse(raw);
    } catch {
      return;
    }

    switch (msg.type) {
      case "ping":
        send(ws, { type: "pong", t0: msg.t0, t1: Date.now(), t2: Date.now() });
        break;

      case "latency": {
        const client = room.clients.get(clientId);
        if (client && typeof msg.rtt === "number" && msg.rtt >= 0) {
          client.rtt = Math.round(msg.rtt);
          broadcastPeers(room);
        }
        break;
      }

      case "play": {
        room.seqState.playing = true;
        room.seqState.epoch = Date.now() + 300;
        broadcastAll(room, {
          type: "play",
          epoch: room.seqState.epoch,
          bpm: room.seqState.bpm,
        });
        break;
      }

      case "stop":
        room.seqState.playing = false;
        broadcastAll(room, { type: "stop" });
        break;

      case "bpm":
        if (typeof msg.bpm === "number" && msg.bpm >= 60 && msg.bpm <= 200) {
          room.seqState.bpm = msg.bpm;
          broadcastRoom(room, { type: "bpm", bpm: msg.bpm }, clientId);
        }
        break;


      case "midi":
        if (
          Array.isArray(msg.data) &&
          msg.data.length >= 1 &&
          msg.data.length <= 4096
        ) {
          const isClock = msg.data[0] === 0xf8;
          if (isClock && !room.seqState.clockRelay) break;
          broadcastRoom(room, { type: "midi", data: msg.data }, clientId);
        }
        break;

      case "clockRelay":
        if (typeof msg.enabled === "boolean") {
          room.seqState.clockRelay = msg.enabled;
          broadcastRoom(
            room,
            { type: "clockRelay", enabled: msg.enabled },
            clientId,
          );
        }
        break;

      case "setPrivate":
        if (typeof msg.private === "boolean") {
          room.seqState.private = msg.private;
          broadcastAll(room, { type: "roomPrivate", private: msg.private });
          broadcastPublicRooms();
        }
        break;
    }
  });

  ws.on("close", () => {
    room.clients.delete(clientId);
    console.log(
      `[-] ${clientId} left room "${roomName}" (${room.clients.size} total)`,
    );
    broadcastPeers(room);
    if (room.clients.size === 0) {
      // Reset transport so new joiners don't inherit a stale playing state
      room.seqState.playing = false;
      room.seqState.epoch = null;
      if (roomName !== "default") rooms.delete(roomName);
    }
    broadcastPublicRooms();
  });
});

const PORT = process.env.PORT || 3000;
httpServer.listen(PORT, () => {
  console.log(`MIDI-server running → http://localhost:${PORT}`);
});
