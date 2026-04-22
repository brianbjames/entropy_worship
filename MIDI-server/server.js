// ============================================================
// MIDI-server — server.js
// WebSocket server: clock sync, sequencer state, event relay
// ============================================================

const http = require('http');
const fs   = require('fs');
const path = require('path');
const { WebSocketServer, WebSocket } = require('ws');

const PUBLIC = path.join(__dirname, 'public');
const MIME = {
  '.html': 'text/html',
  '.css':  'text/css',
  '.js':   'application/javascript',
};

// ── HTTP static file server ──────────────────────────────────
const httpServer = http.createServer((req, res) => {
  const filePath = path.join(PUBLIC, req.url === '/' ? 'index.html' : req.url);
  // Prevent path traversal
  if (!filePath.startsWith(PUBLIC)) {
    res.writeHead(403); res.end(); return;
  }
  fs.readFile(filePath, (err, data) => {
    if (err) { res.writeHead(404); res.end('Not found'); return; }
    res.writeHead(200, { 'Content-Type': MIME[path.extname(filePath)] || 'text/plain' });
    res.end(data);
  });
});

// ── Shared sequencer state ───────────────────────────────────
const seqState = {
  playing: false,
  bpm: 120,
  steps: {
    kick:  [1,0,0,0, 1,0,0,0, 1,0,0,0, 1,0,0,0],
    snare: [0,0,0,0, 1,0,0,0, 0,0,0,0, 1,0,0,0],
    hihat: [1,0,1,0, 1,0,1,0, 1,0,1,0, 1,0,1,0],
    synth: [0,0,0,0, 0,0,0,0, 0,0,0,0, 0,0,0,0],
  },
};

// ── WebSocket server ─────────────────────────────────────────
const wss = new WebSocketServer({ server: httpServer });
const clients = new Set();

function send(ws, msg) {
  if (ws.readyState === WebSocket.OPEN) ws.send(JSON.stringify(msg));
}

function broadcast(msg, exclude = null) {
  for (const c of clients) if (c !== exclude) send(c, msg);
}

function broadcastAll(msg) {
  for (const c of clients) send(c, msg);
}

wss.on('connection', ws => {
  clients.add(ws);
  console.log(`[+] client connected  (${clients.size} total)`);

  // Send current state to new joiner
  send(ws, { type: 'state', bpm: seqState.bpm, steps: seqState.steps, playing: seqState.playing });
  broadcastAll({ type: 'clients', count: clients.size });

  ws.on('message', raw => {
    let msg;
    try { msg = JSON.parse(raw); } catch { return; }

    switch (msg.type) {

      // ── NTP-style clock sync ──
      case 'ping':
        send(ws, { type: 'pong', t0: msg.t0, t1: Date.now(), t2: Date.now() });
        break;

      // ── Transport ──
      case 'play': {
        seqState.playing = true;
        // Give every client 300 ms to receive the message and set up scheduling
        const startAt = Date.now() + 300;
        broadcastAll({ type: 'play', startAt, bpm: seqState.bpm });
        break;
      }
      case 'stop':
        seqState.playing = false;
        broadcastAll({ type: 'stop' });
        break;

      // ── BPM ──
      case 'bpm':
        if (typeof msg.bpm === 'number' && msg.bpm >= 60 && msg.bpm <= 200) {
          seqState.bpm = msg.bpm;
          broadcast({ type: 'bpm', bpm: msg.bpm }, ws);
        }
        break;

      // ── Step toggle ──
      case 'step': {
        const { track, step, value } = msg;
        if (seqState.steps[track] && step >= 0 && step < 16) {
          seqState.steps[track][step] = value ? 1 : 0;
          broadcast({ type: 'step', track, step, value: seqState.steps[track][step] }, ws);
        }
        break;
      }

      // ── MIDI relay ──
      case 'midi':
        broadcast({ type: 'midi', midiType: msg.midiType, note: msg.note, velocity: msg.velocity }, ws);
        break;
    }
  });

  ws.on('close', () => {
    clients.delete(ws);
    console.log(`[-] client disconnected (${clients.size} total)`);
    broadcastAll({ type: 'clients', count: clients.size });
  });
});

const PORT = process.env.PORT || 3000;
httpServer.listen(PORT, () => {
  console.log(`MIDI-server running → http://localhost:${PORT}`);
});
