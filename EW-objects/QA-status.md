# EW/OBJECTS ISSUE TRACKER

---

## COMMON FEATURES

| #   | Test                                                            | Status | Issues                                                                                              |
| --- | --------------------------------------------------------------- | ------ | --------------------------------------------------------------------------------------------------- |
| C1  | Page loads without console errors                               | FAIL   | [Error] Failed to load resource: the server responded with a status of 404 () (favicon.ico, line 0) |
| C2  | WebSocket connects (status dot turns green, shows ONLINE)       | PASS   |                                                                                                     |
| C3  | Room name auto-generates (e.g. `osc-A2WG9E`)                    | PASS   |                                                                                                     |
| C4  | COPY URL button copies full room URL to clipboard               | PASS   |                                                                                                     |
| C5  | Peer count updates when another tab joins same room             | PASS   |                                                                                                     |
| C6  | Latency displays (ms) after connection                          | PASS   |                                                                                                     |
| C7  | `<<` back-link navigates to /EW-objects/ index                  | PASS   |                                                                                                     |
| C8  | Title link opens new instance in new tab                        | PASS   |                                                                                                     |
| C9  | Theme selector changes color scheme (all 9 themes)              | PASS   |                                                                                                     |
| C10 | Input ports show LINK/UNLINK buttons                            | PASS   |                                                                                                     |
| C11 | Pasting a room URL and clicking LINK connects (dot turns green) | PASS   |                                                                                                     |
| C12 | UNLINK disconnects input (dot turns gray)                       | PASS   |                                                                                                     |
| C13 | Enter key in input field triggers LINK                          | PASS   |                                                                                                     |
| C14 | Room panel JOIN button works                                    | PASS   |                                                                                                     |
| C15 | Privacy toggle switches PUBLIC/PRIVATE                          | PASS   |                                                                                                     |
| C16 | Available rooms list populates with other objects               | PASS   |                                                                                                     |
| C17 | Scope/waveform canvas renders (if present)                      | PASS   |                                                                                                     |
| C18 | Frequency spectrum analyzer renders below scope (if present)    | PASS   |                                                                                                     |
| C19 | Footer shows "© 2026 ENTROPY WORSHIP"                           | PASS   |                                                                                                     |
| C20 | Available rooms section title shows "// AVAILABLE OBJECTS //"   | PASS   |                                                                                                     |
| C21 | Empty rooms list shows "NO OTHER OBJECTS AVAILABLE"             | PASS   |                                                                                                     |
| C22 | Works in Chrome                                                 | PASS   |                                                                                                     |
| C23 | Works in Safari                                                 | PASS   |                                                                                                     |
| C24 | Works in Firefox                                                |        |                                                                                                     |

---

## SIGNAL SOURCES

### 1. AUDIO INPUT — `audioinput.html`

| #    | Test                                                                | Status | Issues |
| ---- | ------------------------------------------------------------------- | ------ | ------ |
| AI1  | Source selector shows MIC and SCREEN / TAB AUDIO                    | PASS   |        |
| AI2  | Unsupported sources disabled with warning (Safari: screen disabled) | PASS   |        |
| AI3  | ENABLE AUDIO INPUT button requests permission                       | PASS   |        |
| AI4  | MIC mode: browser permission prompt appears                         | PASS   |        |
| AI5  | MIC mode: audio captured, scope shows waveform                      | PASS   |        |
| AI6  | MIC mode: device selector lists available inputs                    | PASS   |        |
| AI7  | MIC mode: switching device changes input source                     | PASS   |        |
| AI8  | MIC mode: REFRESH button re-enumerates devices                      |        |        |
| AI9  | SCREEN mode: browser picker appears (Chrome/Edge only)              | PASS   |        |
| AI10 | SCREEN mode: tab audio captured and visualized                      | PASS   |        |
| AI11 | SCREEN mode: no-audio warning if user doesn't share audio           |        |        |
| AI12 | Input gain slider adjusts pre-amplification (0-2x)                  | PASS   |        |
| AI13 | Output gain slider adjusts level without killing signal             | PASS   |        |
| AI14 | Monitor OFF: no local speaker output                                | PASS   |        |
| AI15 | Monitor ON: audio plays through speakers                            | PASS   |        |
| AI16 | Noise gate: signal mutes below threshold                            | PASS   |        |
| AI17 | Noise gate: signal passes above threshold                           | PASS   |        |
| AI18 | Gate threshold slider adjusts noise floor                           | PASS   |        |
| AI19 | Level meter bar tracks input amplitude                              | PASS   |        |
| AI20 | Peak hold indicator appears and decays                              | PASS   |        |
| AI21 | dB readout updates in real-time                                     | PASS   |        |
| AI22 | Power toggle starts/stops capture                                   | PASS   |        |
| AI23 | Output mode selector: CONTROL / AUDIO / BOTH                        | PASS   |        |
| AI24 | Signal output broadcasts to room (link to scope to verify)          | PASS   |        |
| AI25 | External gate input (positive = open, negative = mute)              | PASS   |        |

### 2. NOISE — `noise.html`

| #   | Test                                           | Status | Issues |
| --- | ---------------------------------------------- | ------ | ------ |
| N1  | Power toggle starts/stops noise                | PASS   |        |
| N2  | White noise type produces broadband hiss       | PASS   |        |
| N3  | Pink noise type produces lower-frequency noise | PASS   |        |
| N4  | Brown noise type produces low rumble           | PASS   |        |
| N5  | Type selector switches noise color             | PASS   |        |
| N6  | Gain slider controls output level              | PASS   |        |
| N7  | Output mode: AUDIO / CONTROL / BOTH            | PASS   |        |
| N8  | Room input for gain modulates level            | PASS   |        |
| N9  | Room input for type changes noise color        | PASS   |        |
| N10 | Scope shows noise waveform                     | PASS   |        |

### 3. OSCILLATOR — `oscillator.html`

| #   | Test                                                            | Status | Issues                                                                |
| --- | --------------------------------------------------------------- | ------ | --------------------------------------------------------------------- |
| O1  | Power toggle starts/stops oscillator                            | PASS   |                                                                       |
| O2  | Frequency slider changes pitch audibly                          | PASS   |                                                                       |
| O3  | Detune slider shifts pitch in cents                             | PASS   |                                                                       |
| O4  | Gain slider controls volume                                     | PASS   |                                                                       |
| O5  | Waveform selector: sine / triangle / sawtooth / square          | PASS   |                                                                       |
| O6  | Each waveform sounds distinct                                   | PASS   |                                                                       |
| O7  | Output mode: AUDIO / CONTROL / BOTH                             | PASS   |                                                                       |
| O8  | Room input for frequency: modulates pitch                       | PASS   |                                                                       |
| O9  | Room input for frequency: FM synthesis works (link another osc) | PASS   | FIXED: frequency/detune/gain now snap back to slider values on unlink |
| O10 | Room input for detune modulates tuning                          | PASS   |                                                                       |
| O11 | Room input for gain modulates amplitude                         | PASS   |                                                                       |
| O12 | Room input for waveform changes shape                           | PASS   |                                                                       |
| O13 | Cascading FM: osc A -> osc B -> osc C produces complex timbres  | PASS   |                                                                       |
| O14 | Scope shows waveform shape                                      | PASS   |                                                                       |
| O15 | Signal output broadcasts at ~100Hz                              | PASS   |                                                                       |

---

## INSTRUMENTS

### 4. DRUMS — `drums.html`

