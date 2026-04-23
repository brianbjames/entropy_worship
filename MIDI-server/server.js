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
  epoch: null,   // Unix ms that step 0 started — shared source of truth for all clients
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

  send(ws, { type: 'state', bpm: seqState.bpm, steps: seqState.steps, playing: seqState.playing, epoch: seqState.epoch });
  broadcastAll({ type: 'clients', count: clients.size });

  ws.on('message', raw => {
    let msg;
    try { msg = JSON.parse(raw); } catch { return; }

    switch (msg.type) {
      case 'ping':
        send(ws, { type: 'pong', t0: msg.t0, t1: Date.now(), t2: Date.now() });
        break;
      case 'play': {
        seqState.playing = true;
        // Epoch is the Unix ms at which step 0 fires.
        // Set it 300 ms in the future so every client gets the message in time.
        seqState.epoch = Date.now() + 300;
        broadcastAll({ type: 'play', epoch: seqState.epoch, bpm: seqState.bpm });
        break;
      }
      case 'stop':
        seqState.playing = false;
        broadcastAll({ type: 'stop' });
        break;
      case 'bpm':
        if (typeof msg.bpm === 'number' && msg.bpm >= 60 && msg.bpm <= 200) {
          seqState.bpm = msg.bpm;
          broadcast({ type: 'bpm', bpm: msg.bpm }, ws);
        }
        break;
      case 'step': {
        const { track, step, value } = msg;
        if (seqState.steps[track] && step >= 0 && step < 16) {
          seqState.steps[track][step] = value ? 1 : 0;
          broadcast({ type: 'step', track, step, value: seqState.steps[track][step] }, ws);
        }
        break;
      }
      case 'midi':
        // Relay raw MIDI bytes — 1-3 bytes for standard messages, up to 4096 for SysEx
        if (Array.isArray(msg.data) && msg.data.length >= 1 && msg.data.length <= 4096) {
          broadcast({ type: 'midi', data: msg.data }, ws);
        }
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
