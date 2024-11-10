   // example usage: keyContext.note.c.mode.ionian.chords.supertonic returns "D, F, A"
    const keyContext = {
        note: {
            c: {//C Start here
            name: "C",
            mode: {
                ionian: {
                    name: "Ionian",
                    romans: ["I", "ii", "iii", "IV", "V", "vi", "vii°"],
                    scale: ["C", "D", "E", "F", "G", "A", "B"],
                    midiNotes: ["0", "2", "4", "5", "7", "9", "11"],
                    chords: {
                        tonic: ["C", "E", "G"],     
                        supertonic: ["D", "F", "A"],
                        mediant: ["E", "G", "B"],
                        subdominant: ["F", "A", "C"],
                        dominant: ["G", "B", "D"],  
                        submediant: ["A", "C", "E"],
                        leadingTone: ["B", "D", "F"],
                    },  
                },
                dorian: {
                    name: "Dorian",
                    romans: ["i", "ii", "III", "IV", "v", "vi°", "VII"],
                    scale: ["C", "D", "E", "F", "G", "A", "B"],
                    midiNotes: ["0", "2", "4", "5", "7", "9", "11"],
                    chords: {   

                    },  
                },
                phrygian: {
                    name: "Phrygian",
                    romans: ["i", "II", "III", "iv", "v°", "VI", "vii"],
                    scale: ["C", "D", "E", "F", "G", "A", "B"],
                    midiNotes: ["0", "2", "4", "5", "7", "9", "11"],
                    chords: {   

                    },  
                },
                lydian: {
                    name: "Lydian",
                    romans: ["I", "II", "iii", "iv°", "V", "vi", "vii"],
                    scale: ["C", "D", "E", "F", "G", "A", "B"],
                    midiNotes: ["0", "2", "4", "5", "7", "9", "11"],
                    chords: {   

                    },  
                },
                mixolydian: {
                    name: "Mixolydian",
                    romans: ["I", "ii", "iii°", "IV", "v", "vi", "VII"],
                    scale: ["C", "D", "E", "F", "G", "A", "B"],
                    midiNotes: ["0", "2", "4", "5", "7", "9", "11"],
                    chords: {   

                    },  
                },
                aeolian: {
                    name: "Aeolian",
                    romans: ["i", "ii°", "III", "iv", "v", "VI", "VII"],
                    scale: ["C", "D", "E", "F", "G", "A", "B"],
                    midiNotes: ["0", "2", "4", "5", "7", "9", "11"],
                    chords: {   

                    },  
                },
                locrian: {
                    name: "Locrian",
                    romans: ["i°", "II", "iii", "iv", "V", "VI", "vii"],
                    scale: ["C", "D", "E", "F", "G", "A", "B"],
                    midiNotes: ["0", "2", "4", "5", "7", "9", "11"],
                    chords: {   

                    },  
                },
            },
            },//C End here
        },
    };


const test = {
    notes: ["C", "C♯", "D", "D♯", "E", "F", "F♯", "G", "G♯", "A", "A♯", "B"],

    modes: {
    ionian: ["0", "2", "4", "5", "7", "9", "11"]
},
};

const notes = ["C", "C♯", "D", "D♯", "E", "F", "F♯", "G", "G♯", "A", "A♯", "B"];