| #   | Test                                            | Status | Issues |
| --- | ----------------------------------------------- | ------ | ------ |
| D1  | Play/stop button starts/stops sequence          |        |        |
| D2  | 16-step grid displays for all 6 voices          |        |        |
| D3  | Clicking grid cells toggles steps on/off        |        |        |
| D4  | Kick voice sounds correct                       |        |        |
| D5  | Snare voice sounds correct                      |        |        |
| D6  | Hihat voice sounds correct                      |        |        |
| D7  | Clap voice sounds correct                       |        |        |
| D8  | Ride voice sounds correct                       |        |        |
| D9  | Sub voice sounds correct                        |        |        |
| D10 | BPM slider changes tempo                        |        |        |
| D11 | Swing slider adds swing feel                    |        |        |
| D12 | Room input for BPM syncs tempo                  |        |        |
| D13 | Room input for trigger advances step externally |        |        |
| D14 | Output mode: AUDIO / CONTROL / BOTH             |        |        |
| D15 | Signal output broadcasts trigger pulses         |        |        |

### 5. GRANULAR — `granular.html`

| #   | Test                                                              | Status | Issues                                                                                                             |
| --- | ----------------------------------------------------------------- | ------ | ------------------------------------------------------------------------------------------------------------------ |
| G1  | Sample dropdown lists built-in samples (Drums, 808, 909, Ambient) | PASS   | need different samples                                                                                             |
| G2  | Selecting a sample loads it                                       | PASS   |                                                                                                                    |
| G3  | Drag-and-drop loads custom audio file                             | PASS   |                                                                                                                    |
| G4  | Trigger button starts granular playback                           | PASS   |                                                                                                                    |
| G5  | Grain size slider changes grain duration (audible texture change) |        |                                                                                                                    |
| G6  | Overlap slider changes grain density                              |        |                                                                                                                    |
| G7  | Position slider scrubs through sample                             | PASS   |                                                                                                                    |
| G8  | Spread slider randomizes grain position                           |        |                                                                                                                    |
| G9  | Pitch slider shifts pitch without changing speed                  |        |                                                                                                                    |
| G10 | Speed slider changes playback rate                                |        |                                                                                                                    |
| G11 | Gain slider controls volume                                       |        |                                                                                                                    |
| G12 | Reverse toggle reverses grain direction                           |        |                                                                                                                    |
| G13 | Loop toggle enables/disables looping                              |        |                                                                                                                    |
| G14 | Room input for position: LFO scanning through sample works        |        |                                                                                                                    |
| G15 | Room input for pitch: modulatable                                 |        |                                                                                                                    |
| G16 | Room input for trigger: triggers from clock/sequencer             |        |                                                                                                                    |
| G17 | Output mode: AUDIO / CONTROL / BOTH                               |        | FIXED: added continuous analyser-based signal output (~100Hz bipolar broadcast, matching oscillator/noise pattern) |
| G18 | Scope shows output waveform                                       | PASS   |                                                                                                                    |

### 6. LOOPER — `looper.html`

| #   | Test                                                          | Status | Issues |
| --- | ------------------------------------------------------------- | ------ | ------ |
| L1  | Audio input: link to oscillator room, audio arrives           |        |        |
| L2  | REC button starts recording (red indicator)                   |        |        |
| L3  | Clicking REC again (or PLAY) stops recording, starts playback |        |        |
| L4  | PLAY button plays recorded loop                               |        |        |
| L5  | Loop plays back continuously                                  |        |        |
| L6  | DUB button starts overdub (amber indicator)                   |        |        |
| L7  | Overdub layers new audio on top of existing                   |        |        |
| L8  | Feedback slider controls how much previous pass is retained   |        |        |
| L9  | STOP button stops playback                                    |        |        |
| L10 | CLR button erases buffer, resets to empty                     |        |        |
| L11 | Gain slider controls output volume                            |        |        |
| L12 | State display shows current mode (EMPTY/REC/PLAY/DUB/STOP)    |        |        |
| L13 | Loop length display shows duration                            |        |        |
| L14 | Room input for trigger cycles through states                  |        |        |
| L15 | Output mode: AUDIO / CONTROL / BOTH                           |        |        |
| L16 | Scope shows buffer waveform with playhead                     |        |        |

### 7. SAMPLER — `sampler.html`

| #   | Test                                                             | Status | Issues |
| --- | ---------------------------------------------------------------- | ------ | ------ |
| S1  | Sample dropdown lists all categories (Drums, 808, 909, Ambient)  |        |        |
| S2  | Selecting a sample loads and is ready to play                    |        |        |
| S3  | Drag-and-drop loads custom audio file                            |        |        |
| S4  | Trigger button plays sample                                      |        |        |
| S5  | Re-triggering while playing restarts sample                      |        |        |
| S6  | Pitch slider shifts pitch (-24 to +24 st) without changing speed |        |        |
| S7  | Speed slider changes playback rate (0.1-4x)                      |        |        |
| S8  | Gain slider controls volume                                      |        |        |
| S9  | Loop toggle enables looping                                      |        |        |
| S10 | Loop start/end sliders adjust loop region                        |        |        |
| S11 | Room input for trigger: positive edge plays sample               |        |        |
| S12 | Room input for pitch: modulates detune                           |        |        |
| S13 | Room input for gain: modulates level                             |        |        |
| S14 | Room input for speed: modulates rate                             |        |        |
| S15 | Output mode: AUDIO / CONTROL / BOTH                              |        |        |
| S16 | Scope shows output waveform                                      |        |        |

### 8. SYNTH — `synth.html`

| #    | Test                                                                       | Status | Issues                                                                                                          |
| ---- | -------------------------------------------------------------------------- | ------ | --------------------------------------------------------------------------------------------------------------- |
| SY1  | Manual trigger button plays note (hold = sustain, release = release)       | PASS   |                                                                                                                 |
| SY2  | Waveform selector: sine/tri/saw/square/fat variants/pwm/pulse              | PASS   |                                                                                                                 |
| SY3  | Each waveform sounds distinct                                              | PASS   |                                                                                                                 |
| SY4  | Octave shift transposes pitch                                              | FIXED  | Was: no live update during playback. Fix: rampTo(getEffectiveFrequency()) on slider change                      |
| SY5  | Detune slider adjusts fine tuning                                          | PASS   |                                                                                                                 |
| SY6  | Filter type: lowpass / highpass / bandpass                                 | PASS   | FIXED: cutoff now sets filterEnvelope.baseFrequency (was only setting filter.frequency, overridden by envelope) |
| SY7  | Cutoff slider sweeps filter audibly                                        |        |                                                                                                                 |
| SY8  | Resonance (Q) slider adds emphasis at cutoff                               |        |                                                                                                                 |
| SY9  | Filter envelope ADSR shapes the filter sweep                               | PASS   |                                                                                                                 |
| SY10 | Filter envelope octaves controls sweep range                               |        |                                                                                                                 |
| SY11 | Amplitude ADSR: attack ramps up                                            | PASS   |                                                                                                                 |
| SY12 | Amplitude ADSR: decay falls to sustain                                     | PASS   |                                                                                                                 |
| SY13 | Amplitude ADSR: sustain holds level                                        | PASS   |                                                                                                                 |
| SY14 | Amplitude ADSR: release fades out after trigger off                        | FIXED  | Was: slider changes lost if set before power-on. Fix: applySynthParams() syncs all sliders on audio init        |
| SY15 | Gain slider controls output level                                          | PASS   |                                                                                                                 |
| SY16 | Room input for trigger: note on (positive edge) / note off (negative edge) | PASS   |                                                                                                                 |
| SY17 | Room input for frequency: sets pitch (Hz from arpeggiator/quantizer)       | PASS   |                                                                                                                 |
| SY18 | Room input for cutoff: modulates filter                                    |        |                                                                                                                 |
| SY19 | Current note display shows frequency + note name                           | PASS   |                                                                                                                 |
| SY20 | Output mode: AUDIO / CONTROL / BOTH                                        | PASS   |                                                                                                                 |
| SY21 | Scope shows output waveform                                                | PASS   |                                                                                                                 |

