// Convert MIDI value to frequency (A440 = 69 in MIDI)

class MIDIUtilities {
  static function midiToFrequency(midiNoteNumber) {
    return 440 * Math.pow(2, (midiNoteNumber - 69) / 12);
  }
  static function getOctave(midiNoteNumber) {
    return Math.floor(midiNoteNumber / 12) - 1;
  }

  // Calculate MIDI values for a given note
  static function getMidiValuesForNote(note, octave) {
    let noteIndex = notes.indexOf(note);
    let midiValues = [];
    for (let i = -1; i <= 11; i++) {
      let midi = (octave + i) * 12 + noteIndex;
      if (midi >= 0 && midi <= 127) { // Valid MIDI range
        midiValues.push(midi);
      }
    }
    midiValues.sort((a, b) => a - b); // Sort MIDI values
    return midiValues;
  }
}
