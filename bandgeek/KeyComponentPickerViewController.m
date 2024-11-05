//
//  KeyComponentPickerViewController.m
//  Harmony
//
//  Created by Brian B. James on 5/24/09.
//  Copyright Brian B. James 2009. All rights reserved.
//

#import "KeyComponentPickerViewController.h"

@implementation KeyComponentPickerViewController

@synthesize doublePicker;
@synthesize keyTypes;
@synthesize keyRoot;
@synthesize label;

- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
	if (component == kRootComponent)
		return 90;
	return 210;
}

// didSelectRow
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
	NSInteger keyRow = [doublePicker selectedRowInComponent:kKeyComponent];
	NSInteger rootRow = [doublePicker selectedRowInComponent:kRootComponent];
	NSString *theKey = [self.keyTypes objectAtIndex:keyRow];
	NSString *theRoot = [self.keyRoot objectAtIndex:rootRow];
	
	// THE MESSAGE FROM THE PICKER
	NSMutableString *messageFromPicker = [[NSMutableString alloc] initWithFormat:@"%@ %@", theRoot, theKey];
		
	// *********** MAJOR TEST STRINGS **********************
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
	
	// *********** MINOR TEST STRINGS **********************
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
	
	// *********** IonianChords TEST STRINGS **********************
	NSString *testStringCIonianChords = @"C Ionian";
	NSString *testStringCSharpIonianChords = @"C♯ Ionian";
	NSString *testStringDbIonianChords = @"D♭ Ionian";
	NSString *testStringDIonianChords = @"D Ionian";
	NSString *testStringDSharpIonianChords = @"D♯ Ionian";
	NSString *testStringEbIonianChords = @"E♭ Ionian";
	NSString *testStringEIonianChords = @"E Ionian";
	NSString *testStringFIonianChords = @"F Ionian";
	NSString *testStringFSharpIonianChords = @"F♯ Ionian";
	NSString *testStringGbIonianChords = @"G♭ Ionian";
	NSString *testStringGIonianChords = @"G Ionian";
	NSString *testStringGSharpIonianChords = @"G♯ Ionian";
	NSString *testStringAbIonianChords = @"A♭ Ionian";
	NSString *testStringAIonianChords = @"A Ionian";
	NSString *testStringASharpIonianChords = @"A♯ Ionian";
	NSString *testStringBbIonianChords = @"B♭ Ionian";
	NSString *testStringBIonianChords = @"B Ionian";
	
	// *********** DorianChords TEST STRINGS **********************
	NSString *testStringCDorianChords = @"C Dorian";
	NSString *testStringCSharpDorianChords = @"C♯ Dorian";
	NSString *testStringDbDorianChords = @"D♭ Dorian";
	NSString *testStringDDorianChords = @"D Dorian";
	NSString *testStringDSharpDorianChords = @"D♯ Dorian";
	NSString *testStringEbDorianChords = @"E♭ Dorian";
	NSString *testStringEDorianChords = @"E Dorian";
	NSString *testStringFDorianChords = @"F Dorian";
	NSString *testStringFSharpDorianChords = @"F♯ Dorian";
	NSString *testStringGbDorianChords = @"G♭ Dorian";
	NSString *testStringGDorianChords = @"G Dorian";
	NSString *testStringGSharpDorianChords = @"G♯ Dorian";
	NSString *testStringAbDorianChords = @"A♭ Dorian";
	NSString *testStringADorianChords = @"A Dorian";
	NSString *testStringASharpDorianChords = @"A♯ Dorian";
	NSString *testStringBbDorianChords = @"B♭ Dorian";
	NSString *testStringBDorianChords = @"B Dorian";
	
	// *********** PhrygianChords TEST STRINGS **********************
	NSString *testStringCPhrygianChords = @"C Phrygian";
	NSString *testStringCSharpPhrygianChords = @"C♯ Phrygian";
	NSString *testStringDbPhrygianChords = @"D♭ Phrygian";
	NSString *testStringDPhrygianChords = @"D Phrygian";
	NSString *testStringDSharpPhrygianChords = @"D♯ Phrygian";
	NSString *testStringEbPhrygianChords = @"E♭ Phrygian";
	NSString *testStringEPhrygianChords = @"E Phrygian";
	NSString *testStringFPhrygianChords = @"F Phrygian";
	NSString *testStringFSharpPhrygianChords = @"F♯ Phrygian";
	NSString *testStringGbPhrygianChords = @"G♭ Phrygian";
	NSString *testStringGPhrygianChords = @"G Phrygian";
	NSString *testStringGSharpPhrygianChords = @"G♯ Phrygian";
	NSString *testStringAbPhrygianChords = @"A♭ Phrygian";
	NSString *testStringAPhrygianChords = @"A Phrygian";
	NSString *testStringASharpPhrygianChords = @"A♯ Phrygian";
	NSString *testStringBbPhrygianChords = @"B♭ Phrygian";
	NSString *testStringBPhrygianChords = @"B Phrygian";
	
	// *********** LydianChords TEST STRINGS **********************
	NSString *testStringCLydianChords = @"C Lydian";
	NSString *testStringCSharpLydianChords = @"C♯ Lydian";
	NSString *testStringDbLydianChords = @"D♭ Lydian";
	NSString *testStringDLydianChords = @"D Lydian";
	NSString *testStringDSharpLydianChords = @"D♯ Lydian";
	NSString *testStringEbLydianChords = @"E♭ Lydian";
	NSString *testStringELydianChords = @"E Lydian";
	NSString *testStringFLydianChords = @"F Lydian";
	NSString *testStringFSharpLydianChords = @"F♯ Lydian";
	NSString *testStringGbLydianChords = @"G♭ Lydian";
	NSString *testStringGLydianChords = @"G Lydian";
	NSString *testStringGSharpLydianChords = @"G♯ Lydian";
	NSString *testStringAbLydianChords = @"A♭ Lydian";
	NSString *testStringALydianChords = @"A Lydian";
	NSString *testStringASharpLydianChords = @"A♯ Lydian";
	NSString *testStringBbLydianChords = @"B♭ Lydian";
	NSString *testStringBLydianChords = @"B Lydian";
	
	// *********** MixolydianChords TEST STRINGS **********************
	NSString *testStringCMixolydianChords = @"C Mixolydian";
	NSString *testStringCSharpMixolydianChords = @"C♯ Mixolydian";
	NSString *testStringDbMixolydianChords = @"D♭ Mixolydian";
	NSString *testStringDMixolydianChords = @"D Mixolydian";
	NSString *testStringDSharpMixolydianChords = @"D♯ Mixolydian";
	NSString *testStringEbMixolydianChords = @"E♭ Mixolydian";
	NSString *testStringEMixolydianChords = @"E Mixolydian";
	NSString *testStringFMixolydianChords = @"F Mixolydian";
	NSString *testStringFSharpMixolydianChords = @"F♯ Mixolydian";
	NSString *testStringGbMixolydianChords = @"G♭ Mixolydian";
	NSString *testStringGMixolydianChords = @"G Mixolydian";
	NSString *testStringGSharpMixolydianChords = @"G♯ Mixolydian";
	NSString *testStringAbMixolydianChords = @"A♭ Mixolydian";
	NSString *testStringAMixolydianChords = @"A Mixolydian";
	NSString *testStringASharpMixolydianChords = @"A♯ Mixolydian";
	NSString *testStringBbMixolydianChords = @"B♭ Mixolydian";
	NSString *testStringBMixolydianChords = @"B Mixolydian";
	
	// *********** AeolianChords TEST STRINGS **********************
	NSString *testStringCAeolianChords = @"C Aeolian";
	NSString *testStringCSharpAeolianChords = @"C♯ Aeolian";
	NSString *testStringDbAeolianChords = @"D♭ Aeolian";
	NSString *testStringDAeolianChords = @"D Aeolian";
	NSString *testStringDSharpAeolianChords = @"D♯ Aeolian";
	NSString *testStringEbAeolianChords = @"E♭ Aeolian";
	NSString *testStringEAeolianChords = @"E Aeolian";
	NSString *testStringFAeolianChords = @"F Aeolian";
	NSString *testStringFSharpAeolianChords = @"F♯ Aeolian";
	NSString *testStringGbAeolianChords = @"G♭ Aeolian";
	NSString *testStringGAeolianChords = @"G Aeolian";
	NSString *testStringGSharpAeolianChords = @"G♯ Aeolian";
	NSString *testStringAbAeolianChords = @"A♭ Aeolian";
	NSString *testStringAAeolianChords = @"A Aeolian";
	NSString *testStringASharpAeolianChords = @"A♯ Aeolian";
	NSString *testStringBbAeolianChords = @"B♭ Aeolian";
	NSString *testStringBAeolianChords = @"B Aeolian";
	
	// *********** LocrianChords TEST STRINGS **********************
	NSString *testStringCLocrianChords = @"C Locrian";
	NSString *testStringCSharpLocrianChords = @"C♯ Locrian";
	NSString *testStringDbLocrianChords = @"D♭ Locrian";
	NSString *testStringDLocrianChords = @"D Locrian";
	NSString *testStringDSharpLocrianChords = @"D♯ Locrian";
	NSString *testStringEbLocrianChords = @"E♭ Locrian";
	NSString *testStringELocrianChords = @"E Locrian";
	NSString *testStringFLocrianChords = @"F Locrian";
	NSString *testStringFSharpLocrianChords = @"F♯ Locrian";
	NSString *testStringGbLocrianChords = @"G♭ Locrian";
	NSString *testStringGLocrianChords = @"G Locrian";
	NSString *testStringGSharpLocrianChords = @"G♯ Locrian";
	NSString *testStringAbLocrianChords = @"A♭ Locrian";
	NSString *testStringALocrianChords = @"A Locrian";
	NSString *testStringASharpLocrianChords = @"A♯ Locrian";
	NSString *testStringBbLocrianChords = @"B♭ Locrian";
	NSString *testStringBLocrianChords = @"B Locrian";
	