---

## EFFECTS

### 9. BITCRUSHER — `bitcrusher.html`

| #   | Test                                                  | Status | Issues |
| --- | ----------------------------------------------------- | ------ | ------ |
| BC1 | Audio input: link to oscillator, audio passes through | PASS   |        |
| BC2 | Bits slider: 16 = clean, 1 = heavily degraded         |        |        |
| BC3 | Wet slider blends dry/wet                             |        |        |
| BC4 | Gain slider controls output level                     |        |        |
| BC5 | Room input for bits: modulatable                      |        |        |
| BC6 | Output mode: AUDIO / CONTROL / BOTH                   |        |        |
| BC7 | Scope shows output waveform                           |        |        |

### 10. CHORUS — `chorus.html`

| #   | Test                                                  | Status | Issues |
| --- | ----------------------------------------------------- | ------ | ------ |
| CH1 | Audio input: link to oscillator, audio passes through | PASS   |        |
| CH2 | Frequency slider changes chorus rate                  |        |        |
| CH3 | Depth slider changes chorus intensity                 |        |        |
| CH4 | Room input for frequency: modulatable                 |        |        |
| CH5 | Room input for depth: modulatable                     |        |        |
| CH6 | Output mode: AUDIO / CONTROL / BOTH                   |        |        |
| CH7 | Scope shows output waveform                           |        |        |

### 11. COMPRESSOR — `compressor.html`

| #    | Test                                                        | Status | Issues |
| ---- | ----------------------------------------------------------- | ------ | ------ |
| CM1  | Audio input: link to oscillator, audio passes through       | PASS   |        |
| CM2  | Threshold slider: lower threshold = more compression        |        |        |
| CM3  | Ratio slider: higher ratio = more squash                    |        |        |
| CM4  | Attack slider: fast attack catches transients               |        |        |
| CM5  | Release slider: controls recovery time                      |        |        |
| CM6  | Knee slider: soft vs hard knee                              |        |        |
| CM7  | Makeup gain: compensates for level reduction                |        |        |
| CM8  | GR meter shows gain reduction amount                        |        |        |
| CM9  | Room inputs for threshold/ratio/attack/release: modulatable |        |        |
| CM10 | Output mode: AUDIO / CONTROL / BOTH                         |        |        |
| CM11 | Scope shows output waveform                                 |        |        |

### 12. DELAY — `delay.html`

| #   | Test                                                  | Status | Issues |
| --- | ----------------------------------------------------- | ------ | ------ |
| DL1 | Audio input: link to oscillator, audio passes through | PASS   |        |
| DL2 | Time slider changes delay time (audible echo spacing) |        |        |
| DL3 | Feedback slider: higher = more repeats                |        |        |
| DL4 | Room input for time: modulatable                      |        |        |
| DL5 | Room input for feedback: modulatable                  |        |        |
| DL6 | Output mode: AUDIO / CONTROL / BOTH                   |        |        |
| DL7 | Scope shows output waveform                           |        |        |

### 13. DISTORTION — `distortion.html`

| #   | Test                                                  | Status | Issues |
| --- | ----------------------------------------------------- | ------ | ------ |
| DT1 | Audio input: link to oscillator, audio passes through | PASS   |        |
| DT2 | Amount slider increases distortion intensity          |        |        |
| DT3 | Wet slider blends dry/wet                             |        |        |
| DT4 | Room input for amount: modulatable                    |        |        |
| DT5 | Output mode: AUDIO / CONTROL / BOTH                   |        |        |
| DT6 | Scope shows output waveform                           |        |        |

### 14. EQ — `eq.html`

| #   | Test                                                   | Status | Issues |
| --- | ------------------------------------------------------ | ------ | ------ |
| EQ1 | Audio input: link to oscillator, audio passes through  | PASS   |        |
| EQ2 | Low gain slider boosts/cuts low frequencies            |        |        |
| EQ3 | Mid gain slider boosts/cuts mid frequencies            |        |        |
| EQ4 | High gain slider boosts/cuts high frequencies          |        |        |
| EQ5 | Low crossover frequency slider adjusts low/mid split   |        |        |
| EQ6 | High crossover frequency slider adjusts mid/high split |        |        |
| EQ7 | Room inputs for low/mid/high: modulatable              |        |        |
| EQ8 | Output mode: AUDIO / CONTROL / BOTH                    |        |        |
| EQ9 | Scope shows output waveform                            |        |        |

### 15. FILTER — `filter.html`

| #   | Test                                                         | Status | Issues |
| --- | ------------------------------------------------------------ | ------ | ------ |
| F1  | Audio input: link to oscillator, audio passes through        | PASS   |        |
| F2  | Cutoff slider sweeps filter (audible tonal change)           |        |        |
| F3  | Q/resonance slider adds emphasis at cutoff                   |        |        |
| F4  | Filter type: lowpass / highpass / bandpass / notch           |        |        |
| F5  | Gain slider controls output level                            |        |        |
| F6  | Room input for cutoff: modulatable (LFO filter sweep)        |        |        |
| F7  | Room input for cutoff: audio-rate modulation from oscillator |        |        |
| F8  | Room input for Q: modulatable                                |        |        |
| F9  | Room input for type: changes filter mode                     |        |        |
| F10 | Output mode: AUDIO / CONTROL / BOTH                          |        |        |
| F11 | Scope shows output waveform                                  |        |        |

### 16. PANNER — `panner.html`

| #   | Test                                                  | Status | Issues |
| --- | ----------------------------------------------------- | ------ | ------ |
| P1  | Audio input: link to oscillator, audio passes through | PASS   |        |
| P2  | MANUAL mode: pan slider moves audio left/right        | PASS   |        |
| P3  | AUTO mode: audio sweeps left/right automatically      |        |        |
| P4  | AUTO mode: rate slider changes sweep speed            |        |        |
| P5  | AUTO mode: depth slider changes sweep width           |        |        |
| P6  | Mode switch: MANUAL ↔ AUTO toggles correctly          |        |        |
| P7  | Room input for pan: modulatable (manual mode)         |        |        |
| P8  | Room input for rate/depth: modulatable (auto mode)    |        |        |
| P9  | Output mode: AUDIO / CONTROL / BOTH                   |        |        |
| P10 | Scope shows output waveform                           |        |        |

### 17. PHASER — `phaser.html`

| #   | Test                                                  | Status | Issues |
| --- | ----------------------------------------------------- | ------ | ------ |
| PH1 | Audio input: link to oscillator, audio passes through | PASS   |        |
| PH2 | Frequency slider changes phaser sweep rate            | PASS   |        |
| PH3 | Octaves slider changes phaser sweep range             | PASS   |        |
| PH4 | Wet slider blends dry/wet                             | PASS   |        |
| PH5 | Room input for frequency: modulatable                 |        |        |
| PH6 | Output mode: AUDIO / CONTROL / BOTH                   |        |        |
| PH7 | Scope shows output waveform                           |        |        |

