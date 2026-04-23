# MIDI Server

A collaborative, web-based MIDI step sequencer with real-time network synchronization. Multiple users can join the same room and control drum sequences, synthesizers, and external MIDI devices in perfect sync.

## Features

- **Multi-user collaboration** — Multiple clients connect to named rooms and share state in real time
- **NTP-style clock sync** — Epoch-based scheduling keeps all clients locked to the same tempo
- **16-step drum sequencer** — 4 tracks (Kick, Snare, Hi-Hat, Synth) with 16 steps each
- **Piano roll editor** — Canvas-based note editor with MIDI file import/export
- **Web MIDI API** — Send/receive MIDI to/from external hardware (inputs, outputs, clock relay)
- **MIDI recording** — Record incoming MIDI and export as `.mid` files
- **Virtual keyboard** — On-screen keyboard for playing notes
- **CC monitor** — Displays incoming MIDI Control Change messages
- **Built-in synths** — Tone.js drums and pad synth for in-browser playback
- **Retro CRT aesthetic** — Scanlines, galaxy background (Three.js), VT323 font

## Stack

| Layer         | Tech                                             |
| ------------- | ------------------------------------------------ |
| Server        | Node.js, [ws](https://github.com/websockets/ws)  |
| Audio         | [Tone.js](https://tonejs.github.io/) v14.8 (CDN) |
| 3D Background | [Three.js](https://threejs.org/) v0.160.0 (CDN)  |
| MIDI          | Web MIDI API (native browser)                    |

## Getting Started

```bash
cd MIDI-server
npm install
npm start
```

The server runs on port `3000` by default, or the value of the `PORT` environment variable.

Open `http://localhost:3000` in a browser.

## Usage

1. Enter a room name and click **JOIN** (or use the default room)
2. Share the room name with collaborators — they join the same room and sync automatically
3. Use the sequencer grid to program drum patterns
4. Adjust BPM with the slider; press **PLAY** to start

### MIDI I/O

- Select an input device to receive MIDI from hardware
- Select an output device to route sequencer notes to external gear
- **THRU** — pass MIDI input through to the output device
- **CLK** — relay MIDI clock (0xF8) messages to the output device
- **PANIC** — send all-notes-off to the output device

### Rooms

Connect multiple browser tabs or devices to the same room:

```
http://localhost:3000?room=my-room
```

All play/stop commands, BPM changes, and step edits are broadcast to all peers in the room.

## File Structure

```
MIDI-server/
├── server.js          # Node.js HTTP + WebSocket server
├── package.json
├── railway.json       # Railway deployment config
└── public/
    ├── index.html     # Main UI
    ├── client.js      # Client app (sync, sequencer, MIDI, UI)
    ├── piano-roll.js  # Piano roll editor
    ├── galaxy.js      # Three.js starfield background
    └── style.css      # Retro CRT styling
```

## Deployment

Configured for [Railway](https://railway.app/). Push to the linked repo and Railway builds with Nixpacks automatically.

The server reads `PORT` from the environment — no config changes needed.