// IF STRING isEqualToString X XXXXXX ******************************************
// *********** MAJOR ifs **********************

	if ([messageFromPicker isEqualToString: testStringCMajor] == YES)
	{
	label.text = [NSString stringWithFormat:@"C, d, e, F, G, a, b°"];
	//@"C Major:"
	}

	if ([messageFromPicker isEqualToString: testStringCSharpMajor] == YES)
	{
	label.text = [NSString stringWithFormat:@"C♯, d♯, e♯, F♯, G♯, a♯, b♯°"];
	//@"C♯ Major:"
	}

	if ([messageFromPicker isEqualToString: testStringDbMajor] == YES)
	{
	label.text = [NSString stringWithFormat:@"D♭, e♭, f, G♭, A♭, b♭, c°"];
	//@"D♭ Major:"
	}

	if ([messageFromPicker isEqualToString: testStringDMajor] == YES)
	{
	label.text = [NSString stringWithFormat:@"D, e, f♯, G, A, b, c♯°"];
	//@"D Major:"
	}

	if ([messageFromPicker isEqualToString: testStringDSharpMajor] == YES)
	{
	label.text = [NSString stringWithFormat:@"D♯, e♯, fx, G♯, A♯, b♯, cx°"];
	//@"D♯ Major:"
	}

	if ([messageFromPicker isEqualToString: testStringEbMajor] == YES)
	{
	label.text = [NSString stringWithFormat:@"E♭, f, g, A♭, B♭, c, d°"];
	//@"E♭ Major:"
	}

	if ([messageFromPicker isEqualToString: testStringEMajor] == YES)
	{
	label.text = [NSString stringWithFormat:@"E, f♯, g♯, A, B, c♯, d♯°"];
	//@"E Major:"
	}

	if ([messageFromPicker isEqualToString: testStringFMajor] == YES)
	{
	label.text = [NSString stringWithFormat:@"F, g, a, B♭, C, d, e°"];
	//@"F Major:"
	}

	if ([messageFromPicker isEqualToString: testStringFSharpMajor] == YES)
	{
	label.text = [NSString stringWithFormat:@"F♯, g♯, a♯, B, C♯, d♯, e♯°"];
	//@"F♯ Major:"
	}

	if ([messageFromPicker isEqualToString: testStringGbMajor] == YES)
	{
	label.text = [NSString stringWithFormat:@"G♭, a♭, b♭, C♭, D♭, e♭, f°"];
	//@"G♭ Major:"
	}

	if ([messageFromPicker isEqualToString: testStringGMajor] == YES)
	{
	label.text = [NSString stringWithFormat:@"G, a, b, C, D, e, f♯°"];
	//@"G Major:"
	}

	if ([messageFromPicker isEqualToString: testStringGSharpMajor] == YES)
	{
	label.text = [NSString stringWithFormat:@"G♯, a♯, b♯, C♯, D♯, e♯, fx°"];
	//@"G♯ Major:"
	}

	if ([messageFromPicker isEqualToString: testStringAbMajor] == YES)
	{
	label.text = [NSString stringWithFormat:@"A♭, b♭, c, D♭, E♭, f, g°"];
	//@"A♭ Major:"
	}

	if ([messageFromPicker isEqualToString: testStringAMajor] == YES)
	{
	label.text = [NSString stringWithFormat:@"A, b, c♯, D, E, f♯, g♯°"];
	//@"A Major:"
	}

	if ([messageFromPicker isEqualToString: testStringASharpMajor] == YES)
	{
	label.text = [NSString stringWithFormat:@"A♯, b♯, cx, D♯, E♯, fx, gx°"];
	//@"A♯ Major:"
	}

	if ([messageFromPicker isEqualToString: testStringBbMajor] == YES)
	{
	label.text = [NSString stringWithFormat:@"B♭, c, d, E♭, F, g, a°"];
	//@"B♭ Major:"
	}

	if ([messageFromPicker isEqualToString: testStringBMajor] == YES)
	{
	label.text = [NSString stringWithFormat:@"B, c♯, d♯, E, F♯, g♯, a♯°"];
	//@"B Major:"
	}

	// *********** MINOR ifs **********************

	if ([messageFromPicker isEqualToString: testStringCMinor] == YES)
	{
	label.text = [NSString stringWithFormat:@"c, d°, E♭, f, G, a♭, B♭"];
	//@"C Minor:"
	}

	if ([messageFromPicker isEqualToString: testStringCSharpMinor] == YES)
	{
	label.text = [NSString stringWithFormat:@"c♯, d♯°, E, f♯, G♯, a, b"];
	//@"C♯ Minor:"
	}

	if ([messageFromPicker isEqualToString: testStringDbMinor] == YES)
	{
	label.text = [NSString stringWithFormat:@"d♭, e♭°, F♭, g♭, a♭, B♭♭, C♭"];
	//@"D♭ Minor:"
	}

	if ([messageFromPicker isEqualToString: testStringDMinor] == YES)
	{
	label.text = [NSString stringWithFormat:@"d, e°, F, g, a, B♭, C"];
	//@"D Minor:"
	}

	if ([messageFromPicker isEqualToString: testStringDSharpMinor] == YES)
	{
	label.text = [NSString stringWithFormat:@"d♯, e♯°, F♯, g♯, a♯, B, C♯"];
	//@"D♯ Minor:"
	}

	if ([messageFromPicker isEqualToString: testStringEbMinor] == YES)
	{
	label.text = [NSString stringWithFormat:@"e♭, f°, G♭, a♭, b♭, C♭, D♭"];
	//@"E♭ Minor:"
	}

	if ([messageFromPicker isEqualToString: testStringEMinor] == YES)
	{
	label.text = [NSString stringWithFormat:@"e, f♯°, G, a, b, C, D"];
	//@"E Minor:"
	}

	if ([messageFromPicker isEqualToString: testStringFMinor] == YES)
	{
	label.text = [NSString stringWithFormat:@"f, g°, A♭, b♭, c, D♭, E♭"];
	//@"F Minor:"
	}

	if ([messageFromPicker isEqualToString: testStringFSharpMinor] == YES)
	{
	label.text = [NSString stringWithFormat:@"f♯, g♯°, A, b, c♯, D, E"];
	//@"F♯ Minor:"
	}

	if ([messageFromPicker isEqualToString: testStringGbMinor] == YES)
	{
	label.text = [NSString stringWithFormat:@"g♭, a♭°, B♭♭, c♭, d♭, E♭♭, F♭"];
	//@"G♭ Minor:"
	}

	if ([messageFromPicker isEqualToString: testStringGMinor] == YES)
	{
	label.text = [NSString stringWithFormat:@"g, a°, B♭, c, d, E♭, F"];
	//@"G Minor:"
	}

	if ([messageFromPicker isEqualToString: testStringGSharpMinor] == YES)
	{
	label.text = [NSString stringWithFormat:@"g♯, a♯°, B, c♯, d♯, E, F♯"];
	//@"G♯ Minor:"
	}

	if ([messageFromPicker isEqualToString: testStringAbMinor] == YES)
	{
	label.text = [NSString stringWithFormat:@"a♭, b♭°, C♭, d♭, e♭, F♭, G♭"];
	//@"A♭ Minor:"
	}

	if ([messageFromPicker isEqualToString: testStringAMinor] == YES)
	{
	label.text = [NSString stringWithFormat:@"a, b°, C, d, e, F, G"];
	//@"A Minor:"
	}

	if ([messageFromPicker isEqualToString: testStringASharpMinor] == YES)
	{
	label.text = [NSString stringWithFormat:@"a♯, b♯°, C♯, d♯, e♯, F♯, G♯"];
	//@"A♯ Minor:"
	}

	if ([messageFromPicker isEqualToString: testStringBbMinor] == YES)
	{
	label.text = [NSString stringWithFormat:@"b♭, c°, D♭, e♭, f, G♭, A♭"];
	//@"B♭ Minor:"
	}

	if ([messageFromPicker isEqualToString: testStringBMinor] == YES)
	{
	label.text = [NSString stringWithFormat:@"b, c♯°, D, e, f♯, G, A"];
	//@"B Minor:"
	}

	// *********** IonianChords ifs **********************
	// W W 1/2 W W W 1/2
	// M, m, m, M, M, m, °

	if ([messageFromPicker isEqualToString: testStringCIonianChords] == YES)
	{
	label.text = [NSString stringWithFormat:@"C, d, e, F, G, a, b°"];
	//@"C Ionian:"
	}

	if ([messageFromPicker isEqualToString: testStringCSharpIonianChords] == YES)
	{
	label.text = [NSString stringWithFormat:@"C♯, d♯, e♯, F♯, G♯, a♯, b♯°"];
	//@"C♯ Ionian:"
	}

	if ([messageFromPicker isEqualToString: testStringDbIonianChords] == YES)
	{
	label.text = [NSString stringWithFormat:@"D♭, e♭, f, G♭, A♭, b♭, c°"];
	//@"D♭ Ionian:"
	}

	if ([messageFromPicker isEqualToString: testStringDIonianChords] == YES)
	{
	label.text = [NSString stringWithFormat:@"D, e, f♯, G, A, b, c♯°"];
	//@"D Ionian:"
	}

	if ([messageFromPicker isEqualToString: testStringDSharpIonianChords] == YES)
	{
	label.text = [NSString stringWithFormat:@"D♯, e♯, fx, G♯, A♯, b♯, cx°"];
	//@"D♯ Ionian:"
	}

	if ([messageFromPicker isEqualToString: testStringEbIonianChords] == YES)
	{
	label.text = [NSString stringWithFormat:@"E♭, f, g, A♭, B♭, c, d°"];
	//@"E♭ Ionian:"
	}

	if ([messageFromPicker isEqualToString: testStringEIonianChords] == YES)
	{
	label.text = [NSString stringWithFormat:@"E, f♯, g♯, A, B, c♯, d♯°"];
	//@"E Ionian:"
	}

	if ([messageFromPicker isEqualToString: testStringFIonianChords] == YES)
	{
	label.text = [NSString stringWithFormat:@"F, g, a, B♭, C, d, e°"];
	//@"F Ionian:"
	}

	if ([messageFromPicker isEqualToString: testStringFSharpIonianChords] == YES)
	{
	label.text = [NSString stringWithFormat:@"F♯, g♯, a♯, B, C♯, d♯, e♯°"];
	//@"F♯ Ionian:"
	}

	if ([messageFromPicker isEqualToString: testStringGbIonianChords] == YES)
	{
	label.text = [NSString stringWithFormat:@"G♭, a♭, b♭, C♭, D♭, e♭, f°"];
	//@"G♭ Ionian:"
	}

	if ([messageFromPicker isEqualToString: testStringGIonianChords] == YES)
	{
	label.text = [NSString stringWithFormat:@"G, a, b, C, D, e, f♯°"];
	//@"G Ionian:"
	}

	if ([messageFromPicker isEqualToString: testStringGSharpIonianChords] == YES)
	{
	label.text = [NSString stringWithFormat:@"G♯, a♯, b♯, C♯, D♯, e♯, fx°"];
	//@"G♯ Ionian:"
	}

	if ([messageFromPicker isEqualToString: testStringAbIonianChords] == YES)
	{
	label.text = [NSString stringWithFormat:@"A♭, b♭, c, D♭, E♭, f, g°"];
	//@"A♭ Ionian:"
	}

	if ([messageFromPicker isEqualToString: testStringAIonianChords] == YES)
	{
	label.text = [NSString stringWithFormat:@"A, b, c♯, D, E, f♯, g♯°"];
	//@"A Ionian:"
	}

	if ([messageFromPicker isEqualToString: testStringASharpIonianChords] == YES)
	{
	label.text = [NSString stringWithFormat:@"A♯, b♯, cx, D♯, E♯, fx, gx°"];
	//@"A♯ Ionian:"
	}

	if ([messageFromPicker isEqualToString: testStringBbIonianChords] == YES)
	{
	label.text = [NSString stringWithFormat:@"B♭, c, d, E♭, F, g, a°"];
	//@"B♭ Ionian:"
	}

	if ([messageFromPicker isEqualToString: testStringBIonianChords] == YES)
	{
	label.text = [NSString stringWithFormat:@"B, c♯, d♯, E, F♯, g♯, a♯°"];
	//@"B Ionian:"
	}

	// *********** DorianChords ifs **********************
	// W 1/2 W W W 1/2 W
	// m, m, M, M, m, °, M

	if ([messageFromPicker isEqualToString: testStringCDorianChords] == YES)
	{
	label.text = [NSString stringWithFormat:@"c, d, E♭, F, g, a°, B♭"];
	//@"C Dorian:"
	}

	if ([messageFromPicker isEqualToString: testStringCSharpDorianChords] == YES)
	{
	label.text = [NSString stringWithFormat:@"c♯, d♯, E, F♯, g♯, a♯°, B"];
	//@"C♯ Dorian:"
	}

	if ([messageFromPicker isEqualToString: testStringDbDorianChords] == YES)
	{
	label.text = [NSString stringWithFormat:@"d♭, e♭, F♭, G♭, a♭, b♭°, C♭"];
	//@"D♭ Dorian:"
	}

	if ([messageFromPicker isEqualToString: testStringDDorianChords] == YES)
	{
	label.text = [NSString stringWithFormat:@"d, e, F, G, a, b°, C"];
	//@"D Dorian:"
	}

	if ([messageFromPicker isEqualToString: testStringDSharpDorianChords] == YES)
	{
	label.text = [NSString stringWithFormat:@"d♯, e♯, F♯, G♯, a♯, b♯°, C♯"];
	//@"D♯ Dorian:"
	}

	if ([messageFromPicker isEqualToString: testStringEbDorianChords] == YES)
	{
	label.text = [NSString stringWithFormat:@"e♭, f, G♭, A♭, b♭, c°, D♭"];
	//@"E♭ Dorian:"
	}

	if ([messageFromPicker isEqualToString: testStringEDorianChords] == YES)
	{
	label.text = [NSString stringWithFormat:@"e, f♯, G, A, b, c♯°, D"];
	//@"E Dorian:"
	}

	if ([messageFromPicker isEqualToString: testStringFDorianChords] == YES)
	{
	label.text = [NSString stringWithFormat:@"f, g, A♭, B♭, c, d°, E♭"];
	//@"F Dorian:"
	}

	if ([messageFromPicker isEqualToString: testStringFSharpDorianChords] == YES)
	{
	label.text = [NSString stringWithFormat:@"f♯, g♯, A, B, c♯, d♯°, E"];
	//@"F♯ Dorian:"
	}

	if ([messageFromPicker isEqualToString: testStringGbDorianChords] == YES)
	{
	label.text = [NSString stringWithFormat:@"g♭, a♭, B♭♭, C♭, d♭, e♭°, F♭"];
	//@"G♭ Dorian:"
	}

	if ([messageFromPicker isEqualToString: testStringGDorianChords] == YES)
	{
	label.text = [NSString stringWithFormat:@"g, a, B♭, C, d, e°, F"];
	//@"G Dorian:"
	}

	if ([messageFromPicker isEqualToString: testStringGSharpDorianChords] == YES)
	{
	label.text = [NSString stringWithFormat:@"g♯, a♯, B, C♯, d♯, e♯°, F♯"];
	//@"G♯ Dorian:"
	}

	if ([messageFromPicker isEqualToString: testStringAbDorianChords] == YES)
	{
	label.text = [NSString stringWithFormat:@"a♭, b♭, C♭, D♭, e♭, f°, G♭"];
	//@"A♭ Dorian:"
	}

	if ([messageFromPicker isEqualToString: testStringADorianChords] == YES)
	{
	label.text = [NSString stringWithFormat:@"a, b, C, D, e, f♯°, G"];
	//@"A Dorian:"
	}

	if ([messageFromPicker isEqualToString: testStringASharpDorianChords] == YES)
	{
	label.text = [NSString stringWithFormat:@"a♯, b♯, C♯, D♯, e♯, fx°, G♯"];
	//@"A♯ Dorian:"
	}

	if ([messageFromPicker isEqualToString: testStringBbDorianChords] == YES)
	{
	label.text = [NSString stringWithFormat:@"b♭, c, D♭, E♭, f, g°, A♭"];
	//@"B♭ Dorian:"
	}

	if ([messageFromPicker isEqualToString: testStringBDorianChords] == YES)
	{
	label.text = [NSString stringWithFormat:@"b, c♯, D, E, f♯, g♯°, A"];
	//@"B Dorian:"
	}

	// *********** PhrygianChords ifs **********************
	// 1/2 W W W 1/2 W W
	// m, M, M, m, °, M, m

	if ([messageFromPicker isEqualToString: testStringCPhrygianChords] == YES)
	{
	label.text = [NSString stringWithFormat:@"c, D♭, E♭, f, g°, A♭, B♭"];
	//@"C Phrygian:"
	}

	if ([messageFromPicker isEqualToString: testStringCSharpPhrygianChords] == YES)
	{
	label.text = [NSString stringWithFormat:@"c♯, D, E, f♯, g♯°, A, b"];
	//@"C♯ Phrygian:"
	}

	if ([messageFromPicker isEqualToString: testStringDbPhrygianChords] == YES)
	{
	label.text = [NSString stringWithFormat:@"d♭, E♭♭, F♭, g♭, a♭°, B♭♭, c♭"];
	//@"D♭ Phrygian:"
	}

	if ([messageFromPicker isEqualToString: testStringDPhrygianChords] == YES)
	{
	label.text = [NSString stringWithFormat:@"d, E♭, F, g, a°, B♭, c"];
	//@"D Phrygian:"
	}

	if ([messageFromPicker isEqualToString: testStringDSharpPhrygianChords] == YES)
	{
	label.text = [NSString stringWithFormat:@"d♯, E, F♯, g♯, a♯°, B, c♯"];
	//@"D♯ Phrygian:"
	}

	if ([messageFromPicker isEqualToString: testStringEbPhrygianChords] == YES)
	{
	label.text = [NSString stringWithFormat:@"e♭, F♭, G♭, a♭, b♭°, C♭, d♭"];
	//@"E♭ Phrygian:"
	}

	if ([messageFromPicker isEqualToString: testStringEPhrygianChords] == YES)
	{
	label.text = [NSString stringWithFormat:@"e, F, G, a, b°, C, d"];
	//@"E Phrygian:"
	}

	if ([messageFromPicker isEqualToString: testStringFPhrygianChords] == YES)
	{
	label.text = [NSString stringWithFormat:@"f, G♭, A♭, b♭, c°, D♭, e♭"];
	//@"F Phrygian:"
	}

	if ([messageFromPicker isEqualToString: testStringFSharpPhrygianChords] == YES)
	{
	label.text = [NSString stringWithFormat:@"f♯, G, A, b, c♯°, D, e"];
	//@"F♯ Phrygian:"
	}

	if ([messageFromPicker isEqualToString: testStringGbPhrygianChords] == YES)
	{
	label.text = [NSString stringWithFormat:@"g♭, A♭♭, B♭♭, c♭, d♭°, E♭♭, f♭"];
	//@"G♭ Phrygian:"
	}

	if ([messageFromPicker isEqualToString: testStringGPhrygianChords] == YES)
	{
	label.text = [NSString stringWithFormat:@"g, A♭, B♭, c, d°, E♭, f"];
	//@"G Phrygian:"
	}

	if ([messageFromPicker isEqualToString: testStringGSharpPhrygianChords] == YES)
	{
	label.text = [NSString stringWithFormat:@"g♯, A, B, c♯, d♯°, E, f♯"];
	//@"G♯ Phrygian:"
	}

	if ([messageFromPicker isEqualToString: testStringAbPhrygianChords] == YES)
	{
	label.text = [NSString stringWithFormat:@"a♭, B♭♭, C♭, d♭, e♭°, F♭, g♭"];
	//@"A♭ Phrygian:"
	}

	if ([messageFromPicker isEqualToString: testStringAPhrygianChords] == YES)
	{
	label.text = [NSString stringWithFormat:@"a, B♭, C, d, e°, F, g"];
	//@"A Phrygian:"
	}

	if ([messageFromPicker isEqualToString: testStringASharpPhrygianChords] == YES)
	{
	label.text = [NSString stringWithFormat:@"a♯, B, C♯, d♯, e♯°, F♯, g♯"];
	//@"A♯ Phrygian:"
	}

	if ([messageFromPicker isEqualToString: testStringBbPhrygianChords] == YES)
	{
	label.text = [NSString stringWithFormat:@"b♭, C♭, D♭, e♭, f°, G♭, a♭"];
	//@"B♭ Phrygian:"
	}

	if ([messageFromPicker isEqualToString: testStringBPhrygianChords] == YES)
	{
	label.text = [NSString stringWithFormat:@"b, C, D, e, f♯°, G, a"];
	//@"B Phrygian:"
	}

	// *********** LydianChords ifs **********************
	// W W W 1/2 W W 1/2
	// M, M, m, °, M, m, m

	if ([messageFromPicker isEqualToString: testStringCLydianChords] == YES)
	{
	label.text = [NSString stringWithFormat:@"C, D, e, f♯°, G, a, b"];
	//@"C Lydian:"
	}

	if ([messageFromPicker isEqualToString: testStringCSharpLydianChords] == YES)
	{
	label.text = [NSString stringWithFormat:@"C♯, D♯, e♯, fx°, G♯, a♯, b♯"];
	//@"C♯ Lydian:"
	}

	if ([messageFromPicker isEqualToString: testStringDbLydianChords] == YES)
	{
	label.text = [NSString stringWithFormat:@"D♭, E♭, f, g°, A♭, b♭, c"];
	//@"D♭ Lydian:"
	}

	if ([messageFromPicker isEqualToString: testStringDLydianChords] == YES)
	{
	label.text = [NSString stringWithFormat:@"D, E, f♯, g♯°, A, b, c♯"];
	//@"D Lydian:"
	}

	if ([messageFromPicker isEqualToString: testStringDSharpLydianChords] == YES)
	{
	label.text = [NSString stringWithFormat:@"D♯, E♯, fx, gx°, A♯, b♯, cx"];
	//@"D♯ Lydian:"
	}

	if ([messageFromPicker isEqualToString: testStringEbLydianChords] == YES)
	{
	label.text = [NSString stringWithFormat:@"E♭, F, g, a°, B♭, c, d"];
	//@"E♭ Lydian:"
	}

	if ([messageFromPicker isEqualToString: testStringELydianChords] == YES)
	{
	label.text = [NSString stringWithFormat:@"E, F♯, g♯, a♯°, B, c♯, Db♯"];
	//@"E Lydian:"
	}

	if ([messageFromPicker isEqualToString: testStringFLydianChords] == YES)
	{
	label.text = [NSString stringWithFormat:@"F, G, a, b°, C, d, e"];
	//@"F Lydian:"
	}

	if ([messageFromPicker isEqualToString: testStringFSharpLydianChords] == YES)
	{
	label.text = [NSString stringWithFormat:@"F♯, G♯, a♯, b♯°, C♯, d♯, e♯"];
	//@"F♯ Lydian:"
	}

	if ([messageFromPicker isEqualToString: testStringGbLydianChords] == YES)
	{
	label.text = [NSString stringWithFormat:@"G♭, A♭, b♭, c°, D♭, e♭, f"];
	//@"G♭ Lydian:"
	}

	if ([messageFromPicker isEqualToString: testStringGLydianChords] == YES)
	{
	label.text = [NSString stringWithFormat:@"G, A, b, c♯°, D, e, f♯"];
	//@"G Lydian:"
	}

	if ([messageFromPicker isEqualToString: testStringGSharpLydianChords] == YES)
	{
	label.text = [NSString stringWithFormat:@"G♯, A♯, b♯, cx°, D♯, e♯, fx"];
	//@"G♯ Lydian:"
	}

	if ([messageFromPicker isEqualToString: testStringAbLydianChords] == YES)
	{
	label.text = [NSString stringWithFormat:@"A♭, B♭, c, d°, E♭, f, g"];
	//@"A♭ Lydian:"
	}

	if ([messageFromPicker isEqualToString: testStringALydianChords] == YES)
	{
	label.text = [NSString stringWithFormat:@"A, B, c♯, d♯°, E, f♯, g♯"];
	//@"A Lydian:"
	}

	if ([messageFromPicker isEqualToString: testStringASharpLydianChords] == YES)
	{
	label.text = [NSString stringWithFormat:@"A♯, B♯, cx, dx°, E♯, fx, gx"];
	//@"A♯ Lydian:"
	}

	if ([messageFromPicker isEqualToString: testStringBbLydianChords] == YES)
	{
	label.text = [NSString stringWithFormat:@"B♭, C, d, e°, F, g, a"];
	//@"B♭ Lydian:"
	}

	if ([messageFromPicker isEqualToString: testStringBLydianChords] == YES)
	{
	label.text = [NSString stringWithFormat:@"B, C♯, d♯, e♯°, F♯, g♯, a♯"];
	//@"B Lydian:"
	}

	// ********************************************************
	// *********** MixolydianChords ifs **********************
	// W W 1/2 W W 1/2 W
	// M, m, °, M, m, m, M

	if ([messageFromPicker isEqualToString: testStringCMixolydianChords] == YES)
	{
	label.text = [NSString stringWithFormat:@"C, d, e°, F, g, a, B♭"];
	//@"C Mixolydian:"
	}

	if ([messageFromPicker isEqualToString: testStringCSharpMixolydianChords] == YES)
	{
	label.text = [NSString stringWithFormat:@"C♯, d♯, e♯°, F♯, g♯, a♯, B"];
	//@"C♯ Mixolydian:"
	}

	if ([messageFromPicker isEqualToString: testStringDbMixolydianChords] == YES)
	{
	label.text = [NSString stringWithFormat:@"D♭, e♭, f°, G♭, a♭, b♭, C♭"];
	//@"D♭ Mixolydian:"
	}

	if ([messageFromPicker isEqualToString: testStringDMixolydianChords] == YES)
	{
	label.text = [NSString stringWithFormat:@"D, e, f♯°, G, a, b, C"];
	//@"D Mixolydian:"
	}

	if ([messageFromPicker isEqualToString: testStringDSharpMixolydianChords] == YES)
	{
	label.text = [NSString stringWithFormat:@"D♯, e♯, fx°, G♯, a♯, b♯, C♯"];
	//@"D♯ Mixolydian:"
	}

	if ([messageFromPicker isEqualToString: testStringEbMixolydianChords] == YES)
	{
	label.text = [NSString stringWithFormat:@"E♭, f, g°, A♭, b♭, c, D♭"];
	//@"E♭ Mixolydian:"
	}

	if ([messageFromPicker isEqualToString: testStringEMixolydianChords] == YES)
	{
	label.text = [NSString stringWithFormat:@"E, f♯, g♯°, A, b, c♯, D"];
	//@"E Mixolydian:"
	}

	if ([messageFromPicker isEqualToString: testStringFMixolydianChords] == YES)
	{
	label.text = [NSString stringWithFormat:@"F, g, a°, B♭, c, d, E♭"];
	//@"F Mixolydian:"
	}

	if ([messageFromPicker isEqualToString: testStringFSharpMixolydianChords] == YES)
	{
	label.text = [NSString stringWithFormat:@"F♯, g♯, a♯°, B, c♯, d♯, E"];
	//@"F♯ Mixolydian:"
	}

	if ([messageFromPicker isEqualToString: testStringGbMixolydianChords] == YES)
	{
	label.text = [NSString stringWithFormat:@"G♭, a♭, b♭°, C♭, d♭, e♭, F♭"];
	//@"G♭ Mixolydian:"
	}

	if ([messageFromPicker isEqualToString: testStringGMixolydianChords] == YES)
	{
	label.text = [NSString stringWithFormat:@"G, a, b°, C, d, e, F"];
	//@"G Mixolydian:"
	}

	if ([messageFromPicker isEqualToString: testStringGSharpMixolydianChords] == YES)
	{
	label.text = [NSString stringWithFormat:@"G♯, a♯, b♯°, C♯, d♯, e♯, F♯"];
	//@"G♯ Mixolydian:"
	}

	if ([messageFromPicker isEqualToString: testStringAbMixolydianChords] == YES)
	{
	label.text = [NSString stringWithFormat:@"A♭, b♭, c°, D♭, e♭, f, G♭"];
	//@"A♭ Mixolydian:"
	}

	if ([messageFromPicker isEqualToString: testStringAMixolydianChords] == YES)
	{
	label.text = [NSString stringWithFormat:@"A, b, c♯°, D, e, f♯, G"];
	//@"A Mixolydian:"
	}

	if ([messageFromPicker isEqualToString: testStringASharpMixolydianChords] == YES)
	{
	label.text = [NSString stringWithFormat:@"A♯, b♯, cx°, D♯, e♯, fx, G♯"];
	//@"A♯ Mixolydian:"
	}

	if ([messageFromPicker isEqualToString: testStringBbMixolydianChords] == YES)
	{
	label.text = [NSString stringWithFormat:@"B♭, c, d°, E♭, f, g, A♭"];
	//@"B♭ Mixolydian:"
	}

	if ([messageFromPicker isEqualToString: testStringBMixolydianChords] == YES)
	{
	label.text = [NSString stringWithFormat:@"B, c♯, d♯°, E, f♯, g♯, A"];
	//@"B Mixolydian:"
	}

	// *********** AeolianChords ifs **********************
	// W 1/2 W W 1/2 W W
	// m, °, M, m, m, M, M

	if ([messageFromPicker isEqualToString: testStringCAeolianChords] == YES)
	{
	label.text = [NSString stringWithFormat:@"c, d°, E♭, f, g, A♭, B♭"];
	//@"C Aeolian:"
	}

	if ([messageFromPicker isEqualToString: testStringCSharpAeolianChords] == YES)
	{
	label.text = [NSString stringWithFormat:@"c♯, d♯°, E, f♯, g♯, A, B"];
	//@"C♯ Aeolian:"
	}

	if ([messageFromPicker isEqualToString: testStringDbAeolianChords] == YES)
	{
	label.text = [NSString stringWithFormat:@"d♭, e♭°, F♭, g♭, a♭, B♭♭, C♭"];
	//@"D♭ Aeolian:"
	}

	if ([messageFromPicker isEqualToString: testStringDAeolianChords] == YES)
	{
	label.text = [NSString stringWithFormat:@"d, e°, F, g, a, B♭, C"];
	//@"D Aeolian:"
	}

	if ([messageFromPicker isEqualToString: testStringDSharpAeolianChords] == YES)
	{
	label.text = [NSString stringWithFormat:@"d♯, e♯°, F♯, g♯, a♯, B, C♯"];
	//@"D♯ Aeolian:"
	}

	if ([messageFromPicker isEqualToString: testStringEbAeolianChords] == YES)
	{
	label.text = [NSString stringWithFormat:@"e♭, f°, G♭, a♭, b♭, C♭, D♭"];
	//@"E♭ Aeolian:"
	}

	if ([messageFromPicker isEqualToString: testStringEAeolianChords] == YES)
	{
	label.text = [NSString stringWithFormat:@"e, f♯°, G, a, b, C, D"];
	//@"E Aeolian:"
	}

	if ([messageFromPicker isEqualToString: testStringFAeolianChords] == YES)
	{
	label.text = [NSString stringWithFormat:@"f, g°, A♭, b♭, c, D♭, E♭"];
	//@"F Aeolian:"
	}

	if ([messageFromPicker isEqualToString: testStringFSharpAeolianChords] == YES)
	{
	label.text = [NSString stringWithFormat:@"f♯, g♯°, A, b, c♯, D, E"];
	//@"F♯ Aeolian:"
	}

	if ([messageFromPicker isEqualToString: testStringGbAeolianChords] == YES)
	{
	label.text = [NSString stringWithFormat:@"g♭, a♭°, B♭♭, c♭, d♭, E♭♭, F♭"];
	//@"G♭ Aeolian:"
	}

	if ([messageFromPicker isEqualToString: testStringGAeolianChords] == YES)
	{
	label.text = [NSString stringWithFormat:@"g, a°, B♭, c, d, E♭, F"];
	//@"G Aeolian:"
	}

	if ([messageFromPicker isEqualToString: testStringGSharpAeolianChords] == YES)
	{
	label.text = [NSString stringWithFormat:@"g♯, a♯°, B, c♯, d♯, E, F♯"];
	//@"G♯ Aeolian:"
	}

	if ([messageFromPicker isEqualToString: testStringAbAeolianChords] == YES)
	{
	label.text = [NSString stringWithFormat:@"a♭, b♭°, C♭, d♭, e♭, F♭, G♭"];
	//@"A♭ Aeolian:"
	}

	if ([messageFromPicker isEqualToString: testStringAAeolianChords] == YES)
	{
	label.text = [NSString stringWithFormat:@"a, b°, C, d, e, F, G"];
	//@"A Aeolian:"
	}

	if ([messageFromPicker isEqualToString: testStringASharpAeolianChords] == YES)
	{
	label.text = [NSString stringWithFormat:@"a♯, b♯°, C♯, d♯, e♯, F♯, G♯"];
	//@"A♯ Aeolian:"
	}

	if ([messageFromPicker isEqualToString: testStringBbAeolianChords] == YES)
	{
	label.text = [NSString stringWithFormat:@"b♭, c°, D♭, e♭, f, G♭, A♭"];
	//@"B♭ Aeolian:"
	}

	if ([messageFromPicker isEqualToString: testStringBAeolianChords] == YES)
	{
	label.text = [NSString stringWithFormat:@"b, c♯°, D, e, f♯, G, A"];
	//@"B Aeolian:"
	}

	// *********** LocrianChords ifs **********************
	// 1/2 W W 1/2 W W Ws
	// °, M, m, m, M, M, m

	if ([messageFromPicker isEqualToString: testStringCLocrianChords] == YES)
	{
	label.text = [NSString stringWithFormat:@"c°, D♭, e♭, f, G♭, A♭, B♭"];
	//@"C Locrian:"
	}

	if ([messageFromPicker isEqualToString: testStringCSharpLocrianChords] == YES)
	{
	label.text = [NSString stringWithFormat:@"c♯°, D, e, f♯, G, A, b"];
	//@"C♯ Locrian:"
	}

	if ([messageFromPicker isEqualToString: testStringDbLocrianChords] == YES)
	{
	label.text = [NSString stringWithFormat:@"d♭°, E♭♭, f♭, g♭, A♭♭, B♭♭, c♭"];
	//@"D♭ Locrian:"
	}

	if ([messageFromPicker isEqualToString: testStringDLocrianChords] == YES)
	{
	label.text = [NSString stringWithFormat:@"d°, E♭, f, g, A♭, B♭, c"];
	//@"D Locrian:"
	}

	if ([messageFromPicker isEqualToString: testStringDSharpLocrianChords] == YES)
	{
	label.text = [NSString stringWithFormat:@"d♯°, E, f♯, g♯, A, B, c♯"];
	//@"D♯ Locrian:"
	}

	if ([messageFromPicker isEqualToString: testStringEbLocrianChords] == YES)
	{
	label.text = [NSString stringWithFormat:@"e♭°, F♭, g♭, a♭, B♭♭, C♭, d♭"];
	//@"E♭ Locrian:"
	}

	if ([messageFromPicker isEqualToString: testStringELocrianChords] == YES)
	{
	label.text = [NSString stringWithFormat:@"e°, F, g, a, B♭, C, d"];
	//@"E Locrian:"
	}

	if ([messageFromPicker isEqualToString: testStringFLocrianChords] == YES)
	{
	label.text = [NSString stringWithFormat:@"f°, G♭, a♭, b♭, C♭, D♭, e♭"];
	//@"F Locrian:"
	}

	if ([messageFromPicker isEqualToString: testStringFSharpLocrianChords] == YES)
	{
	label.text = [NSString stringWithFormat:@"f♯°, G, a, b, C, D, e"];
	//@"F♯ Locrian:"
	}

	if ([messageFromPicker isEqualToString: testStringGbLocrianChords] == YES)
	{
	label.text = [NSString stringWithFormat:@"g♭°, A♭♭, b♭♭, c♭, D♭♭, E♭♭, f♭"];
	//@"G♭ Locrian:"
	}

	if ([messageFromPicker isEqualToString: testStringGLocrianChords] == YES)
	{
	label.text = [NSString stringWithFormat:@"g°, A♭, b♭, c, D♭, E♭, f"];
	//@"G Locrian:"
	}

	if ([messageFromPicker isEqualToString: testStringGSharpLocrianChords] == YES)
	{
	label.text = [NSString stringWithFormat:@"g♯°, A, b, c♯, D, E, f♯"];
	//@"G♯ Locrian:"
	}

	if ([messageFromPicker isEqualToString: testStringAbLocrianChords] == YES)
	{
	label.text = [NSString stringWithFormat:@"a♭°, B♭♭, c♭, d♭, E♭♭, F♭, g♭"];
	//@"A♭ Locrian:"
	}

	if ([messageFromPicker isEqualToString: testStringALocrianChords] == YES)
	{
	label.text = [NSString stringWithFormat:@"a°, B♭, c, d, E♭, F, g"];
	//@"A Locrian:"
	}

	if ([messageFromPicker isEqualToString: testStringASharpLocrianChords] == YES)
	{
	label.text = [NSString stringWithFormat:@"a♯°, B, c♯, d♯, E, F♯, g♯"];
	//@"A♯ Locrian:"
	}

	if ([messageFromPicker isEqualToString: testStringBbLocrianChords] == YES)
	{
	label.text = [NSString stringWithFormat:@"b♭°, C♭, d♭, e♭, F♭, G♭, a♭"];
	//@"B♭ Locrian:"
	}

	if ([messageFromPicker isEqualToString: testStringBLocrianChords] == YES)
	{
	label.text = [NSString stringWithFormat:@"b°, C, d, e, F, G, a"];
	//@"B Locrian:"
	}	
	
	// ********************************************************

	// ELSE UIAlertView ************************************************
	else 
	{
	/*
		do something cool
	*/
	}

	// ***TEST STRING AUTORELEASE *******************************************
	// *********** MAJOR TEST STRING RELEASE **********************
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

	// *********** MINOR TEST STRING RELEASE **********************
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

	// *********** IonianChords TEST STRING RELEASE **********************
	[testStringCIonianChords autorelease];
	[testStringCSharpIonianChords autorelease];
	[testStringDbIonianChords autorelease];
	[testStringDIonianChords autorelease];
	[testStringDSharpIonianChords autorelease];
	[testStringEbIonianChords autorelease];
	[testStringEIonianChords autorelease];
	[testStringFIonianChords autorelease];
	[testStringFSharpIonianChords autorelease];
	[testStringGbIonianChords autorelease];
	[testStringGIonianChords autorelease];
	[testStringGSharpIonianChords autorelease];
	[testStringAbIonianChords autorelease];
	[testStringAIonianChords autorelease];
	[testStringASharpIonianChords autorelease];
	[testStringBbIonianChords autorelease];
	[testStringBIonianChords autorelease];

	// *********** DorianChords TEST STRING RELEASE **********************
	[testStringCDorianChords autorelease];
	[testStringCSharpDorianChords autorelease];
	[testStringDbDorianChords autorelease];
	[testStringDDorianChords autorelease];
	[testStringDSharpDorianChords autorelease];
	[testStringEbDorianChords autorelease];
	[testStringEDorianChords autorelease];
	[testStringFDorianChords autorelease];
	[testStringFSharpDorianChords autorelease];
	[testStringGbDorianChords autorelease];
	[testStringGDorianChords autorelease];
	[testStringGSharpDorianChords autorelease];
	[testStringAbDorianChords autorelease];
	[testStringADorianChords autorelease];
	[testStringASharpDorianChords autorelease];
	[testStringBbDorianChords autorelease];
	[testStringBDorianChords autorelease];

	// *********** PhrygianChords TEST STRING RELEASE **********************
	[testStringCPhrygianChords autorelease];
	[testStringCSharpPhrygianChords autorelease];
	[testStringDbPhrygianChords autorelease];
	[testStringDPhrygianChords autorelease];
	[testStringDSharpPhrygianChords autorelease];
	[testStringEbPhrygianChords autorelease];
	[testStringEPhrygianChords autorelease];
	[testStringFPhrygianChords autorelease];
	[testStringFSharpPhrygianChords autorelease];
	[testStringGbPhrygianChords autorelease];
	[testStringGPhrygianChords autorelease];
	[testStringGSharpPhrygianChords autorelease];
	[testStringAbPhrygianChords autorelease];
	[testStringAPhrygianChords autorelease];
	[testStringASharpPhrygianChords autorelease];
	[testStringBbPhrygianChords autorelease];
	[testStringBPhrygianChords autorelease];

	// *********** LydianChords TEST STRING RELEASE ***********
	[testStringCLydianChords autorelease];
	[testStringCSharpLydianChords autorelease];
	[testStringDbLydianChords autorelease];
	[testStringDLydianChords autorelease];
	[testStringDSharpLydianChords autorelease];
	[testStringEbLydianChords autorelease];
	[testStringELydianChords autorelease];
	[testStringFLydianChords autorelease];
	[testStringFSharpLydianChords autorelease];
	[testStringGbLydianChords autorelease];
	[testStringGLydianChords autorelease];
	[testStringGSharpLydianChords autorelease];
	[testStringAbLydianChords autorelease];
	[testStringALydianChords autorelease];
	[testStringASharpLydianChords autorelease];
	[testStringBbLydianChords autorelease];
	[testStringBLydianChords autorelease];

	// *********** MixolydianChords TEST STRING RELEASE **********************
	[testStringCMixolydianChords autorelease];
	[testStringCSharpMixolydianChords autorelease];
	[testStringDbMixolydianChords autorelease];
	[testStringDMixolydianChords autorelease];
	[testStringDSharpMixolydianChords autorelease];
	[testStringEbMixolydianChords autorelease];
	[testStringEMixolydianChords autorelease];
	[testStringFMixolydianChords autorelease];
	[testStringFSharpMixolydianChords autorelease];
	[testStringGbMixolydianChords autorelease];
	[testStringGMixolydianChords autorelease];
	[testStringGSharpMixolydianChords autorelease];
	[testStringAbMixolydianChords autorelease];
	[testStringAMixolydianChords autorelease];
	[testStringASharpMixolydianChords autorelease];
	[testStringBbMixolydianChords autorelease];
	[testStringBMixolydianChords autorelease];

	// *********** AeolianChords TEST STRING RELEASE **********************
	[testStringCAeolianChords autorelease];
	[testStringCSharpAeolianChords autorelease];
	[testStringDbAeolianChords autorelease];
	[testStringDAeolianChords autorelease];
	[testStringDSharpAeolianChords autorelease];
	[testStringEbAeolianChords autorelease];
	[testStringEAeolianChords autorelease];
	[testStringFAeolianChords autorelease];
	[testStringFSharpAeolianChords autorelease];
	[testStringGbAeolianChords autorelease];
	[testStringGAeolianChords autorelease];
	[testStringGSharpAeolianChords autorelease];
	[testStringAbAeolianChords autorelease];
	[testStringAAeolianChords autorelease];
	[testStringASharpAeolianChords autorelease];
	[testStringBbAeolianChords autorelease];
	[testStringBAeolianChords autorelease];

	// *********** LocrianChords TEST STRING RELEASE **********************
	[testStringCLocrianChords autorelease];
	[testStringCSharpLocrianChords autorelease];
	[testStringDbLocrianChords autorelease];
	[testStringDLocrianChords autorelease];
	[testStringDSharpLocrianChords autorelease];
	[testStringEbLocrianChords autorelease];
	[testStringELocrianChords autorelease];
	[testStringFLocrianChords autorelease];
	[testStringFSharpLocrianChords autorelease];
	[testStringGbLocrianChords autorelease];
	[testStringGLocrianChords autorelease];
	[testStringGSharpLocrianChords autorelease];
	[testStringAbLocrianChords autorelease];
	[testStringALocrianChords autorelease];
	[testStringASharpLocrianChords autorelease];
	[testStringBbLocrianChords autorelease];
	[testStringBLocrianChords autorelease];

	// ********************************************************
	// ^*^^^^^^*^*^^*^*^*^*^^^^^*^*^^*^*^*^*^^*^*^*^^*^*^*^*^^^^^*^*^

}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
	// Initialization code
}
return self;
}

// arrays
- (void)viewDidLoad {
NSArray *breadArray = [[NSArray alloc] initWithObjects:@"Major", @"Minor", @"Ionian", @"Dorian", @"Phrygian", @"Lydian", @"Mixolydian", @"Aeolian", @"Locrian", nil];
self.keyTypes = breadArray;
[breadArray release];

NSArray *rootArray = [[NSArray alloc] initWithObjects:@"C", @"C♯", @"D♭", @"D", @"D♯", @"E♭", @"E", @"F", @"F♯", @"G♭", @"G", @"G♯", @"A♭", @"A", @"A♯", @"B♭", @"B", nil];
self.keyRoot = rootArray;
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
[keyTypes release];
[keyRoot release];
[super dealloc];
}

#pragma mark -
#pragma mark Picker Data Source Methods
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
return 2;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
if (component == kKeyComponent)
	return [self.keyTypes count];

return [self.keyRoot count];
}

#pragma mark Picker Delegate Methods
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
if (component == kKeyComponent)
	return [self.keyTypes objectAtIndex:row];

return [self.keyRoot objectAtIndex:row];
}

@end
