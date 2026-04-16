class MIDIUtil {
  // Convert MIDI value to frequency (A440 = 69 in MIDI)
  static midiToFrequency(midiNoteNumber) {
    return 440 * Math.pow(2, (midiNoteNumber - 69) / 12);
  }

  // Convert MIDI value to frequency (A440 = 69 in MIDI)
  static getOctave(midiNoteNumber) {
    return Math.floor(midiNoteNumber / 12) - 1;
  }

  // Calculate MIDI values for a given note
  static getMidiValuesForNote(note, octave) {
    var noteIndex = notes.indexOf(note);
    var midiValues = [];
    for (var i = -1; i <= 11; i++) {
      let midi = (octave + i) * 12 + noteIndex;
      // Valid MIDI range
      if (midi >= 0 && midi <= 127) {
        midiValues.push(midi);
      }
    }
    midiValues.sort((a, b) => a - b); // Sort MIDI values
    return midiValues;
  }
}
