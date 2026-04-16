let oscillators = [];
let audioContext;
let currentVolume = 0;
let gainNodes = [];
let globalGainNode;
let isPlaying = [];

// Setup audio context and global gain node
function setupAudioContext(window) {
  // Create a new AudioContext
  audioContext = makeAudioContextFactory(window);
  // Create a global gain node
  globalGainNode = audioContext.createGain();
  globalGainNode.connect(audioContext.destination); // Connect to audio context output
  globalGainNode.gain.setValueAtTime(currentVolume, audioContext.currentTime); // Set initial volume
}

function makeAudioContextFactory(window) {
  return new (window.AudioContext || window.webkitAudioContext)();
}

function oscillatorFactory() {
  audioContext.createOscillator();
}

// Function to start playing the sound for the given frequency
function startOscillator(frequency, midiValue) {
  const oscillator = oscillatorFactory();
  oscillator.type = "sine"; // Sine wave
  oscillator.frequency.setValueAtTime(frequency, audioContext.currentTime);

  // Set volume using the global gain node
  oscillator.connect(globalGainNode); // Connect oscillator to the global gain node
  oscillator.start();

  // Store oscillator
  oscillators[midiValue] = oscillator;
}

// Function to stop the oscillator
function stopOscillator(midiValue) {
  if (oscillators[midiValue]) {
    oscillators[midiValue].stop();
    oscillators[midiValue].disconnect();
  }
}

// Stop all oscillators
function stopAllOscillators() {
  for (let midiValue in oscillators) {
    stopOscillator(midiValue);
  }
}
