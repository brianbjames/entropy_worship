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
// EW-objects — server.js
// WebSocket signal server for the EW distributed modular
// audio system. Handles rooms, NTP clock sync, signal relay,
// and object discovery.
// ============================================================

const http = require("http");
const fs = require("fs");
const path = require("path");
const { WebSocketServer, WebSocket } = require("ws");

// ── Static file serving ──────────────────────────────────────
// Serves the entire EW-objects directory (index.html, lib/, objects/)
const PUBLIC = path.join(__dirname);
const MIME = {
  ".html": "text/html",
  ".css": "text/css",
  ".js": "application/javascript",
  ".json": "application/json",
  ".png": "image/png",
  ".svg": "image/svg+xml",
};

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
    private: false,
    clients: new Map(), // clientId → { ws, rtt, objectInfo }
  };
}

function getRoom(name) {
  if (!rooms.has(name)) rooms.set(name, makeRoom(name));
  return rooms.get(name);
}

function parseRoom(req) {
  try {
    const name = (
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

function broadcastObjectInfo(room) {
  const objects = [];
  for (const [id, client] of room.clients) {
    if (client.objectInfo) {
      objects.push({ clientId: id, ...client.objectInfo });
    }
  }
  broadcastAll(room, { type: "objectList", objects });
}

function broadcastPublicRooms() {
  const list = [...rooms.values()]
    .filter((r) => !r.private && r.clients.size > 0)
    .map((r) => {
      const objectTypes = [];
      for (const client of r.clients.values()) {
        if (client.objectInfo) objectTypes.push(client.objectInfo.objectType);
      }
      return {
        name: r.name,
        clients: r.clients.size,
        objects: objectTypes,
      };
    });
  const msg = { type: "rooms", rooms: list };
  for (const room of rooms.values()) {
    for (const { ws } of room.clients.values()) send(ws, msg);
  }
}

// ── WebSocket server ─────────────────────────────────────────
const wss = new WebSocketServer({ server: httpServer });

wss.on("error", (err) => {
  console.error("[WSS] Server error:", err.message);
});

wss.on("connection", (ws, req) => {
  const roomName = parseRoom(req);
  const room = getRoom(roomName);
  const clientId = String(nextId++);
  room.clients.set(clientId, { ws, rtt: 0, objectInfo: null });
  console.log(
    `[+] ${clientId} → room "${roomName}" (${room.clients.size} total)`,
  );

  // Send initial state
  send(ws, {
    type: "state",
    clientId,
    room: roomName,
    private: room.private,
  });
  broadcastPeers(room);
  broadcastPublicRooms();

  // If other clients in this room have object info, send the list
  broadcastObjectInfo(room);

  ws.on("message", (raw) => {
    let msg;
    try {
      msg = JSON.parse(raw);
    } catch {
      return;
    }

    switch (msg.type) {
      // ── NTP clock sync ──────────────────────────────────────
      case "ping":
        send(ws, {
          type: "pong",
          t0: msg.t0,
          t1: Date.now(),
          t2: Date.now(),
        });
        break;

      case "latency": {
        const client = room.clients.get(clientId);
        if (client && typeof msg.rtt === "number" && msg.rtt >= 0) {
          client.rtt = Math.round(msg.rtt);
          broadcastPeers(room);
        }
        break;
      }

      // ── Signal relay ────────────────────────────────────────
      case "signal":
        if (msg.data && typeof msg.data === "object") {
          broadcastRoom(
            room,
            {
              type: "signal",
              from: clientId,
              data: msg.data,
              ts: Date.now(),
            },
            clientId,
          );
        }
        break;

      // ── Object discovery ────────────────────────────────────
      case "objectInfo":
        if (msg.info && typeof msg.info === "object") {
          const client = room.clients.get(clientId);
          if (client) {
            client.objectInfo = msg.info;
            broadcastObjectInfo(room);
          }
        }
        break;

      // ── Room privacy ────────────────────────────────────────
      case "setPrivate":
        if (typeof msg.private === "boolean") {
          room.private = msg.private;
          broadcastAll(room, { type: "roomPrivate", private: msg.private });
          broadcastPublicRooms();
        }
        break;

      // ── State request ──────────────────────────────────────
      // When a new subscriber joins, it asks for the current state.
      // Relay this to all other clients so they re-broadcast.
      case "requestState":
        broadcastRoom(room, { type: "requestState" }, clientId);
        break;
    }
  });

  ws.on("error", (err) => {
    console.error(`[WS] Client ${clientId} error:`, err.message);
  });

  ws.on("close", () => {
    room.clients.delete(clientId);
    console.log(
      `[-] ${clientId} left room "${roomName}" (${room.clients.size} total)`,
    );
    broadcastPeers(room);
    if (room.clients.size === 0) {
      rooms.delete(roomName);
    }
    broadcastPublicRooms();
  });
});

// ── Start ────────────────────────────────────────────────────
const PORT = process.env.PORT || 3001;
httpServer.listen(PORT, () => {
  console.log(`EW-objects server running → http://localhost:${PORT}`);
});
