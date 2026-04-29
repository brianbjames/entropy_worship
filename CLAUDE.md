# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

Entropy Worship is an experimental multimedia platform combining interactive 3D environments, web-based music production tools, audio visualization, and urban data tools. It uses a retro cyberpunk aesthetic with VT323 monospace font and dark CRT-style UIs.

## Architecture

This is a **monorepo with independent sub-applications** — each app has its own stack and can be developed/deployed independently. There is no root package.json, no monorepo tooling, and no shared build system.

Most apps are **vanilla HTML/CSS/JS with CDN dependencies** (no bundler, no framework). The two Node.js backends are the exceptions.

### Sub-applications

| App | Path | Stack | Run |
|-----|------|-------|-----|
| Main site | `index.html` | Babylon.js, Three.js, Bootstrap 4.5.2 | Static — any HTTP server |
| MIDI Server | `MIDI-server/` | Node.js + WebSocket (ws), Tone.js, Three.js | `cd MIDI-server && npm install && npm start` (port 3000) |
| SCOPE | `scope/` | Web Audio API, Canvas 2D, Three.js (GLSL shaders) | Static — open `index.html` |
| Euclid | `euclid/` | Single HTML file | Static |
| WTFDIPISF | `WTFDIPISF/` | Leaflet.js, DataSF Socrata API | Static |
| RA Backend | `ra-backend/` | Express.js, Playwright, Eventbrite API | `cd ra-backend && npm install && npm start` |
| EW Objects | `EW-objects/` | Node.js + WebSocket (ws), Tone.js, EWUILIB CSS | `cd EW-objects && npm install && npm start` (port 3001) |
| Standalone tools | Root `EW*.html` files | Various (Tone.js, Web MIDI, Three.js) | Static |

### Shared resources

- `scripts/` — Utility modules: MIDI helpers, scale/chord definitions (`midiCalc.js`), oscillators, game engine
- `styles/` — CSS framework (cyberpunk.css, scientific UI styles)
- `EW-objects/lib/` — EW Object system shared modules: `ewuilib.css` (extracted EWUILIB design system), `ew-object-base.js` (WebSocket/room/signal core), `ew-object-ui.js` (shared UI builders)
- `fonts/` — Custom typefaces (VT323, Chargen)
- `models/` — 3D assets (.glb, .obj) — 190+ files
- `textures/`, `samples/`, `images/` — Media assets

## Key Architecture Details

### MIDI Server collaboration model
The MIDI server uses **room-based WebSocket collaboration** with **epoch-based clock synchronization** (NTP-style). Clients join rooms via URL query (`?room=name`). Room state (playing, bpm, epoch, notes) lives on the server and broadcasts to all peers. The epoch sync calculates beat position as `(Date.now() - epoch) / (60000 / bpm / 4)`.

Key WebSocket message types: `ping/pong`, `latency`, `play`, `stop`, `bpm`, `midi`, `clockRelay`, `setPrivate`, `peers`, `rooms`, `state`.

### EW Object System (distributed modular audio)
Each audio module is a standalone HTML page that connects via WebSocket rooms. **Room URLs act as patch cables** — paste one module's room name into another module's input to connect them. Has its own Node.js WebSocket server (`EW-objects/server.js`, port 3001) independent from the MIDI Server. Modules use `EWObject` (from `EW-objects/lib/ew-object-base.js`) which manages output room broadcasting, input room subscriptions, NTP clock sync, and signal throttling (~30Hz). Key message types: `ping/pong`, `latency`, `signal`, `objectInfo`, `objectList`, `peers`, `rooms`, `state`. Objects use the extracted EWUILIB CSS (`EW-objects/lib/ewuilib.css`) and Tone.js for audio.

### SCOPE audio visualization
Uses Web Audio `AnalyserNode` to capture real-time audio, renders to Canvas 2D (waveform/spectrum), and drives a Three.js point-cloud grid (72x36) that reacts to audio data via custom GLSL shaders.

### WTFDIPISF parking inference
Infers street cleaning schedules from historical citation data: groups citations by street + day, and if 3+ citations cluster in the same hour, infers that as a cleaning window. Overlays with official DataSF schedules.

## Development Commands

```bash
# MIDI Server (the main Node.js app)
cd MIDI-server && npm install && npm start    # http://localhost:3000

# EW Objects (modular audio signal server + static pages)
cd EW-objects && npm install && npm start     # http://localhost:3001

# RA Backend
cd ra-backend && npm install && npm start     # http://localhost:3000

# Static apps (main site, scope, euclid, tools)
python -m http.server 8000                    # http://localhost:8000
```

No test suite exists. Testing is manual via browser. MIDI/audio features require hardware or virtual loopback devices (BlackHole on macOS, VB-Cable on Windows).

## Deployment

- **MIDI Server**: Railway.app (Nixpacks builder, reads `PORT` env var, config in `MIDI-server/railway.json`)
- **Main site**: Static hosting
- **Note**: `.gitignore` has unresolved merge conflict markers that should be cleaned up

## Conventions

- ASCII art headers in major files
- Dark color schemes (#2e2e2e, black backgrounds, neon accents)
- CDN-first for frontend dependencies (Tone.js, Three.js, Babylon.js, Bootstrap, Leaflet)
- Feature branches named descriptively (e.g., `MIDI-Web-Server`, `Tone-JS-Examples`, `VR-Drum-Machine`)