const modes = {
    ionian: [0, 2, 4, 5, 7, 9, 11],
    dorian: [0, 2, 3, 5, 7, 9, 10],
    phrygian: [0, 1, 3, 5, 7, 8, 10],
    lydian: [0, 2, 4, 6, 7, 9, 11],
    mixolydian: [0, 2, 4, 5, 7, 9, 10],
    aeolian: [0, 2, 3, 5, 7, 8, 10],
    locrian: [0, 1, 3, 5, 6, 8, 10]
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


        // Ionian (Major Scale)
let cShIonian = ["C♯", "D♯", "E♯", "F♯", "G♯", "A♯", "B♯"];
let cIonian = ["C", "D", "E", "F", "G", "A", "B"];
let dIonian = ["D", "E", "F♯", "G", "A", "B", "C♯"];
let dShIonian = ["D♯", "E♯", "F𝄪", "G♯", "A♯", "B♯", "C𝄪"];
let eIonian = ["E", "F♯", "G♯", "A", "B", "C♯", "D♯"];
let fIonian = ["F", "G", "A", "B♭", "C", "D", "E"];
let fShIonian = ["F♯", "G♯", "A♯", "B", "C♯", "D♯", "E♯"];
let gIonian = ["G", "A", "B", "C", "D", "E", "F♯"];
let gShIonian = ["G♯", "A♯", "B♯", "C♯", "D♯", "E♯", "F𝄪"]; 
let aIonian = ["A", "B", "C♯", "D", "E", "F♯", "G♯"];
let aShIonian = ["A♯", "B♯", "C𝄪", "D♯", "E♯", "F𝄪", "G𝄪"];
let bIonian = ["B", "C♯", "D♯", "E", "F♯", "G♯", "A♯"];

// Dorian Mode
let cDorian = ["C", "D", "E♭", "F", "G", "A", "B♭"];
let cShDorian = ["C♯", "D♯", "E", "F♯", "G♯", "A♯", "B"];
let dDorian = ["D", "E", "F", "G", "A", "B", "C"];
let dShDorian = ["D♯", "E♯", "F♯", "G♯", "A♯", "B♯", "C♯"];
let eDorian = ["E", "F♯", "G", "A", "B", "C♯", "D"];
let fDorian = ["F", "G", "A♭", "B♭", "C", "D", "E♭"];
let fShDorian = ["F♯", "G♯", "A", "B", "C♯", "D♯", "E"];
let gDorian = ["G", "A", "B♭", "C", "D", "E", "F"];
let gShDorian = ["G♯", "A♯", "B", "C♯", "D♯", "E♯", "F♯"];
let aDorian = ["A", "B", "C", "D", "E", "F♯", "G"];
let aShDorian = ["A♯", "B♯", "C♯", "D♯", "E♯", "F𝄪", "G♯"];
let bDorian = ["B", "C♯", "D", "E", "F♯", "G♯", "A"];

// Phrygian Mode
let cPhrygian = ["C", "D♭", "E♭", "F", "G", "A♭", "B♭"];
let cShPhrygian = ["C♯", "D", "E", "F♯", "G♯", "A", "B"];
let dPhrygian = ["D", "E♭", "F", "G", "A", "B♭", "C"];
let dShPhrygian = ["D♯", "E", "F", "G♯", "A♯", "B", "C♯"];
let ePhrygian = ["E", "F", "G", "A", "B", "C", "D"];
let fPhrygian = ["F", "G♭", "A♭", "B♭", "C", "D♭", "E♭"];
let fShPhrygian = ["F♯", "G", "A", "B", "C♯", "D", "E"];
let gPhrygian = ["G", "A♭", "B♭", "C", "D", "E♭", "F"];
let gShPhrygian = ["G♯", "A", "B", "C♯", "D♯", "E", "F♯"];
let aPhrygian = ["A", "B♭", "C", "D", "E", "F", "G"];
let aShPhrygian = ["A♯", "B", "C♯", "D♯", "E♯", "F♯", "G♯"];
let bPhrygian = ["B", "C", "D", "E", "F♯", "G", "A"];

// Lydian Mode
let cLydian = ["C", "D", "E", "F♯", "G", "A", "B"];
let cShLydian = ["C♯", "D♯", "E♯", "F𝄪", "G♯", "A♯", "B♯"];
let dLydian = ["D", "E", "F♯", "G♯", "A", "B", "C♯"];
let dShLydian = ["D♯", "E♯", "F𝄪", "G𝄪", "A♯", "B♯", "C𝄪"];
let eLydian = ["E", "F♯", "G♯", "A♯", "B", "C♯", "D♯"];
let fLydian = ["F", "G", "A", "B", "C", "D", "E"];
let fShLydian = ["F♯", "G♯", "A♯", "B♯", "C♯", "D♯", "E♯"];
let gLydian = ["G", "A", "B", "C♯", "D", "E", "F♯"];
let gShLydian = ["G♯", "A♯", "B♯", "C𝄪", "D♯", "E♯", "F♯"];
let aLydian = ["A", "B", "C♯", "D♯", "E", "F♯", "G♯"];
let aShLydian = ["A♯", "B♯", "C𝄪", "D𝄪", "E♯", "F𝄪", "G𝄪"];
let bLydian = ["B", "C♯", "D♯", "E♯", "F♯", "G♯", "A♯"];

// Mixolydian Mode
let cMixolydian = ["C", "D", "E", "F", "G", "A", "B♭"];
let cShMixolydian = ["C♯", "D♯", "E♯", "F♯", "G♯", "A♯", "B"];
let dMixolydian = ["D", "E", "F♯", "G", "A", "B", "C"];
let dShMixolydian = ["D♯", "E♯", "F𝄪", "G♯", "A♯", "B♯", "C♯"];
let eMixolydian = ["E", "F♯", "G♯", "A", "B", "C♯", "D"];
let fMixolydian = ["F", "G", "A", "B♭", "C", "D", "E♭"];
let fShMixolydian = ["F♯", "G♯", "A♯", "B", "C♯", "D♯", "E"];
let gMixolydian = ["G", "A", "B", "C", "D", "E", "F"];
let gShMixolydian = ["G♯", "A♯", "B♯", "C♯", "D♯", "E♯", "F♯"];
let aMixolydian = ["A", "B", "C♯", "D", "E", "F♯", "G"];
let aShMixolydian = ["A♯", "B♯", "C𝄪", "D♯", "E♯", "F𝄪", "G♯"];
let bMixolydian = ["B", "C♯", "D♯", "E", "F♯", "G♯", "A"];

// Aeolian Mode (Natural Minor)
let cAeolian = ["C", "D", "E♭", "F", "G", "A♭", "B♭"];
let cShAeolian = ["C♯", "D♯", "E", "F♯", "G♯", "A", "B"];
let dAeolian = ["D", "E♭", "F", "G", "A", "B♭", "C"];
let dShAeolian = ["D♯", "E", "F", "G♯", "A♯", "B", "C♯"];
let eAeolian = ["E", "F♯", "G", "A", "B", "C", "D"];
let fAeolian = ["F", "G♭", "A♭", "B♭", "C", "D♭", "E♭"];
let fShAeolian = ["F♯", "G", "A", "B", "C♯", "D", "E"];
let gAeolian = ["G", "A♭", "B♭", "C", "D", "E♭", "F"];
let gShAeolian = ["G♯", "A", "B", "C♯", "D♯", "E", "F♯"];
let aAeolian = ["A", "B♭", "C", "D", "E", "F", "G"];
let aShAeolian = ["A♯", "B", "C♯", "D♯", "E♯", "F", "G♯"];
let bAeolian = ["B", "C", "D", "E", "F♯", "G♯", "A"];

// Locrian Mode
let cLocrian = ["C", "D♭", "E♭", "F", "G♭", "A♭", "B♭"];
let cShLocrian = ["C♯", "D", "E", "F♯", "G", "A", "B"];
let dLocrian = ["D", "E♭", "F", "G", "A♭", "B♭", "C"];
let dShLocrian = ["D♯", "E", "F", "G♯", "A", "B", "C♯"];
let eLocrian = ["E", "F", "G", "A", "B♭", "C", "D"];
let fLocrian = ["F", "G♭", "A♭", "B♭", "C", "D♭", "E♭"];
let fShLocrian = ["F♯", "G", "A", "B", "C♯", "D", "E"];
let gLocrian = ["G", "A♭", "B♭", "C", "D♭", "E♭", "F"];
let gShLocrian = ["G♯", "A", "B", "C♯", "D", "E", "F♯"];
let aLocrian = ["A", "B♭", "C", "D", "E♭", "F", "G"];
let aShLocrian = ["A♯", "B", "C♯", "D♯", "E", "F♯", "G♯"];
let bLocrian = ["B", "C", "D", "E", "F", "G", "A"];
