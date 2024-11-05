//
//  ScaleComponentPickerViewController.m
//  Harmony
//
//  Created by Brian B. James on 5/24/09.
//  Copyright Brian B. James 2009. All rights reserved.
//

#import "ScaleComponentPickerViewController.h"

@implementation ScaleComponentPickerViewController

@synthesize doublePicker;
@synthesize modeTypes;
@synthesize modeRoot;
@synthesize label;

- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
	if (component == kRootComponent)
		return 90;
	return 210;
}

// didSelectRow
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {	
	NSInteger modeRow = [doublePicker selectedRowInComponent:kModeComponent];
	NSInteger rootRow = [doublePicker selectedRowInComponent:kRootComponent];
	NSString *mode = [self.modeTypes objectAtIndex:modeRow];
	NSString *theRoot = [self.modeRoot objectAtIndex:rootRow];
	
	// THE MESSAGE FROM THE PICKER
	NSMutableString *messageFromPicker = [[NSMutableString alloc] initWithFormat:@"%@ %@", theRoot, mode];
	
	// *********** Major TEST STRINGS **********************
	NSString *testStringCMajor = @"C Major";
	NSString *testStringCSharpMajor = @"C♯ Major";
	NSString *testStringDbMajor = @"D♭ Major";
	NSString *testStringDMajor = @"D Major";
	NSString *testStringDSharpMajor = @"D♯ Major";
	NSString *testStringEbMajor = @"E♭ Major";
	NSString *testStringEMajor = @"E Major";
	NSString *testStringFMajor = @"F Major";
	NSString *testStringFSharpMajor = @"F♯ Major";
	NSString *testStringGbMajor = @"G♭ Major";
	NSString *testStringGMajor = @"G Major";
	NSString *testStringGSharpMajor = @"G♯ Major";
	NSString *testStringAbMajor = @"A♭ Major";
	NSString *testStringAMajor = @"A Major";
	NSString *testStringASharpMajor = @"A♯ Major";
	NSString *testStringBbMajor = @"B♭ Major";
	NSString *testStringBMajor = @"B Major";
	
	// *********** Minor TEST STRINGS **********************
	NSString *testStringCMinor = @"C Minor";
	NSString *testStringCSharpMinor = @"C♯ Minor";
	NSString *testStringDbMinor = @"D♭ Minor";
	NSString *testStringDMinor = @"D Minor";
	NSString *testStringDSharpMinor = @"D♯ Minor";
	NSString *testStringEbMinor = @"E♭ Minor";
	NSString *testStringEMinor = @"E Minor";
	NSString *testStringFMinor = @"F Minor";
	NSString *testStringFSharpMinor = @"F♯ Minor";
	NSString *testStringGbMinor = @"G♭ Minor";
	NSString *testStringGMinor = @"G Minor";
	NSString *testStringGSharpMinor = @"G♯ Minor";
	NSString *testStringAbMinor = @"A♭ Minor";
	NSString *testStringAMinor = @"A Minor";
	NSString *testStringASharpMinor = @"A♯ Minor";
	NSString *testStringBbMinor = @"B♭ Minor";
	NSString *testStringBMinor = @"B Minor";
	
	// *********** HarmonicMinor TEST STRINGS **********************
	NSString *testStringCHarmonicMinor = @"C Harmonic Minor";
	NSString *testStringCSharpHarmonicMinor = @"C♯ Harmonic Minor";
	NSString *testStringDbHarmonicMinor = @"D♭ Harmonic Minor";
	NSString *testStringDHarmonicMinor = @"D Harmonic Minor";
	NSString *testStringDSharpHarmonicMinor = @"D♯ Harmonic Minor";
	NSString *testStringEbHarmonicMinor = @"E♭ Harmonic Minor";
	NSString *testStringEHarmonicMinor = @"E Harmonic Minor";
	NSString *testStringFHarmonicMinor = @"F Harmonic Minor";
	NSString *testStringFSharpHarmonicMinor = @"F♯ Harmonic Minor";
	NSString *testStringGbHarmonicMinor = @"G♭ Harmonic Minor";
	NSString *testStringGHarmonicMinor = @"G Harmonic Minor";
	NSString *testStringGSharpHarmonicMinor = @"G♯ Harmonic Minor";
	NSString *testStringAbHarmonicMinor = @"A♭ Harmonic Minor";
	NSString *testStringAHarmonicMinor = @"A Harmonic Minor";
	NSString *testStringASharpHarmonicMinor = @"A♯ Harmonic Minor";
	NSString *testStringBbHarmonicMinor = @"B♭ Harmonic Minor";
	NSString *testStringBHarmonicMinor = @"B Harmonic Minor";
	
	// *********** MelodicMinor TEST STRINGS **********************
	NSString *testStringCMelodicMinor = @"C Melodic Minor";
	NSString *testStringCSharpMelodicMinor = @"C♯ Melodic Minor";
	NSString *testStringDbMelodicMinor = @"D♭ Melodic Minor";
	NSString *testStringDMelodicMinor = @"D Melodic Minor";
	NSString *testStringDSharpMelodicMinor = @"D♯ Melodic Minor";
	NSString *testStringEbMelodicMinor = @"E♭ Melodic Minor";
	NSString *testStringEMelodicMinor = @"E Melodic Minor";
	NSString *testStringFMelodicMinor = @"F Melodic Minor";
	NSString *testStringFSharpMelodicMinor = @"F♯ Melodic Minor";
	NSString *testStringGbMelodicMinor = @"G♭ Melodic Minor";
	NSString *testStringGMelodicMinor = @"G Melodic Minor";
	NSString *testStringGSharpMelodicMinor = @"G♯ Melodic Minor";
	NSString *testStringAbMelodicMinor = @"A♭ Melodic Minor";
	NSString *testStringAMelodicMinor = @"A Melodic Minor";
	NSString *testStringASharpMelodicMinor = @"A♯ Melodic Minor";
	NSString *testStringBbMelodicMinor = @"B♭ Melodic Minor";
	NSString *testStringBMelodicMinor = @"B Melodic Minor";
	
	// *********** Ionian TEST STRINGS **********************
	NSString *testStringCIonian = @"C Ionian";
	NSString *testStringCSharpIonian = @"C♯ Ionian";
	NSString *testStringDbIonian = @"D♭ Ionian";
	NSString *testStringDIonian = @"D Ionian";
	NSString *testStringDSharpIonian = @"D♯ Ionian";
	NSString *testStringEbIonian = @"E♭ Ionian";
	NSString *testStringEIonian = @"E Ionian";
	NSString *testStringFIonian = @"F Ionian";
	NSString *testStringFSharpIonian = @"F♯ Ionian";
	NSString *testStringGbIonian = @"G♭ Ionian";
	NSString *testStringGIonian = @"G Ionian";
	NSString *testStringGSharpIonian = @"G♯ Ionian";
	NSString *testStringAbIonian = @"A♭ Ionian";
	NSString *testStringAIonian = @"A Ionian";
	NSString *testStringASharpIonian = @"A♯ Ionian";
	NSString *testStringBbIonian = @"B♭ Ionian";
	NSString *testStringBIonian = @"B Ionian";
	
	// *********** Dorian TEST STRINGS **********************
	NSString *testStringCDorian = @"C Dorian";
	NSString *testStringCSharpDorian = @"C♯ Dorian";
	NSString *testStringDbDorian = @"D♭ Dorian";
	NSString *testStringDDorian = @"D Dorian";
	NSString *testStringDSharpDorian = @"D♯ Dorian";
	NSString *testStringEbDorian = @"E♭ Dorian";
	NSString *testStringEDorian = @"E Dorian";
	NSString *testStringFDorian = @"F Dorian";
	NSString *testStringFSharpDorian = @"F♯ Dorian";
	NSString *testStringGbDorian = @"G♭ Dorian";
	NSString *testStringGDorian = @"G Dorian";
	NSString *testStringGSharpDorian = @"G♯ Dorian";
	NSString *testStringAbDorian = @"A♭ Dorian";
	NSString *testStringADorian = @"A Dorian";
	NSString *testStringASharpDorian = @"A♯ Dorian";
	NSString *testStringBbDorian = @"B♭ Dorian";
	NSString *testStringBDorian = @"B Dorian";
	
	// *********** Phrygian TEST STRINGS **********************
	NSString *testStringCPhrygian = @"C Phrygian";
	NSString *testStringCSharpPhrygian = @"C♯ Phrygian";
	NSString *testStringDbPhrygian = @"D♭ Phrygian";
	NSString *testStringDPhrygian = @"D Phrygian";
	NSString *testStringDSharpPhrygian = @"D♯ Phrygian";
	NSString *testStringEbPhrygian = @"E♭ Phrygian";
	NSString *testStringEPhrygian = @"E Phrygian";
	NSString *testStringFPhrygian = @"F Phrygian";
	NSString *testStringFSharpPhrygian = @"F♯ Phrygian";
	NSString *testStringGbPhrygian = @"G♭ Phrygian";
	NSString *testStringGPhrygian = @"G Phrygian";
	NSString *testStringGSharpPhrygian = @"G♯ Phrygian";
	NSString *testStringAbPhrygian = @"A♭ Phrygian";
	NSString *testStringAPhrygian = @"A Phrygian";
	NSString *testStringASharpPhrygian = @"A♯ Phrygian";
	NSString *testStringBbPhrygian = @"B♭ Phrygian";
	NSString *testStringBPhrygian = @"B Phrygian";
	
	// *********** Lydian TEST STRINGS **********************
	NSString *testStringCLydian = @"C Lydian";
	NSString *testStringCSharpLydian = @"C♯ Lydian";
	NSString *testStringDbLydian = @"D♭ Lydian";
	NSString *testStringDLydian = @"D Lydian";
	NSString *testStringDSharpLydian = @"D♯ Lydian";
	NSString *testStringEbLydian = @"E♭ Lydian";
	NSString *testStringELydian = @"E Lydian";
	NSString *testStringFLydian = @"F Lydian";
	NSString *testStringFSharpLydian = @"F♯ Lydian";
	NSString *testStringGbLydian = @"G♭ Lydian";
	NSString *testStringGLydian = @"G Lydian";
	NSString *testStringGSharpLydian = @"G♯ Lydian";
	NSString *testStringAbLydian = @"A♭ Lydian";
	NSString *testStringALydian = @"A Lydian";
	NSString *testStringASharpLydian = @"A♯ Lydian";
	NSString *testStringBbLydian = @"B♭ Lydian";
	NSString *testStringBLydian = @"B Lydian";
	
	// *********** Mixolydian TEST STRINGS **********************
	NSString *testStringCMixolydian = @"C Mixolydian";
	NSString *testStringCSharpMixolydian = @"C♯ Mixolydian";
	NSString *testStringDbMixolydian = @"D♭ Mixolydian";
	NSString *testStringDMixolydian = @"D Mixolydian";
	NSString *testStringDSharpMixolydian = @"D♯ Mixolydian";
	NSString *testStringEbMixolydian = @"E♭ Mixolydian";
	NSString *testStringEMixolydian = @"E Mixolydian";
	NSString *testStringFMixolydian = @"F Mixolydian";
	NSString *testStringFSharpMixolydian = @"F♯ Mixolydian";
	NSString *testStringGbMixolydian = @"G♭ Mixolydian";
	NSString *testStringGMixolydian = @"G Mixolydian";
	NSString *testStringGSharpMixolydian = @"G♯ Mixolydian";
	NSString *testStringAbMixolydian = @"A♭ Mixolydian";
	NSString *testStringAMixolydian = @"A Mixolydian";
	NSString *testStringASharpMixolydian = @"A♯ Mixolydian";
	NSString *testStringBbMixolydian = @"B♭ Mixolydian";
	NSString *testStringBMixolydian = @"B Mixolydian";
	
	// *********** Aeolian TEST STRINGS **********************
	NSString *testStringCAeolian = @"C Aeolian";
	NSString *testStringCSharpAeolian = @"C♯ Aeolian";
	NSString *testStringDbAeolian = @"D♭ Aeolian";
	NSString *testStringDAeolian = @"D Aeolian";
	NSString *testStringDSharpAeolian = @"D♯ Aeolian";
	NSString *testStringEbAeolian = @"E♭ Aeolian";
	NSString *testStringEAeolian = @"E Aeolian";
	NSString *testStringFAeolian = @"F Aeolian";
	NSString *testStringFSharpAeolian = @"F♯ Aeolian";
	NSString *testStringGbAeolian = @"G♭ Aeolian";
	NSString *testStringGAeolian = @"G Aeolian";
	NSString *testStringGSharpAeolian = @"G♯ Aeolian";
	NSString *testStringAbAeolian = @"A♭ Aeolian";
	NSString *testStringAAeolian = @"A Aeolian";
	NSString *testStringASharpAeolian = @"A♯ Aeolian";
	NSString *testStringBbAeolian = @"B♭ Aeolian";
	NSString *testStringBAeolian = @"B Aeolian";
	
	// *********** Locrian TEST STRINGS **********************
	NSString *testStringCLocrian = @"C Locrian";
	NSString *testStringCSharpLocrian = @"C♯ Locrian";
	NSString *testStringDbLocrian = @"D♭ Locrian";
	NSString *testStringDLocrian = @"D Locrian";
	NSString *testStringDSharpLocrian = @"D♯ Locrian";
	NSString *testStringEbLocrian = @"E♭ Locrian";
	NSString *testStringELocrian = @"E Locrian";
	NSString *testStringFLocrian = @"F Locrian";
	NSString *testStringFSharpLocrian = @"F♯ Locrian";
	NSString *testStringGbLocrian = @"G♭ Locrian";
	NSString *testStringGLocrian = @"G Locrian";
	NSString *testStringGSharpLocrian = @"G♯ Locrian";
	NSString *testStringAbLocrian = @"A♭ Locrian";
	NSString *testStringALocrian = @"A Locrian";
	NSString *testStringASharpLocrian = @"A♯ Locrian";
	NSString *testStringBbLocrian = @"B♭ Locrian";
	NSString *testStringBLocrian = @"B Locrian";
	
	// *********** WholeTone TEST STRINGS **********************
	NSString *testStringCWholeTone = @"C Whole Tone";
	NSString *testStringCSharpWholeTone = @"C♯ Whole Tone";
	NSString *testStringDbWholeTone = @"D♭ Whole Tone";
	NSString *testStringDWholeTone = @"D Whole Tone";
	NSString *testStringDSharpWholeTone = @"D♯ Whole Tone";
	NSString *testStringEbWholeTone = @"E♭ Whole Tone";
	NSString *testStringEWholeTone = @"E Whole Tone";
	NSString *testStringFWholeTone = @"F Whole Tone";
	NSString *testStringFSharpWholeTone = @"F♯ Whole Tone";
	NSString *testStringGbWholeTone = @"G♭ Whole Tone";
	NSString *testStringGWholeTone = @"G Whole Tone";
	NSString *testStringGSharpWholeTone = @"G♯ Whole Tone";
	NSString *testStringAbWholeTone = @"A♭ Whole Tone";
	NSString *testStringAWholeTone = @"A Whole Tone";
	NSString *testStringASharpWholeTone = @"A♯ Whole Tone";
	NSString *testStringBbWholeTone = @"B♭ Whole Tone";
	NSString *testStringBWholeTone = @"B Whole Tone";
	
	// *********** ChromaticScale TEST STRINGS **********************
	NSString *testStringCChromaticScale = @"C Chromatic";
	NSString *testStringCSharpChromaticScale = @"C♯ Chromatic";
	NSString *testStringDbChromaticScale = @"D♭ Chromatic";
	NSString *testStringDChromaticScale = @"D Chromatic";
	NSString *testStringDSharpChromaticScale = @"D♯ Chromatic";
	NSString *testStringEbChromaticScale = @"E♭ Chromatic";
	NSString *testStringEChromaticScale = @"E Chromatic";
	NSString *testStringFChromaticScale = @"F Chromatic";
	NSString *testStringFSharpChromaticScale = @"F♯ Chromatic";
	NSString *testStringGbChromaticScale = @"G♭ Chromatic";
	NSString *testStringGChromaticScale = @"G Chromatic";
	NSString *testStringGSharpChromaticScale = @"G♯ Chromatic";
	NSString *testStringAbChromaticScale = @"A♭ Chromatic";
	NSString *testStringAChromaticScale = @"A Chromatic";
	NSString *testStringASharpChromaticScale = @"A♯ Chromatic";
	NSString *testStringBbChromaticScale = @"B♭ Chromatic";
	NSString *testStringBChromaticScale = @"B Chromatic";	
	
	// *********** Pentatonic TEST STRINGS **********************
	NSString *testStringCPentatonic = @"C Pentatonic";
	NSString *testStringCSharpPentatonic = @"C♯ Pentatonic";
	NSString *testStringDbPentatonic = @"D♭ Pentatonic";
	NSString *testStringDPentatonic = @"D Pentatonic";
	NSString *testStringDSharpPentatonic = @"D♯ Pentatonic";
	NSString *testStringEbPentatonic = @"E♭ Pentatonic";
	NSString *testStringEPentatonic = @"E Pentatonic";
	NSString *testStringFPentatonic = @"F Pentatonic";
	NSString *testStringFSharpPentatonic = @"F♯ Pentatonic";
	NSString *testStringGbPentatonic = @"G♭ Pentatonic";
	NSString *testStringGPentatonic = @"G Pentatonic";
	NSString *testStringGSharpPentatonic = @"G♯ Pentatonic";
	NSString *testStringAbPentatonic = @"A♭ Pentatonic";
	NSString *testStringAPentatonic = @"A Pentatonic";
	NSString *testStringASharpPentatonic = @"A♯ Pentatonic";
	NSString *testStringBbPentatonic = @"B♭ Pentatonic";
	NSString *testStringBPentatonic = @"B Pentatonic";
	
	// *********** BluesScale TEST STRINGS **********************
	NSString *testStringCBluesScale = @"C Blues";
	NSString *testStringCSharpBluesScale = @"C♯ Blues";
	NSString *testStringDbBluesScale = @"D♭ Blues";
	NSString *testStringDBluesScale = @"D Blues";
	NSString *testStringDSharpBluesScale = @"D♯ Blues";
	NSString *testStringEbBluesScale = @"E♭ Blues";
	NSString *testStringEBluesScale = @"E Blues";
	NSString *testStringFBluesScale = @"F Blues";
	NSString *testStringFSharpBluesScale = @"F♯ Blues";
	NSString *testStringGbBluesScale = @"G♭ Blues";
	NSString *testStringGBluesScale = @"G Blues";
	NSString *testStringGSharpBluesScale = @"G♯ Blues";
	NSString *testStringAbBluesScale = @"A♭ Blues";
	NSString *testStringABluesScale = @"A Blues";
	NSString *testStringASharpBluesScale = @"A♯ Blues";
	NSString *testStringBbBluesScale = @"B♭ Blues";
	NSString *testStringBBluesScale = @"B Blues";
	
	// *********** DiminishedScale TEST STRINGS **********************
	NSString *testStringCDiminishedScale = @"C Diminished";
	NSString *testStringCSharpDiminishedScale = @"C♯ Diminished";
	NSString *testStringDbDiminishedScale = @"D♭ Diminished";
	NSString *testStringDDiminishedScale = @"D Diminished";
	NSString *testStringDSharpDiminishedScale = @"D♯ Diminished";
	NSString *testStringEbDiminishedScale = @"E♭ Diminished";
	NSString *testStringEDiminishedScale = @"E Diminished";
	NSString *testStringFDiminishedScale = @"F Diminished";
	NSString *testStringFSharpDiminishedScale = @"F♯ Diminished";
	NSString *testStringGbDiminishedScale = @"G♭ Diminished";
	NSString *testStringGDiminishedScale = @"G Diminished";
	NSString *testStringGSharpDiminishedScale = @"G♯ Diminished";
	NSString *testStringAbDiminishedScale = @"A♭ Diminished";
	NSString *testStringADiminishedScale = @"A Diminished";
	NSString *testStringASharpDiminishedScale = @"A♯ Diminished";
	NSString *testStringBbDiminishedScale = @"B♭ Diminished";
	NSString *testStringBDiminishedScale = @"B Diminished";
	
	// *********** OctatonicScale TEST STRINGS **********************
	NSString *testStringCOctatonicScale = @"C Octatonic";
	NSString *testStringCSharpOctatonicScale = @"C♯ Octatonic";
	NSString *testStringDbOctatonicScale = @"D♭ Octatonic";
	NSString *testStringDOctatonicScale = @"D Octatonic";
	NSString *testStringDSharpOctatonicScale = @"D♯ Octatonic";
	NSString *testStringEbOctatonicScale = @"E♭ Octatonic";
	NSString *testStringEOctatonicScale = @"E Octatonic";
	NSString *testStringFOctatonicScale = @"F Octatonic";
	NSString *testStringFSharpOctatonicScale = @"F♯ Octatonic";
	NSString *testStringGbOctatonicScale = @"G♭ Octatonic";
	NSString *testStringGOctatonicScale = @"G Octatonic";
	NSString *testStringGSharpOctatonicScale = @"G♯ Octatonic";
	NSString *testStringAbOctatonicScale = @"A♭ Octatonic";
	NSString *testStringAOctatonicScale = @"A Octatonic";
	NSString *testStringASharpOctatonicScale = @"A♯ Octatonic";
	NSString *testStringBbOctatonicScale = @"B♭ Octatonic";
	NSString *testStringBOctatonicScale = @"B Octatonic";
	
	// *********** EnigmaticScale TEST STRINGS **********************
	NSString *testStringCEnigmaticScale = @"C Enigmatic";
	NSString *testStringCSharpEnigmaticScale = @"C♯ Enigmatic";
	NSString *testStringDbEnigmaticScale = @"D♭ Enigmatic";
	NSString *testStringDEnigmaticScale = @"D Enigmatic";
	NSString *testStringDSharpEnigmaticScale = @"D♯ Enigmatic";
	NSString *testStringEbEnigmaticScale = @"E♭ Enigmatic";
	NSString *testStringEEnigmaticScale = @"E Enigmatic";
	NSString *testStringFEnigmaticScale = @"F Enigmatic";
	NSString *testStringFSharpEnigmaticScale = @"F♯ Enigmatic";
	NSString *testStringGbEnigmaticScale = @"G♭ Enigmatic";
	NSString *testStringGEnigmaticScale = @"G Enigmatic";
	NSString *testStringGSharpEnigmaticScale = @"G♯ Enigmatic";
	NSString *testStringAbEnigmaticScale = @"A♭ Enigmatic";
	NSString *testStringAEnigmaticScale = @"A Enigmatic";
	NSString *testStringASharpEnigmaticScale = @"A♯ Enigmatic";
	NSString *testStringBbEnigmaticScale = @"B♭ Enigmatic";
	NSString *testStringBEnigmaticScale = @"B Enigmatic";
	
	// *********** HungarianGypsyScale TEST STRINGS **********************
	NSString *testStringCHungarianGypsyScale = @"C Hungarian Gypsy";
	NSString *testStringCSharpHungarianGypsyScale = @"C♯ Hungarian Gypsy";
	NSString *testStringDbHungarianGypsyScale = @"D♭ Hungarian Gypsy";
	NSString *testStringDHungarianGypsyScale = @"D Hungarian Gypsy";
	NSString *testStringDSharpHungarianGypsyScale = @"D♯ Hungarian Gypsy";
	NSString *testStringEbHungarianGypsyScale = @"E♭ Hungarian Gypsy";
	NSString *testStringEHungarianGypsyScale = @"E Hungarian Gypsy";
	NSString *testStringFHungarianGypsyScale = @"F Hungarian Gypsy";
	NSString *testStringFSharpHungarianGypsyScale = @"F♯ Hungarian Gypsy";
	NSString *testStringGbHungarianGypsyScale = @"G♭ Hungarian Gypsy";
	NSString *testStringGHungarianGypsyScale = @"G Hungarian Gypsy";
	NSString *testStringGSharpHungarianGypsyScale = @"G♯ Hungarian Gypsy";
	NSString *testStringAbHungarianGypsyScale = @"A♭ Hungarian Gypsy";
	NSString *testStringAHungarianGypsyScale = @"A Hungarian Gypsy";
	NSString *testStringASharpHungarianGypsyScale = @"A♯ Hungarian Gypsy";
	NSString *testStringBbHungarianGypsyScale = @"B♭ Hungarian Gypsy";
	NSString *testStringBHungarianGypsyScale = @"B Hungarian Gypsy";
	
	
	// IF STRING isEqualToString X XXXXXX ******************************************
	
	// *********** Major ifs **********************
	
	if ([messageFromPicker isEqualToString: testStringCMajor] == YES)
	{
	label.text = [NSString stringWithFormat:@"C, D, E, F, G, A, B"];
	//@"C Major:"
	}

	if ([messageFromPicker isEqualToString: testStringCSharpMajor] == YES)
	{
	label.text = [NSString stringWithFormat:@"C♯, D♯, E♯, F♯, G♯, A♯, B♯"];
	//@"C♯ Major:"
	}

	if ([messageFromPicker isEqualToString: testStringDbMajor] == YES)
	{
	label.text = [NSString stringWithFormat:@"D♭, E♭, F, G♭, A♭, B♭, C"];
	//@"D♭ Major:"
	}

	if ([messageFromPicker isEqualToString: testStringDMajor] == YES)
	{
	label.text = [NSString stringWithFormat:@"D, E, F♯, G, A, B, C♯"];
	//@"D Major:"
	}

	if ([messageFromPicker isEqualToString: testStringDSharpMajor] == YES)
	{
	label.text = [NSString stringWithFormat:@"D♯, E♯, Fx, G♯, A♯, B♯, Cx"];
	//@"D♯ Major:"
	}

	if ([messageFromPicker isEqualToString: testStringEbMajor] == YES)
	{
	label.text = [NSString stringWithFormat:@"E♭, F, G, A♭, B♭, C, D"];
	//@"E♭ Major:"
	}

	if ([messageFromPicker isEqualToString: testStringEMajor] == YES)
	{
	label.text = [NSString stringWithFormat:@"E, F♯, G♯, A, B, C♯, D♯"];
	//@"E Major:"
	}

	if ([messageFromPicker isEqualToString: testStringFMajor] == YES)
	{
	label.text = [NSString stringWithFormat:@"F, G, A, B♭, C, D, E"];
	//@"F Major:"
	}

	if ([messageFromPicker isEqualToString: testStringFSharpMajor] == YES)
	{
	label.text = [NSString stringWithFormat:@"F♯, G♯, A♯, B, C♯, D♯, E♯"];
	//@"F♯ Major:"
	}

	if ([messageFromPicker isEqualToString: testStringGbMajor] == YES)
	{
	label.text = [NSString stringWithFormat:@"G♭, A♭, B♭, C♭, D♭, E♭, F"];
	//@"G♭ Major:"
	}

	if ([messageFromPicker isEqualToString: testStringGMajor] == YES)
	{
	label.text = [NSString stringWithFormat:@"G, A, B, C, D, E, F♯"];
	//@"G Major:"
	}

	if ([messageFromPicker isEqualToString: testStringGSharpMajor] == YES)
	{
	label.text = [NSString stringWithFormat:@"G♯, A♯, B♯, C♯, D♯, E♯, Fx"];
	//@"G♯ Major:"
	}

	if ([messageFromPicker isEqualToString: testStringAbMajor] == YES)
	{
	label.text = [NSString stringWithFormat:@"A♭, B♭, C, D♭, E♭, F, G"];
	//@"A♭ Major:"
	}

	if ([messageFromPicker isEqualToString: testStringAMajor] == YES)
	{
	label.text = [NSString stringWithFormat:@"A, B, C♯, D, E, F♯, G♯"];
	//@"A Major:"
	}

	if ([messageFromPicker isEqualToString: testStringASharpMajor] == YES)
	{
	label.text = [NSString stringWithFormat:@"A♯, B♯, Cx, D♯, E♯, Fx, Gx"];
	//@"A♯ Major:"
	}

	if ([messageFromPicker isEqualToString: testStringBbMajor] == YES)
	{
	label.text = [NSString stringWithFormat:@"B♭, C, D, E♭, F, G, A"];
	//@"B♭ Major:"
	}

	if ([messageFromPicker isEqualToString: testStringBMajor] == YES)
	{
	label.text = [NSString stringWithFormat:@"B, C♯, D♯, E, F♯, G♯, A♯"];
	//@"B Major:"
	}

	// *********** Minor ifs **********************

	if ([messageFromPicker isEqualToString: testStringCMinor] == YES)
	{
	label.text = [NSString stringWithFormat:@"C, D, E♭, F, G, A♭, B♭"];
	//@"C Minor:"
	}

	if ([messageFromPicker isEqualToString: testStringCSharpMinor] == YES)
	{
	label.text = [NSString stringWithFormat:@"C♯, D♯, E, F♯, G♯, A, B"];
	//@"C♯ Minor:"
	}

	if ([messageFromPicker isEqualToString: testStringDbMinor] == YES)
	{
	label.text = [NSString stringWithFormat:@"D♭, E♭, F♭, G♭, A♭, B♭♭, C♭"];
	//@"D♭ Minor:"
	}

	if ([messageFromPicker isEqualToString: testStringDMinor] == YES)
	{
	label.text = [NSString stringWithFormat:@"D, E, F, G, A, B♭, C"];
	//@"D Minor:"
	}

	if ([messageFromPicker isEqualToString: testStringDSharpMinor] == YES)
	{
	label.text = [NSString stringWithFormat:@"D♯, E♯, F♯, G♯, A♯, B, C♯"];
	//@"D♯ Minor:"
	}

	if ([messageFromPicker isEqualToString: testStringEbMinor] == YES)
	{
	label.text = [NSString stringWithFormat:@"E♭, F, G♭, A♭, B♭, C♭, D♭"];
	//@"E♭ Minor:"
	}

	if ([messageFromPicker isEqualToString: testStringEMinor] == YES)
	{
	label.text = [NSString stringWithFormat:@"E, F♯, G, A, B, C, D"];
	//@"E Minor:"
	}

	if ([messageFromPicker isEqualToString: testStringFMinor] == YES)
	{
	label.text = [NSString stringWithFormat:@"F, G, A♭, B♭, C, D♭, E♭"];
	//@"F Minor:"
	}

	if ([messageFromPicker isEqualToString: testStringFSharpMinor] == YES)
	{
	label.text = [NSString stringWithFormat:@"F♯, G♯, A, B, C♯, D, E"];
	//@"F♯ Minor:"
	}

	if ([messageFromPicker isEqualToString: testStringGbMinor] == YES)
	{
	label.text = [NSString stringWithFormat:@"G♭, A♭, B♭♭, C♭, D♭, E♭♭, F♭"];
	//@"G♭ Minor:"
	}

	if ([messageFromPicker isEqualToString: testStringGMinor] == YES)
	{
	label.text = [NSString stringWithFormat:@"G, A, B♭, C, D, E♭, F"];
	//@"G Minor:"
	}

	if ([messageFromPicker isEqualToString: testStringGSharpMinor] == YES)
	{
	label.text = [NSString stringWithFormat:@"G♯, A♯, B, C♯, D♯, E, F♯"];
	//@"G♯ Minor:"
	}

	if ([messageFromPicker isEqualToString: testStringAbMinor] == YES)
	{
	label.text = [NSString stringWithFormat:@"A♭, B♭, C♭, D♭, E♭, F♭, G♭"];
	//@"A♭ Minor:"
	}

	if ([messageFromPicker isEqualToString: testStringAMinor] == YES)
	{
	label.text = [NSString stringWithFormat:@"A, B, C, D, E, F, G"];
	//@"A Minor:"
	}

	if ([messageFromPicker isEqualToString: testStringASharpMinor] == YES)
	{
	label.text = [NSString stringWithFormat:@"A♯, B♯, C♯, D♯, E♯, F♯, G♯"];
	//@"A♯ Minor:"
	}

	if ([messageFromPicker isEqualToString: testStringBbMinor] == YES)
	{
	label.text = [NSString stringWithFormat:@"B♭, C, D♭, E♭, F, G♭, A♭"];
	//@"B♭ Minor:"
	}

	if ([messageFromPicker isEqualToString: testStringBMinor] == YES)
	{
	label.text = [NSString stringWithFormat:@"B, C♯, D, E, F♯, G, A"];
	//@"B Minor:"
	}

	// *********** HarmonicMinor ifs **********************

	if ([messageFromPicker isEqualToString: testStringCHarmonicMinor] == YES)
	{
	label.text = [NSString stringWithFormat:@"C, D, E♭, F, G, A♭, B"];
	//@"C Harmonic Minor:"
	}

	if ([messageFromPicker isEqualToString: testStringCSharpHarmonicMinor] == YES)
	{
	label.text = [NSString stringWithFormat:@"C♯, D♯, E, F♯, G♯, A, B♯"];
	//@"C♯ Harmonic Minor:"
	}

	if ([messageFromPicker isEqualToString: testStringDbHarmonicMinor] == YES)
	{
	label.text = [NSString stringWithFormat:@"D♭, E♭, F♭, G♭, A♭, B♭♭, C"];
	//@"D♭ Harmonic Minor:"
	}

	if ([messageFromPicker isEqualToString: testStringDHarmonicMinor] == YES)
	{
	label.text = [NSString stringWithFormat:@"D, E, F, G, A, B♭, C♯"];
	//@"D Harmonic Minor:"
	}

	if ([messageFromPicker isEqualToString: testStringDSharpHarmonicMinor] == YES)
	{
	label.text = [NSString stringWithFormat:@"D♯, E♯, F♯, G♯, A♯, B, Cx"];
	//@"D♯ Harmonic Minor:"
	}

	if ([messageFromPicker isEqualToString: testStringEbHarmonicMinor] == YES)
	{
	label.text = [NSString stringWithFormat:@"E♭, F, G♭, A♭, B♭, C♭, D♭"];
	//@"E♭ Harmonic Minor:"
	}

	if ([messageFromPicker isEqualToString: testStringEHarmonicMinor] == YES)
	{
	label.text = [NSString stringWithFormat:@"E, F♯, G, A, B, C, D♯"];
	//@"E Harmonic Minor:"
	}

	if ([messageFromPicker isEqualToString: testStringFHarmonicMinor] == YES)
	{
	label.text = [NSString stringWithFormat:@"F, G, A♭, B♭, C, D♭, E"];
	//@"F Harmonic Minor:"
	}

	if ([messageFromPicker isEqualToString: testStringFSharpHarmonicMinor] == YES)
	{
	label.text = [NSString stringWithFormat:@"F♯, G♯, A, B, C♯, D, E♯"];
	//@"F♯ Harmonic Minor:"
	}

	if ([messageFromPicker isEqualToString: testStringGbHarmonicMinor] == YES)
	{
	label.text = [NSString stringWithFormat:@"G♭, A♭, B♭♭, C♭, D♭, E♭♭, F"];
	//@"G♭ Harmonic Minor:"
	}

	if ([messageFromPicker isEqualToString: testStringGHarmonicMinor] == YES)
	{
	label.text = [NSString stringWithFormat:@"G, A, B♭, C, D, E♭, F♯"];
	//@"G Harmonic Minor:"
	}

	if ([messageFromPicker isEqualToString: testStringGSharpHarmonicMinor] == YES)
	{
	label.text = [NSString stringWithFormat:@"G♯, A♯, B, C♯, D♯, E, Fx"];
	//@"G♯ Harmonic Minor:"
	}

	if ([messageFromPicker isEqualToString: testStringAbHarmonicMinor] == YES)
	{
	label.text = [NSString stringWithFormat:@"A♭, B♭, C♭, D♭, E♭, F♭, G"];
	//@"A♭ Harmonic Minor:"
	}

	if ([messageFromPicker isEqualToString: testStringAHarmonicMinor] == YES)
	{
	label.text = [NSString stringWithFormat:@"A, B, C, D, E, F, G♯"];
	//@"A Harmonic Minor:"
	}

	if ([messageFromPicker isEqualToString: testStringASharpHarmonicMinor] == YES)
	{
	label.text = [NSString stringWithFormat:@"A♯, B♯, C♯, D♯, E♯, F♯, Gx"];
	//@"A♯ Harmonic Minor:"
	}

	if ([messageFromPicker isEqualToString: testStringBbHarmonicMinor] == YES)
	{
	label.text = [NSString stringWithFormat:@"B♭, C, D♭, E♭, F, G♭, A"];
	//@"B♭ Harmonic Minor:"
	}

	if ([messageFromPicker isEqualToString: testStringBHarmonicMinor] == YES)
	{
	label.text = [NSString stringWithFormat:@"B, C♯, D, E, F♯, G, A♯"];
	//@"B Harmonic Minor:"
	}

	// *********** MelodicMinor ifs **********************

	if ([messageFromPicker isEqualToString: testStringCMelodicMinor] == YES)
	{
	label.text = [NSString stringWithFormat:@"C, D, E♭, F, G, A, B"];
	//@"C Melodic Minor:"
	}

	if ([messageFromPicker isEqualToString: testStringCSharpMelodicMinor] == YES)
	{
	label.text = [NSString stringWithFormat:@"C♯, D♯, E, F♯, G♯, A♯, B♯"];
	//@"C♯ Melodic Minor:"
	}

	if ([messageFromPicker isEqualToString: testStringDbMelodicMinor] == YES)
	{
	label.text = [NSString stringWithFormat:@"D♭, E♭, F♭, G♭, A♭, B♭, C"];
	//@"D♭ Melodic Minor:"
	}

	if ([messageFromPicker isEqualToString: testStringDMelodicMinor] == YES)
	{
	label.text = [NSString stringWithFormat:@"D, E, F, G, A, B, C♯"];
	//@"D Melodic Minor:"
	}

	if ([messageFromPicker isEqualToString: testStringDSharpMelodicMinor] == YES)
	{
	label.text = [NSString stringWithFormat:@"D♯, E♯, F♯, G♯, A♯, B♯, Cx"];
	//@"D♯ Melodic Minor:"
	}

	if ([messageFromPicker isEqualToString: testStringEbMelodicMinor] == YES)
	{
	label.text = [NSString stringWithFormat:@"E♭, F, G♭, A♭, B♭, C, D♭"];
	//@"E♭ Melodic Minor:"
	}

	if ([messageFromPicker isEqualToString: testStringEMelodicMinor] == YES)
	{
	label.text = [NSString stringWithFormat:@"E, F♯, G, A, B, C♯, D♯"];
	//@"E Melodic Minor:"
	}

	if ([messageFromPicker isEqualToString: testStringFMelodicMinor] == YES)
	{
	label.text = [NSString stringWithFormat:@"F, G, A♭, B♭, C, D, E"];
	//@"F Melodic Minor:"
	}

	if ([messageFromPicker isEqualToString: testStringFSharpMelodicMinor] == YES)
	{
	label.text = [NSString stringWithFormat:@"F♯, G♯, A, B, C♯, D♯, E♯"];
	//@"F♯ Melodic Minor:"
	}

	if ([messageFromPicker isEqualToString: testStringGbMelodicMinor] == YES)
	{
	label.text = [NSString stringWithFormat:@"G♭, A♭, B♭♭, C♭, D♭, E♭, F"];
	//@"G♭ Melodic Minor:"
	}

	if ([messageFromPicker isEqualToString: testStringGMelodicMinor] == YES)
	{
	label.text = [NSString stringWithFormat:@"G, A, B♭, C, D, E, F♯"];
	//@"G Melodic Minor:"
	}

	if ([messageFromPicker isEqualToString: testStringGSharpMelodicMinor] == YES)
	{
	label.text = [NSString stringWithFormat:@"G♯, A♯, B, C♯, D♯, E♯, Fx"];
	//@"G♯ Melodic Minor:"
	}

	if ([messageFromPicker isEqualToString: testStringAbMelodicMinor] == YES)
	{
	label.text = [NSString stringWithFormat:@"A♭, B♭, C♭, D♭, E♭, F, G"];
	//@"A♭ Melodic Minor:"
	}

	if ([messageFromPicker isEqualToString: testStringAMelodicMinor] == YES)
	{
	label.text = [NSString stringWithFormat:@"A, B, C, D, E, F♯, G♯"];
	//@"A Melodic Minor:"
	}

	if ([messageFromPicker isEqualToString: testStringASharpMelodicMinor] == YES)
	{
	label.text = [NSString stringWithFormat:@"A♯, B♯, C♯, D♯, E♯, Fx, Gx"];
	//@"A♯ Melodic Minor:"
	}

	if ([messageFromPicker isEqualToString: testStringBbMelodicMinor] == YES)
	{
	label.text = [NSString stringWithFormat:@"B♭, C, D♭, E♭, F, G, A"];
	//@"B♭ Melodic Minor:"
	}

	if ([messageFromPicker isEqualToString: testStringBMelodicMinor] == YES)
	{
	label.text = [NSString stringWithFormat:@"B, C♯, D, E, F♯, G♯, A♯"];
	//@"B Melodic Minor:"
	}	

	// *********** Ionian ifs **********************

	if ([messageFromPicker isEqualToString: testStringCIonian] == YES)
	{
	label.text = [NSString stringWithFormat:@"C, D, E, F, G, A, B"];
	//@"C Ionian:"
	}

	if ([messageFromPicker isEqualToString: testStringCSharpIonian] == YES)
	{
	label.text = [NSString stringWithFormat:@"C♯, D♯, E♯, F♯, G♯, A♯, B♯"];
	//@"C♯ Ionian:"
	}

	if ([messageFromPicker isEqualToString: testStringDbIonian] == YES)
	{
	label.text = [NSString stringWithFormat:@"D♭, E♭, F, G♭, A♭, B♭, C"];
	//@"D♭ Ionian:"
	}

	if ([messageFromPicker isEqualToString: testStringDIonian] == YES)
	{
	label.text = [NSString stringWithFormat:@"D, E, F♯, G, A, B, C♯"];
	//@"D Ionian:"
	}

	if ([messageFromPicker isEqualToString: testStringDSharpIonian] == YES)
	{
	label.text = [NSString stringWithFormat:@"D♯, E♯, Fx, G♯, A♯, B♯, Cx"];
	//@"D♯ Ionian:"
	}

	if ([messageFromPicker isEqualToString: testStringEbIonian] == YES)
	{
	label.text = [NSString stringWithFormat:@"E♭, F, G, A♭, B♭, C, D"];
	//@"E♭ Ionian:"
	}

	if ([messageFromPicker isEqualToString: testStringEIonian] == YES)
	{
	label.text = [NSString stringWithFormat:@"E, F♯, G♯, A, B, C♯, D♯"];
	//@"E Ionian:"
	}

	if ([messageFromPicker isEqualToString: testStringFIonian] == YES)
	{
	label.text = [NSString stringWithFormat:@"F, G, A, B♭, C, D, E"];
	//@"F Ionian:"
	}

	if ([messageFromPicker isEqualToString: testStringFSharpIonian] == YES)
	{
	label.text = [NSString stringWithFormat:@"F♯, G♯, A♯, B, C♯, D♯, E♯"];
	//@"F♯ Ionian:"
	}

	if ([messageFromPicker isEqualToString: testStringGbIonian] == YES)
	{
	label.text = [NSString stringWithFormat:@"G♭, A♭, B♭, C♭, D♭, E♭, F"];
	//@"G♭ Ionian:"
	}

	if ([messageFromPicker isEqualToString: testStringGIonian] == YES)
	{
	label.text = [NSString stringWithFormat:@"G, A, B, C, D, E, F♯"];
	//@"G Ionian:"
	}

	if ([messageFromPicker isEqualToString: testStringGSharpIonian] == YES)
	{
	label.text = [NSString stringWithFormat:@"G♯, A♯, B♯, C♯, D♯, E♯, Fx"];
	//@"G♯ Ionian:"
	}

	if ([messageFromPicker isEqualToString: testStringAbIonian] == YES)
	{
	label.text = [NSString stringWithFormat:@"A♭, B♭, C, D♭, E♭, F, G"];
	//@"A♭ Ionian:"
	}

	if ([messageFromPicker isEqualToString: testStringAIonian] == YES)
	{
	label.text = [NSString stringWithFormat:@"A, B, C♯, D, E, F♯, G♯"];
	//@"A Ionian:"
	}

	if ([messageFromPicker isEqualToString: testStringASharpIonian] == YES)
	{
	label.text = [NSString stringWithFormat:@"A♯, B♯, Cx, D♯, E♯, Fx, Gx"];
	//@"A♯ Ionian:"
	}

	if ([messageFromPicker isEqualToString: testStringBbIonian] == YES)
	{
	label.text = [NSString stringWithFormat:@"B♭, C, D, E♭, F, G, A"];
	//@"B♭ Ionian:"
	}

	if ([messageFromPicker isEqualToString: testStringBIonian] == YES)
	{
	label.text = [NSString stringWithFormat:@"B, C♯, D♯, E, F♯, G♯, A♯"];
	//@"B Ionian:"
	}

	// *********** Dorian ifs **********************
	// dorian = W 1/2 W W W 1/2 W

	if ([messageFromPicker isEqualToString: testStringCDorian] == YES)
	{
	label.text = [NSString stringWithFormat:@"C, D, E♭, F, G, A, B♭"];
	//@"C Dorian:"
	}

	if ([messageFromPicker isEqualToString: testStringCSharpDorian] == YES)
	{
	label.text = [NSString stringWithFormat:@"C♯, D♯, E, F♯, G♯, A♯, B"];
	//@"C♯ Dorian:"
	}

	if ([messageFromPicker isEqualToString: testStringDbDorian] == YES)
	{
	label.text = [NSString stringWithFormat:@"D♭, E♭, F♭, G♭, A♭, B♭, C♭"];
	//@"D♭ Dorian:"
	}

	if ([messageFromPicker isEqualToString: testStringDDorian] == YES)
	{
	label.text = [NSString stringWithFormat:@"D, E, F, G, A, B, C"];
	//@"D Dorian:"
	}

	if ([messageFromPicker isEqualToString: testStringDSharpDorian] == YES)
	{
	label.text = [NSString stringWithFormat:@"D♯, E♯, F♯, G♯, A♯, B♯, C♯"];
	//@"D♯ Dorian:"
	}

	if ([messageFromPicker isEqualToString: testStringEbDorian] == YES)
	{
	label.text = [NSString stringWithFormat:@"E♭, F, G♭, A♭, B♭, C, D♭"];
	//@"E♭ Dorian:"
	}

	if ([messageFromPicker isEqualToString: testStringEDorian] == YES)
	{
	label.text = [NSString stringWithFormat:@"E, F♯, G, A, B, C♯, D"];
	//@"E Dorian:"
	}

	if ([messageFromPicker isEqualToString: testStringFDorian] == YES)
	{
	label.text = [NSString stringWithFormat:@"F, G, A♭, B♭, C, D, E♭"];
	//@"F Dorian:"
	}

	if ([messageFromPicker isEqualToString: testStringFSharpDorian] == YES)
	{
	label.text = [NSString stringWithFormat:@"F♯, G♯, A, B, C♯, D♯, E"];
	//@"F♯ Dorian:"
	}

	if ([messageFromPicker isEqualToString: testStringGbDorian] == YES)
	{
	label.text = [NSString stringWithFormat:@"G♭, A♭, B♭♭, C♭, D♭, E♭, F♭"];
	//@"G♭ Dorian:"
	}

	if ([messageFromPicker isEqualToString: testStringGDorian] == YES)
	{
	label.text = [NSString stringWithFormat:@"G, A, B♭, C, D, E, F"];
	//@"G Dorian:"
	}

	if ([messageFromPicker isEqualToString: testStringGSharpDorian] == YES)
	{
	label.text = [NSString stringWithFormat:@"G♯, A♯, B, C♯, D♯, E♯, F♯"];
	//@"G♯ Dorian:"
	}

	if ([messageFromPicker isEqualToString: testStringAbDorian] == YES)
	{
	label.text = [NSString stringWithFormat:@"A♭, B♭, C♭, D♭, E♭, F, G♭"];
	//@"A♭ Dorian:"
	}

	if ([messageFromPicker isEqualToString: testStringADorian] == YES)
	{
	label.text = [NSString stringWithFormat:@"A, B, C, D, E, F♯, G"];
	//@"A Dorian:"
	}

	if ([messageFromPicker isEqualToString: testStringASharpDorian] == YES)
	{
	label.text = [NSString stringWithFormat:@"A♯, B♯, C♯, D♯, E♯, Fx, G♯"];
	//@"A♯ Dorian:"
	}

	if ([messageFromPicker isEqualToString: testStringBbDorian] == YES)
	{
	label.text = [NSString stringWithFormat:@"B♭, C, D♭, E♭, F, G, A♭"];
	//@"B♭ Dorian:"
	}

	if ([messageFromPicker isEqualToString: testStringBDorian] == YES)
	{
	label.text = [NSString stringWithFormat:@"B, C♯, D, E, F♯, G♯, A"];
	//@"B Dorian:"
	}

	// *********** Phrygian ifs **********************

	if ([messageFromPicker isEqualToString: testStringCPhrygian] == YES)
	{
	label.text = [NSString stringWithFormat:@"C, D♭, E♭, F, G, A♭, B♭"];
	//@"C Phrygian:"
	}

	if ([messageFromPicker isEqualToString: testStringCSharpPhrygian] == YES)
	{
	label.text = [NSString stringWithFormat:@"C♯, D, E, F♯, G♯, A, B"];
	//@"C♯ Phrygian:"
	}

	if ([messageFromPicker isEqualToString: testStringDbPhrygian] == YES)
	{
	label.text = [NSString stringWithFormat:@"D♭, E♭♭, F♭, G♭, A♭, B♭♭, C♭"];
	//@"D♭ Phrygian:"
	}

	if ([messageFromPicker isEqualToString: testStringDPhrygian] == YES)
	{
	label.text = [NSString stringWithFormat:@"D, E♭, F, G, A, B♭, C"];
	//@"D Phrygian:"
	}

	if ([messageFromPicker isEqualToString: testStringDSharpPhrygian] == YES)
	{
	label.text = [NSString stringWithFormat:@"D♯, E, F♯, G♯, A♯, B, C♯"];
	//@"D♯ Phrygian:"
	}

	if ([messageFromPicker isEqualToString: testStringEbPhrygian] == YES)
	{
	label.text = [NSString stringWithFormat:@"E♭, F♭, G♭, A♭, B♭, C♭, D♭"];
	//@"E♭ Phrygian:"
	}

	if ([messageFromPicker isEqualToString: testStringEPhrygian] == YES)
	{
	label.text = [NSString stringWithFormat:@"E, F, G, A, B, C, D"];
	//@"E Phrygian:"
	}

	if ([messageFromPicker isEqualToString: testStringFPhrygian] == YES)
	{
	label.text = [NSString stringWithFormat:@"F, G♭, A♭, B♭, C, D♭, E♭"];
	//@"F Phrygian:"
	}

	if ([messageFromPicker isEqualToString: testStringFSharpPhrygian] == YES)
	{
	label.text = [NSString stringWithFormat:@"F♯, G, A, B, C♯, D, E"];
	//@"F♯ Phrygian:"
	}

	if ([messageFromPicker isEqualToString: testStringGbPhrygian] == YES)
	{
	label.text = [NSString stringWithFormat:@"G♭, A♭♭, B♭♭, C♭, D♭, E♭♭, F♭"];
	//@"G♭ Phrygian:"
	}

	if ([messageFromPicker isEqualToString: testStringGPhrygian] == YES)
	{
	label.text = [NSString stringWithFormat:@"G, A♭, B♭, C, D, E♭, F"];
	//@"G Phrygian:"
	}

	if ([messageFromPicker isEqualToString: testStringGSharpPhrygian] == YES)
	{
	label.text = [NSString stringWithFormat:@"G♯, A, B, C♯, D♯, E, F♯"];
	//@"G♯ Phrygian:"
	}

	if ([messageFromPicker isEqualToString: testStringAbPhrygian] == YES)
	{
	label.text = [NSString stringWithFormat:@"A♭, B♭♭, C♭, D♭, E♭, F♭, G♭"];
	//@"A♭ Phrygian:"
	}

	if ([messageFromPicker isEqualToString: testStringAPhrygian] == YES)
	{
	label.text = [NSString stringWithFormat:@"A, B♭, C, D, E, F, G"];
	//@"A Phrygian:"
	}

	if ([messageFromPicker isEqualToString: testStringASharpPhrygian] == YES)
	{
	label.text = [NSString stringWithFormat:@"A♯, B, C♯, D♯, E♯, F♯, G♯"];
	//@"A♯ Phrygian:"
	}

	if ([messageFromPicker isEqualToString: testStringBbPhrygian] == YES)
	{
	label.text = [NSString stringWithFormat:@"B♭, C♭, D♭, E♭, F, G♭, A♭"];
	//@"B♭ Phrygian:"
	}

	if ([messageFromPicker isEqualToString: testStringBPhrygian] == YES)
	{
	label.text = [NSString stringWithFormat:@"B, C, D, E, F♯, G, A"];
	//@"B Phrygian:"
	}

	// *********** Lydian ifs **********************

	if ([messageFromPicker isEqualToString: testStringCLydian] == YES)
	{
	label.text = [NSString stringWithFormat:@"C, D, E, F♯, G, A, B"];
	//@"C Lydian:"
	}

	if ([messageFromPicker isEqualToString: testStringCSharpLydian] == YES)
	{
	label.text = [NSString stringWithFormat:@"C♯, D♯, E♯, Fx, G♯, A♯, B♯"];
	//@"C♯ Lydian:"
	}

	if ([messageFromPicker isEqualToString: testStringDbLydian] == YES)
	{
	label.text = [NSString stringWithFormat:@"D♭, E♭, F, G, A♭, B♭, C"];
	//@"D♭ Lydian:"
	}

	if ([messageFromPicker isEqualToString: testStringDLydian] == YES)
	{
	label.text = [NSString stringWithFormat:@"D, E, F♯, G♯, A, B, C♯"];
	//@"D Lydian:"
	}

	if ([messageFromPicker isEqualToString: testStringDSharpLydian] == YES)
	{
	label.text = [NSString stringWithFormat:@"D♯, E♯, Fx, Gx, A♯, B♯, Cx"];
	//@"D♯ Lydian:"
	}

	if ([messageFromPicker isEqualToString: testStringEbLydian] == YES)
	{
	label.text = [NSString stringWithFormat:@"E♭, F, G, A, B♭, C, D"];
	//@"E♭ Lydian:"
	}

	if ([messageFromPicker isEqualToString: testStringELydian] == YES)
	{
	label.text = [NSString stringWithFormat:@"E, F♯, G♯, A♯, B, C♯, D♯"];
	//@"E Lydian:"
	}

	if ([messageFromPicker isEqualToString: testStringFLydian] == YES)
	{
	label.text = [NSString stringWithFormat:@"F, G, A, B, C, D, E"];
	//@"F Lydian:"
	}

	if ([messageFromPicker isEqualToString: testStringFSharpLydian] == YES)
	{
	label.text = [NSString stringWithFormat:@"F♯, G♯, A♯, B♯, C♯, D♯, E♯"];
	//@"F♯ Lydian:"
	}

	if ([messageFromPicker isEqualToString: testStringGbLydian] == YES)
	{
	label.text = [NSString stringWithFormat:@"G♭, A♭, B♭, C, D♭, E♭, F"];
	//@"G♭ Lydian:"
	}

	if ([messageFromPicker isEqualToString: testStringGLydian] == YES)
	{
	label.text = [NSString stringWithFormat:@"G, A, B, C♯, D, E, F♯"];
	//@"G Lydian:"
	}

	if ([messageFromPicker isEqualToString: testStringGSharpLydian] == YES)
	{
	label.text = [NSString stringWithFormat:@"G♯, A♯, B♯, Cx, D♯, E♯, Fx"];
	//@"G♯ Lydian:"
	}

	if ([messageFromPicker isEqualToString: testStringAbLydian] == YES)
	{
	label.text = [NSString stringWithFormat:@"A♭, B♭, C, D, E♭, F, G"];
	//@"A♭ Lydian:"
	}

	if ([messageFromPicker isEqualToString: testStringALydian] == YES)
	{
	label.text = [NSString stringWithFormat:@"A, B, C♯, D♯, E, F♯, G♯"];
	//@"A Lydian:"
	}

	if ([messageFromPicker isEqualToString: testStringASharpLydian] == YES)
	{
	label.text = [NSString stringWithFormat:@"A♯, B♯, Cx, Dx, E♯, Fx, Gx"];
	//@"A♯ Lydian:"
	}

	if ([messageFromPicker isEqualToString: testStringBbLydian] == YES)
	{
	label.text = [NSString stringWithFormat:@"B♭, C, D, E, F, G, A"];
	//@"B♭ Lydian:"
	}

	if ([messageFromPicker isEqualToString: testStringBLydian] == YES)
	{
	label.text = [NSString stringWithFormat:@"B, C♯, D♯, E♯, F♯, G♯, A♯"];
	//@"B Lydian:"
	}

	// ********************************************************

	// *********** Mixolydian ifs **********************

	if ([messageFromPicker isEqualToString: testStringCMixolydian] == YES)
	{
	label.text = [NSString stringWithFormat:@"C, D, E, F, G, A, B♭"];
	//@"C Mixolydian:"
	}

	if ([messageFromPicker isEqualToString: testStringCSharpMixolydian] == YES)
	{
	label.text = [NSString stringWithFormat:@"C♯, D♯, E♯, F♯, G♯, A♯, B"];
	//@"C♯ Mixolydian:"
	}

	if ([messageFromPicker isEqualToString: testStringDbMixolydian] == YES)
	{
	label.text = [NSString stringWithFormat:@"D♭, E♭, F, G♭, A♭, B♭, C♭"];
	//@"D♭ Mixolydian:"
	}

	if ([messageFromPicker isEqualToString: testStringDMixolydian] == YES)
	{
	label.text = [NSString stringWithFormat:@"D, E, F♯, G, A, B, C"];
	//@"D Mixolydian:"
	}

	if ([messageFromPicker isEqualToString: testStringDSharpMixolydian] == YES)
	{
	label.text = [NSString stringWithFormat:@"D♯, E♯, Fx, G♯, A♯, B♯, C♯"];
	//@"D♯ Mixolydian:"
	}

	if ([messageFromPicker isEqualToString: testStringEbMixolydian] == YES)
	{
	label.text = [NSString stringWithFormat:@"E♭, F, G, A♭, B♭, C, D♭"];
	//@"E♭ Mixolydian:"
	}

	if ([messageFromPicker isEqualToString: testStringEMixolydian] == YES)
	{
	label.text = [NSString stringWithFormat:@"E, F♯, G♯, A, B, C♯, D"];
	//@"E Mixolydian:"
	}

	if ([messageFromPicker isEqualToString: testStringFMixolydian] == YES)
	{
	label.text = [NSString stringWithFormat:@"F, G, A, B♭, C, D, E♭"];
	//@"F Mixolydian:"
	}

	if ([messageFromPicker isEqualToString: testStringFSharpMixolydian] == YES)
	{
	label.text = [NSString stringWithFormat:@"F♯, G♯, A♯, B, C♯, D♯, E"];
	//@"F♯ Mixolydian:"
	}

	if ([messageFromPicker isEqualToString: testStringGbMixolydian] == YES)
	{
	label.text = [NSString stringWithFormat:@"G♭, A♭, B♭, C♭, D♭, E♭, F♭"];
	//@"G♭ Mixolydian:"
	}

	if ([messageFromPicker isEqualToString: testStringGMixolydian] == YES)
	{
	label.text = [NSString stringWithFormat:@"G, A, B, C, D, E, F"];
	//@"G Mixolydian:"
	}

	if ([messageFromPicker isEqualToString: testStringGSharpMixolydian] == YES)
	{
	label.text = [NSString stringWithFormat:@"G♯, A♯, B♯, C♯, D♯, E♯, F♯"];
	//@"G♯ Mixolydian:"
	}

	if ([messageFromPicker isEqualToString: testStringAbMixolydian] == YES)
	{
	label.text = [NSString stringWithFormat:@"A♭, B♭, C, D♭, E♭, F, G♭"];
	//@"A♭ Mixolydian:"
	}

	if ([messageFromPicker isEqualToString: testStringAMixolydian] == YES)
	{
	label.text = [NSString stringWithFormat:@"A, B, C♯, D, E, F♯, G"];
	//@"A Mixolydian:"
	}

	if ([messageFromPicker isEqualToString: testStringASharpMixolydian] == YES)
	{
	label.text = [NSString stringWithFormat:@"A♯, B♯, Cx, D♯, E♯, Fx, G♯"];
	//@"A♯ Mixolydian:"
	}

	if ([messageFromPicker isEqualToString: testStringBbMixolydian] == YES)
	{
	label.text = [NSString stringWithFormat:@"B♭, C, D, E♭, F, G, A♭"];
	//@"B♭ Mixolydian:"
	}

	if ([messageFromPicker isEqualToString: testStringBMixolydian] == YES)
	{
	label.text = [NSString stringWithFormat:@"B, C♯, D♯, E, F♯, G♯, A"];
	//@"B Mixolydian:"
	}

	// *********** Aeolian ifs **********************

	if ([messageFromPicker isEqualToString: testStringCAeolian] == YES)
	{
	label.text = [NSString stringWithFormat:@"C, D, E♭, F, G, A♭, B♭"];
	//@"C Aeolian:"
	}

	if ([messageFromPicker isEqualToString: testStringCSharpAeolian] == YES)
	{
	label.text = [NSString stringWithFormat:@"C♯, D♯, E, F♯, G♯, A, B"];
	//@"C♯ Aeolian:"
	}

	if ([messageFromPicker isEqualToString: testStringDbAeolian] == YES)
	{
	label.text = [NSString stringWithFormat:@"D♭, E♭, F♭, G♭, A♭, B♭♭, C♭"];
	//@"D♭ Aeolian:"
	}

	if ([messageFromPicker isEqualToString: testStringDAeolian] == YES)
	{
	label.text = [NSString stringWithFormat:@"D, E, F, G, A, B♭, C"];
	//@"D Aeolian:"
	}

	if ([messageFromPicker isEqualToString: testStringDSharpAeolian] == YES)
	{
	label.text = [NSString stringWithFormat:@"D♯, E♯, F♯, G♯, A♯, B, C♯"];
	//@"D♯ Aeolian:"
	}

	if ([messageFromPicker isEqualToString: testStringEbAeolian] == YES)
	{
	label.text = [NSString stringWithFormat:@"E♭, F, G♭, A♭, B♭, C♭, D♭"];
	//@"E♭ Aeolian:"
	}

	if ([messageFromPicker isEqualToString: testStringEAeolian] == YES)
	{
	label.text = [NSString stringWithFormat:@"E, F♯, G, A, B, C, D"];
	//@"E Aeolian:"
	}

	if ([messageFromPicker isEqualToString: testStringFAeolian] == YES)
	{
	label.text = [NSString stringWithFormat:@"F, G, A♭, B♭, C, D♭, E♭"];
	//@"F Aeolian:"
	}

	if ([messageFromPicker isEqualToString: testStringFSharpAeolian] == YES)
	{
	label.text = [NSString stringWithFormat:@"F♯, G♯, A, B, C♯, D, E"];
	//@"F♯ Aeolian:"
	}

	if ([messageFromPicker isEqualToString: testStringGbAeolian] == YES)
	{
	label.text = [NSString stringWithFormat:@"G♭, A♭, B♭♭, C♭, D♭, E♭♭, F♭"];
	//@"G♭ Aeolian:"
	}

	if ([messageFromPicker isEqualToString: testStringGAeolian] == YES)
	{
	label.text = [NSString stringWithFormat:@"G, A, B♭, C, D, E♭, F"];
	//@"G Aeolian:"
	}

	if ([messageFromPicker isEqualToString: testStringGSharpAeolian] == YES)
	{
	label.text = [NSString stringWithFormat:@"G♯, A♯, B, C♯, D♯, E, F♯"];
	//@"G♯ Aeolian:"
	}

	if ([messageFromPicker isEqualToString: testStringAbAeolian] == YES)
	{
	label.text = [NSString stringWithFormat:@"A♭, B♭, C♭, D♭, E♭, F♭, G♭"];
	//@"A♭ Aeolian:"
	}

	if ([messageFromPicker isEqualToString: testStringAAeolian] == YES)
	{
	label.text = [NSString stringWithFormat:@"A, B, C, D, E, F, G"];
	//@"A Aeolian:"
	}

	if ([messageFromPicker isEqualToString: testStringASharpAeolian] == YES)
	{
	label.text = [NSString stringWithFormat:@"A♯, B♯, C♯, D♯, E♯, F♯, G♯"];
	//@"A♯ Aeolian:"
	}

	if ([messageFromPicker isEqualToString: testStringBbAeolian] == YES)
	{
	label.text = [NSString stringWithFormat:@"B♭, C, D♭, E♭, F, G♭, A♭"];
	//@"B♭ Aeolian:"
	}

	if ([messageFromPicker isEqualToString: testStringBAeolian] == YES)
	{
	label.text = [NSString stringWithFormat:@"B, C♯, D, E, F♯, G, A"];
	//@"B Aeolian:"
	}

	// *********** Locrian ifs **********************

	if ([messageFromPicker isEqualToString: testStringCLocrian] == YES)
	{
	label.text = [NSString stringWithFormat:@"C, D♭, E♭, F, G♭, A♭, B♭"];
	//@"C Locrian:"
	}

	if ([messageFromPicker isEqualToString: testStringCSharpLocrian] == YES)
	{
	label.text = [NSString stringWithFormat:@"C♯, D, E, F♯, G, A, B"];
	//@"C♯ Locrian:"
	}

	if ([messageFromPicker isEqualToString: testStringDbLocrian] == YES)
	{
	label.text = [NSString stringWithFormat:@"D♭, E♭♭, F♭, G♭, A♭♭, B♭♭, C♭"];
	//@"D♭ Locrian:"
	}

	if ([messageFromPicker isEqualToString: testStringDLocrian] == YES)
	{
	label.text = [NSString stringWithFormat:@"D, E♭, F, G, A♭, B♭, C"];
	//@"D Locrian:"
	}

	if ([messageFromPicker isEqualToString: testStringDSharpLocrian] == YES)
	{
	label.text = [NSString stringWithFormat:@"D♯, E, F♯, G♯, A, B, C♯"];
	//@"D♯ Locrian:"
	}

	if ([messageFromPicker isEqualToString: testStringEbLocrian] == YES)
	{
	label.text = [NSString stringWithFormat:@"E♭, F♭, G♭, A♭, B♭♭, C♭, D♭"];
	//@"E♭ Locrian:"
	}

	if ([messageFromPicker isEqualToString: testStringELocrian] == YES)
	{
	label.text = [NSString stringWithFormat:@"E, F, G, A, B♭, C, D"];
	//@"E Locrian:"
	}

	if ([messageFromPicker isEqualToString: testStringFLocrian] == YES)
	{
	label.text = [NSString stringWithFormat:@"F, G♭, A♭, B♭, C♭, D♭, E♭"];
	//@"F Locrian:"
	}

	if ([messageFromPicker isEqualToString: testStringFSharpLocrian] == YES)
	{
	label.text = [NSString stringWithFormat:@"F♯, G, A, B, C, D, E"];
	//@"F♯ Locrian:"
	}

	if ([messageFromPicker isEqualToString: testStringGbLocrian] == YES)
	{
	label.text = [NSString stringWithFormat:@"G♭, A♭♭, B♭♭, C♭, D♭♭, E♭♭, F♭"];
	//@"G♭ Locrian:"
	}

	if ([messageFromPicker isEqualToString: testStringGLocrian] == YES)
	{
	label.text = [NSString stringWithFormat:@"G, A♭, B♭, C, D♭, E♭, F"];
	//@"G Locrian:"
	}

	if ([messageFromPicker isEqualToString: testStringGSharpLocrian] == YES)
	{
	label.text = [NSString stringWithFormat:@"G♯, A, B, C♯, D, E, F♯"];
	//@"G♯ Locrian:"
	}

	if ([messageFromPicker isEqualToString: testStringAbLocrian] == YES)
	{
	label.text = [NSString stringWithFormat:@"A♭, B♭♭, C♭, D♭, E♭♭, F♭, G♭"];
	//@"A♭ Locrian:"
	}

	if ([messageFromPicker isEqualToString: testStringALocrian] == YES)
	{
	label.text = [NSString stringWithFormat:@"A, B♭, C, D, E♭, F, G"];
	//@"A Locrian:"
	}

	if ([messageFromPicker isEqualToString: testStringASharpLocrian] == YES)
	{
	label.text = [NSString stringWithFormat:@"A♯, B, C♯, D♯, E, F♯, G♯"];
	//@"A♯ Locrian:"
	}

	if ([messageFromPicker isEqualToString: testStringBbLocrian] == YES)
	{
	label.text = [NSString stringWithFormat:@"B♭, C♭, D♭, E♭, F♭, G♭, A♭"];
	//@"B♭ Locrian:"
	}

	if ([messageFromPicker isEqualToString: testStringBLocrian] == YES)
	{
	label.text = [NSString stringWithFormat:@"B, C, D, E, F, G, B"];
	//@"B Locrian:"
	}

	// *********** WholeTone ifs **********************

	if ([messageFromPicker isEqualToString: testStringCWholeTone] == YES)
	{
	label.text = [NSString stringWithFormat:@"C, D, E, F♯, G♯, A♯"];
	//@"C Whole Tone:"
	}

	if ([messageFromPicker isEqualToString: testStringCSharpWholeTone] == YES)
	{
	label.text = [NSString stringWithFormat:@"C♯, D♯, E♯, Fx, Gx, Ax"];
	//@"C♯ Whole Tone:"
	}

	if ([messageFromPicker isEqualToString: testStringDbWholeTone] == YES)
	{
	label.text = [NSString stringWithFormat:@"D♭, E♭, F, G, A, B"];
	//@"D♭ Whole Tone:"
	}

	if ([messageFromPicker isEqualToString: testStringDWholeTone] == YES)
	{
	label.text = [NSString stringWithFormat:@"D, E, F♯, G♯, A♯, B♯"];
	//@"D Whole Tone:"
	}

	if ([messageFromPicker isEqualToString: testStringDSharpWholeTone] == YES)
	{
	label.text = [NSString stringWithFormat:@"D♯, E♯, Fx, Gx, Ax, Bx"];
	//@"D♯ Whole Tone:"
	}

	if ([messageFromPicker isEqualToString: testStringEbWholeTone] == YES)
	{
	label.text = [NSString stringWithFormat:@"E♭, F, G, A, B, C♯"];
	//@"E♭ Whole Tone:"
	}

	if ([messageFromPicker isEqualToString: testStringEWholeTone] == YES)
	{
	label.text = [NSString stringWithFormat:@"E, F♯, G♯, A♯, B♯, Cx"];
	//@"E Whole Tone:"
	}

	if ([messageFromPicker isEqualToString: testStringFWholeTone] == YES)
	{
	label.text = [NSString stringWithFormat:@"F, G, A, B, C♯, D♯"];
	//@"F Whole Tone:"
	}

	if ([messageFromPicker isEqualToString: testStringFSharpWholeTone] == YES)
	{
	label.text = [NSString stringWithFormat:@"F♯, G♯, A♯, B♯, Cx, Dx"];
	//@"F♯ Whole Tone:"
	}

	if ([messageFromPicker isEqualToString: testStringGbWholeTone] == YES)
	{
	label.text = [NSString stringWithFormat:@"G♭, A♭, B♭, C, D, E"];
	//@"G♭ Whole Tone:"
	}

	if ([messageFromPicker isEqualToString: testStringGWholeTone] == YES)
	{
	label.text = [NSString stringWithFormat:@"G, A, B, C♯, D♯, E♯"];
	//@"G Whole Tone:"
	}

	if ([messageFromPicker isEqualToString: testStringGSharpWholeTone] == YES)
	{
	label.text = [NSString stringWithFormat:@"G♯, A♯, B♯, Cx, Dx, Ex"];
	//@"G♯ Whole Tone:"
	}

	if ([messageFromPicker isEqualToString: testStringAbWholeTone] == YES)
	{
	label.text = [NSString stringWithFormat:@"A♭, B♭, C, D, E, F♯"];
	//@"A♭ Whole Tone:"
	}

	if ([messageFromPicker isEqualToString: testStringAWholeTone] == YES)
	{
	label.text = [NSString stringWithFormat:@"A, B, C♯, D♯, E♯, Fx"];
	//@"A Whole Tone:"
	}

	if ([messageFromPicker isEqualToString: testStringASharpWholeTone] == YES)
	{
	label.text = [NSString stringWithFormat:@"A♯, B♯, Cx, Dx, Ex, F♯x"];
	//@"A♯ Whole Tone:"
	}

	if ([messageFromPicker isEqualToString: testStringBbWholeTone] == YES)
	{
	label.text = [NSString stringWithFormat:@"B♭, C, D, E, F♯, G♯"];
	//@"B♭ Whole Tone:"
	}

	if ([messageFromPicker isEqualToString: testStringBWholeTone] == YES)
	{
	label.text = [NSString stringWithFormat:@"B, C♯, D♯, E♯, Fx, Gx"];
	//@"B Whole Tone:"
	}
	
	// *********** ChromaticScale ifs **********************
	
	if ([messageFromPicker isEqualToString: testStringCChromaticScale] == YES)
	{
		label.text = [NSString stringWithFormat:@"C, C♯, D, D♯, E, F, F♯, G, G♯, A, A♯, B"];
		//@"C Chromatic:"
	}
	
	if ([messageFromPicker isEqualToString: testStringCSharpChromaticScale] == YES)
	{
		label.text = [NSString stringWithFormat:@"C♯, D, D♯, E, F, F♯, G, G♯, A, A♯, B, C"];
		//@"C♯ Chromatic:"
	}
	
	if ([messageFromPicker isEqualToString: testStringDbChromaticScale] == YES)
	{
		label.text = [NSString stringWithFormat:@"D♭, D, E♭, E, F, G♭, G, A♭, A, B♭, B, C"];
		//@"D♭ Chromatic:"
	}
	
	if ([messageFromPicker isEqualToString: testStringDChromaticScale] == YES)
	{
		label.text = [NSString stringWithFormat:@"D, D♯, E, F, F♯, G, G♯, A, A♯, B, C, C♯"];
		//@"D Chromatic:"
	}
	
	if ([messageFromPicker isEqualToString: testStringDSharpChromaticScale] == YES)
	{
		label.text = [NSString stringWithFormat:@"D♯, E, F, F♯, G, G♯, A, A♯, B, C, C♯, D"];
		//@"D♯ Chromatic:"
	}
	
	if ([messageFromPicker isEqualToString: testStringEbChromaticScale] == YES)
	{
		label.text = [NSString stringWithFormat:@"E♭, E, F, G♭, G, A♭, A, B♭, B, C, D♭, D"];
		//@"E♭ Chromatic:"
	}
	
	if ([messageFromPicker isEqualToString: testStringEChromaticScale] == YES)
	{
		label.text = [NSString stringWithFormat:@"E, F, F♯, G, G♯, A, A♯, B, C, C♯, D, D♯"];
		//@"E Chromatic:"
	}
	
	if ([messageFromPicker isEqualToString: testStringFChromaticScale] == YES)
	{
		label.text = [NSString stringWithFormat:@"F, G♭, G, A♭, A, B♭, B, C, D♭, D, E♭, E"];
		//@"F Chromatic:"
	}//m2, M3 from root, dim5 from root, M2, M2, m2
	
	if ([messageFromPicker isEqualToString: testStringFSharpChromaticScale] == YES)
	{
		label.text = [NSString stringWithFormat:@"F♯, G, G♯, A, A♯, B, C, C♯, D, D♯, E, F"];
		//@"F♯ Chromatic:"
	}
	
	if ([messageFromPicker isEqualToString: testStringGbChromaticScale] == YES)
	{
		label.text = [NSString stringWithFormat:@"G♭, G, A♭, A, B♭, B, C, D♭, D, E♭, E, F"];
		//@"G♭ Chromatic:"
	}
	
	if ([messageFromPicker isEqualToString: testStringGChromaticScale] == YES)
	{
		label.text = [NSString stringWithFormat:@"G, G♯, A, A♯, B, C, C♯, D, D♯, E, F, F♯"];
		//@"G Chromatic:"
	}
	
	if ([messageFromPicker isEqualToString: testStringGSharpChromaticScale] == YES)
	{
		label.text = [NSString stringWithFormat:@"G♯, A, A♯, B, C, C♯, D, D♯, E, F, F♯, G"];
		//@"G♯ Chromatic:"
	}
	
	if ([messageFromPicker isEqualToString: testStringAbChromaticScale] == YES)
	{
		label.text = [NSString stringWithFormat:@"A♭, A, B♭, B, C, D♭, D, E♭, E, F, G♭, G"];
		//@"A♭ Chromatic:"
	}
	
	if ([messageFromPicker isEqualToString: testStringAChromaticScale] == YES)
	{
		label.text = [NSString stringWithFormat:@"A, A♯, B, C, C♯, D, D♯, E, F, F♯, G, G♯"];
		//@"A Chromatic:"
	}
	
	if ([messageFromPicker isEqualToString: testStringASharpChromaticScale] == YES)
	{
		label.text = [NSString stringWithFormat:@"A♯, B, C, C♯, D, D♯, E, F, F♯, G, G♯, A"];
		//@"A♯ Chromatic:"
	}
	
	if ([messageFromPicker isEqualToString: testStringBbChromaticScale] == YES)
	{
		label.text = [NSString stringWithFormat:@"B♭, B, C, D♭, D, E♭, E, F, G♭, G, A♭, A"];
		//@"B♭ Chromatic:"
	}
	
	if ([messageFromPicker isEqualToString: testStringBChromaticScale] == YES)
	{
		label.text = [NSString stringWithFormat:@"B, C, C♯, D, D♯, E, F, F♯, G, G♯, A, A♯"];
		//@"B Chromatic:"
	}	

	// *********** Pentatonic ifs **********************

	if ([messageFromPicker isEqualToString: testStringCPentatonic] == YES)
	{
	label.text = [NSString stringWithFormat:@"C, D, E, G, A"];
	//@"C Pentatonic:"
	}

	if ([messageFromPicker isEqualToString: testStringCSharpPentatonic] == YES)
	{
	label.text = [NSString stringWithFormat:@"C♯, D♯, E♯, G♯, A♯"];
	//@"C♯ Pentatonic:"
	}

	if ([messageFromPicker isEqualToString: testStringDbPentatonic] == YES)
	{
	label.text = [NSString stringWithFormat:@"D♭, E♭, F, A♭, B♭"];
	//@"D♭ Pentatonic:"
	}

	if ([messageFromPicker isEqualToString: testStringDPentatonic] == YES)
	{
	label.text = [NSString stringWithFormat:@"D, E, F♯, A, B"];
	//@"D Pentatonic:"
	}

	if ([messageFromPicker isEqualToString: testStringDSharpPentatonic] == YES)
	{
	label.text = [NSString stringWithFormat:@"D♯, E♯, Fx, A♯, B♯"];
	//@"D♯ Pentatonic:"
	}

	if ([messageFromPicker isEqualToString: testStringEbPentatonic] == YES)
	{
	label.text = [NSString stringWithFormat:@"E♭, F, G, B♭, C"];
	//@"E♭ Pentatonic:"
	}

	if ([messageFromPicker isEqualToString: testStringEPentatonic] == YES)
	{
	label.text = [NSString stringWithFormat:@"E, F♯, G♯, B, C♯"];
	//@"E Pentatonic:"
	}

	if ([messageFromPicker isEqualToString: testStringFPentatonic] == YES)
	{
	label.text = [NSString stringWithFormat:@"F, G, A, C, D"];
	//@"F Pentatonic:"
	}

	if ([messageFromPicker isEqualToString: testStringFSharpPentatonic] == YES)
	{
	label.text = [NSString stringWithFormat:@"F♯, G♯, A♯, C♯, D♯"];
	//@"F♯ Pentatonic:"
	}

	if ([messageFromPicker isEqualToString: testStringGbPentatonic] == YES)
	{
	label.text = [NSString stringWithFormat:@"G♭, A♭, B♭, D♭, E♭"];
	//@"G♭ Pentatonic:"
	}

	if ([messageFromPicker isEqualToString: testStringGPentatonic] == YES)
	{
	label.text = [NSString stringWithFormat:@"G, A, B, D, E"];
	//@"G Pentatonic:"
	}

	if ([messageFromPicker isEqualToString: testStringGSharpPentatonic] == YES)
	{
	label.text = [NSString stringWithFormat:@"G♯, A♯, B♯, D♯, E♯"];
	//@"G♯ Pentatonic:"
	}

	if ([messageFromPicker isEqualToString: testStringAbPentatonic] == YES)
	{
	label.text = [NSString stringWithFormat:@"A♭, B♭, C, E♭, F"];
	//@"A♭ Pentatonic:"
	}

	if ([messageFromPicker isEqualToString: testStringAPentatonic] == YES)
	{
	label.text = [NSString stringWithFormat:@"A, B, C♯, E, F♯"];
	//@"A Pentatonic:"
	}

	if ([messageFromPicker isEqualToString: testStringASharpPentatonic] == YES)
	{
	label.text = [NSString stringWithFormat:@"A♯, B♯, Cx, E♯, Fx"];
	//@"A♯ Pentatonic:"
	}

	if ([messageFromPicker isEqualToString: testStringBbPentatonic] == YES)
	{
	label.text = [NSString stringWithFormat:@"B♭, C, D F, G"];
	//@"B♭ Pentatonic:"
	}

	if ([messageFromPicker isEqualToString: testStringBPentatonic] == YES)
	{
	label.text = [NSString stringWithFormat:@"B, C♯, D♯, F♯, G♯"];
	//@"B Pentatonic:"
	}
	
	// *********** BluesScale ifs **********************
	
	if ([messageFromPicker isEqualToString: testStringCBluesScale] == YES)
	{
		label.text = [NSString stringWithFormat:@"C, E♭, F, G♭, G, B♭"];
		//@"C Blues:"
	}
	
	if ([messageFromPicker isEqualToString: testStringCSharpBluesScale] == YES)
	{
		label.text = [NSString stringWithFormat:@"C♯, E, F♯, G, G♯, B"];
		//@"C♯ Blues:"
	}
	
	if ([messageFromPicker isEqualToString: testStringDbBluesScale] == YES)
	{
		label.text = [NSString stringWithFormat:@"D♭, E, G♭, G, A♭, B"];
		//@"D♭ Blues:"
	}
	
	if ([messageFromPicker isEqualToString: testStringDBluesScale] == YES)
	{
		label.text = [NSString stringWithFormat:@"D, F, G, A♭, A, C"];
		//@"D Blues:"
	}
	
	if ([messageFromPicker isEqualToString: testStringDSharpBluesScale] == YES)
	{
		label.text = [NSString stringWithFormat:@"D♯, F♯, G♯, A, A♯, C♯"];
		//@"D♯ Blues:"
	}
	
	if ([messageFromPicker isEqualToString: testStringEbBluesScale] == YES)
	{
		label.text = [NSString stringWithFormat:@"E♭, G♭, A♭, A, B♭, D♭"];
		//@"E♭ Blues:"
	}
	
	if ([messageFromPicker isEqualToString: testStringEBluesScale] == YES)
	{
		label.text = [NSString stringWithFormat:@"E, G, A, B♭, B, D"];
		//@"E Blues:"
	}
	
	if ([messageFromPicker isEqualToString: testStringFBluesScale] == YES)
	{
		label.text = [NSString stringWithFormat:@"F, A♭, B♭, B, C, E♭"];
		//@"F Blues:"
	}
	
	if ([messageFromPicker isEqualToString: testStringFSharpBluesScale] == YES)
	{
		label.text = [NSString stringWithFormat:@"F♯, A, B, C, C♯, E"];
		//@"F♯ Blues:"
	}
	
	if ([messageFromPicker isEqualToString: testStringGbBluesScale] == YES)
	{
		label.text = [NSString stringWithFormat:@"G♭, A, B, C, D♭, E"];
		//@"G♭ Blues:"
	}
	
	if ([messageFromPicker isEqualToString: testStringGBluesScale] == YES)
	{
		label.text = [NSString stringWithFormat:@"G, B♭, C, D♭, D, F"];
		//@"G Blues:"
	}
	
	if ([messageFromPicker isEqualToString: testStringGSharpBluesScale] == YES)
	{
		label.text = [NSString stringWithFormat:@"G♯, B, C♯, D, D♯, F♯"];
		//@"G♯ Blues:"
	}
	
	if ([messageFromPicker isEqualToString: testStringAbBluesScale] == YES)
	{
		label.text = [NSString stringWithFormat:@"A♭, B, D♭, D, E♭, G♭"];
		//@"A♭ Blues:"
	}
	
	if ([messageFromPicker isEqualToString: testStringABluesScale] == YES)
	{
		label.text = [NSString stringWithFormat:@"A, C, D, E♭, E, G"];
		//@"A Blues:"
	}
	
	if ([messageFromPicker isEqualToString: testStringASharpBluesScale] == YES)
	{
		label.text = [NSString stringWithFormat:@"A♯, C♯, D♯, E, E♯, G♯"];
		//@"A♯ Blues:"
	}
	
	if ([messageFromPicker isEqualToString: testStringBbBluesScale] == YES)
	{
		label.text = [NSString stringWithFormat:@"B♭, D♭, E♭, E, F, A♭"];
		//@"B♭ Blues:"
	}
	
	if ([messageFromPicker isEqualToString: testStringBBluesScale] == YES)
	{
		label.text = [NSString stringWithFormat:@"B, D, E, F, F♯, A"];
		//@"B Blues:"
	}	
	
	// *********** DiminishedScale ifs **********************
	
	if ([messageFromPicker isEqualToString: testStringCDiminishedScale] == YES)
	{
		label.text = [NSString stringWithFormat:@"C, D, E♭, F, G♭, G♯, A, B"];
		//@"C Diminished:"
	}
	
	if ([messageFromPicker isEqualToString: testStringCSharpDiminishedScale] == YES)
	{
		label.text = [NSString stringWithFormat:@"C♯, D♯, E, F♯, G, A, A♯, B♯"];
		//@"C♯ Diminished:"
	}
	
	if ([messageFromPicker isEqualToString: testStringDbDiminishedScale] == YES)
	{
		label.text = [NSString stringWithFormat:@"D♭, E♭, F♭, G♭, G, A, B♭, C"];
		//@"D♭ Diminished:"
	}
	
	if ([messageFromPicker isEqualToString: testStringDDiminishedScale] == YES)
	{
		label.text = [NSString stringWithFormat:@"D, E, F, G, A♭, A♯, B, C♯"];
		//@"D Diminished:"
	}
	
	if ([messageFromPicker isEqualToString: testStringDSharpDiminishedScale] == YES)
	{
		label.text = [NSString stringWithFormat:@"D♯, E♯, F♯, G♯, A, B, C, D"];
		//@"D♯ Diminished:"
	}
	
	if ([messageFromPicker isEqualToString: testStringEbDiminishedScale] == YES)
	{
		label.text = [NSString stringWithFormat:@"E♭, F, G♭, A♭, B♭♭, C♭, C, D"];
		//@"E♭ Diminished:"
	}
	
	if ([messageFromPicker isEqualToString: testStringEDiminishedScale] == YES)
	{
		label.text = [NSString stringWithFormat:@"E, F♯, G, A, B♭, C, C♯, D♯"];
		//@"E Diminished:"
	}
	
	if ([messageFromPicker isEqualToString: testStringFDiminishedScale] == YES)
	{
		label.text = [NSString stringWithFormat:@"F, G, A♭, B♭, C♭, C♯, D, E"];
		//@"F Diminished:"
	}
	
	if ([messageFromPicker isEqualToString: testStringFSharpDiminishedScale] == YES)
	{
		label.text = [NSString stringWithFormat:@"F♯, G♯, A, B, C, D, D♯, E♯"];
		//@"F♯ Diminished:"
	}
	
	if ([messageFromPicker isEqualToString: testStringGbDiminishedScale] == YES)
	{
		label.text = [NSString stringWithFormat:@"G♭, A♭, A, B, C, D, E♭, F"];
		//@"G♭ Diminished:"
	}
	
	if ([messageFromPicker isEqualToString: testStringGDiminishedScale] == YES)
	{
		label.text = [NSString stringWithFormat:@"G, A, B♭, C, D♭, D♯, E, F♯"];
		//@"G Diminished:"
	}
	
	if ([messageFromPicker isEqualToString: testStringGSharpDiminishedScale] == YES)
	{
		label.text = [NSString stringWithFormat:@"G♯, A♯, B, C♯, D, E, F, G"];
		//@"G♯ Diminished:"
	}
	
	if ([messageFromPicker isEqualToString: testStringAbDiminishedScale] == YES)
	{
		label.text = [NSString stringWithFormat:@"A♭, B♭, C♭, D♭, D, E, F, G"];
		//@"A♭ Diminished:"
	}
	
	if ([messageFromPicker isEqualToString: testStringADiminishedScale] == YES)
	{
		label.text = [NSString stringWithFormat:@"A, B, C, D, E♭, F, G♭, G♯"];
		//@"A Diminished:"
	}
	
	if ([messageFromPicker isEqualToString: testStringASharpDiminishedScale] == YES)
	{
		label.text = [NSString stringWithFormat:@"A♯, B♯, C♯, D♯, E, F♯, G, A"];
		//@"A♯ Diminished:"
	}
	
	if ([messageFromPicker isEqualToString: testStringBbDiminishedScale] == YES)
	{
		label.text = [NSString stringWithFormat:@"B♭, C, D♭, E♭, E, F♯, G, A"];
		//@"B♭ Diminished:"
	}
	
	if ([messageFromPicker isEqualToString: testStringBDiminishedScale] == YES)
	{
		label.text = [NSString stringWithFormat:@"B, C♯, D, E, F, G, G♯, A♯"];
		//@"B Diminished:"
	}
	
	// *********** OctatonicScale ifs **********************
	
	if ([messageFromPicker isEqualToString: testStringCOctatonicScale] == YES)
	{
		label.text = [NSString stringWithFormat:@"C, D♭, E♭, E, F♯, G, A, B♭"];
		//@"C Octatonic:"
	}
	
	if ([messageFromPicker isEqualToString: testStringCSharpOctatonicScale] == YES)
	{
		label.text = [NSString stringWithFormat:@"C, C♯, D♯, E, F♯, G, A, A♯"];
		//@"C♯ Octatonic:"
	}
	
	if ([messageFromPicker isEqualToString: testStringDbOctatonicScale] == YES)
	{
		label.text = [NSString stringWithFormat:@"D♭, D, E, F, G, G♯, A♯, B"];
		//@"D♭ Octatonic:"
	}
	
	if ([messageFromPicker isEqualToString: testStringDOctatonicScale] == YES)
	{
		label.text = [NSString stringWithFormat:@"D, E♭, F, G♭, G♯, A, B, C"];
		//@"D Octatonic:"
	}
	
	if ([messageFromPicker isEqualToString: testStringDSharpOctatonicScale] == YES)
	{
		label.text = [NSString stringWithFormat:@"D♯, E, F♯, G, A, A♯, B♯, C♯"];
		//@"D♯ Octatonic:"
	}
	
	if ([messageFromPicker isEqualToString: testStringEbOctatonicScale] == YES)
	{
		label.text = [NSString stringWithFormat:@"E♭, F♭, G♭, G, A, B♭, C, D♭"];
		//@"E♭ Octatonic:"
	}
	
	if ([messageFromPicker isEqualToString: testStringEOctatonicScale] == YES)
	{
		label.text = [NSString stringWithFormat:@"E, F, G, A♭, A♯, B, C♯, D"];
		//@"E Octatonic:"
	}
	
	if ([messageFromPicker isEqualToString: testStringFOctatonicScale] == YES)
	{
		label.text = [NSString stringWithFormat:@"F, G♭, A♭, B♭♭, C♭, C, D, E♭"];
		//@"F Octatonic:"
	}
	
	if ([messageFromPicker isEqualToString: testStringFSharpOctatonicScale] == YES)
	{
		label.text = [NSString stringWithFormat:@"F♯, G, A, A♯, C, D♭, E♭, E"];
		//@"F♯ Octatonic:"
	}
	
	if ([messageFromPicker isEqualToString: testStringGbOctatonicScale] == YES)
	{
		label.text = [NSString stringWithFormat:@"G♭, G, A, B♭, C, D♭, E♭, E"];
		//@"G♭ Octatonic:"
	}
	
	if ([messageFromPicker isEqualToString: testStringGOctatonicScale] == YES)
	{
		label.text = [NSString stringWithFormat:@"G, A♭, B♭, C♭, C♯, D, E, F"];
		//@"G Octatonic:"
	}
	
	if ([messageFromPicker isEqualToString: testStringGSharpOctatonicScale] == YES)
	{
		label.text = [NSString stringWithFormat:@"G♯, A, B, C, D, D♯, E♯, F♯"];
		//@"F♯ Octatonic:"
	}
	
	if ([messageFromPicker isEqualToString: testStringAbOctatonicScale] == YES)
	{
		label.text = [NSString stringWithFormat:@"A♭, A, B, C, D, E♭, F, G♭"];
		//@"A♭ Octatonic:"
	}
	
	if ([messageFromPicker isEqualToString: testStringAOctatonicScale] == YES)
	{
		label.text = [NSString stringWithFormat:@"A, B♭, C, D♭, D♯, E, F♯, G"];
		//@"A Octatonic:"
	}
	
	if ([messageFromPicker isEqualToString: testStringASharpOctatonicScale] == YES)
	{
		label.text = [NSString stringWithFormat:@"A♯, B, C♯, D, E, F, G, G♯"];
		//@"A♯ Octatonic:"
	}
	
	if ([messageFromPicker isEqualToString: testStringBbOctatonicScale] == YES)
	{
		label.text = [NSString stringWithFormat:@"B♭, C♭, D♭, D, E, F, G, A♭"];
		//@"B♭ Octatonic:"
	}
	
	if ([messageFromPicker isEqualToString: testStringBOctatonicScale] == YES)
	{
		label.text = [NSString stringWithFormat:@"B, C, D, E♭, F, G♭, G♯, A"];
		//@"B Octatonic:"
	}

	// *********** EnigmaticScale ifs **********************
	
	if ([messageFromPicker isEqualToString: testStringCEnigmaticScale] == YES)
	{
		label.text = [NSString stringWithFormat:@"C, D♭, E, G♭, A♭, B♭, B"];
		//@"C Enigmatic:"
	}
	
	if ([messageFromPicker isEqualToString: testStringCSharpEnigmaticScale] == YES)
	{
		label.text = [NSString stringWithFormat:@"C♯, D, E♯, G, A, B, B♯"];
		//@"C♯ Enigmatic:"
	}
	
	if ([messageFromPicker isEqualToString: testStringDbEnigmaticScale] == YES)
	{
		label.text = [NSString stringWithFormat:@"D♭, D, F, A♭♭, B♭♭, C♭, C"];
		//@"D♭ Enigmatic:"
	}
	
	if ([messageFromPicker isEqualToString: testStringDEnigmaticScale] == YES)
	{
		label.text = [NSString stringWithFormat:@"D, E♭, F♯, A♭, B♭, C, C♯"];
		//@"D Enigmatic:"
	}
	
	if ([messageFromPicker isEqualToString: testStringDSharpEnigmaticScale] == YES)
	{
		label.text = [NSString stringWithFormat:@"D♯, E, Fx, A, B, C♯, Cx"];
		//@"D♯ Enigmatic:"
	}
	
	if ([messageFromPicker isEqualToString: testStringEbEnigmaticScale] == YES)
	{
		label.text = [NSString stringWithFormat:@"E♭, F♭, G, B♭♭, C♭, D♭, D"];
		//@"E♭ Enigmatic:"
	}
	
	if ([messageFromPicker isEqualToString: testStringEEnigmaticScale] == YES)
	{
		label.text = [NSString stringWithFormat:@"E, F, G♯, B♭, C, D, D♯"];
		//@"E Enigmatic:"
	}
	
	if ([messageFromPicker isEqualToString: testStringFEnigmaticScale] == YES)
	{
		label.text = [NSString stringWithFormat:@"F, G♭, A, C♭, D♭, E♭, E"];
		//@"F Enigmatic:"
	}//m2, M3 from root, dim5 from root, M2, M2, m2
	
	if ([messageFromPicker isEqualToString: testStringFSharpEnigmaticScale] == YES)
	{
		label.text = [NSString stringWithFormat:@"F♯, G, A♯, C, D, E, E♯"];
		//@"F♯ Enigmatic:"
	}
	
	if ([messageFromPicker isEqualToString: testStringGbEnigmaticScale] == YES)
	{
		label.text = [NSString stringWithFormat:@"G♭, A, B♭, D♭♭, E♭♭, F♭, F"];
		//@"G♭ Enigmatic:"
	}
	
	if ([messageFromPicker isEqualToString: testStringGEnigmaticScale] == YES)
	{
		label.text = [NSString stringWithFormat:@"G, A♭, B, D♭, E♭, F, F♯"];
		//@"G Enigmatic:"
	}
	
	if ([messageFromPicker isEqualToString: testStringGSharpEnigmaticScale] == YES)
	{
		label.text = [NSString stringWithFormat:@"G♯, A, B♯, D, E, F♯, Fx"];
		//@"G♯ Enigmatic:"
	}
	
	if ([messageFromPicker isEqualToString: testStringAbEnigmaticScale] == YES)
	{
		label.text = [NSString stringWithFormat:@"A♭, B♭♭, C♭, E♭♭, F♭, G♭, G"];
		//@"A♭ Enigmatic:"
	}
	
	if ([messageFromPicker isEqualToString: testStringAEnigmaticScale] == YES)
	{
		label.text = [NSString stringWithFormat:@"A, B♭, C, E♭, F, G, G♯"];
		//@"A Enigmatic:"
	}
	
	if ([messageFromPicker isEqualToString: testStringASharpEnigmaticScale] == YES)
	{
		label.text = [NSString stringWithFormat:@"A♯, B, C♯, E, F♯, G♯, Gx"];
		//@"A♯ Enigmatic:"
	}
	
	if ([messageFromPicker isEqualToString: testStringBbEnigmaticScale] == YES)
	{
		label.text = [NSString stringWithFormat:@"B♭, C♭, D, F♭, G♭, A♭, A"];
		//@"B♭ Enigmatic:"
	}
	
	if ([messageFromPicker isEqualToString: testStringBEnigmaticScale] == YES)
	{
		label.text = [NSString stringWithFormat:@"B, C, D♯, F, G, A, A♯"];
		//@"B Enigmatic:"
	}
	
	// *********** HungarianGypsyScale ifs **********************
	
	if ([messageFromPicker isEqualToString: testStringCHungarianGypsyScale] == YES)
	{
		label.text = [NSString stringWithFormat:@"C, D, D♯, F♯, G, G♯, A♯"];
		//@"C Hungarian Gypsy:"
	}
	//M2, m2, m3, m2, m2, M2
	if ([messageFromPicker isEqualToString: testStringCSharpHungarianGypsyScale] == YES)
	{
		label.text = [NSString stringWithFormat:@"C♯, D♯, E, G, G♯, A, B"];
		//@"C♯ Hungarian Gypsy:"
	}
	
	if ([messageFromPicker isEqualToString: testStringDbHungarianGypsyScale] == YES)
	{
		label.text = [NSString stringWithFormat:@"D♭, E♭, E, G, A♭, A, B♭"];
		//@"D♭ Hungarian Gypsy:"
	}
	
	if ([messageFromPicker isEqualToString: testStringDHungarianGypsyScale] == YES)
	{
		label.text = [NSString stringWithFormat:@"D, E, F, G♯, A, A♯, C"];
		//@"D Hungarian Gypsy:"
	}
	
	if ([messageFromPicker isEqualToString: testStringDSharpHungarianGypsyScale] == YES)
	{
		label.text = [NSString stringWithFormat:@"D♯, F, F♯, A, A♯, B, C♯"];
		//@"D♯ Hungarian Gypsy:"
	}
	
	if ([messageFromPicker isEqualToString: testStringEbHungarianGypsyScale] == YES)
	{
		label.text = [NSString stringWithFormat:@"E♭, F, G♭, A, B♭, B, D♭"];
		//@"E♭ Hungarian Gypsy:"
	}
	//M2, m2, m3, m2, m2, M2
	if ([messageFromPicker isEqualToString: testStringEHungarianGypsyScale] == YES)
	{
		label.text = [NSString stringWithFormat:@"E, F♯, G, A♯, B, C, C♯"];
		//@"E Hungarian Gypsy:"
	}
	
	if ([messageFromPicker isEqualToString: testStringFHungarianGypsyScale] == YES)
	{
		label.text = [NSString stringWithFormat:@"F, G, A♭, B, C, C♯, D♯"];
		//@"F Hungarian Gypsy:"
	}//m2, M3 from root, dim5 from root, M2, M2, m2
	
	if ([messageFromPicker isEqualToString: testStringFSharpHungarianGypsyScale] == YES)
	{
		label.text = [NSString stringWithFormat:@"F♯, G♯, A, C, C♯, D, E"];
		//@"F♯ Hungarian Gypsy:"
	}
	
	if ([messageFromPicker isEqualToString: testStringGbHungarianGypsyScale] == YES)
	{
		label.text = [NSString stringWithFormat:@"G♭, A♭, A, C, D♭, D, E"];
		//@"G♭ Hungarian Gypsy:"
	}
	
	if ([messageFromPicker isEqualToString: testStringGHungarianGypsyScale] == YES)
	{
		label.text = [NSString stringWithFormat:@"G, A, A♯, C♯, D, D♯, F"];
		//@"G Hungarian Gypsy:"
	}
	
	if ([messageFromPicker isEqualToString: testStringGSharpHungarianGypsyScale] == YES)
	{
		label.text = [NSString stringWithFormat:@"G♯, A♯, B, D, D♯, E, F♯"];
		//@"G♯ Hungarian Gypsy:"
	}
	
	if ([messageFromPicker isEqualToString: testStringAbHungarianGypsyScale] == YES)
	{
		label.text = [NSString stringWithFormat:@"A♭, B♭, B, D, E♭, E, G♭"];
		//@"A♭ Hungarian Gypsy:"
	}
	
	if ([messageFromPicker isEqualToString: testStringAHungarianGypsyScale] == YES)
	{
		label.text = [NSString stringWithFormat:@"A, B, C, D♯, E, F, G"];
		//@"A Hungarian Gypsy:"
	}
	
	if ([messageFromPicker isEqualToString: testStringASharpHungarianGypsyScale] == YES)
	{
		label.text = [NSString stringWithFormat:@"A♯, C, C♯, E, F, F♯, G♯"];
		//@"A♯ Hungarian Gypsy:"
	}
	
	if ([messageFromPicker isEqualToString: testStringBbHungarianGypsyScale] == YES)
	{
		label.text = [NSString stringWithFormat:@"B♭, C, D♭, E, F, G♭, A♭"];
		//@"B♭ Hungarian Gypsy:"
	}
	
	if ([messageFromPicker isEqualToString: testStringBHungarianGypsyScale] == YES)
	{
		label.text = [NSString stringWithFormat:@"B, C♯, D, F, F♯, G, A"];
		//@"B Hungarian Gypsy:"
	}
	
	/*
	// ELSE UIAlertView ************************************************
	else 
	{
		// do something
	}*/

	// ***TEST STRING AUTORELEASE *******************************************

	// *********** Major TEST STRING RELEASE **********************
	[testStringCMajor autorelease];
	[testStringCSharpMajor autorelease];
	[testStringDbMajor autorelease];
	[testStringDMajor autorelease];
	[testStringDSharpMajor autorelease];
	[testStringEbMajor autorelease];
	[testStringEMajor autorelease];
	[testStringFMajor autorelease];
	[testStringFSharpMajor autorelease];
	[testStringGbMajor autorelease];
	[testStringGMajor autorelease];
	[testStringGSharpMajor autorelease];
	[testStringAbMajor autorelease];
	[testStringAMajor autorelease];
	[testStringASharpMajor autorelease];
	[testStringBbMajor autorelease];
	[testStringBMajor autorelease];

	// *********** Minor TEST STRING RELEASE **********************
	[testStringCMinor autorelease];
	[testStringCSharpMinor autorelease];
	[testStringDbMinor autorelease];
	[testStringDMinor autorelease];
	[testStringDSharpMinor autorelease];
	[testStringEbMinor autorelease];
	[testStringEMinor autorelease];
	[testStringFMinor autorelease];
	[testStringFSharpMinor autorelease];
	[testStringGbMinor autorelease];
	[testStringGMinor autorelease];
	[testStringGSharpMinor autorelease];
	[testStringAbMinor autorelease];
	[testStringAMinor autorelease];
	[testStringASharpMinor autorelease];
	[testStringBbMinor autorelease];
	[testStringBMinor autorelease];

	// *********** HarmonicMinor TEST STRING RELEASE **********************
	[testStringCHarmonicMinor autorelease];
	[testStringCSharpHarmonicMinor autorelease];
	[testStringDbHarmonicMinor autorelease];
	[testStringDHarmonicMinor autorelease];
	[testStringDSharpHarmonicMinor autorelease];
	[testStringEbHarmonicMinor autorelease];
	[testStringEHarmonicMinor autorelease];
	[testStringFHarmonicMinor autorelease];
	[testStringFSharpHarmonicMinor autorelease];
	[testStringGbHarmonicMinor autorelease];
	[testStringGHarmonicMinor autorelease];
	[testStringGSharpHarmonicMinor autorelease];
	[testStringAbHarmonicMinor autorelease];
	[testStringAHarmonicMinor autorelease];
	[testStringASharpHarmonicMinor autorelease];
	[testStringBbHarmonicMinor autorelease];
	[testStringBHarmonicMinor autorelease];

	// *********** MelodicMinor TEST STRING RELEASE **********************
	[testStringCMelodicMinor autorelease];
	[testStringCSharpMelodicMinor autorelease];
	[testStringDbMelodicMinor autorelease];
	[testStringDMelodicMinor autorelease];
	[testStringDSharpMelodicMinor autorelease];
	[testStringEbMelodicMinor autorelease];
	[testStringEMelodicMinor autorelease];
	[testStringFMelodicMinor autorelease];
	[testStringFSharpMelodicMinor autorelease];
	[testStringGbMelodicMinor autorelease];
	[testStringGMelodicMinor autorelease];
	[testStringGSharpMelodicMinor autorelease];
	[testStringAbMelodicMinor autorelease];
	[testStringAMelodicMinor autorelease];
	[testStringASharpMelodicMinor autorelease];
	[testStringBbMelodicMinor autorelease];
	[testStringBMelodicMinor autorelease];

	// *********** Ionian TEST STRING RELEASE **********************
	[testStringCIonian autorelease];
	[testStringCSharpIonian autorelease];
	[testStringDbIonian autorelease];
	[testStringDIonian autorelease];
	[testStringDSharpIonian autorelease];
	[testStringEbIonian autorelease];
	[testStringEIonian autorelease];
	[testStringFIonian autorelease];
	[testStringFSharpIonian autorelease];
	[testStringGbIonian autorelease];
	[testStringGIonian autorelease];
	[testStringGSharpIonian autorelease];
	[testStringAbIonian autorelease];
	[testStringAIonian autorelease];
	[testStringASharpIonian autorelease];
	[testStringBbIonian autorelease];
	[testStringBIonian autorelease];

	// *********** Dorian TEST STRING RELEASE **********************
	[testStringCDorian autorelease];
	[testStringCSharpDorian autorelease];
	[testStringDbDorian autorelease];
	[testStringDDorian autorelease];
	[testStringDSharpDorian autorelease];
	[testStringEbDorian autorelease];
	[testStringEDorian autorelease];
	[testStringFDorian autorelease];
	[testStringFSharpDorian autorelease];
	[testStringGbDorian autorelease];
	[testStringGDorian autorelease];
	[testStringGSharpDorian autorelease];
	[testStringAbDorian autorelease];
	[testStringADorian autorelease];
	[testStringASharpDorian autorelease];
	[testStringBbDorian autorelease];
	[testStringBDorian autorelease];

	// *********** Phrygian TEST STRING RELEASE **********************
	[testStringCPhrygian autorelease];
	[testStringCSharpPhrygian autorelease];
	[testStringDbPhrygian autorelease];
	[testStringDPhrygian autorelease];
	[testStringDSharpPhrygian autorelease];
	[testStringEbPhrygian autorelease];
	[testStringEPhrygian autorelease];
	[testStringFPhrygian autorelease];
	[testStringFSharpPhrygian autorelease];
	[testStringGbPhrygian autorelease];
	[testStringGPhrygian autorelease];
	[testStringGSharpPhrygian autorelease];
	[testStringAbPhrygian autorelease];
	[testStringAPhrygian autorelease];
	[testStringASharpPhrygian autorelease];
	[testStringBbPhrygian autorelease];
	[testStringBPhrygian autorelease];

	// *********** Lydian TEST STRING RELEASE ***********
	[testStringCLydian autorelease];
	[testStringCSharpLydian autorelease];
	[testStringDbLydian autorelease];
	[testStringDLydian autorelease];
	[testStringDSharpLydian autorelease];
	[testStringEbLydian autorelease];
	[testStringELydian autorelease];
	[testStringFLydian autorelease];
	[testStringFSharpLydian autorelease];
	[testStringGbLydian autorelease];
	[testStringGLydian autorelease];
	[testStringGSharpLydian autorelease];
	[testStringAbLydian autorelease];
	[testStringALydian autorelease];
	[testStringASharpLydian autorelease];
	[testStringBbLydian autorelease];
	[testStringBLydian autorelease];

	// *********** Mixolydian TEST STRING RELEASE **********************
	[testStringCMixolydian autorelease];
	[testStringCSharpMixolydian autorelease];
	[testStringDbMixolydian autorelease];
	[testStringDMixolydian autorelease];
	[testStringDSharpMixolydian autorelease];
	[testStringEbMixolydian autorelease];
	[testStringEMixolydian autorelease];
	[testStringFMixolydian autorelease];
	[testStringFSharpMixolydian autorelease];
	[testStringGbMixolydian autorelease];
	[testStringGMixolydian autorelease];
	[testStringGSharpMixolydian autorelease];
	[testStringAbMixolydian autorelease];
	[testStringAMixolydian autorelease];
	[testStringASharpMixolydian autorelease];
	[testStringBbMixolydian autorelease];
	[testStringBMixolydian autorelease];

	// *********** Aeolian TEST STRING RELEASE **********************
	[testStringCAeolian autorelease];
	[testStringCSharpAeolian autorelease];
	[testStringDbAeolian autorelease];
	[testStringDAeolian autorelease];
	[testStringDSharpAeolian autorelease];
	[testStringEbAeolian autorelease];
	[testStringEAeolian autorelease];
	[testStringFAeolian autorelease];
	[testStringFSharpAeolian autorelease];
	[testStringGbAeolian autorelease];
	[testStringGAeolian autorelease];
	[testStringGSharpAeolian autorelease];
	[testStringAbAeolian autorelease];
	[testStringAAeolian autorelease];
	[testStringASharpAeolian autorelease];
	[testStringBbAeolian autorelease];
	[testStringBAeolian autorelease];

	// *********** Locrian TEST STRING RELEASE **********************
	[testStringCLocrian autorelease];
	[testStringCSharpLocrian autorelease];
	[testStringDbLocrian autorelease];
	[testStringDLocrian autorelease];
	[testStringDSharpLocrian autorelease];
	[testStringEbLocrian autorelease];
	[testStringELocrian autorelease];
	[testStringFLocrian autorelease];
	[testStringFSharpLocrian autorelease];
	[testStringGbLocrian autorelease];
	[testStringGLocrian autorelease];
	[testStringGSharpLocrian autorelease];
	[testStringAbLocrian autorelease];
	[testStringALocrian autorelease];
	[testStringASharpLocrian autorelease];
	[testStringBbLocrian autorelease];
	[testStringBLocrian autorelease];

	// *********** WholeTone TEST STRING RELEASE ***********
	[testStringCWholeTone autorelease];
	[testStringCSharpWholeTone autorelease];
	[testStringDbWholeTone autorelease];
	[testStringDWholeTone autorelease];
	[testStringDSharpWholeTone autorelease];
	[testStringEbWholeTone autorelease];
	[testStringEWholeTone autorelease];
	[testStringFWholeTone autorelease];
	[testStringFSharpWholeTone autorelease];
	[testStringGbWholeTone autorelease];
	[testStringGWholeTone autorelease];
	[testStringGSharpWholeTone autorelease];
	[testStringAbWholeTone autorelease];
	[testStringAWholeTone autorelease];
	[testStringASharpWholeTone autorelease];
	[testStringBbWholeTone autorelease];
	[testStringBWholeTone autorelease];
	
	// *********** ChromaticScale TEST STRING RELEASE ***********
	[testStringCChromaticScale autorelease];
	[testStringCSharpChromaticScale autorelease];
	[testStringDbChromaticScale autorelease];
	[testStringDChromaticScale autorelease];
	[testStringDSharpChromaticScale autorelease];
	[testStringEbChromaticScale autorelease];
	[testStringEChromaticScale autorelease];
	[testStringFChromaticScale autorelease];
	[testStringFSharpChromaticScale autorelease];
	[testStringGbChromaticScale autorelease];
	[testStringGChromaticScale autorelease];
	[testStringGSharpChromaticScale autorelease];
	[testStringAbChromaticScale autorelease];
	[testStringAChromaticScale autorelease];
	[testStringASharpChromaticScale autorelease];
	[testStringBbChromaticScale autorelease];
	[testStringBChromaticScale autorelease];	

	// *********** Pentatonic TEST STRING RELEASE **********************
	[testStringCPentatonic autorelease];
	[testStringCSharpPentatonic autorelease];
	[testStringDbPentatonic autorelease];
	[testStringDPentatonic autorelease];
	[testStringDSharpPentatonic autorelease];
	[testStringEbPentatonic autorelease];
	[testStringEPentatonic autorelease];
	[testStringFPentatonic autorelease];
	[testStringFSharpPentatonic autorelease];
	[testStringGbPentatonic autorelease];
	[testStringGPentatonic autorelease];
	[testStringGSharpPentatonic autorelease];
	[testStringAbPentatonic autorelease];
	[testStringAPentatonic autorelease];
	[testStringASharpPentatonic autorelease];
	[testStringBbPentatonic autorelease];
	[testStringBPentatonic autorelease];
	
	// *********** BluesScale TEST STRING RELEASE ***********
	[testStringCBluesScale autorelease];
	[testStringCSharpBluesScale autorelease];
	[testStringDbBluesScale autorelease];
	[testStringDBluesScale autorelease];
	[testStringDSharpBluesScale autorelease];
	[testStringEbBluesScale autorelease];
	[testStringEBluesScale autorelease];
	[testStringFBluesScale autorelease];
	[testStringFSharpBluesScale autorelease];
	[testStringGbBluesScale autorelease];
	[testStringGBluesScale autorelease];
	[testStringGSharpBluesScale autorelease];
	[testStringAbBluesScale autorelease];
	[testStringABluesScale autorelease];
	[testStringASharpBluesScale autorelease];
	[testStringBbBluesScale autorelease];
	[testStringBBluesScale autorelease];
	
	// *********** DiminishedScale TEST STRING RELEASE ***********
	[testStringCDiminishedScale autorelease];
	[testStringCSharpDiminishedScale autorelease];
	[testStringDbDiminishedScale autorelease];
	[testStringDDiminishedScale autorelease];
	[testStringDSharpDiminishedScale autorelease];
	[testStringEbDiminishedScale autorelease];
	[testStringEDiminishedScale autorelease];
	[testStringFDiminishedScale autorelease];
	[testStringFSharpDiminishedScale autorelease];
	[testStringGbDiminishedScale autorelease];
	[testStringGDiminishedScale autorelease];
	[testStringGSharpDiminishedScale autorelease];
	[testStringAbDiminishedScale autorelease];
	[testStringADiminishedScale autorelease];
	[testStringASharpDiminishedScale autorelease];
	[testStringBbDiminishedScale autorelease];
	[testStringBDiminishedScale autorelease];
	
	// *********** OctatonicScale TEST STRING RELEASE ***********
	[testStringCOctatonicScale autorelease];
	[testStringCSharpOctatonicScale autorelease];
	[testStringDbOctatonicScale autorelease];
	[testStringDOctatonicScale autorelease];
	[testStringDSharpOctatonicScale autorelease];
	[testStringEbOctatonicScale autorelease];
	[testStringEOctatonicScale autorelease];
	[testStringFOctatonicScale autorelease];
	[testStringFSharpOctatonicScale autorelease];
	[testStringGbOctatonicScale autorelease];
	[testStringGOctatonicScale autorelease];
	[testStringGSharpOctatonicScale autorelease];
	[testStringAbOctatonicScale autorelease];
	[testStringAOctatonicScale autorelease];
	[testStringASharpOctatonicScale autorelease];
	[testStringBbOctatonicScale autorelease];
	[testStringBOctatonicScale autorelease];
	
	// *********** EnigmaticScale TEST STRING RELEASE ***********
	[testStringCEnigmaticScale autorelease];
	[testStringCSharpEnigmaticScale autorelease];
	[testStringDbEnigmaticScale autorelease];
	[testStringDEnigmaticScale autorelease];
	[testStringDSharpEnigmaticScale autorelease];
	[testStringEbEnigmaticScale autorelease];
	[testStringEEnigmaticScale autorelease];
	[testStringFEnigmaticScale autorelease];
	[testStringFSharpEnigmaticScale autorelease];
	[testStringGbEnigmaticScale autorelease];
	[testStringGEnigmaticScale autorelease];
	[testStringGSharpEnigmaticScale autorelease];
	[testStringAbEnigmaticScale autorelease];
	[testStringAEnigmaticScale autorelease];
	[testStringASharpEnigmaticScale autorelease];
	[testStringBbEnigmaticScale autorelease];
	[testStringBEnigmaticScale autorelease];
	
	// *********** HungarianGypsyScale TEST STRING RELEASE ***********
	[testStringCHungarianGypsyScale autorelease];
	[testStringCSharpHungarianGypsyScale autorelease];
	[testStringDbHungarianGypsyScale autorelease];
	[testStringDHungarianGypsyScale autorelease];
	[testStringDSharpHungarianGypsyScale autorelease];
	[testStringEbHungarianGypsyScale autorelease];
	[testStringEHungarianGypsyScale autorelease];
	[testStringFHungarianGypsyScale autorelease];
	[testStringFSharpHungarianGypsyScale autorelease];
	[testStringGbHungarianGypsyScale autorelease];
	[testStringGHungarianGypsyScale autorelease];
	[testStringGSharpHungarianGypsyScale autorelease];
	[testStringAbHungarianGypsyScale autorelease];
	[testStringAHungarianGypsyScale autorelease];
	[testStringASharpHungarianGypsyScale autorelease];
	[testStringBbHungarianGypsyScale autorelease];
	[testStringBHungarianGypsyScale autorelease];
	
	
	// ********************************************************
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
	if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
		// Initialization code
	}
	return self;
}