### 18. PITCH SHIFT — `pitchshift.html`

| #   | Test                                                  | Status | Issues |
| --- | ----------------------------------------------------- | ------ | ------ |
| PS1 | Audio input: link to oscillator, audio passes through | PASS   |        |
| PS2 | Pitch slider: shifts up/down (-24 to +24 semitones)   | PASS   |        |
| PS3 | 0 semitones = no change (clean passthrough)           |        |        |
| PS4 | Wet slider blends dry/wet                             |        |        |
| PS5 | Room input for pitch: modulatable                     |        |        |
| PS6 | Output mode: AUDIO / CONTROL / BOTH                   |        |        |
| PS7 | Scope shows output waveform                           |        |        |

### 19. REVERB — `reverb.html`

| #   | Test                                                  | Status | Issues |
| --- | ----------------------------------------------------- | ------ | ------ |
| RV1 | Audio input: link to oscillator, audio passes through | PASS   |        |
| RV2 | Decay slider changes reverb tail length               | PASS   |        |
| RV3 | Wet slider blends dry/wet                             | PASS   |        |
| RV4 | Room input for decay: modulatable                     |        |        |
| RV5 | Room input for wet: modulatable                       |        |        |
| RV6 | Output mode: AUDIO / CONTROL / BOTH                   | PASS   |        |
| RV7 | Scope shows output waveform                           | PASS   |        |

### 20. RING MOD — `ringmod.html`

| #   | Test                                                  | Status | Issues |
| --- | ----------------------------------------------------- | ------ | ------ |
| RM1 | Audio input: link to oscillator, audio passes through | PASS   |        |
| RM2 | Carrier frequency slider changes ring mod tone        | PASS   |        |
| RM3 | Depth slider blends dry/wet                           | PASS   |        |
| RM4 | Carrier waveform: sine / triangle / sawtooth / square | PASS   |        |
| RM5 | Room input for frequency: modulatable                 |        |        |
| RM6 | Output mode: AUDIO / CONTROL / BOTH                   |        |        |
| RM7 | Scope shows output waveform                           |        |        |

### 21. WAVEFOLDER — `wavefolder.html`

| #    | Test                                                     | Status | Issues                |
| ---- | -------------------------------------------------------- | ------ | --------------------- |
| WF1  | Audio input: link to oscillator, audio passes through    | PASS   |                       |
| WF2  | Drive slider: increases pre-amplification into folder    | PASS   |                       |
| WF3  | Folds slider: more folds = more harmonic complexity      | FAIL   | slider not responding |
| WF4  | Symmetry slider: shifts folding threshold asymmetrically | PASS   |                       |
| WF5  | Gain slider controls output level                        | PASS   |                       |
| WF6  | Transfer curve canvas shows input/output mapping         | PASS   |                       |
| WF7  | Transfer curve updates when drive/folds/symmetry change  | PASS   |                       |
| WF8  | Room inputs for drive/folds/symmetry: modulatable        |        |                       |
| WF9  | Output mode: AUDIO / CONTROL / BOTH                      | PASS   |                       |
| WF10 | Scope shows output waveform                              | PASS   |                       |

---

## MODULATION

### 22. ENVELOPE — `envelope.html`

| #   | Test                                                    | Status | Issues |
| --- | ------------------------------------------------------- | ------ | ------ |
| EN1 | Audio input: link to oscillator, audio passes through   |        |        |
| EN2 | Manual trigger button fires envelope                    |        |        |
| EN3 | Attack slider: ramp-up time                             |        |        |
| EN4 | Decay slider: fall time to sustain                      |        |        |
| EN5 | Sustain slider: held level                              |        |        |
| EN6 | Release slider: fade-out after trigger off              |        |        |
| EN7 | Room input for trigger: fires envelope on positive edge |        |        |
| EN8 | ADSR output broadcasts envelope shape                   |        |        |
| EN9 | Scope shows envelope shape                              |        |        |

### 23. FUNC GEN — `funcgen.html`

| #    | Test                                                 | Status | Issues |
| ---- | ---------------------------------------------------- | ------ | ------ |
| FG1  | Manual trigger button starts function                |        |        |
| FG2  | RAMP UP shape: linear 0 → +1                         |        |        |
| FG3  | RAMP DOWN shape: linear +1 → 0                       |        |        |
| FG4  | TRIANGLE shape: 0 → +1 → 0                           |        |        |
| FG5  | EXPONENTIAL RISE shape: curved 0 → +1                |        |        |
| FG6  | EXPONENTIAL FALL shape: curved +1 → 0                |        |        |
| FG7  | S-CURVE shape: smooth sigmoid                        |        |        |
| FG8  | ATTACK-DECAY shape: fast attack, slower decay        |        |        |
| FG9  | RANDOM WALK shape: brownian motion                   |        |        |
| FG10 | Duration slider: controls function length (0.01-30s) |        |        |
| FG11 | Level slider: scales output amplitude                |        |        |
| FG12 | Curve slider: adjusts exponential curvature          |        |        |
| FG13 | Attack % slider: adjusts attack/decay ratio          |        |        |
| FG14 | HOLD end mode: stays at final value                  |        |        |
| FG15 | RETURN end mode: snaps back to 0                     |        |        |
| FG16 | LOOP end mode: restarts automatically                |        |        |
| FG17 | Shape preview canvas shows theoretical curve         |        |        |
| FG18 | Playhead dot animates during active function         |        |        |
| FG19 | Room input for trigger: fires function               |        |        |
| FG20 | Phase output broadcasts 0-1 progress                 |        |        |
| FG21 | Active output: +1 while running, -1 when done        |        |        |

### 24. LFO — `lfo.html`

| #    | Test                                                           | Status | Issues                                |
| ---- | -------------------------------------------------------------- | ------ | ------------------------------------- |
| LF1  | Power toggle starts/stops LFO                                  | PASS   |                                       |
| LF2  | Rate slider changes LFO speed (0.01-100 Hz)                    | PASS   |                                       |
| LF3  | Depth slider scales output amplitude                           | PASS   |                                       |
| LF4  | Sine waveform: smooth oscillation                              | PASS   |                                       |
| LF5  | Triangle waveform: linear ramp up/down                         | PASS   |                                       |
| LF6  | Sawtooth waveform: ramp up, drop                               | PASS   |                                       |
| LF7  | Square waveform: alternating high/low                          | PASS   |                                       |
| LF8  | Pulse 25% waveform                                             |        | sometimes doesnt modulate all targets |
| LF9  | Pulse 10% waveform                                             |        | sometimes doesnt modulate all targets |
| LF10 | Exp rise waveform                                              |        | sometimes doesnt modulate all targets |
| LF11 | Exp fall waveform                                              |        | sometimes doesnt modulate all targets |
| LF12 | Staircase waveform: stepped levels                             |        | sometimes doesnt modulate all targets |
| LF13 | Random S&H waveform: random held values                        |        | sometimes doesnt modulate all targets |
| LF14 | Smooth random waveform: interpolated random                    |        | sometimes doesnt modulate all targets |
| LF15 | Wander waveform: brownian drift                                |        | sometimes doesnt modulate all targets |
| LF16 | Signal output modulates another object (link to osc frequency) |        | sometimes doesnt modulate all targets |
| LF17 | Room input for rate: modulatable                               |        |                                       |
| LF18 | Scope shows LFO waveform                                       | PASS   |                                       |

