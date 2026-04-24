# SCOPE

Real-time audio oscilloscope and spectrum analyzer.

## Features

### Display modes

| View | Description                                          |
| ---- | ---------------------------------------------------- |
| WAVE | Time-domain waveform with edge trigger               |
| SPEC | Frequency spectrum, log-scale 20 Hz – Nyquist        |
| BOTH | Split view — waveform top half, spectrum bottom half |

### Controls

**TIME / DIV** — zoom the waveform window from ~3 ms to ~43 ms per screen  
**VOLT / DIV** — vertical gain from 0.25× to 2.00×  
**TRIGGER LVL** — sets the rising zero-crossing threshold for stable waveform lock  
**SPEC SMOOTH** — `smoothingTimeConstant` for the spectrum (0 = raw, 0.97 = heavily averaged)  
**FREEZE / UNFREEZE** — pauses the display without stopping audio capture

### Trace options

- **Color** — CYN (cyan) / VLT (violet) / ORG (orange) / WHT (white)
- **Display** — LINE / FILL (waveform with filled area) / DOTS

### Stats bar

Displays live **frequency estimate**, **peak amplitude (dBFS)**, **sample rate**, and **connection status**.

### Audio device selection

Click **SCAN** to enumerate available input devices without starting capture. Select a device from the dropdown before or during capture. Switching devices while running reconnects without restarting the AudioContext.

## Routing audio into it

**Microphone** — select your mic from the dropdown, or use the browser default.

**DAW / software** — use a virtual audio loopback device:

- macOS: [BlackHole](https://github.com/ExistentialAudio/BlackHole) — set your DAW output to BlackHole, select BlackHole as the input here
- Windows: [VB-Audio Virtual Cable](https://vb-audio.com/Cable/)

**Hardware interface** — physical audio interfaces appear in the device list automatically once browser mic permission is granted.

## Background

A Three.js point-cloud grid (72 × 36 = 2,592 points) reacts to the live audio data in real time. The grid mirrors whichever view mode is active:

- **WAVE** — points displace vertically from the time-domain waveform; crests glow cyan, troughs glow violet
- **SPEC / BOTH** — points displace by log-scale frequency amplitude; color ramps from dim teal to bright cyan-white at peaks

## Stack

- Web Audio API — `AnalyserNode`, `getUserMedia`, `MediaStreamSourceNode`
- Canvas 2D — waveform and spectrum rendering
- Three.js r171 — audio-reactive background (custom GLSL vertex/fragment shaders, additive blending)
- No build step, no framework dependencies
