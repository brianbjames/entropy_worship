//
// Note and Scale Definitions
//
// https://altcodeunicode.com/alt-codes-musical-note-instrument-symbols/
//

const notes = ["C", "C♯/D♭", "D", "D♯/E♭", "E", "F", "F♯/G♭", "G", "G♯/A♭", "A", "A♯/B♭", "B"];

const modes = {
    "Ionian": [0, 2, 4, 5, 7, 9, 11],
    "Dorian": [0, 2, 3, 5, 7, 9, 10],
    "Phrygian": [0, 1, 3, 5, 7, 8, 10],
    "Lydian": [0, 2, 4, 6, 7, 9, 11],
    "Mixolydian": [0, 2, 4, 5, 7, 9, 10],
    "Aeolian": [0, 2, 3, 5, 7, 8, 10],
    "Locrian": [0, 1, 3, 5, 6, 8, 10]
};

const romanNumerals = {
    "Ionian": ["I", "ii", "iii", "IV", "V", "vi", "vii°"],
    "Dorian": ["i", "ii", "III", "IV", "v", "vi°", "VII"],
    "Phrygian": ["i", "II", "III", "iv", "v°", "VI", "vii"],
    "Lydian": ["I", "II", "iii", "iv°", "V", "vi", "vii"],
    "Mixolydian": ["I", "ii", "iii°", "IV", "v", "vi", "VII"],
    "Aeolian": ["i", "ii°", "III", "iv", "v", "VI", "VII"],
    "Locrian": ["i°", "II", "iii", "iv", "V", "VI", "vii"]
};

// Degree names for each scale degree
const degreeNames = [
    "Tonic",           // 1st degree
    "Supertonic",      // 2nd degree
    "Mediant",         // 3rd degree
    "Subdominant",     // 4th degree
    "Dominant",        // 5th degree
    "Submediant",      // 6th degree
    "Leading Tone"     // 7th degree
];