### 25. SAMPLE & HOLD — `samplehold.html`

| #   | Test                                                   | Status | Issues |
| --- | ------------------------------------------------------ | ------ | ------ |
| SH1 | Room input for signal: receives continuous value       |        |        |
| SH2 | Room input for trigger: samples value on positive edge |        |        |
| SH3 | Output holds sampled value until next trigger          |        |        |
| SH4 | Slew slider: 0 = instant, higher = glide to new value  |        |        |
| SH5 | Scope shows stepped output                             |        |        |

---

## SEQUENCING

### 26. ARPEGGIATOR — `arpeggiator.html`

| #    | Test                                                       | Status | Issues |
| ---- | ---------------------------------------------------------- | ------ | ------ |
| AR1  | Root note selector: C through B                            |        |        |
| AR2  | Scale selector: all 8 scales produce different patterns    |        |        |
| AR3  | Base octave slider: shifts pitch range                     |        |        |
| AR4  | Octave range slider: expands pattern span                  |        |        |
| AR5  | UP pattern: ascending                                      |        |        |
| AR6  | DOWN pattern: descending                                   |        |        |
| AR7  | UP-DOWN pattern: pendulum                                  |        |        |
| AR8  | DOWN-UP pattern: reverse pendulum                          |        |        |
| AR9  | RANDOM pattern: random note selection                      |        |        |
| AR10 | Gate length slider: controls note duration percentage      |        |        |
| AR11 | Room input for trigger: advances to next note (link clock) |        |        |
| AR12 | Frequency output: Hz value (link to oscillator or synth)   |        |        |
| AR13 | Gate output: +1 note on, -1 note off (link to envelope)    |        |        |
| AR14 | Step output: current step number                           |        |        |
| AR15 | Note name display updates on each step                     |        |        |

### 27. CLOCK — `clock.html`

| #   | Test                                                | Status | Issues |
| --- | --------------------------------------------------- | ------ | ------ |
| CK1 | START/STOP button toggles clock                     |        |        |
| CK2 | BPM slider changes tempo (20-300)                   |        |        |
| CK3 | Division selector: 1/1, 1/2, 1/4, 1/8, 1/16, 1/32   |        |        |
| CK4 | Swing slider adds swing feel                        |        |        |
| CK5 | Tap tempo: tapping sets BPM from tap intervals      |        |        |
| CK6 | Signal output: trigger pulses at tempo              |        |        |
| CK7 | Link clock output to sequencer/euclid trigger input |        |        |
| CK8 | Room input for BPM: sync from external source       |        |        |
| CK9 | Scope shows trigger pulse train                     |        |        |

### 28. EUCLID — `euclid.html`

| #   | Test                                                           | Status | Issues |
| --- | -------------------------------------------------------------- | ------ | ------ |
| EU1 | Steps slider: changes total steps (2-32)                       |        |        |
| EU2 | Beats slider: changes active beats (0-steps)                   |        |        |
| EU3 | Offset slider: rotates pattern                                 |        |        |
| EU4 | Ring visualization shows pattern with active beats highlighted |        |        |
| EU5 | Room input for trigger: advances step (link clock)             |        |        |
| EU6 | Signal output: +1 on active step, -1 on inactive               |        |        |
| EU7 | Pattern output: broadcasts array                               |        |        |
| EU8 | Room inputs for steps/beats/offset: modulatable                |        |        |
| EU9 | Playhead shows current position on ring                        |        |        |

### 29. SEQUENCER — `sequencer.html`

| #    | Test                                                | Status | Issues |
| ---- | --------------------------------------------------- | ------ | ------ |
| SQ1  | 8 step faders visible and adjustable                |        |        |
| SQ2  | Steps slider: changes active step count (1-8)       |        |        |
| SQ3  | Forward mode: steps advance left to right           |        |        |
| SQ4  | Reverse mode: steps advance right to left           |        |        |
| SQ5  | Pendulum mode: bounces back and forth               |        |        |
| SQ6  | Random mode: random step selection                  |        |        |
| SQ7  | Room input for trigger: advances step (link clock)  |        |        |
| SQ8  | Room input for reset: returns to step 1             |        |        |
| SQ9  | Signal output: current step value mapped to bipolar |        |        |
| SQ10 | Step output: current step number                    |        |        |
| SQ11 | Current step highlighted visually                   |        |        |

---

## SIGNAL ROUTING

### 30. CROSSFADER — `crossfader.html`

| #   | Test                                                 | Status | Issues |
| --- | ---------------------------------------------------- | ------ | ------ |
| XF1 | Audio input A: link to first oscillator              |        |        |
| XF2 | Audio input B: link to second oscillator             |        |        |
| XF3 | Crossfade slider at 0: only A audible                |        |        |
| XF4 | Crossfade slider at 1: only B audible                |        |        |
| XF5 | Crossfade slider at 0.5: equal mix of A and B        |        |        |
| XF6 | Output gain slider controls level                    |        |        |
| XF7 | Room input for fade: LFO-driven crossfade automation |        |        |
| XF8 | Output mode: AUDIO / CONTROL / BOTH                  |        |        |
| XF9 | Scope shows output waveform                          |        |        |

### 31. MIXER — `mixer.html`

| #   | Test                                             | Status | Issues |
| --- | ------------------------------------------------ | ------ | ------ |
| MX1 | Add channel: paste room URL, channel appears     |        |        |
| MX2 | Multiple channels: add 2+ sources                |        |        |
| MX3 | Per-channel fader: adjusts individual level      |        |        |
| MX4 | Per-channel mute: silences individual channel    |        |        |
| MX5 | Remove channel button works                      |        |        |
| MX6 | Master gain slider controls overall output       |        |        |
| MX7 | Room input for master mod: modulates master gain |        |        |
| MX8 | Output mode: AUDIO / CONTROL / BOTH              |        |        |
| MX9 | Scope shows mixed output waveform                |        |        |

---

## UTILITY

### 32. GAIN — `gain.html`

| #   | Test                                                  | Status | Issues |
| --- | ----------------------------------------------------- | ------ | ------ |
| GA1 | Audio input: link to oscillator, audio passes through |        |        |
| GA2 | Gain slider: amplify (>1) and attenuate (<1)          |        |        |
| GA3 | Room input for gain: modulatable                      |        |        |
| GA4 | Output mode: AUDIO / CONTROL / BOTH                   |        |        |
| GA5 | Scope shows output waveform                           |        |        |

### 33. GATE — `gate.html`

| #   | Test                                                          | Status | Issues |
| --- | ------------------------------------------------------------- | ------ | ------ |
| GT1 | Room input for signal: receives continuous value              |        |        |
| GT2 | Room input for control: opens/closes gate                     |        |        |
| GT3 | PASS mode: signal passes when control > threshold             |        |        |
| GT4 | BLOCK mode: signal passes when control < threshold (inverted) |        |        |
| GT5 | Threshold slider adjusts gate trigger point                   |        |        |
| GT6 | Closed value slider: what outputs when gate is closed         |        |        |
| GT7 | Slew slider: smooths gate transitions                         |        |        |
| GT8 | OPEN/CLOSED indicator displays current state                  |        |        |
| GT9 | State output: +1 open, -1 closed                              |        |        |

### 34. LOGIC — `logic.html`