// picker arrays
- (void)viewDidLoad {
	NSArray *scalesArray = [[NSArray alloc] initWithObjects:@"Major", @"Minor", @"Harmonic Minor", @"Melodic Minor", @"Ionian", @"Dorian", @"Phrygian", @"Lydian", @"Mixolydian", @"Aeolian", @"Locrian", @"Whole Tone", @"Pentatonic", @"Chromatic", @"Blues", @"Diminished", @"Octatonic", @"Enigmatic", @"Hungarian Gypsy", nil];
	self.modeTypes = scalesArray;
	[scalesArray release];
	
	NSArray *rootArray = [[NSArray alloc] initWithObjects:@"C", @"C♯", @"D♭", @"D", @"D♯", @"E♭", @"E", @"F", @"F♯", @"G♭", @"G", @"G♯", @"A♭", @"A", @"A♯", @"B♭", @"B", nil];
	self.modeRoot = rootArray;
	[rootArray release];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	// Return YES for supported orientations
	return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning]; // Releases the view if it doesn't have a superview
	// Release anything that's not essential, such as cached data
}

// clean-up
- (void)dealloc {
	[doublePicker release];
	[modeTypes release];
	[modeRoot release];
	[super dealloc];
}

#pragma mark -
#pragma mark Picker Data Source Methods
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
	return 2;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
	if (component == kModeComponent)
		return [self.modeTypes count];
	
	return [self.modeRoot count];
}

#pragma mark Picker Delegate Methods
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
	if (component == kModeComponent)
		return [self.modeTypes objectAtIndex:row];
	
	return [self.modeRoot objectAtIndex:row];
}

@end
