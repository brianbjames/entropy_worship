# MIDI Server

A collaborative, web-based MIDI relay and performance tool with real-time network synchronization. Multiple users can join the same room and play, sequence, and route MIDI in perfect sync.

## Features

- **Multi-user collaboration** — Multiple clients connect to named rooms and share state in real time
- **NTP-style clock sync** — Epoch-based scheduling keeps all clients locked to the same tempo
- **Piano roll editor** — Canvas-based note editor with drag-and-drop MIDI file import and `.mid` export
- **Web MIDI API** — Send/receive MIDI to/from external hardware (inputs, outputs, clock relay, clock generation, clock sync)
- **MIDI recording** — Record incoming MIDI and export as `.mid` files
- **Virtual keyboard** — On-screen keyboard for playing notes into the piano roll or MIDI output
- **Monitor panel** — Live display of incoming CC values, Program Changes, and Pitch Bend per channel
- **Private rooms** — Mark a room private to hide it from the available rooms panel
- **Available rooms panel** — Live list of all public, occupied rooms with one-click join
- **Click track** — Built-in metronome with downbeat accent, toggled from the transport bar
- **Built-in synths** — Tone.js pad synth and click synth for in-browser playback
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

1. Click **[ ENTER ]** on the splash screen
2. Enter a room name and click **[ JOIN ]** (or use the default room)
3. Share the room name with collaborators — they join the same room and sync automatically
4. Draw notes on the piano roll, adjust BPM, and press **▶ PLAY** to start

### Transport

- **▶ PLAY / ■ STOP** — Start and stop synchronized playback across all peers
- **♩ CLICK** — Toggle the metronome click track (downbeat accent on beat 1)
- **BPM** — Drag the slider to change tempo; changes broadcast to all peers

### Piano Roll

- **Left-click empty area** — Add a note (snapped to 1/16th)
- **Left-click existing note** — Delete the note
- **Left-click + drag note** — Move the note (pitch and/or beat)
- **Right-click note** — Delete the note
- **Scroll wheel** — Scroll pitch range (vertical)
- **Shift + scroll** — Scroll time (horizontal)
- **Ctrl + scroll** — Zoom horizontal
- **↓ DROP .MID** — Drag a `.mid` file onto the drop zone to import it
- **↓ EXPORT .MID** — Download the current roll as a standard MIDI file
- **PR ON** — Enable piano roll playback (routes notes to built-in synth and/or MIDI output)

### MIDI I/O

- Select an input device to receive MIDI from hardware
- Select an output device to route piano roll and keyboard notes to external gear
- **THRU** — Pass MIDI input through to the output device
- **CLK ↑** — Relay incoming MIDI clock (0xF8) from hardware to all room peers
- **CLK GEN** — Generate MIDI clock to the output device, locked to the room BPM; sends Start/Stop on transport
- **CLK SYNC** — Slave the room BPM and transport to an incoming hardware MIDI clock; sends play/stop to all peers on Start/Stop
- **PANIC** — Send all-notes-off to the output device

### Monitor Panel

Displays live incoming MIDI data:
- **CC** — Bar graph per controller number, labeled with CC name
- **Program Change** — Last program received per channel, with GM patch name
- **Pitch Bend** — Center-anchored bar per channel showing bend amount

### MIDI Recording

- **● REC** — Start recording all incoming MIDI events
- **■ STOP** — Stop recording
- **↓ EXPORT .MID** — Download the recording as a `.mid` file

### Rooms

On first load a random room name is generated and set in the URL. To join a specific room, enter its name and click **JOIN**, or navigate directly:

```
http://localhost:3000?room=my-room
```

All play/stop commands, BPM changes, and piano roll state are broadcast to all peers in the room. Header shows your latency (`you Xms`) and total player count.

Toggle **PUBLIC / PRIVATE** in the room bar to control whether the room appears in the **// AVAILABLE ROOMS //** panel, which lists all public, occupied rooms on the server with a one-click join link.

## File Structure

```
MIDI-server/
├── server.js          # Node.js HTTP + WebSocket server
├── package.json
├── railway.json       # Railway deployment config
└── public/
    ├── index.html     # Main UI
    ├── client.js      # Client app (sync, MIDI, transport, monitor, recording)
    ├── piano-roll.js  # Piano roll editor + MIDI parser/exporter
    ├── galaxy.js      # Three.js starfield background
    └── style.css      # Retro CRT styling
```

## Deployment

Configured for [Railway](https://railway.app/). Push to the linked repo and Railway builds with Nixpacks automatically.

The server reads `PORT` from the environment — no config changes needed.