| #    | Test                                                   | Status | Issues |
| ---- | ------------------------------------------------------ | ------ | ------ |
| LG1  | Room input for A: receives bipolar signal              |        |        |
| LG2  | Room input for B: receives bipolar signal              |        |        |
| LG3  | AND: output +1 only when both A and B are true         |        |        |
| LG4  | OR: output +1 when either A or B is true               |        |        |
| LG5  | XOR: output +1 when exactly one is true                |        |        |
| LG6  | NAND: inverse of AND                                   |        |        |
| LG7  | NOR: inverse of OR                                     |        |        |
| LG8  | NOT: inverts A only (B ignored)                        |        |        |
| LG9  | A threshold slider: adjusts true/false boundary        |        |        |
| LG10 | B threshold slider: adjusts true/false boundary        |        |        |
| LG11 | Truth table display shows A/B/output states with color |        |        |

### 35. MATH — `math.html`

| #    | Test                                      | Status | Issues |
| ---- | ----------------------------------------- | ------ | ------ |
| MT1  | Room input for A: receives bipolar signal |        |        |
| MT2  | Room input for B: receives bipolar signal |        |        |
| MT3  | ADD operation: A + B                      |        |        |
| MT4  | SUBTRACT operation: A - B                 |        |        |
| MT5  | MULTIPLY operation: A \* B                |        |        |
| MT6  | MIN operation: lesser of A and B          |        |        |
| MT7  | MAX operation: greater of A and B         |        |        |
| MT8  | AVERAGE operation: (A + B) / 2            |        |        |
| MT9  | Scale A slider: pre-scales input A        |        |        |
| MT10 | Scale B slider: pre-scales input B        |        |        |
| MT11 | Offset slider: adds constant to result    |        |        |
| MT12 | Output clamped to -1..+1                  |        |        |

### 36. MIDI CALC — `midicalc.html`

| #   | Test                                                          | Status | Issues |
| --- | ------------------------------------------------------------- | ------ | ------ |
| MC1 | Root selector: C through B                                    |        |        |
| MC2 | Mode selector: all 7 modes                                    |        |        |
| MC3 | Results table shows: degree, note name, MIDI value, frequency |        |        |
| MC4 | Table updates when root or mode changes                       |        |        |
| MC5 | Clicking a note broadcasts its frequency                      |        |        |
| MC6 | Outputs: root, mode, scale values broadcast to room           |        |        |

### 37. PROBABILITY — `probability.html`

| #    | Test                                                         | Status | Issues |
| ---- | ------------------------------------------------------------ | ------ | ------ |
| PR1  | Room input for trigger: receives trigger pulses              |        |        |
| PR2  | Probability slider: 0% = all blocked, 100% = all pass        |        |        |
| PR3  | 50% probability: roughly half of triggers pass through       |        |        |
| PR4  | TRIGGER mode: individual triggers pass/block independently   |        |        |
| PR5  | GATE mode: state toggles on each trigger (stays open/closed) |        |        |
| PR6  | Signal output: +1 when passed, -1 when blocked               |        |        |
| PR7  | Statistics display: pass rate percentage                     |        |        |
| PR8  | History dots: green = passed, dim = blocked                  |        |        |
| PR9  | Room input for probability: modulatable                      |        |        |
| PR10 | passCount and totalCount outputs increment                   |        |        |

### 38. QUANTIZER — `quantizer.html`

| #    | Test                                                     | Status | Issues |
| ---- | -------------------------------------------------------- | ------ | ------ |
| QN1  | Room input for signal: receives continuous bipolar value |        |        |
| QN2  | Root selector: C through B                               |        |        |
| QN3  | Scale: chromatic (all 12 notes)                          |        |        |
| QN4  | Scale: major (7 notes)                                   |        |        |
| QN5  | Scale: minor (7 notes)                                   |        |        |
| QN6  | Scale: pentatonic (5 notes)                              |        |        |
| QN7  | Scale: blues (6 notes)                                   |        |        |
| QN8  | Scale: dorian, mixolydian, whole-tone                    |        |        |
| QN9  | Output snaps to nearest scale degree                     |        |        |
| QN10 | Frequency output: Hz value                               |        |        |
| QN11 | Signal output: quantized bipolar                         |        |        |
| QN12 | Note name display shows current note                     |        |        |
| QN13 | Range slider adjusts octave span                         |        |        |

### 39. RNG — `rng.html`

| #    | Test                                             | Status | Issues |
| ---- | ------------------------------------------------ | ------ | ------ |
| RN1  | FREE mode: generates values continuously         |        |        |
| RN2  | TRIGGER mode: generates on positive edge only    |        |        |
| RN3  | Rate slider changes generation speed (FREE mode) |        |        |
| RN4  | UNIFORM distribution: even spread across range   |        |        |
| RN5  | GAUSSIAN distribution: bell curve centered on 0  |        |        |
| RN6  | BIPOLAR distribution: full -1 to +1 range        |        |        |
| RN7  | BINARY distribution: only -1 or +1               |        |        |
| RN8  | WALK distribution: brownian motion (small steps) |        |        |
| RN9  | Min/max sliders limit output range (UNIFORM)     |        |        |
| RN10 | Step size slider limits walk step (WALK)         |        |        |
| RN11 | Spread slider controls gaussian width            |        |        |
| RN12 | Histogram shows distribution shape               |        |        |
| RN13 | Room input for trigger: fires in TRIGGER mode    |        |        |
| RN14 | Large value display updates in real-time         |        |        |

---

## VISUALIZATION

### 40. DB METER — `dbmeter.html`

| #   | Test                                                       | Status | Issues |
| --- | ---------------------------------------------------------- | ------ | ------ |
| DB1 | MIC source: captures microphone input                      |        |        |
| DB2 | ROOM source: receives audio from room input                |        |        |
| DB3 | VU meter bar tracks audio level                            |        |        |
| DB4 | Peak hold indicator shows and decays                       |        |        |
| DB5 | dB readout displays current level                          |        |        |
| DB6 | Smoothing slider adjusts meter response                    |        |        |
| DB7 | Signal output: level mapped to 0..1 (usable as mod source) |        |        |

### 41. SCOPE — `scope.html`

| #   | Test                                               | Status | Issues          |
| --- | -------------------------------------------------- | ------ | --------------- |
| SC1 | Audio input: link to oscillator, waveform displays | PASS   |                 |
| SC2 | Time scaling: adjusts horizontal zoom              | PASS   |                 |
| SC3 | Gain scaling: adjusts vertical zoom                | PASS   |                 |
| SC4 | Trigger mode: stabilizes waveform display          | PASS   |                 |
| SC5 | Waveform renders smoothly at audio rate            | FAIL   | visual aliasing |

---

## SYSTEM

### 42. DISTRIBUTED OBJECTS (Dashboard) — `dashboard.html`

| #   | Test                                                     | Status | Issues |
| --- | -------------------------------------------------------- | ------ | ------ |
| DA1 | Page loads and connects to WebSocket server              | PASS   |        |
| DA2 | Shows active rooms as nodes in topology graph            | PASS   |        |
| DA3 | Shows connections between rooms as edges                 | PASS   |        |
| DA4 | Graph updates in real-time as objects connect/disconnect | PASS   |        |
| DA5 | Signal flow hierarchy is visible                         | PASS   |        |
| DA6 | Interactive — nodes can be clicked/dragged               | PASS   |        |

---

## INTEGRATION TESTS

Test signal chains across multiple objects.

