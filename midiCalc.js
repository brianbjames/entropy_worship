// example usage: keyContext.c.mode.ionian.chords.supertonic returns "D, F, A"
const keyContext = {
    c: {//C Start here
    name: "C",
    mode: {
        ionian: {
            name: "Ionian",
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
            scale: ["C", "D", "Eb", "F", "G", "A", "Bb"],
            midiNotes: ["0", "2", "3", "5", "7", "9", "10"],
            chords: {
                tonic: ["C", "Eb", "G"],       // I (C minor)
                supertonic: ["D", "F", "A"],   // ii (D minor)
                mediant: ["Eb", "G", "Bb"],    // bIII (Eb major)
                subdominant: ["F", "A", "C"],  // IV (F major)
                dominant: ["G", "Bb", "D"],    // V (G minor)
                submediant: ["A", "C", "Eb"],  // vi (A diminished)
                leadingTone: ["Bb", "D", "F"], // bVII (Bb major)
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
};

        // This is the base set to build MIDI values from, this was a const
        let notes = ["C", "C♯", "D", "D♯", "E", "F", "F♯", "G", "G♯", "A", "A♯", "B"];

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
    
        let currentVolume = 0.5;
        let audioContext;
        let oscillators = [];
        let gainNodes = [];
        let globalGainNode;
        let isPlaying = [];

            // Add a function to update the modal's play/stop button to "Play"
        function resetModalPlayButton() {
            const playButton = document.getElementById("playButton");
            playButton.innerText = "Play";
        }

        // Event listener for the Stop All button
        document.getElementById('stopAllButton').addEventListener('click', () => {
            stopAllOscillators(); // Stop all oscillators
            
            // Reset any modal stop button to Play
            resetModalPlayButton();
        });
    
// Setup audio context and global gain node
function setupAudioContext() {
    // Create a new AudioContext
    audioContext = new (window.AudioContext || window.webkitAudioContext)();
    // Create a global gain node
    globalGainNode = audioContext.createGain();
    globalGainNode.connect(audioContext.destination);  // Connect to audio context output
    globalGainNode.gain.setValueAtTime(currentVolume, audioContext.currentTime); // Set initial volume
}

// Event listener to update the global volume when the slider is changed
document.getElementById('volumeSlider').addEventListener('input', (e) => {
    currentVolume = e.target.value / 100;  // Convert slider value to a decimal
    globalGainNode.gain.setValueAtTime(currentVolume, audioContext.currentTime); // Set volume globally
    // Optionally update the volume value in UI (you can add a span to show the volume value)
    document.getElementById("volumeValue").innerText = `Volume: ${e.target.value}%`;
});

        //These arrays are for overwriting incorrectly spelled enharomic notes
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

        // Update results when inputs change
        function updateResults() {
            const noteroot = document.getElementById("noteroot").value;
            const mode = document.getElementById("mode").value;
            const octave = -1;  // Default octave set to -1
    
            const noteRootIndex = notes.indexOf(noteroot);
            const modeIntervals = modes[mode];
            let romanHeaders = romanNumerals[mode];
           
    
            // Calculate scale
            const scale = modeIntervals.map(interval => notes[(noteRootIndex + interval) % notes.length]);
    
            // Calculate MIDI values for each note in the scale
            const midiValues = scale.map(note => getMidiValuesForNote(note, octave));

            // Generate table rows with Roman numeral chord names, note names, and MIDI data
            const diatonicChords = scale.map((_, i) => {
            let rootNote = scale[i]; // The root note for the chord is the corresponding calculated scale note
            

            // Ionian (Major Scale)
            if (mode === "Ionian" && noteroot === "C") {
                rootNote = cIonian[i];   
/*                 keyRoot = document.getElementById("noteroot").value;
                document.getElementById("tonic").innerText = keyContext.c.mode.ionian.chords.tonic;
                document.getElementById("supertonic").innerText = keyContext.c.mode.ionian.chords.supertonic;
                document.getElementById("mediant").innerText = keyContext.c.mode.ionian.chords.mediant;
                document.getElementById("subdominant").innerText = keyContext.c.mode.ionian.chords.subdominant;
                document.getElementById("dominant").innerText = keyContext.c.mode.ionian.chords.dominant;
                document.getElementById("submediant").innerText = keyContext.c.mode.ionian.chords.submediant;
                document.getElementById("leadingTone").innerText = keyContext.c.mode.ionian.chords.leadingTone; */
            }

            if (mode === "Ionian" && noteroot === "C♯") {
                rootNote = cShIonian[i];
            }
            if (mode === "Ionian" && noteroot === "D") {
                rootNote = dIonian[i];
            }
            if (mode === "Ionian" && noteroot === "D♯") {
                rootNote = dShIonian[i];
            }
            if (mode === "Ionian" && noteroot === "E") {
                rootNote = eIonian[i];
            }
            if (mode === "Ionian" && noteroot === "F") {
                rootNote = fIonian[i];
            }
            if (mode === "Ionian" && noteroot === "F♯") {
                rootNote = fShIonian[i];
            }
            if (mode === "Ionian" && noteroot === "G") {
                rootNote = gIonian[i];
            }
            if (mode === "Ionian" && noteroot === "G♯") {
                rootNote = gShIonian[i];
            }
            if (mode === "Ionian" && noteroot === "A") {
                rootNote = aIonian[i];
            }
            if (mode === "Ionian" && noteroot === "A♯") {
                rootNote = aShIonian[i];
            }
            if (mode === "Ionian" && noteroot === "B") {
                rootNote = bIonian[i];
            }

            // Dorian Mode
            if (mode === "Dorian" && noteroot === "C") {
                rootNote = cDorian[i];   
/*                 keyRoot = document.getElementById("noteroot").value;
                document.getElementById("tonic").innerText = keyContext.c.mode.dorian.chords.tonic;
                document.getElementById("supertonic").innerText = keyContext.c.mode.dorian.chords.supertonic;
                document.getElementById("mediant").innerText = keyContext.c.mode.dorian.chords.mediant;
                document.getElementById("subdominant").innerText = keyContext.c.mode.dorian.chords.subdominant;
                document.getElementById("dominant").innerText = keyContext.c.mode.dorian.chords.dominant;
                document.getElementById("submediant").innerText = keyContext.c.mode.dorian.chords.submediant;
                document.getElementById("leadingTone").innerText = keyContext.c.mode.dorian.chords.leadingTone; */
            }
            if (mode === "Dorian" && noteroot === "C♯") {
                rootNote = cShDorian[i];
            }
            if (mode === "Dorian" && noteroot === "D") {
                rootNote = dDorian[i];
            }
            if (mode === "Dorian" && noteroot === "D♯") {
                rootNote = dShDorian[i];
            }
            if (mode === "Dorian" && noteroot === "E") {
                rootNote = eDorian[i];
            }
            if (mode === "Dorian" && noteroot === "F") {
                rootNote = fDorian[i];
            }
            if (mode === "Dorian" && noteroot === "F♯") {
                rootNote = fShDorian[i];
            }
            if (mode === "Dorian" && noteroot === "G") {
                rootNote = gDorian[i];
            }
            if (mode === "Dorian" && noteroot === "G♯") {
                rootNote = gShDorian[i];
            }
            if (mode === "Dorian" && noteroot === "A") {
                rootNote = aDorian[i];
            }
            if (mode === "Dorian" && noteroot === "A♯") {
                rootNote = aShDorian[i];
            }
            if (mode === "Dorian" && noteroot === "B") {
                rootNote = bDorian[i];
            }

            // Phrygian Mode
            if (mode === "Phrygian" && noteroot === "C") {
                rootNote = cPhrygian[i];
            }
            if (mode === "Phrygian" && noteroot === "C♯") {
                rootNote = cShPhrygian[i];
            }
            if (mode === "Phrygian" && noteroot === "D") {
                rootNote = dPhrygian[i];
            }
            if (mode === "Phrygian" && noteroot === "D♯") {
                rootNote = dShPhrygian[i];
            }
            if (mode === "Phrygian" && noteroot === "E") {
                rootNote = ePhrygian[i];
            }
            if (mode === "Phrygian" && noteroot === "F") {
                rootNote = fPhrygian[i];
            }
            if (mode === "Phrygian" && noteroot === "F♯") {
                rootNote = fShPhrygian[i];
            }
            if (mode === "Phrygian" && noteroot === "G") {
                rootNote = gPhrygian[i];
            }
            if (mode === "Phrygian" && noteroot === "G♯") {
                rootNote = gShPhrygian[i];
            }
            if (mode === "Phrygian" && noteroot === "A") {
                rootNote = aPhrygian[i];
            }
            if (mode === "Phrygian" && noteroot === "A♯") {
                rootNote = aShPhrygian[i];
            }
            if (mode === "Phrygian" && noteroot === "B") {
                rootNote = bPhrygian[i];
            }

            // Lydian Mode
            if (mode === "Lydian" && noteroot === "C") {
                rootNote = cLydian[i];
            }
            if (mode === "Lydian" && noteroot === "C♯") {
                rootNote = cShLydian[i];
            }
            if (mode === "Lydian" && noteroot === "D") {
                rootNote = dLydian[i];
            }
            if (mode === "Lydian" && noteroot === "D♯") {
                rootNote = dShLydian[i];
            }
            if (mode === "Lydian" && noteroot === "E") {
                rootNote = eLydian[i];
            }
            if (mode === "Lydian" && noteroot === "F") {
                rootNote = fLydian[i];
            }
            if (mode === "Lydian" && noteroot === "F♯") {
                rootNote = fShLydian[i];
            }
            if (mode === "Lydian" && noteroot === "G") {
                rootNote = gLydian[i];
            }
            if (mode === "Lydian" && noteroot === "G♯") {
                rootNote = gShLydian[i];
            }
            if (mode === "Lydian" && noteroot === "A") {
                rootNote = aLydian[i];
            }
            if (mode === "Lydian" && noteroot === "A♯") {
                rootNote = aShLydian[i];
            }
            if (mode === "Lydian" && noteroot === "B") {
                rootNote = bLydian[i];
            }

            // Mixolydian Mode
            if (mode === "Mixolydian" && noteroot === "C") {
                rootNote = cMixolydian[i];
            }
            if (mode === "Mixolydian" && noteroot === "C♯") {
                rootNote = cShMixolydian[i];
            }
            if (mode === "Mixolydian" && noteroot === "D") {
                rootNote = dMixolydian[i];
            }
            if (mode === "Mixolydian" && noteroot === "D♯") {
                rootNote = dShMixolydian[i];
            }
            if (mode === "Mixolydian" && noteroot === "E") {
                rootNote = eMixolydian[i];
            }
            if (mode === "Mixolydian" && noteroot === "F") {
                rootNote = fMixolydian[i];
            }
            if (mode === "Mixolydian" && noteroot === "F♯") {
                rootNote = fShMixolydian[i];
            }
            if (mode === "Mixolydian" && noteroot === "G") {
                rootNote = gMixolydian[i];
            }
            if (mode === "Mixolydian" && noteroot === "G♯") {
                rootNote = gShMixolydian[i];
            }
            if (mode === "Mixolydian" && noteroot === "A") {
                rootNote = aMixolydian[i];
            }
            if (mode === "Mixolydian" && noteroot === "A♯") {
                rootNote = aShMixolydian[i];
            }
            if (mode === "Mixolydian" && noteroot === "B") {
                rootNote = bMixolydian[i];
            }

            // Aeolian Mode (Natural Minor Scale)
            if (mode === "Aeolian" && noteroot === "C") {
                rootNote = cAeolian[i];
            }
            if (mode === "Aeolian" && noteroot === "C♯") {
                rootNote = cShAeolian[i];
            }
            if (mode === "Aeolian" && noteroot === "D") {
                rootNote = dAeolian[i];
            }
            if (mode === "Aeolian" && noteroot === "D♯") {
                rootNote = dShAeolian[i];
            }
            if (mode === "Aeolian" && noteroot === "E") {
                rootNote = eAeolian[i];
            }
            if (mode === "Aeolian" && noteroot === "F") {
                rootNote = fAeolian[i];
            }
            if (mode === "Aeolian" && noteroot === "F♯") {
                rootNote = fShAeolian[i];
            }
            if (mode === "Aeolian" && noteroot === "G") {
                rootNote = gAeolian[i];
            }
            if (mode === "Aeolian" && noteroot === "G♯") {
                rootNote = gShAeolian[i];
            }
            if (mode === "Aeolian" && noteroot === "A") {
                rootNote = aAeolian[i];
            }
            if (mode === "Aeolian" && noteroot === "A♯") {
                rootNote = aShAeolian[i];
            }
            if (mode === "Aeolian" && noteroot === "B") {
                rootNote = bAeolian[i];
            }

            // Locrian Mode
            if (mode === "Locrian" && noteroot === "C") {
                rootNote = cLocrian[i];
            }
            if (mode === "Locrian" && noteroot === "C♯") {
                rootNote = cShLocrian[i];
            }
            if (mode === "Locrian" && noteroot === "D") {
                rootNote = dLocrian[i];
            }
            if (mode === "Locrian" && noteroot === "D♯") {
                rootNote = dShLocrian[i];
            }
            if (mode === "Locrian" && noteroot === "E") {
                rootNote = eLocrian[i];
            }
            if (mode === "Locrian" && noteroot === "F") {
                rootNote = fLocrian[i];
            }
            if (mode === "Locrian" && noteroot === "F♯") {
                rootNote = fShLocrian[i];
            }
            if (mode === "Locrian" && noteroot === "G") {
                rootNote = gLocrian[i];
            }
            if (mode === "Locrian" && noteroot === "G♯") {
                rootNote = gShLocrian[i];
            }
            if (mode === "Locrian" && noteroot === "A") {
                rootNote = aLocrian[i];
            }
            if (mode === "Locrian" && noteroot === "A♯") {
                rootNote = aShLocrian[i];
            }
            if (mode === "Locrian" && noteroot === "B") {
                rootNote = bLocrian[i];
            }


            const rootMidi = midiValues[i].join(", ");
                return `<tr>
                    <td>${romanHeaders[i]}</td>
                    <td>${rootNote}</td>
                    <td>${generateMidiLinks(rootMidi)}</td>
                </tr>`;
            }).join("");

    //  This was the button from before                  <td><button class="btn btn-outline-light btn-sm" style="color: white;><a href="#" id="scaleButton" data-scaleDegree="${rootNote}" onclick="openRootModal('${rootNote}')">${rootNote}</a></button></td>



            // Display results in table with dynamic Roman numeral headers, note names, and MIDI data
            document.getElementById("results").innerHTML = `
                <table class="table table-bordered mt-4 table-sm" style="color: white;">
                    <tbody>
                        ${diatonicChords}
                    </tbody>
                </table>
            `;
        }

        // Helper function to generate clickable MIDI links
        function generateMidiLinks(midi) {
            return midi.split(', ').map(midiValue => {
                const frequency = midiToFrequency(parseInt(midiValue));
                return `<button class="btn btn-outline-light btn-sm" style="color: white;><a href="#" data-midi="${midiValue}" data-frequency="${frequency}" onclick="openModal('${midiValue}', '${frequency}')">${midiValue}</a></button>`;
            }).join(" ");
        }

        // not sure we need this function, its not getting called from anywhere
        // Helper function to generate clickable scale degree links
        function generateScaleDegreeLinks(scaleDegree) {
            return `<button class="btn btn-outline-light btn-sm" style="color: white;><a href="#" data-scaleDegree="${rootNote}" data-chordSpelling="${chordSpelling}" onclick="openRootModal('${rootNote}')">${rootNote}</a></button>`;
        }

        // Function to open the modal and show information, including octave
        function openModal(midiValue, frequency) {
        const octave = Math.floor(midiValue / 12) - 1; // Calculate octave based on MIDI value
        document.getElementById("midiValue").innerText = `MIDI Value: ${midiValue}`;
        document.getElementById("frequency").innerText = `Frequency: ${frequency} Hz`;
        document.getElementById("octave").innerText = `Octave: ${octave}`;

        const playButton = document.getElementById("playButton");

        // Add event listener to play button
        playButton.onclick = () => {
            if (isPlaying[midiValue]) {
                stopOscillator(midiValue);
                playButton.innerText = "Play"; // Change button to "Play"
                isPlaying[midiValue] = false;
            } else {
                startOscillator(frequency, midiValue);
                //playButton.innerText = "Stop"; // Change button to "Stop"
                isPlaying[midiValue] = true;
            }
        };
        // Show the modal
        const myModal = new bootstrap.Modal(document.getElementById('midiModal'));
        myModal.show();
    }

       // Function to open the ROOT modal and show information
       function openRootModal(rootNote) {
        document.getElementById("rootNote").innerText = `Root: ${rootNote}`;
/*         document.getElementById("thirdNote").innerText = `Third: ${thirdNote}`;
        document.getElementById("fifthNote").innerText = `Fifth: ${fifthNote}`;
        document.getElementById("seventhNote").innerText = `Seventh: ${seventhNote}`;
        document.getElementById("ninthNote").innerText = `Ninth: ${ninthNote}`;
        document.getElementById("chordSpelling").innerText = `Chord: ${chordSpelling}`; */
        //document.getElementById("nextChord").innerText = `${nextChord}`;
        // Show the modal
        const myModal = new bootstrap.Modal(document.getElementById('rootModal'));
        myModal.show();
    }
    
        // Convert MIDI value to frequency (A440 = 69 in MIDI)
        function midiToFrequency(midi) {
            return 440 * Math.pow(2, (midi - 69) / 12);
        }
    
        // Function to start playing the sound for the given frequency
        function startOscillator(frequency, midiValue) {
            const oscillator = audioContext.createOscillator();
            oscillator.type = 'sine'; // Sine wave
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
    
        // Event listener to update the global volume when the slider is changed
        document.getElementById('volumeSlider').addEventListener('input', (e) => {
            currentVolume = e.target.value / 100;
            document.getElementById("volumeValue").innerText = e.target.value;
            globalGainNode.gain.setValueAtTime(currentVolume, audioContext.currentTime); // Update global volume
        });
    
        // Event listener for the Stop All button
        document.getElementById('stopAllButton').addEventListener('click', () => {
            stopAllOscillators();
        });
    
        // Calculate MIDI values for a given note
        function getMidiValuesForNote(note, octave) {
            const noteIndex = notes.indexOf(note);
            const midiValues = [];
            
            for (let i = -1; i <= 11; i++) {
                const midi = (octave + i) * 12 + noteIndex;
                if (midi >= 0 && midi <= 127) { // Valid MIDI range
                    midiValues.push(midi);
                }
            }
    
            midiValues.sort((a, b) => a - b); // Sort MIDI values
            return midiValues;
        }
    
        // Initial call to setup audio context and display results
        setupAudioContext();
        updateResults();
