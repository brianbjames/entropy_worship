// Music Theory Object Constructor
function MusicTheory(scaleRoot, mode, noteSpellings = {}) {
  this.scaleRoot = scaleRoot; // The root note of the scale
  this.mode = mode; // The mode (major, minor, etc.)
  this.noteSpellings = noteSpellings; // Custom note spellings to override enharmonic equivalents
  this.scale = this.generateScale(); // The scale based on the mode and root
  this.scaleDegrees = this.generateScaleDegrees(); // Scale degree spellings
  this.chords = this.generateChords(); // Diatonic chords in the scale
  this.relatedProgressions = this.generateProgressions(); // Common chord progressions
  this.midiNumbers = this.generateMidiNumbers(); // MIDI numbers of the scale
}

// Default note spellings (for overriding)
MusicTheory.prototype.defaultNoteSpellings = {
  'C#': 'C#', 'Db': 'C#',
  'D#': 'D#', 'Eb': 'D#',
  'E#': 'F', 'Fb': 'E',
  'F#': 'F#', 'Gb': 'F#',
  'G#': 'G#', 'Ab': 'G#',
  'A#': 'A#', 'Bb': 'A#',
  'B#': 'C', 'Cb': 'B',
  'C': 'C', 'D': 'D', 'E': 'E', 'F': 'F', 'G': 'G', 'A': 'A', 'B': 'B',
};

// Merge custom note spellings with the default spellings
MusicTheory.prototype.getNoteSpelling = function (note) {
  return this.noteSpellings[note] || this.defaultNoteSpellings[note] || note;
};

// Define the scale notes for different modes based on the root note
MusicTheory.prototype.generateScale = function () {
  const scales = {
    major: ['W', 'W', 'H', 'W', 'W', 'W', 'H'], // Whole, Whole, Half, etc.
    minor: ['W', 'H', 'W', 'W', 'H', 'W', 'W'],
    // Add other modes as needed...
  };

  const modeIntervals = scales[this.mode] || scales.major; // Default to major if mode is not defined
  const root = this.scaleRoot;
  let scaleNotes = [root];
  let currentNote = root;

  // Helper function to get the next note based on a semitone step
  function getNextNote(note, interval) {
    const noteToSemitone = {
      'C': 0, 'C#': 1, 'D': 2, 'D#': 3, 'E': 4, 'F': 5, 'F#': 6, 'G': 7, 'G#': 8, 'A': 9, 'A#': 10, 'B': 11
    };
    const semitoneToNote = Object.keys(noteToSemitone);

    let newNoteIdx = (noteToSemitone[note] + interval) % 12;
    return semitoneToNote[newNoteIdx];
  }

  // Generate scale notes using intervals from the root note
  modeIntervals.forEach(interval => {
    let intervalSteps = interval === 'W' ? 2 : 1; // W = whole step, H = half step
    currentNote = getNextNote(currentNote, intervalSteps);
    scaleNotes.push(currentNote);
  });

  // Apply custom note spellings
  return scaleNotes.map(note => this.getNoteSpelling(note));
};

// Generate scale degrees (e.g., "1st", "2nd", etc.)
MusicTheory.prototype.generateScaleDegrees = function () {
  const degreeSpellings = ['1st', '2nd', '3rd', '4th', '5th', '6th', '7th', '8th'];
  return this.scale.map((note, index) => degreeSpellings[index] || `°${index + 1}`);
};

// Get chord spelling (I, ii, iii, IV, etc.) based on scale degree
MusicTheory.prototype.getChordSpelling = function (degree) {
  const romanNumerals = ['I', 'ii', 'iii', 'IV', 'V', 'vi', 'vii°'];
  return romanNumerals[degree] || `°${degree + 1}`;
};

// Generate diatonic chords in the scale
MusicTheory.prototype.generateChords = function () {
  // Chord formulas (root, major third, perfect fifth) for each type
  const chordFormulas = {
    major: [0, 4, 7],  // Root, major third, perfect fifth
    minor: [0, 3, 7],  // Root, minor third, perfect fifth
    diminished: [0, 3, 6], // Root, minor third, diminished fifth
    // Add more chord types if needed
  };

  const chords = [];
  const scaleNotes = this.scale;

  // Loop through each scale degree and create a chord based on its root note
  for (let i = 0; i < scaleNotes.length; i++) {
    const chordType = i === 0 || i === 4 || i === 5 ? 'major' : 'minor';  // Example logic for major/minor
    const chordNotes = chordFormulas[chordType].map(interval => scaleNotes[(i + interval) % scaleNotes.length]);
    const chordSpelling = this.getChordSpelling(i); // Get Roman numeral chord spelling
    
    // Push the chord with both notes and its Roman numeral spelling
    chords.push({
      root: scaleNotes[i],
      chord: chordNotes,
      chordSpelling: chordSpelling
    });
  }

  return chords;
};

// Generate common chord progressions in the scale (I-IV-V, ii-V-I, etc.)
MusicTheory.prototype.generateProgressions = function () {
  // Some basic progressions in Roman numerals
  const progressions = [
    ['I', 'IV', 'V'], // I-IV-V
    ['ii', 'V', 'I'], // ii-V-I
    ['vi', 'IV', 'I', 'V'], // vi-IV-I-V
    // Add more progressions as necessary
  ];
  return progressions;
};

// Generate MIDI numbers for the scale
MusicTheory.prototype.generateMidiNumbers = function () {
  const noteToMidi = {
    'C': 60, 'C#': 61, 'D': 62, 'D#': 63, 'E': 64, 'F': 65, 'F#': 66, 'G': 67, 'G#': 68, 'A': 69, 'A#': 70, 'B': 71
  };

  // Apply custom spellings before mapping to MIDI numbers
  return this.scale.map(note => {
    const correctSpelling = this.getNoteSpelling(note);
    return noteToMidi[correctSpelling];
  });
};

// Example Usage
const scaleRoot = 'C'; // Root of the scale (C, D, E, etc.)
const mode = 'major'; // Mode (major, minor, etc.)
const customNoteSpellings = {
  'Cb': 'B', // Override Cb to be spelled as B
  'D#': 'Eb', // Override D# to be spelled as Eb
};

const musicTheory = new MusicTheory(scaleRoot, mode, customNoteSpellings);

console.log('Scale:', musicTheory.scale);
console.log('Scale Degrees:', musicTheory.scaleDegrees);
console.log('Chords:', musicTheory.chords);
console.log('Progressions:', musicTheory.relatedProgressions);
console.log('MIDI Numbers:', musicTheory.midiNumbers);