| #     | Test                                                                | Status | Issues                                              |
| ----- | ------------------------------------------------------------------- | ------ | --------------------------------------------------- |
| INT1  | Oscillator → Filter → Reverb → Scope (basic chain)                  | PASS   | with issues noted in reverb tests                   |
| INT2  | LFO → Oscillator frequency (vibrato)                                | PASS   |                                                     |
| INT3  | LFO → Filter cutoff (filter sweep)                                  |        |                                                     |
| INT4  | Clock → Sequencer → Oscillator frequency (sequenced melody)         |        |                                                     |
| INT5  | Clock → Euclid → Envelope → Oscillator (euclidean rhythm)           |        |                                                     |
| INT6  | Clock → Arpeggiator → Synth (arpeggiated synth)                     |        |                                                     |
| INT7  | Oscillator A → Oscillator B frequency (FM synthesis)                | PASS   |                                                     |
| INT8  | Osc A → Osc B → Osc C frequency (cascading FM)                      | PASS   |                                                     |
| INT9  | Noise → Sample & Hold → Quantizer → Oscillator (random melody)      |        |                                                     |
| INT10 | Clock → Probability → Envelope (probabilistic triggers)             |        |                                                     |
| INT11 | LFO → Math (scale) → Filter cutoff (scaled modulation)              |        |                                                     |
| INT12 | Audio Input → Filter → Delay → Reverb (live FX chain)               |        |                                                     |
| INT13 | Oscillator + Noise → Mixer → Compressor → Scope (mix + dynamics)    |        |                                                     |
| INT14 | Clock → Drums + Sequencer → Mixer (rhythm + melody)                 |        |                                                     |
| INT15 | RNG → Gate (control) + LFO (signal) → Oscillator (gated random)     |        |                                                     |
| INT16 | Func Gen → Oscillator frequency (pitch sweep)                       |        |                                                     |
| INT17 | Sampler triggered by Clock (rhythmic sample playback)               |        |                                                     |
| INT18 | Granular with LFO → position (scanning granular texture)            |        |                                                     |
| INT19 | Two users: same room, parameter changes sync in real-time           | FAIL   | sliders need smoother scaling, they jump and glitch |
| INT20 | Cross-machine: modules on different devices, connected via room URL |        |                                                     |

---

## MOBILE DEVICE TESTS

Test core functionality on mobile browsers (iOS Safari, Android Chrome).

### Touch Interaction

| #   | Test                                                              | Status | Issues |
| --- | ----------------------------------------------------------------- | ------ | ------ |
| MB1 | Sliders respond to touch drag (no accidental page scroll)         |        |        |
| MB2 | Buttons respond to tap (single tap, no double-tap zoom)           |        |        |
| MB3 | Step grid cells (drums/sequencer) toggle on tap                   |        |        |
| MB4 | COPY URL button works (clipboard API available)                   |        |        |
| MB5 | Room URL paste works from mobile clipboard                        |        |        |
| MB6 | Long-press does not trigger context menu on interactive elements  |        |        |
| MB7 | Drag-and-drop file loading (granular/sampler) has fallback picker |        |        |

### Layout & Responsiveness

| #    | Test                                                            | Status | Issues                                                                              |
| ---- | --------------------------------------------------------------- | ------ | ----------------------------------------------------------------------------------- |
| MB8  | Page renders without horizontal overflow (no sideways scroll)   |        |                                                                                     |
| MB9  | Controls are large enough to tap (minimum 44x44px touch target) |        |                                                                                     |
| MB10 | Text is readable without pinch-to-zoom                          |        |                                                                                     |
| MB11 | Header/status bar doesn't overlap with device notch/safe area   |        |                                                                                     |
| MB12 | Theme selector dropdown usable on mobile                        |        |                                                                                     |
| MB13 | Scope/waveform canvas scales to viewport width                  |        |                                                                                     |
| MB14 | Room panel and input ports are accessible without scrolling     |        |                                                                                     |
| MB15 | Landscape / portrait view of distributed networks page          | FAIL   | cannot use two fingers to zoom in on mobile, and cannot drag and move a room object |

### Audio & WebSocket

| #    | Test                                                             | Status | Issues |
| ---- | ---------------------------------------------------------------- | ------ | ------ |
| MB15 | Audio context starts after user gesture (mobile autoplay policy) |        |        |
| MB16 | WebSocket reconnects after app goes to background/foreground     |        |        |
| MB17 | Audio resumes after phone call / interruption                    |        |        |
| MB18 | Oscillator/synth produces sound on mobile (Tone.js works)        |        |        |
| MB19 | Microphone input works on mobile (permission prompt appears)     |        |        |
| MB20 | Signal output broadcasts correctly from mobile device            |        |        |

### Performance & Battery

| #    | Test                                                          | Status | Issues |
| ---- | ------------------------------------------------------------- | ------ | ------ |
| MB21 | Page loads within 5 seconds on 4G connection                  |        |        |
| MB22 | UI remains responsive while audio is running                  |        |        |
| MB23 | Scope animation doesn't cause excessive frame drops on mobile |        |        |
| MB24 | App doesn't drain battery excessively in background           |        |        |

### Cross-Device Connectivity

| #    | Test                                                                  | Status | Issues |
| ---- | --------------------------------------------------------------------- | ------ | ------ |
| MB25 | Mobile → Desktop: signal from mobile object received on desktop scope |        |        |
| MB26 | Desktop → Mobile: signal from desktop object modulates mobile target  |        |        |
| MB27 | Mobile → Mobile: two phones in same room, signals sync                |        |        |
| MB28 | Latency display shows reasonable values on mobile network (< 200ms)   |        |        |

---

## OUTBOUND MODULATION

Test that each object's output signal successfully modulates a parameter on a downstream target.
Method: connect object output room → target input, verify modulation effect.

### Signal Sources → Target

| #   | Source → Target                                          | Status | Issues |
| --- | -------------------------------------------------------- | ------ | ------ |
| OM1 | Audio Input → Filter cutoff (envelope follower behavior) |        |        |
| OM2 | Audio Input → Scope (waveform visible)                   | PASS   |        |
| OM3 | Noise → Filter cutoff (random modulation)                |        |        |
| OM4 | Noise → Oscillator frequency (noise FM)                  |        |        |
| OM5 | Oscillator → Oscillator frequency (FM synthesis)         |        |        |
| OM6 | Oscillator → Filter cutoff (audio-rate filter mod)       |        |        |
| OM7 | Oscillator → Ring Mod carrier frequency                  |        |        |

### Instruments → Target

| #    | Source → Target                                     | Status | Issues |
| ---- | --------------------------------------------------- | ------ | ------ |
| OM8  | Drums → Scope (trigger pulses visible)              |        |        |
| OM9  | Drums → Envelope trigger (drum-triggered envelope)  |        |        |
| OM10 | Granular → Scope (output visible)                   |        |        |
| OM11 | Granular → Filter audio input (granular → FX chain) |        |        |
| OM12 | Looper → Scope (loop output visible)                |        |        |
| OM13 | Looper → Reverb audio input (looper → FX chain)     |        |        |
| OM14 | Sampler → Scope (sample output visible)             |        |        |
| OM15 | Sampler → Delay audio input (sampler → FX chain)    |        |        |
| OM16 | Synth → Scope (synth output visible)                |        |        |
| OM17 | Synth → Filter audio input (synth → FX chain)       |        |        |

### Effects → Target

