const midi = WebMidi;

// const ctx = new AudioContext();
// const soundfont = new Soundfont(ctx);
// const instrument = soundfont.instrument();

let newChordObj;

function randomNote(range = 36) {
  return Math.floor(Math.random() * range);
}

function randomLength(range = 1000) {
  return Math.floor(Math.random() * range);
}

function randomOctave(range = 5) {
  return Math.floor(Math.random() * 12) * range;
}

function getScale(key, scale) {
  Object.entries(notesAndScales.notes).map(([key, value]) => {
    console.log();
  });
}

function generateRandomChord() {
  let noteA = randomNote();
  let noteB = randomNote();
  let noteC = randomNote();
  return [noteA, noteB, noteC];
}

function transposeChord(octave = 48) {
  return function (num) {
    return num + octave;
  };
}

function getRandomChord() {
  let duration = randomLength();
  if (duration <= 0) {
    duration = 1;
  }
  let chord = generateRandomChord();
  let octave = randomOctave();
  let newChord = chord.map(transposeChord(octave));
  newChordObj = { chordNotes: newChord, duration: duration };
  document.getElementsByClassName("test");
  console.log("Chord Generated", newChordObj);
}

function playChord(chord) {
  let duration = 400;
  let newChordObj = { chordNotes: chord, duration: duration };

  MIDIOut.playNote(newChordObj);
  SoundFontPlayer.playNote(newChordObj);
}

class SoundFontPlayer {
  static playNote(noteObj) {
    console.log("SoundFontPlayer.playNote", noteObj);
    // soundfont(ctx, "acoustic_grand_piano").then(function (instrument) {
    //   instrument.play(note, duration);
    // });
  }
}

class MIDIOut {
  static playNote(noteObj) {
    midi.enable(function (err) {
      if (err) {
        console.log(err);
      } else {
        console.log("MIDIOut.playNote", noteObj);
        let output = midi.outputs[0];
        let channel = output.channels[1];
        channel.playNote(noteObj.chordNotes, { duration: noteObj.duration });
      }
    });
  }
}
