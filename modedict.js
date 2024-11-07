        //These arrays are for overwriting incorrectly spelled enharomic notes
        // Ionian (Major Scale)
        let cShIonian = ["C♯", "D♯", "E♯", "F♯", "G♯", "A♯", "B♯"];
        let cIonian = ["C", "D", "E", "F", "G", "A", "B"];
        let dIonian = ["D", "E", "F♯", "G", "A", "B", "C♯"];
        let dShIonian = ["D♯", "E♯", "F𝄪", "G♯", "A♯", "B♯", "C𝄪"]; // Corrected F♯ to F𝄪
        let eIonian = ["E", "F♯", "G♯", "A", "B", "C♯", "D♯"];
        let fIonian = ["F", "G", "A", "B♭", "C", "D", "E"];
        let fShIonian = ["F♯", "G♯", "A♯", "B", "C♯", "D♯", "E♯"];
        let gIonian = ["G", "A", "B", "C", "D", "E", "F♯"];
        let gShIonian = ["G♯", "A♯", "B♯", "C♯", "D♯", "E♯", "F𝄪"]; // Corrected F♯ to F𝄪
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