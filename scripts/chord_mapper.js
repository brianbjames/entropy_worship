const notesAndScales = {
  notes: {
    0: "C",
    1: "C♯/D♭",
    2: "D",
    3: "D♯/E♭",
    4: "E",
    5: "F",
    6: "F♯/G♭",
    7: "G",
    8: "G♯/A♭",
    9: "A",
    10: "A♯/B♭",
    11: "B",
  },
  scales: {
    chromatic: [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11],
    // C, D, E, F, G, A, B
    major: [0, 2, 4, 5, 7, 9, 11],
    // C, D, E♭, F, G, A♭, B♭
    minor: [0, 2, 3, 5, 7, 8, 10],
    // C, E♭, E, G, G#, B
    augmented: [0, 3, 4, 7, 8, 11],
    // C, D, D#, F, F#, G#, A, B
    diminished: [0, 2, 3, 5, 6, 8, 11],
    // C, D, E♭, F, G♭, A♭, B♭
    halfDiminished: [0, 2, 3, 5, 6, 8, 10],
    modes: {
      ionian: [0, 2, 4, 5, 7, 9, 11],
      dorian: [0, 2, 3, 5, 7, 9, 10],
      phrygian: [0, 1, 3, 5, 7, 8, 10],
      lydian: [0, 2, 4, 6, 7, 9, 11],
      mixolydian: [0, 2, 4, 5, 7, 9, 10],
      aeolian: [0, 2, 3, 5, 7, 8, 10],
      locrian: [0, 1, 3, 5, 6, 8, 10],
    },
    // Super Locrian
    altered: [0, 1, 3, 4, 6, 8, 10],
    melodicMinor: [0, 2, 3, 5, 7, 9, 11],
    bebop: {
      major: [0, 2, 4, 5, 7, 9, 11],
      dorian: [0, 2, 3, 5, 7, 9, 10],
      melodicMinor: [],
      harmonicMinor: [],
      dominant: [0, 2, 4, 5, 7, 9, 10, 11],
    },
    // W+H, W, W, W+H, W
    // C, E♭, F, G, B♭, C
    pentatonic: {
      major: [0, 2, 4, 7, 9],
      minor: [0, 3, 5, 7, 10],
    },
    /* Blues Scale
    W+H – W – H – H – W+H – W
    C, E♭, F, G♭, G, B♭ */
    blues: [0, 3, 5, 6, 7, 10],
    /* Whole Tone Scale
    W – W – W – W – W – W
    E – F♯ – G♯ – A♯ – C – D – E
    E♭ – F – G – A – B – D♭ – E♭ */
    wholetone: [0, 2, 4, 6, 8, 10],
    ukrainianDorian: [0, 2, 3, 6, 7, 9, 10],
    tritone: [0, 1, 4, 6, 7, 10],
    harmonics: [0, 3, 4, 5, 7, 9],
    prometheus: [0, 2, 4, 6, 9, 10],
    persian: [0, 1, 4, 5, 6, 8, 11],
    gypsy: [0, 2, 3, 6, 7, 8, 10],
    iwato: [0, 1, 5, 6, 10],
    istrian: [0, 1, 3, 4, 6, 7],
    hirajoshi: [0, 4, 6, 7, 11],
    hungarian: {
      major: [0, 3, 4, 6, 7, 9, 10],
      minor: [0, 2, 3, 6, 7, 8, 11],
    },
  },
  chords: {
    // Cmaj
    major: [0, 4, 7],
    // Cm
    minor: [0, 3, 7],
    // Caug
    augmented: [0, 4, 8],
    // Cdim
    diminshed: [0, 3, 6],
    // Csus2
    sus2: [0, 2, 7],
    // Csus4
    sus4: [0, 5, 7],
    // Seventh Chords
    seventh: {
      // CMaj7, CΔ7
      major: [0, 4, 7, 11],
      // Cmin7, Cm7
      minor: [0, 3, 7, 10],
      // Cdom7
      dominant: [0, 4, 7, 10],
      // CMajmin7
      minorMajor: [0],
      minorSeventhFlatFive: [],
      diminished: [],
      augmented: [],
      halfDiminished: [],
    },
    // Ninth Chords
    ninth: {
      major: [],
      minor: [],
      minorMajor: [],
      dominant: [],
      dominantSeventhSharpNine: [],
    },
    // Eleventh Chords
    eleventh: {
      major: [],
      minor: [],
      dominant: [],
    },
    /* Thirteenth Chords
    Major 13th | CM13, CΔ13, Cmaj13 | Major | C-E-G-B-D-F-A

    13th | C13 | Major | C-E-G-Bb-D-F-A

    Minor 13th | Cm 13 / C-13 / Cmin 13 | Major | C-Eb-G-Bb-D-F-A

    Augmented Major 13th | C+M13 / Caugmaj13 | Major | C-E-G#-B-D-F-A

    Augmented 13th | C+13 / C1335 / Caug13 | Major | C-E-G#-Bb-D-F-A

    Half-Diminished 13th | C013 | Major | C-Eb-Gb-Bb-D-F-A
    */
    thirteenth: {
      major: [],
      minor: [],
      dominant: [],
    },
    addedTones: {
      // C6 - C, E, G, A
      majorSixth: [],
      // Cm6 - C, E♭, G, A
      minorSixth: [],
      // C6/9 - C E G A D
      sixNine: [],
      // Cm6/9 - C, E♭, G, A, D
      minorSixNine: [],
      // CMajAdd9 - C E G D
      majorAddNine: [],
      // CmAdd9 C E♭ G D
      minorAddNine: [],
    },
  },
};