| #    | Source → Target                                | Status | Issues |
| ---- | ---------------------------------------------- | ------ | ------ |
| OM18 | Bitcrusher → Scope (crushed signal visible)    |        |        |
| OM19 | Chorus → Scope (chorused signal visible)       |        |        |
| OM20 | Compressor → Scope (compressed signal visible) |        |        |
| OM21 | Delay → Scope (echoes visible)                 |        |        |
| OM22 | Distortion → Scope (distorted signal visible)  |        |        |
| OM23 | EQ → Scope (EQ'd signal visible)               |        |        |
| OM24 | Filter → Scope (filtered signal visible)       |        |        |
| OM25 | Filter → Reverb audio input (effect chaining)  |        |        |
| OM26 | Panner → Scope (panned signal visible)         |        |        |
| OM27 | Phaser → Scope (phased signal visible)         |        |        |
| OM28 | Pitch Shift → Scope (shifted signal visible)   |        |        |
| OM29 | Reverb → Scope (reverb tail visible)           |        |        |
| OM30 | Ring Mod → Scope (ring mod signal visible)     |        |        |
| OM31 | Wavefolder → Scope (folded signal visible)     |        |        |

### Modulation → Target

| #    | Source → Target                                      | Status | Issues |
| ---- | ---------------------------------------------------- | ------ | ------ |
| OM32 | Envelope → Oscillator gain (amplitude shaping)       |        |        |
| OM33 | Envelope → Filter cutoff (filter envelope)           |        |        |
| OM34 | Envelope → Synth trigger (note on/off)               |        |        |
| OM35 | Func Gen → Oscillator frequency (pitch sweep)        |        |        |
| OM36 | Func Gen → Filter cutoff (filter sweep)              |        |        |
| OM37 | Func Gen phase → Scope (phase ramp visible)          |        |        |
| OM38 | LFO → Oscillator frequency (vibrato)                 |        |        |
| OM39 | LFO → Oscillator gain (tremolo)                      |        |        |
| OM40 | LFO → Filter cutoff (filter sweep)                   |        |        |
| OM41 | LFO → Panner pan position (auto-pan)                 |        |        |
| OM42 | LFO → Delay time (chorus-like modulation)            |        |        |
| OM43 | Sample & Hold → Oscillator frequency (stepped pitch) |        |        |
| OM44 | Sample & Hold → Filter cutoff (stepped filter)       |        |        |

### Sequencing → Target

| #    | Source → Target                                      | Status | Issues |
| ---- | ---------------------------------------------------- | ------ | ------ |
| OM45 | Arpeggiator freq → Oscillator frequency (arp melody) |        |        |
| OM46 | Arpeggiator freq → Synth frequency (arp synth)       |        |        |
| OM47 | Arpeggiator gate → Envelope trigger (note gating)    |        |        |
| OM48 | Clock → Sequencer trigger (clocked sequence)         |        |        |
| OM49 | Clock → Euclid trigger (clocked euclidean)           |        |        |
| OM50 | Clock → Arpeggiator trigger (clocked arp)            |        |        |
| OM51 | Clock → Drums trigger (external clock sync)          |        |        |
| OM52 | Clock → Envelope trigger (rhythmic envelope)         |        |        |
| OM53 | Clock → Sampler trigger (rhythmic sample playback)   |        |        |
| OM54 | Euclid → Envelope trigger (euclidean rhythm)         |        |        |
| OM55 | Euclid → Probability trigger (filtered euclidean)    |        |        |
| OM56 | Sequencer → Oscillator frequency (sequenced pitch)   |        |        |
| OM57 | Sequencer → Filter cutoff (sequenced filter)         |        |        |
| OM58 | Sequencer → Gain level (sequenced amplitude)         |        |        |

### Signal Routing → Target

| #    | Source → Target                                   | Status | Issues |
| ---- | ------------------------------------------------- | ------ | ------ |
| OM59 | Crossfader → Scope (mixed signal visible)         |        |        |
| OM60 | Crossfader → Reverb audio input (crossfaded → FX) |        |        |
| OM61 | Mixer → Scope (mixed signal visible)              |        |        |
| OM62 | Mixer → Compressor audio input (mix → dynamics)   |        |        |

### Utility → Target

| #    | Source → Target                                         | Status | Issues |
| ---- | ------------------------------------------------------- | ------ | ------ |
| OM63 | Gain → Scope (amplified signal visible)                 |        |        |
| OM64 | Gain → Filter audio input (gain staging into FX)        |        |        |
| OM65 | Gate state → Oscillator gain (gated drone)              |        |        |
| OM66 | Gate signal → Scope (gated signal visible)              |        |        |
| OM67 | Logic → Gate control (logic-controlled gate)            |        |        |
| OM68 | Logic → Probability trigger (logic-filtered triggers)   |        |        |
| OM69 | Math → Oscillator frequency (computed pitch)            |        |        |
| OM70 | Math → Filter cutoff (computed modulation)              |        |        |
| OM71 | MIDI Calc → Oscillator frequency (scale frequency)      |        |        |
| OM72 | MIDI Calc → Synth frequency (scale-driven synth)        |        |        |
| OM73 | Probability → Envelope trigger (probabilistic notes)    |        |        |
| OM74 | Probability → Sampler trigger (probabilistic playback)  |        |        |
| OM75 | Quantizer freq → Oscillator frequency (quantized pitch) |        |        |
| OM76 | Quantizer freq → Synth frequency (quantized synth)      |        |        |
| OM77 | Quantizer signal → Scope (quantized steps visible)      |        |        |
| OM78 | RNG → Oscillator frequency (random pitch)               |        |        |
| OM79 | RNG → Filter cutoff (random filter)                     |        |        |
| OM80 | RNG → Sample & Hold signal (S&H source)                 |        |        |

### Visualization → Target

| #    | Source → Target                                  | Status | Issues |
| ---- | ------------------------------------------------ | ------ | ------ |
| OM81 | DB Meter → Gain level (level-following dynamics) |        |        |
| OM82 | DB Meter → Filter cutoff (envelope follower)     |        |        |

---

### Open Requests By Users

- when clicking on a unit it would be nice if it spawned a new tab instead of going to a new page on...
- room name - can it just be the string instead of URL?
- transfer function might update to reflect wavefolding process
- what is the current goal of the [distributed objects] graph / display?
- does the scope work?
- how does a user notify the rest of the network that nodes have been configured and are "ready"?
- disambiguate rooms vs entire network

### Resolved Requests By Users

- explain this more — "you can spin up your own instance on a local machine or private network for zero-latency patching with full control over who connects." FIXED - added to info popup: 6. Rooms can be set to private, restricting signal flow to only those who know the room name — useful for isolating sub-patches or running a closed session. The server itself is a standard Node.js WebSocket process — clone the repo, run npm install and npm start inside the EW-objects/ directory, and you have your own signal relay running on localhost:3001. Point your modules at that local address instead of the public server and all traffic stays on your machine or LAN — no internet round-trip, minimal latency, and only devices you allow on your network can connect. This is ideal for live performance setups, private jam sessions, or development without depending on an external host.
- // what is it? // intro could be on top; easier to intro that way; maybe collapsible so it doesn't take entire screen - FIXED - added an INTRODUCTION button with a popup containing all info and instructions
- is there such a thing as "cleanup" where inactive (abandoned) nodes get cut within a certain amount of time? YES and NO, nodes will stay active as long as at least one user has it running in a browser instance, after the last browser instance closes, the node terminates
