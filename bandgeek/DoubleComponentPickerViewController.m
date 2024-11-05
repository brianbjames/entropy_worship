//
//  DoubleComponentPickerViewController.m
//  Harmony
//
//  Created by Brian B. James on 5/24/09.
//  Copyright Brian B. James 2009. All rights reserved.
//

/*
 ********** BUG BUG BUG BUG BUG BUG BUG BUG BUG *********************************
 ********** BUG BUG BUG BUG BUG BUG BUG BUG BUG *********************************
 ********** BUG BUG BUG BUG BUG BUG BUG BUG BUG *********************************
 ********** BUG BUG BUG BUG BUG BUG BUG BUG BUG *********************************
 
 Make sure all of the Half-Diminished and Fully Diminished Chords are correct. 
 
 Add email support:
 [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@""mailto:brianb.james@mac.com?subject=Bug Alert&message=BUG"]];
 
 */

#import "DoubleComponentPickerViewController.h"

@implementation DoubleComponentPickerViewController

@synthesize doublePicker;
@synthesize chordTypes; 
@synthesize chordRoot;
@synthesize label;
@synthesize inversionTypes;

- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
	if (component == kRootComponent)
		return 55;
	if (component == kChordComponent)
		return 180;
	return 65;
}

// didSeclectRow
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
	NSInteger chordRow = [doublePicker selectedRowInComponent:kChordComponent];
	NSInteger rootRow = [doublePicker selectedRowInComponent:kRootComponent];
	NSInteger inversionRow = [doublePicker selectedRowInComponent:kInversionComponent];
	
	NSString *chord = [self.chordTypes objectAtIndex:chordRow];
	NSString *theRoot = [self.chordRoot objectAtIndex:rootRow];
	NSString *theInversion = [self.inversionTypes objectAtIndex:inversionRow];
	
	// THE MESSAGE FROM THE PICKER
	NSMutableString *messageFromPicker = [[NSMutableString alloc] initWithFormat:@"%@ %@ %@", theRoot, chord, theInversion];
	
	// *********** MAJOR TEST STRINGS **********************
	NSString *testStringCMajor = @"C Major 5";
	NSString *testStringCSharpMajor = @"C♯ Major 5";
	NSString *testStringDbMajor = @"D♭ Major 5";
	NSString *testStringDMajor = @"D Major 5";
	NSString *testStringDSharpMajor = @"D♯ Major 5";
	NSString *testStringEbMajor = @"E♭ Major 5";
	NSString *testStringEMajor = @"E Major 5";
	NSString *testStringFMajor = @"F Major 5";
	NSString *testStringFSharpMajor = @"F♯ Major 5";
	NSString *testStringGbMajor = @"G♭ Major 5";
	NSString *testStringGMajor = @"G Major 5";
	NSString *testStringGSharpMajor = @"G♯ Major 5";
	NSString *testStringAbMajor = @"A♭ Major 5";
	NSString *testStringAMajor = @"A Major 5";
	NSString *testStringASharpMajor = @"A♯ Major 5";
	NSString *testStringBbMajor = @"B♭ Major 5";
	NSString *testStringBMajor = @"B Major 5";
	
	// *********** MINOR TEST STRINGS **********************
	NSString *testStringCMinor = @"C Minor 5";
	NSString *testStringCSharpMinor = @"C♯ Minor 5";
	NSString *testStringDbMinor = @"D♭ Minor 5";
	NSString *testStringDMinor = @"D Minor 5";
	NSString *testStringDSharpMinor = @"D♯ Minor 5";
	NSString *testStringEbMinor = @"E♭ Minor 5";
	NSString *testStringEMinor = @"E Minor 5";
	NSString *testStringFMinor = @"F Minor 5";
	NSString *testStringFSharpMinor = @"F♯ Minor 5";
	NSString *testStringGbMinor = @"G♭ Minor 5";
	NSString *testStringGMinor = @"G Minor 5";
	NSString *testStringGSharpMinor = @"G♯ Minor 5";
	NSString *testStringAbMinor = @"A♭ Minor 5";
	NSString *testStringAMinor = @"A Minor 5";
	NSString *testStringASharpMinor = @"A♯ Minor 5";
	NSString *testStringBbMinor = @"B♭ Minor 5";
	NSString *testStringBMinor = @"B Minor 5";
	
	// *********** AUGMENTED TEST STRINGS **********************
	NSString *testStringCAugmented = @"C Augmented 5";
	NSString *testStringCSharpAugmented = @"C♯ Augmented 5";
	NSString *testStringDbAugmented = @"D♭ Augmented 5";
	NSString *testStringDAugmented = @"D Augmented 5";
	NSString *testStringDSharpAugmented = @"D♯ Augmented 5";
	NSString *testStringEbAugmented = @"E♭ Augmented 5";
	NSString *testStringEAugmented = @"E Augmented 5";
	NSString *testStringFAugmented = @"F Augmented 5";
	NSString *testStringFSharpAugmented = @"F♯ Augmented 5";
	NSString *testStringGbAugmented = @"G♭ Augmented 5";
	NSString *testStringGAugmented = @"G Augmented 5";
	NSString *testStringGSharpAugmented = @"G♯ Augmented 5";
	NSString *testStringAbAugmented = @"A♭ Augmented 5";
	NSString *testStringAAugmented = @"A Augmented 5";
	NSString *testStringASharpAugmented = @"A♯ Augmented 5";
	NSString *testStringBbAugmented = @"B♭ Augmented 5";
	NSString *testStringBAugmented = @"B Augmented 5";
	
	// *********** DIMINISHED TEST STRINGS **********************
	NSString *testStringCDiminished = @"C Diminished 5";
	NSString *testStringCSharpDiminished = @"C♯ Diminished 5";
	NSString *testStringDbDiminished = @"D♭ Diminished 5";
	NSString *testStringDDiminished = @"D Diminished 5";
	NSString *testStringDSharpDiminished = @"D♯ Diminished 5";
	NSString *testStringEbDiminished = @"E♭ Diminished 5";
	NSString *testStringEDiminished = @"E Diminished 5";
	NSString *testStringFDiminished = @"F Diminished 5";
	NSString *testStringFSharpDiminished = @"F♯ Diminished 5";
	NSString *testStringGbDiminished = @"G♭ Diminished 5";
	NSString *testStringGDiminished = @"G Diminished 5";
	NSString *testStringGSharpDiminished = @"G♯ Diminished 5";
	NSString *testStringAbDiminished = @"A♭ Diminished 5";
	NSString *testStringADiminished = @"A Diminished 5";
	NSString *testStringASharpDiminished = @"A♯ Diminished 5";
	NSString *testStringBbDiminished = @"B♭ Diminished 5";
	NSString *testStringBDiminished = @"B Diminished 5";
	
	// *********** Major6 TEST STRINGS **********************
	NSString *testStringCMajor6 = @"C Major 6";
	NSString *testStringCSharpMajor6 = @"C♯ Major 6";
	NSString *testStringDbMajor6 = @"D♭ Major 6";
	NSString *testStringDMajor6 = @"D Major 6";
	NSString *testStringDSharpMajor6 = @"D♯ Major 6";
	NSString *testStringEbMajor6 = @"E♭ Major 6";
	NSString *testStringEMajor6 = @"E Major 6";
	NSString *testStringFMajor6 = @"F Major 6";
	NSString *testStringFSharpMajor6 = @"F♯ Major 6";
	NSString *testStringGbMajor6 = @"G♭ Major 6";
	NSString *testStringGMajor6 = @"G Major 6";
	NSString *testStringGSharpMajor6 = @"G♯ Major 6";
	NSString *testStringAbMajor6 = @"A♭ Major 6";
	NSString *testStringAMajor6 = @"A Major 6";
	NSString *testStringASharpMajor6 = @"A♯ Major 6";
	NSString *testStringBbMajor6 = @"B♭ Major 6";
	NSString *testStringBMajor6 = @"B Major 6";
	
	// *********** Minor6 TEST STRINGS **********************
	NSString *testStringCMinor6 = @"C Minor 6";
	NSString *testStringCSharpMinor6 = @"C♯ Minor 6";
	NSString *testStringDbMinor6 = @"D♭ Minor 6";
	NSString *testStringDMinor6 = @"D Minor 6";
	NSString *testStringDSharpMinor6 = @"D♯ Minor 6";
	NSString *testStringEbMinor6 = @"E♭ Minor 6";
	NSString *testStringEMinor6 = @"E Minor 6";
	NSString *testStringFMinor6 = @"F Minor 6";
	NSString *testStringFSharpMinor6 = @"F♯ Minor 6";
	NSString *testStringGbMinor6 = @"G♭ Minor 6";
	NSString *testStringGMinor6 = @"G Minor 6";
	NSString *testStringGSharpMinor6 = @"G♯ Minor 6";
	NSString *testStringAbMinor6 = @"A♭ Minor 6";
	NSString *testStringAMinor6 = @"A Minor 6";
	NSString *testStringASharpMinor6 = @"A♯ Minor 6";
	NSString *testStringBbMinor6 = @"B♭ Minor 6";
	NSString *testStringBMinor6 = @"B Minor 6";
	
	// *********** Augmented6 TEST STRINGS **********************
	NSString *testStringCAugmented6 = @"C Augmented 6";
	NSString *testStringCSharpAugmented6 = @"C♯ Augmented 6";
	NSString *testStringDbAugmented6 = @"D♭ Augmented 6";
	NSString *testStringDAugmented6 = @"D Augmented 6";
	NSString *testStringDSharpAugmented6 = @"D♯ Augmented 6";
	NSString *testStringEbAugmented6 = @"E♭ Augmented 6";
	NSString *testStringEAugmented6 = @"E Augmented 6";
	NSString *testStringFAugmented6 = @"F Augmented 6";
	NSString *testStringFSharpAugmented6 = @"F♯ Augmented 6";
	NSString *testStringGbAugmented6 = @"G♭ Augmented 6";
	NSString *testStringGAugmented6 = @"G Augmented 6";
	NSString *testStringGSharpAugmented6 = @"G♯ Augmented 6";
	NSString *testStringAbAugmented6 = @"A♭ Augmented 6";
	NSString *testStringAAugmented6 = @"A Augmented 6";
	NSString *testStringASharpAugmented6 = @"A♯ Augmented 6";
	NSString *testStringBbAugmented6 = @"B♭ Augmented 6";
	NSString *testStringBAugmented6 = @"B Augmented 6";
	
	// *********** Diminished6 TEST STRINGS **********************
	NSString *testStringCDiminished6 = @"C Diminished 6";
	NSString *testStringCSharpDiminished6 = @"C♯ Diminished 6";
	NSString *testStringDbDiminished6 = @"D♭ Diminished 6";
	NSString *testStringDDiminished6 = @"D Diminished 6";
	NSString *testStringDSharpDiminished6 = @"D♯ Diminished 6";
	NSString *testStringEbDiminished6 = @"E♭ Diminished 6";
	NSString *testStringEDiminished6 = @"E Diminished 6";
	NSString *testStringFDiminished6 = @"F Diminished 6";
	NSString *testStringFSharpDiminished6 = @"F♯ Diminished 6";
	NSString *testStringGbDiminished6 = @"G♭ Diminished 6";
	NSString *testStringGDiminished6 = @"G Diminished 6";
	NSString *testStringGSharpDiminished6 = @"G♯ Diminished 6";
	NSString *testStringAbDiminished6 = @"A♭ Diminished 6";
	NSString *testStringADiminished6 = @"A Diminished 6";
	NSString *testStringASharpDiminished6 = @"A♯ Diminished 6";
	NSString *testStringBbDiminished6 = @"B♭ Diminished 6";
	NSString *testStringBDiminished6 = @"B Diminished 6";
	
	// *********** Major64 TEST STRINGS **********************
	NSString *testStringCMajor64 = @"C Major 6-4";
	NSString *testStringCSharpMajor64 = @"C♯ Major 6-4";
	NSString *testStringDbMajor64 = @"D♭ Major 6-4";
	NSString *testStringDMajor64 = @"D Major 6-4";
	NSString *testStringDSharpMajor64 = @"D♯ Major 6-4";
	NSString *testStringEbMajor64 = @"E♭ Major 6-4";
	NSString *testStringEMajor64 = @"E Major 6-4";
	NSString *testStringFMajor64 = @"F Major 6-4";
	NSString *testStringFSharpMajor64 = @"F♯ Major 6-4";
	NSString *testStringGbMajor64 = @"G♭ Major 6-4";
	NSString *testStringGMajor64 = @"G Major 6-4";
	NSString *testStringGSharpMajor64 = @"G♯ Major 6-4";
	NSString *testStringAbMajor64 = @"A♭ Major 6-4";
	NSString *testStringAMajor64 = @"A Major 6-4";
	NSString *testStringASharpMajor64 = @"A♯ Major 6-4";
	NSString *testStringBbMajor64 = @"B♭ Major 6-4";
	NSString *testStringBMajor64 = @"B Major 6-4";
	
	// *********** Minor64 TEST STRINGS **********************
	NSString *testStringCMinor64 = @"C Minor 6-4";
	NSString *testStringCSharpMinor64 = @"C♯ Minor 6-4";
	NSString *testStringDbMinor64 = @"D♭ Minor 6-4";
	NSString *testStringDMinor64 = @"D Minor 6-4";
	NSString *testStringDSharpMinor64 = @"D♯ Minor 6-4";
	NSString *testStringEbMinor64 = @"E♭ Minor 6-4";
	NSString *testStringEMinor64 = @"E Minor 6-4";
	NSString *testStringFMinor64 = @"F Minor 6-4";
	NSString *testStringFSharpMinor64 = @"F♯ Minor 6-4";
	NSString *testStringGbMinor64 = @"G♭ Minor 6-4";
	NSString *testStringGMinor64 = @"G Minor 6-4";
	NSString *testStringGSharpMinor64 = @"G♯ Minor 6-4";
	NSString *testStringAbMinor64 = @"A♭ Minor 6-4";
	NSString *testStringAMinor64 = @"A Minor 6-4";
	NSString *testStringASharpMinor64 = @"A♯ Minor 6-4";
	NSString *testStringBbMinor64 = @"B♭ Minor 6-4";
	NSString *testStringBMinor64 = @"B Minor 6-4";
	
	// *********** Augmented64 TEST STRINGS **********************
	NSString *testStringCAugmented64 = @"C Augmented 6-4";
	NSString *testStringCSharpAugmented64 = @"C♯ Augmented 6-4";
	NSString *testStringDbAugmented64 = @"D♭ Augmented 6-4";
	NSString *testStringDAugmented64 = @"D Augmented 6-4";
	NSString *testStringDSharpAugmented64 = @"D♯ Augmented 6-4";
	NSString *testStringEbAugmented64 = @"E♭ Augmented 6-4";
	NSString *testStringEAugmented64 = @"E Augmented 6-4";
	NSString *testStringFAugmented64 = @"F Augmented 6-4";
	NSString *testStringFSharpAugmented64 = @"F♯ Augmented 6-4";
	NSString *testStringGbAugmented64 = @"G♭ Augmented 6-4";
	NSString *testStringGAugmented64 = @"G Augmented 6-4";
	NSString *testStringGSharpAugmented64 = @"G♯ Augmented 6-4";
	NSString *testStringAbAugmented64 = @"A♭ Augmented 6-4";
	NSString *testStringAAugmented64 = @"A Augmented 6-4";
	NSString *testStringASharpAugmented64 = @"A♯ Augmented 6-4";
	NSString *testStringBbAugmented64 = @"B♭ Augmented 6-4";
	NSString *testStringBAugmented64 = @"B Augmented 6-4";
	
	// *********** Diminished64 TEST STRINGS **********************
	NSString *testStringCDiminished64 = @"C Diminished 6-4";
	NSString *testStringCSharpDiminished64 = @"C♯ Diminished 6-4";
	NSString *testStringDbDiminished64 = @"D♭ Diminished 6-4";
	NSString *testStringDDiminished64 = @"D Diminished 6-4";
	NSString *testStringDSharpDiminished64 = @"D♯ Diminished 6-4";
	NSString *testStringEbDiminished64 = @"E♭ Diminished 6-4";
	NSString *testStringEDiminished64 = @"E Diminished 6-4";
	NSString *testStringFDiminished64 = @"F Diminished 6-4";
	NSString *testStringFSharpDiminished64 = @"F♯ Diminished 6-4";
	NSString *testStringGbDiminished64 = @"G♭ Diminished 6-4";
	NSString *testStringGDiminished64 = @"G Diminished 6-4";
	NSString *testStringGSharpDiminished64 = @"G♯ Diminished 6-4";
	NSString *testStringAbDiminished64 = @"A♭ Diminished 6-4";
	NSString *testStringADiminished64 = @"A Diminished 6-4";
	NSString *testStringASharpDiminished64 = @"A♯ Diminished 6-4";
	NSString *testStringBbDiminished64 = @"B♭ Diminished 6-4";
	NSString *testStringBDiminished64 = @"B Diminished 6-4";
	
	// *********** Italian +6 TEST STRINGS **********************
	//NSMutableString and %@ to ignore theInversion, or rather to make the string comparison work with any inversion
	NSMutableString *testStringCItalian = [[NSMutableString alloc] initWithFormat:@"C Italian +6 %@", theInversion];
	NSMutableString *testStringCSharpItalian = [[NSMutableString alloc] initWithFormat:@"C♯ Italian +6 %@", theInversion];
	NSMutableString *testStringDbItalian = [[NSMutableString alloc] initWithFormat:@"D♭ Italian +6 %@", theInversion];
	NSMutableString *testStringDItalian = [[NSMutableString alloc] initWithFormat:@"D Italian +6 %@", theInversion];
	NSMutableString *testStringDSharpItalian = [[NSMutableString alloc] initWithFormat:@"D♯ Italian +6 %@", theInversion];
	NSMutableString *testStringEbItalian = [[NSMutableString alloc] initWithFormat:@"E♭ Italian +6 %@", theInversion];
	NSMutableString *testStringEItalian = [[NSMutableString alloc] initWithFormat:@"E Italian +6 %@", theInversion];
	NSMutableString *testStringFItalian = [[NSMutableString alloc] initWithFormat:@"F Italian +6 %@", theInversion];
	NSMutableString *testStringFSharpItalian = [[NSMutableString alloc] initWithFormat:@"F♯ Italian +6 %@", theInversion];
	NSMutableString *testStringGbItalian = [[NSMutableString alloc] initWithFormat:@"G♭ Italian +6 %@", theInversion];
	NSMutableString *testStringGItalian = [[NSMutableString alloc] initWithFormat:@"G Italian +6 %@", theInversion];
	NSMutableString *testStringGSharpItalian = [[NSMutableString alloc] initWithFormat:@"G♯ Italian +6 %@", theInversion];
	NSMutableString *testStringAbItalian = [[NSMutableString alloc] initWithFormat:@"A♭ Italian +6 %@", theInversion];
	NSMutableString *testStringAItalian = [[NSMutableString alloc] initWithFormat:@"A Italian +6 %@", theInversion];
	NSMutableString *testStringASharpItalian = [[NSMutableString alloc] initWithFormat:@"A♯ Italian +6 %@", theInversion];
	NSMutableString *testStringBbItalian = [[NSMutableString alloc] initWithFormat:@"B♭ Italian +6 %@", theInversion];
	NSMutableString *testStringBItalian = [[NSMutableString alloc] initWithFormat:@"B Italian +6 %@", theInversion];
	
	// *********** French +6 TEST STRINGS **********************
	NSMutableString *testStringCFrench = [[NSMutableString alloc] initWithFormat:@"C French +6 %@", theInversion];
	NSMutableString *testStringCSharpFrench = [[NSMutableString alloc] initWithFormat:@"C♯ French +6 %@", theInversion];
	NSMutableString *testStringDbFrench = [[NSMutableString alloc] initWithFormat:@"D♭ French +6 %@", theInversion];
	NSMutableString *testStringDFrench = [[NSMutableString alloc] initWithFormat:@"D French +6 %@", theInversion];
	NSMutableString *testStringDSharpFrench = [[NSMutableString alloc] initWithFormat:@"D♯ French +6 %@", theInversion];
	NSMutableString *testStringEbFrench = [[NSMutableString alloc] initWithFormat:@"E♭ French +6 %@", theInversion];
	NSMutableString *testStringEFrench = [[NSMutableString alloc] initWithFormat:@"E French +6 %@", theInversion];
	NSMutableString *testStringFFrench = [[NSMutableString alloc] initWithFormat:@"F French +6 %@", theInversion];
	NSMutableString *testStringFSharpFrench = [[NSMutableString alloc] initWithFormat:@"F♯ French +6 %@", theInversion];
	NSMutableString *testStringGbFrench = [[NSMutableString alloc] initWithFormat:@"G♭ French +6 %@", theInversion];
	NSMutableString *testStringGFrench = [[NSMutableString alloc] initWithFormat:@"G French +6 %@", theInversion];
	NSMutableString *testStringGSharpFrench = [[NSMutableString alloc] initWithFormat:@"G♯ French +6 %@", theInversion];
	NSMutableString *testStringAbFrench = [[NSMutableString alloc] initWithFormat:@"A♭ French +6 %@", theInversion];
	NSMutableString *testStringAFrench = [[NSMutableString alloc] initWithFormat:@"A French +6 %@", theInversion];
	NSMutableString *testStringASharpFrench = [[NSMutableString alloc] initWithFormat:@"A♯ French +6 %@", theInversion];
	NSMutableString *testStringBbFrench = [[NSMutableString alloc] initWithFormat:@"B♭ French +6 %@", theInversion];
	NSMutableString *testStringBFrench = [[NSMutableString alloc] initWithFormat:@"B French +6 %@", theInversion];
	
	// *********** German +6 TEST STRINGS **********************
	NSMutableString *testStringCGerman = [[NSMutableString alloc] initWithFormat:@"C German +6 %@", theInversion];
	NSMutableString *testStringCSharpGerman = [[NSMutableString alloc] initWithFormat:@"C♯ German +6 %@", theInversion];
	NSMutableString *testStringDbGerman = [[NSMutableString alloc] initWithFormat:@"D♭ German +6 %@", theInversion];
	NSMutableString *testStringDGerman = [[NSMutableString alloc] initWithFormat:@"D German +6 %@", theInversion];
	NSMutableString *testStringDSharpGerman = [[NSMutableString alloc] initWithFormat:@"D♯ German +6 %@", theInversion];
	NSMutableString *testStringEbGerman = [[NSMutableString alloc] initWithFormat:@"E♭ German +6 %@", theInversion];
	NSMutableString *testStringEGerman = [[NSMutableString alloc] initWithFormat:@"E German +6 %@", theInversion];
	NSMutableString *testStringFGerman = [[NSMutableString alloc] initWithFormat:@"F German +6 %@", theInversion];
	NSMutableString *testStringFSharpGerman = [[NSMutableString alloc] initWithFormat:@"F♯ German +6 %@", theInversion];
	NSMutableString *testStringGbGerman = [[NSMutableString alloc] initWithFormat:@"G♭ German +6 %@", theInversion];
	NSMutableString *testStringGGerman = [[NSMutableString alloc] initWithFormat:@"G German +6 %@", theInversion];
	NSMutableString *testStringGSharpGerman = [[NSMutableString alloc] initWithFormat:@"G♯ German +6 %@", theInversion];
	NSMutableString *testStringAbGerman = [[NSMutableString alloc] initWithFormat:@"A♭ German +6 %@", theInversion];
	NSMutableString *testStringAGerman = [[NSMutableString alloc] initWithFormat:@"A German +6 %@", theInversion];
	NSMutableString *testStringASharpGerman = [[NSMutableString alloc] initWithFormat:@"A♯ German +6 %@", theInversion];
	NSMutableString *testStringBbGerman = [[NSMutableString alloc] initWithFormat:@"B♭ German +6 %@", theInversion];
	NSMutableString *testStringBGerman = [[NSMutableString alloc] initWithFormat:@"B German +6 %@", theInversion];
	
	// *********** Major7 TEST STRINGS **********************
	NSString *testStringCMajor7 = @"C Major 7";
	NSString *testStringCSharpMajor7 = @"C♯ Major 7";
	NSString *testStringDbMajor7 = @"D♭ Major 7";
	NSString *testStringDMajor7 = @"D Major 7";
	NSString *testStringDSharpMajor7 = @"D♯ Major 7";
	NSString *testStringEbMajor7 = @"E♭ Major 7";
	NSString *testStringEMajor7 = @"E Major 7";
	NSString *testStringFMajor7 = @"F Major 7";
	NSString *testStringFSharpMajor7 = @"F♯ Major 7";
	NSString *testStringGbMajor7 = @"G♭ Major 7";
	NSString *testStringGMajor7 = @"G Major 7";
	NSString *testStringGSharpMajor7 = @"G♯ Major 7";
	NSString *testStringAbMajor7 = @"A♭ Major 7";
	NSString *testStringAMajor7 = @"A Major 7";
	NSString *testStringASharpMajor7 = @"A♯ Major 7";
	NSString *testStringBbMajor7 = @"B♭ Major 7";
	NSString *testStringBMajor7 = @"B Major 7";
	
	// *********** Minor7 TEST STRINGS **********************
	NSString *testStringCMinor7 = @"C Minor 7";
	NSString *testStringCSharpMinor7 = @"C♯ Minor 7";
	NSString *testStringDbMinor7 = @"D♭ Minor 7";
	NSString *testStringDMinor7 = @"D Minor 7";
	NSString *testStringDSharpMinor7 = @"D♯ Minor 7";
	NSString *testStringEbMinor7 = @"E♭ Minor 7";
	NSString *testStringEMinor7 = @"E Minor 7";
	NSString *testStringFMinor7 = @"F Minor 7";
	NSString *testStringFSharpMinor7 = @"F♯ Minor 7";
	NSString *testStringGbMinor7 = @"G♭ Minor 7";
	NSString *testStringGMinor7 = @"G Minor 7";
	NSString *testStringGSharpMinor7 = @"G♯ Minor 7";
	NSString *testStringAbMinor7 = @"A♭ Minor 7";
	NSString *testStringAMinor7 = @"A Minor 7";
	NSString *testStringASharpMinor7 = @"A♯ Minor 7";
	NSString *testStringBbMinor7 = @"B♭ Minor 7";
	NSString *testStringBMinor7 = @"B Minor 7";
	
	// *********** AUGMENTED 7 TEST STAugmented 7RINGS **********************
	NSString *testStringCAugmented7 = @"C Augmented 7";
	NSString *testStringCSharpAugmented7 = @"C♯ Augmented 7";
	NSString *testStringDbAugmented7 = @"D♭ Augmented 7";
	NSString *testStringDAugmented7 = @"D Augmented 7";
	NSString *testStringDSharpAugmented7 = @"D♯ Augmented 7";
	NSString *testStringEbAugmented7 = @"E♭ Augmented 7";
	NSString *testStringEAugmented7 = @"E Augmented 7";
	NSString *testStringFAugmented7 = @"F Augmented 7";
	NSString *testStringFSharpAugmented7 = @"F♯ Augmented 7";
	NSString *testStringGbAugmented7 = @"G♭ Augmented 7";
	NSString *testStringGAugmented7 = @"G Augmented 7";
	NSString *testStringGSharpAugmented7 = @"G♯ Augmented 7";
	NSString *testStringAbAugmented7 = @"A♭ Augmented 7";
	NSString *testStringAAugmented7 = @"A Augmented 7";
	NSString *testStringASharpAugmented7 = @"A♯ Augmented 7";
	NSString *testStringBbAugmented7 = @"B♭ Augmented 7";
	NSString *testStringBAugmented7 = @"B Augmented 7";
	
	// *********** DIMINISHED 7 TEST STRINGS **********************
	NSString *testStringCDiminished7 = @"C Diminished 7";
	NSString *testStringCSharpDiminished7 = @"C♯ Diminished 7";
	NSString *testStringDbDiminished7 = @"D♭ Diminished 7";
	NSString *testStringDDiminished7 = @"D Diminished 7";
	NSString *testStringDSharpDiminished7 = @"D♯ Diminished 7";
	NSString *testStringEbDiminished7 = @"E♭ Diminished 7";
	NSString *testStringEDiminished7 = @"E Diminished 7";
	NSString *testStringFDiminished7 = @"F Diminished 7";
	NSString *testStringFSharpDiminished7 = @"F♯ Diminished 7";
	NSString *testStringGbDiminished7 = @"G♭ Diminished 7";
	NSString *testStringGDiminished7 = @"G Diminished 7";
	NSString *testStringGSharpDiminished7 = @"G♯ Diminished 7";
	NSString *testStringAbDiminished7 = @"A♭ Diminished 7";
	NSString *testStringADiminished7 = @"A Diminished 7";
	NSString *testStringASharpDiminished7 = @"A♯ Diminished 7";
	NSString *testStringBbDiminished7 = @"B♭ Diminished 7";
	NSString *testStringBDiminished7 = @"B Diminished 7";
	
	// *********** HALF-DIMINISHED 7 TEST STRINGS **********************
	NSString *testStringCHalfDiminished7 = @"C Half-Diminished 7";
	NSString *testStringCSharpHalfDiminished7 = @"C♯ Half-Diminished 7";
	NSString *testStringDbHalfDiminished7 = @"D♭ Half-Diminished 7";
	NSString *testStringDHalfDiminished7 = @"D Half-Diminished 7";
	NSString *testStringDSharpHalfDiminished7 = @"D♯ Half-Diminished 7";
	NSString *testStringEbHalfDiminished7 = @"E♭ Half-Diminished 7";
	NSString *testStringEHalfDiminished7 = @"E Half-Diminished 7";
	NSString *testStringFHalfDiminished7 = @"F Half-Diminished 7";
	NSString *testStringFSharpHalfDiminished7 = @"F♯ Half-Diminished 7";
	NSString *testStringGbHalfDiminished7 = @"G♭ Half-Diminished 7";
	NSString *testStringGHalfDiminished7 = @"G Half-Diminished 7";
	NSString *testStringGSharpHalfDiminished7 = @"G♯ Half-Diminished 7";
	NSString *testStringAbHalfDiminished7 = @"A♭ Half-Diminished 7";
	NSString *testStringAHalfDiminished7 = @"A Half-Diminished 7";
	NSString *testStringASharpHalfDiminished7 = @"A♯ Half-Diminished 7";
	NSString *testStringBbHalfDiminished7 = @"B♭ Half-Diminished 7";
	NSString *testStringBHalfDiminished7 = @"B Half-Diminished 7";
	
	// *********** Dominant7 TEST STRINGS **********************
	NSString *testStringCDominant7 = @"C Dominant 7";
	NSString *testStringCSharpDominant7 = @"C♯ Dominant 7";
	NSString *testStringDbDominant7 = @"D♭ Dominant 7";
	NSString *testStringDDominant7 = @"D Dominant 7";
	NSString *testStringDSharpDominant7 = @"D♯ Dominant 7";
	NSString *testStringEbDominant7 = @"E♭ Dominant 7";
	NSString *testStringEDominant7 = @"E Dominant 7";
	NSString *testStringFDominant7 = @"F Dominant 7";
	NSString *testStringFSharpDominant7 = @"F♯ Dominant 7";
	NSString *testStringGbDominant7 = @"G♭ Dominant 7";
	NSString *testStringGDominant7 = @"G Dominant 7";
	NSString *testStringGSharpDominant7 = @"G♯ Dominant 7";
	NSString *testStringAbDominant7 = @"A♭ Dominant 7";
	NSString *testStringADominant7 = @"A Dominant 7";
	NSString *testStringASharpDominant7 = @"A♯ Dominant 7";
	NSString *testStringBbDominant7 = @"B♭ Dominant 7";
	NSString *testStringBDominant7 = @"B Dominant 7";	
	
	// *********** Major6_5 TEST STRINGS **********************
	NSString *testStringCMajor6_5 = @"C Major 6-5";
	NSString *testStringCSharpMajor6_5 = @"C♯ Major 6-5";
	NSString *testStringDbMajor6_5 = @"D♭ Major 6-5";
	NSString *testStringDMajor6_5 = @"D Major 6-5";
	NSString *testStringDSharpMajor6_5 = @"D♯ Major 6-5";
	NSString *testStringEbMajor6_5 = @"E♭ Major 6-5";
	NSString *testStringEMajor6_5 = @"E Major 6-5";
	NSString *testStringFMajor6_5 = @"F Major 6-5";
	NSString *testStringFSharpMajor6_5 = @"F♯ Major 6-5";
	NSString *testStringGbMajor6_5 = @"G♭ Major 6-5";
	NSString *testStringGMajor6_5 = @"G Major 6-5";
	NSString *testStringGSharpMajor6_5 = @"G♯ Major 6-5";
	NSString *testStringAbMajor6_5 = @"A♭ Major 6-5";
	NSString *testStringAMajor6_5 = @"A Major 6-5";
	NSString *testStringASharpMajor6_5 = @"A♯ Major 6-5";
	NSString *testStringBbMajor6_5 = @"B♭ Major 6-5";
	NSString *testStringBMajor6_5 = @"B Major 6-5";
	
	// *********** Minor6_5 TEST STRINGS **********************
	NSString *testStringCMinor6_5 = @"C Minor 6-5";
	NSString *testStringCSharpMinor6_5 = @"C♯ Minor 6-5";
	NSString *testStringDbMinor6_5 = @"D♭ Minor 6-5";
	NSString *testStringDMinor6_5 = @"D Minor 6-5";
	NSString *testStringDSharpMinor6_5 = @"D♯ Minor 6-5";
	NSString *testStringEbMinor6_5 = @"E♭ Minor 6-5";
	NSString *testStringEMinor6_5 = @"E Minor 6-5";
	NSString *testStringFMinor6_5 = @"F Minor 6-5";
	NSString *testStringFSharpMinor6_5 = @"F♯ Minor 6-5";
	NSString *testStringGbMinor6_5 = @"G♭ Minor 6-5";
	NSString *testStringGMinor6_5 = @"G Minor 6-5";
	NSString *testStringGSharpMinor6_5 = @"G♯ Minor 6-5";
	NSString *testStringAbMinor6_5 = @"A♭ Minor 6-5";
	NSString *testStringAMinor6_5 = @"A Minor 6-5";
	NSString *testStringASharpMinor6_5 = @"A♯ Minor 6-5";
	NSString *testStringBbMinor6_5 = @"B♭ Minor 6-5";
	NSString *testStringBMinor6_5 = @"B Minor 6-5";
	
	// *********** AUGMENTED 6_5 TEST STAugmented 6-5RINGS **********************
	NSString *testStringCAugmented6_5 = @"C Augmented 6-5";
	NSString *testStringCSharpAugmented6_5 = @"C♯ Augmented 6-5";
	NSString *testStringDbAugmented6_5 = @"D♭ Augmented 6-5";
	NSString *testStringDAugmented6_5 = @"D Augmented 6-5";
	NSString *testStringDSharpAugmented6_5 = @"D♯ Augmented 6-5";
	NSString *testStringEbAugmented6_5 = @"E♭ Augmented 6-5";
	NSString *testStringEAugmented6_5 = @"E Augmented 6-5";
	NSString *testStringFAugmented6_5 = @"F Augmented 6-5";
	NSString *testStringFSharpAugmented6_5 = @"F♯ Augmented 6-5";
	NSString *testStringGbAugmented6_5 = @"G♭ Augmented 6-5";
	NSString *testStringGAugmented6_5 = @"G Augmented 6-5";
	NSString *testStringGSharpAugmented6_5 = @"G♯ Augmented 6-5";
	NSString *testStringAbAugmented6_5 = @"A♭ Augmented 6-5";
	NSString *testStringAAugmented6_5 = @"A Augmented 6-5";
	NSString *testStringASharpAugmented6_5 = @"A♯ Augmented 6-5";
	NSString *testStringBbAugmented6_5 = @"B♭ Augmented 6-5";
	NSString *testStringBAugmented6_5 = @"B Augmented 6-5";
	
	// *********** Dominant6_5 TEST STRINGS **********************
	NSString *testStringCDominant6_5 = @"C Dominant 6-5";
	NSString *testStringCSharpDominant6_5 = @"C♯ Dominant 6-5";
	NSString *testStringDbDominant6_5 = @"D♭ Dominant 6-5";
	NSString *testStringDDominant6_5 = @"D Dominant 6-5";
	NSString *testStringDSharpDominant6_5 = @"D♯ Dominant 6-5";
	NSString *testStringEbDominant6_5 = @"E♭ Dominant 6-5";
	NSString *testStringEDominant6_5 = @"E Dominant 6-5";
	NSString *testStringFDominant6_5 = @"F Dominant 6-5";
	NSString *testStringFSharpDominant6_5 = @"F♯ Dominant 6-5";
	NSString *testStringGbDominant6_5 = @"G♭ Dominant 6-5";
	NSString *testStringGDominant6_5 = @"G Dominant 6-5";
	NSString *testStringGSharpDominant6_5 = @"G♯ Dominant 6-5";
	NSString *testStringAbDominant6_5 = @"A♭ Dominant 6-5";
	NSString *testStringADominant6_5 = @"A Dominant 6-5";
	NSString *testStringASharpDominant6_5 = @"A♯ Dominant 6-5";
	NSString *testStringBbDominant6_5 = @"B♭ Dominant 6-5";
	NSString *testStringBDominant6_5 = @"B Dominant 6-5";	
	
	// *********** DIMINISHED 6_5 TEST STRINGS **********************
	NSString *testStringCDiminished6_5 = @"C Diminished 6-5";
	NSString *testStringCSharpDiminished6_5 = @"C♯ Diminished 6-5";
	NSString *testStringDbDiminished6_5 = @"D♭ Diminished 6-5";
	NSString *testStringDDiminished6_5 = @"D Diminished 6-5";
	NSString *testStringDSharpDiminished6_5 = @"D♯ Diminished 6-5";
	NSString *testStringEbDiminished6_5 = @"E♭ Diminished 6-5";
	NSString *testStringEDiminished6_5 = @"E Diminished 6-5";
	NSString *testStringFDiminished6_5 = @"F Diminished 6-5";
	NSString *testStringFSharpDiminished6_5 = @"F♯ Diminished 6-5";
	NSString *testStringGbDiminished6_5 = @"G♭ Diminished 6-5";
	NSString *testStringGDiminished6_5 = @"G Diminished 6-5";
	NSString *testStringGSharpDiminished6_5 = @"G♯ Diminished 6-5";
	NSString *testStringAbDiminished6_5 = @"A♭ Diminished 6-5";
	NSString *testStringADiminished6_5 = @"A Diminished 6-5";
	NSString *testStringASharpDiminished6_5 = @"A♯ Diminished 6-5";
	NSString *testStringBbDiminished6_5 = @"B♭ Diminished 6-5";
	NSString *testStringBDiminished6_5 = @"B Diminished 6-5";
	
	// *********** Dominant4_3 TEST STRINGS **********************
	NSString *testStringCDominant4_3 = @"C Dominant 4-3";
	NSString *testStringCSharpDominant4_3 = @"C♯ Dominant 4-3";
	NSString *testStringDbDominant4_3 = @"D♭ Dominant 4-3";
	NSString *testStringDDominant4_3 = @"D Dominant 4-3";
	NSString *testStringDSharpDominant4_3 = @"D♯ Dominant 4-3";
	NSString *testStringEbDominant4_3 = @"E♭ Dominant 4-3";
	NSString *testStringEDominant4_3 = @"E Dominant 4-3";
	NSString *testStringFDominant4_3 = @"F Dominant 4-3";
	NSString *testStringFSharpDominant4_3 = @"F♯ Dominant 4-3";
	NSString *testStringGbDominant4_3 = @"G♭ Dominant 4-3";
	NSString *testStringGDominant4_3 = @"G Dominant 4-3";
	NSString *testStringGSharpDominant4_3 = @"G♯ Dominant 4-3";
	NSString *testStringAbDominant4_3 = @"A♭ Dominant 4-3";
	NSString *testStringADominant4_3 = @"A Dominant 4-3";
	NSString *testStringASharpDominant4_3 = @"A♯ Dominant 4-3";
	NSString *testStringBbDominant4_3 = @"B♭ Dominant 4-3";
	NSString *testStringBDominant4_3 = @"B Dominant 4-3";	
	
	// *********** HALF-DIMINISHED 6_5 TEST STRINGS **********************
	NSString *testStringCHalfDiminished6_5 = @"C Half-Diminished 6-5";
	NSString *testStringCSharpHalfDiminished6_5 = @"C♯ Half-Diminished 6-5";
	NSString *testStringDbHalfDiminished6_5 = @"D♭ Half-Diminished 6-5";
	NSString *testStringDHalfDiminished6_5 = @"D Half-Diminished 6-5";
	NSString *testStringDSharpHalfDiminished6_5 = @"D♯ Half-Diminished 6-5";
	NSString *testStringEbHalfDiminished6_5 = @"E♭ Half-Diminished 6-5";
	NSString *testStringEHalfDiminished6_5 = @"E Half-Diminished 6-5";
	NSString *testStringFHalfDiminished6_5 = @"F Half-Diminished 6-5";
	NSString *testStringFSharpHalfDiminished6_5 = @"F♯ Half-Diminished 6-5";
	NSString *testStringGbHalfDiminished6_5 = @"G♭ Half-Diminished 6-5";
	NSString *testStringGHalfDiminished6_5 = @"G Half-Diminished 6-5";
	NSString *testStringGSharpHalfDiminished6_5 = @"G♯ Half-Diminished 6-5";
	NSString *testStringAbHalfDiminished6_5 = @"A♭ Half-Diminished 6-5";
	NSString *testStringAHalfDiminished6_5 = @"A Half-Diminished 6-5";
	NSString *testStringASharpHalfDiminished6_5 = @"A♯ Half-Diminished 6-5";
	NSString *testStringBbHalfDiminished6_5 = @"B♭ Half-Diminished 6-5";
	NSString *testStringBHalfDiminished6_5 = @"B Half-Diminished 6-5";
	
	// *********** Major4_3 TEST STRINGS **********************
	NSString *testStringCMajor4_3 = @"C Major 4-3";
	NSString *testStringCSharpMajor4_3 = @"C♯ Major 4-3";
	NSString *testStringDbMajor4_3 = @"D♭ Major 4-3";
	NSString *testStringDMajor4_3 = @"D Major 4-3";
	NSString *testStringDSharpMajor4_3 = @"D♯ Major 4-3";
	NSString *testStringEbMajor4_3 = @"E♭ Major 4-3";
	NSString *testStringEMajor4_3 = @"E Major 4-3";
	NSString *testStringFMajor4_3 = @"F Major 4-3";
	NSString *testStringFSharpMajor4_3 = @"F♯ Major 4-3";
	NSString *testStringGbMajor4_3 = @"G♭ Major 4-3";
	NSString *testStringGMajor4_3 = @"G Major 4-3";
	NSString *testStringGSharpMajor4_3 = @"G♯ Major 4-3";
	NSString *testStringAbMajor4_3 = @"A♭ Major 4-3";
	NSString *testStringAMajor4_3 = @"A Major 4-3";
	NSString *testStringASharpMajor4_3 = @"A♯ Major 4-3";
	NSString *testStringBbMajor4_3 = @"B♭ Major 4-3";
	NSString *testStringBMajor4_3 = @"B Major 4-3";
	
	// *********** Minor4_3 TEST STRINGS **********************
	NSString *testStringCMinor4_3 = @"C Minor 4-3";
	NSString *testStringCSharpMinor4_3 = @"C♯ Minor 4-3";
	NSString *testStringDbMinor4_3 = @"D♭ Minor 4-3";
	NSString *testStringDMinor4_3 = @"D Minor 4-3";
	NSString *testStringDSharpMinor4_3 = @"D♯ Minor 4-3";
	NSString *testStringEbMinor4_3 = @"E♭ Minor 4-3";
	NSString *testStringEMinor4_3 = @"E Minor 4-3";
	NSString *testStringFMinor4_3 = @"F Minor 4-3";
	NSString *testStringFSharpMinor4_3 = @"F♯ Minor 4-3";
	NSString *testStringGbMinor4_3 = @"G♭ Minor 4-3";
	NSString *testStringGMinor4_3 = @"G Minor 4-3";
	NSString *testStringGSharpMinor4_3 = @"G♯ Minor 4-3";
	NSString *testStringAbMinor4_3 = @"A♭ Minor 4-3";
	NSString *testStringAMinor4_3 = @"A Minor 4-3";
	NSString *testStringASharpMinor4_3 = @"A♯ Minor 4-3";
	NSString *testStringBbMinor4_3 = @"B♭ Minor 4-3";
	NSString *testStringBMinor4_3 = @"B Minor 4-3";
	
	// *********** AUGMENTED 4_3 TEST STAugmented 4-3RINGS **********************
	NSString *testStringCAugmented4_3 = @"C Augmented 4-3";
	NSString *testStringCSharpAugmented4_3 = @"C♯ Augmented 4-3";
	NSString *testStringDbAugmented4_3 = @"D♭ Augmented 4-3";
	NSString *testStringDAugmented4_3 = @"D Augmented 4-3";
	NSString *testStringDSharpAugmented4_3 = @"D♯ Augmented 4-3";
	NSString *testStringEbAugmented4_3 = @"E♭ Augmented 4-3";
	NSString *testStringEAugmented4_3 = @"E Augmented 4-3";
	NSString *testStringFAugmented4_3 = @"F Augmented 4-3";
	NSString *testStringFSharpAugmented4_3 = @"F♯ Augmented 4-3";
	NSString *testStringGbAugmented4_3 = @"G♭ Augmented 4-3";
	NSString *testStringGAugmented4_3 = @"G Augmented 4-3";
	NSString *testStringGSharpAugmented4_3 = @"G♯ Augmented 4-3";
	NSString *testStringAbAugmented4_3 = @"A♭ Augmented 4-3";
	NSString *testStringAAugmented4_3 = @"A Augmented 4-3";
	NSString *testStringASharpAugmented4_3 = @"A♯ Augmented 4-3";
	NSString *testStringBbAugmented4_3 = @"B♭ Augmented 4-3";
	NSString *testStringBAugmented4_3 = @"B Augmented 4-3";
	
	// *********** DIMINISHED 4_3 TEST STRINGS **********************
	NSString *testStringCDiminished4_3 = @"C Diminished 4-3";
	NSString *testStringCSharpDiminished4_3 = @"C♯ Diminished 4-3";
	NSString *testStringDbDiminished4_3 = @"D♭ Diminished 4-3";
	NSString *testStringDDiminished4_3 = @"D Diminished 4-3";
	NSString *testStringDSharpDiminished4_3 = @"D♯ Diminished 4-3";
	NSString *testStringEbDiminished4_3 = @"E♭ Diminished 4-3";
	NSString *testStringEDiminished4_3 = @"E Diminished 4-3";
	NSString *testStringFDiminished4_3 = @"F Diminished 4-3";
	NSString *testStringFSharpDiminished4_3 = @"F♯ Diminished 4-3";
	NSString *testStringGbDiminished4_3 = @"G♭ Diminished 4-3";
	NSString *testStringGDiminished4_3 = @"G Diminished 4-3";
	NSString *testStringGSharpDiminished4_3 = @"G♯ Diminished 4-3";
	NSString *testStringAbDiminished4_3 = @"A♭ Diminished 4-3";
	NSString *testStringADiminished4_3 = @"A Diminished 4-3";
	NSString *testStringASharpDiminished4_3 = @"A♯ Diminished 4-3";
	NSString *testStringBbDiminished4_3 = @"B♭ Diminished 4-3";
	NSString *testStringBDiminished4_3 = @"B Diminished 4-3";
	
	// *********** HALF-DIMINISHED 4_3 TEST STRINGS **********************
	NSString *testStringCHalfDiminished4_3 = @"C Half-Diminished 4-3";
	NSString *testStringCSharpHalfDiminished4_3 = @"C♯ Half-Diminished 4-3";
	NSString *testStringDbHalfDiminished4_3 = @"D♭ Half-Diminished 4-3";
	NSString *testStringDHalfDiminished4_3 = @"D Half-Diminished 4-3";
	NSString *testStringDSharpHalfDiminished4_3 = @"D♯ Half-Diminished 4-3";
	NSString *testStringEbHalfDiminished4_3 = @"E♭ Half-Diminished 4-3";
	NSString *testStringEHalfDiminished4_3 = @"E Half-Diminished 4-3";
	NSString *testStringFHalfDiminished4_3 = @"F Half-Diminished 4-3";
	NSString *testStringFSharpHalfDiminished4_3 = @"F♯ Half-Diminished 4-3";
	NSString *testStringGbHalfDiminished4_3 = @"G♭ Half-Diminished 4-3";
	NSString *testStringGHalfDiminished4_3 = @"G Half-Diminished 4-3";
	NSString *testStringGSharpHalfDiminished4_3 = @"G♯ Half-Diminished 4-3";
	NSString *testStringAbHalfDiminished4_3 = @"A♭ Half-Diminished 4-3";
	NSString *testStringAHalfDiminished4_3 = @"A Half-Diminished 4-3";
	NSString *testStringASharpHalfDiminished4_3 = @"A♯ Half-Diminished 4-3";
	NSString *testStringBbHalfDiminished4_3 = @"B♭ Half-Diminished 4-3";
	NSString *testStringBHalfDiminished4_3 = @"B Half-Diminished 4-3";	
	
	// *********** Major4_2 TEST STRINGS **********************
	NSString *testStringCMajor4_2 = @"C Major 4-2";
	NSString *testStringCSharpMajor4_2 = @"C♯ Major 4-2";
	NSString *testStringDbMajor4_2 = @"D♭ Major 4-2";
	NSString *testStringDMajor4_2 = @"D Major 4-2";
	NSString *testStringDSharpMajor4_2 = @"D♯ Major 4-2";
	NSString *testStringEbMajor4_2 = @"E♭ Major 4-2";
	NSString *testStringEMajor4_2 = @"E Major 4-2";
	NSString *testStringFMajor4_2 = @"F Major 4-2";
	NSString *testStringFSharpMajor4_2 = @"F♯ Major 4-2";
	NSString *testStringGbMajor4_2 = @"G♭ Major 4-2";
	NSString *testStringGMajor4_2 = @"G Major 4-2";
	NSString *testStringGSharpMajor4_2 = @"G♯ Major 4-2";
	NSString *testStringAbMajor4_2 = @"A♭ Major 4-2";
	NSString *testStringAMajor4_2 = @"A Major 4-2";
	NSString *testStringASharpMajor4_2 = @"A♯ Major 4-2";
	NSString *testStringBbMajor4_2 = @"B♭ Major 4-2";
	NSString *testStringBMajor4_2 = @"B Major 4-2";
	
	// *********** Dominant4_2 TEST STRINGS **********************
	NSString *testStringCDominant4_2 = @"C Dominant 4-2";
	NSString *testStringCSharpDominant4_2 = @"C♯ Dominant 4-2";
	NSString *testStringDbDominant4_2 = @"D♭ Dominant 4-2";
	NSString *testStringDDominant4_2 = @"D Dominant 4-2";
	NSString *testStringDSharpDominant4_2 = @"D♯ Dominant 4-2";
	NSString *testStringEbDominant4_2 = @"E♭ Dominant 4-2";
	NSString *testStringEDominant4_2 = @"E Dominant 4-2";
	NSString *testStringFDominant4_2 = @"F Dominant 4-2";
	NSString *testStringFSharpDominant4_2 = @"F♯ Dominant 4-2";
	NSString *testStringGbDominant4_2 = @"G♭ Dominant 4-2";
	NSString *testStringGDominant4_2 = @"G Dominant 4-2";
	NSString *testStringGSharpDominant4_2 = @"G♯ Dominant 4-2";
	NSString *testStringAbDominant4_2 = @"A♭ Dominant 4-2";
	NSString *testStringADominant4_2 = @"A Dominant 4-2";
	NSString *testStringASharpDominant4_2 = @"A♯ Dominant 4-2";
	NSString *testStringBbDominant4_2 = @"B♭ Dominant 4-2";
	NSString *testStringBDominant4_2 = @"B Dominant 4-2";	
	
	// *********** Minor4_2 TEST STRINGS **********************
	NSString *testStringCMinor4_2 = @"C Minor 4-2";
	NSString *testStringCSharpMinor4_2 = @"C♯ Minor 4-2";
	NSString *testStringDbMinor4_2 = @"D♭ Minor 4-2";
	NSString *testStringDMinor4_2 = @"D Minor 4-2";
	NSString *testStringDSharpMinor4_2 = @"D♯ Minor 4-2";
	NSString *testStringEbMinor4_2 = @"E♭ Minor 4-2";
	NSString *testStringEMinor4_2 = @"E Minor 4-2";
	NSString *testStringFMinor4_2 = @"F Minor 4-2";
	NSString *testStringFSharpMinor4_2 = @"F♯ Minor 4-2";
	NSString *testStringGbMinor4_2 = @"G♭ Minor 4-2";
	NSString *testStringGMinor4_2 = @"G Minor 4-2";
	NSString *testStringGSharpMinor4_2 = @"G♯ Minor 4-2";
	NSString *testStringAbMinor4_2 = @"A♭ Minor 4-2";
	NSString *testStringAMinor4_2 = @"A Minor 4-2";
	NSString *testStringASharpMinor4_2 = @"A♯ Minor 4-2";
	NSString *testStringBbMinor4_2 = @"B♭ Minor 4-2";
	NSString *testStringBMinor4_2 = @"B Minor 4-2";
	
	// *********** AUGMENTED 4_2 TEST STAugmented 4-2RINGS **********************
	NSString *testStringCAugmented4_2 = @"C Augmented 4-2";
	NSString *testStringCSharpAugmented4_2 = @"C♯ Augmented 4-2";
	NSString *testStringDbAugmented4_2 = @"D♭ Augmented 4-2";
	NSString *testStringDAugmented4_2 = @"D Augmented 4-2";
	NSString *testStringDSharpAugmented4_2 = @"D♯ Augmented 4-2";
	NSString *testStringEbAugmented4_2 = @"E♭ Augmented 4-2";
	NSString *testStringEAugmented4_2 = @"E Augmented 4-2";
	NSString *testStringFAugmented4_2 = @"F Augmented 4-2";
	NSString *testStringFSharpAugmented4_2 = @"F♯ Augmented 4-2";
	NSString *testStringGbAugmented4_2 = @"G♭ Augmented 4-2";
	NSString *testStringGAugmented4_2 = @"G Augmented 4-2";
	NSString *testStringGSharpAugmented4_2 = @"G♯ Augmented 4-2";
	NSString *testStringAbAugmented4_2 = @"A♭ Augmented 4-2";
	NSString *testStringAAugmented4_2 = @"A Augmented 4-2";
	NSString *testStringASharpAugmented4_2 = @"A♯ Augmented 4-2";
	NSString *testStringBbAugmented4_2 = @"B♭ Augmented 4-2";
	NSString *testStringBAugmented4_2 = @"B Augmented 4-2";
	
	// *********** DIMINISHED 4_2 TEST STRINGS **********************
	NSString *testStringCDiminished4_2 = @"C Diminished 4-2";
	NSString *testStringCSharpDiminished4_2 = @"C♯ Diminished 4-2";
	NSString *testStringDbDiminished4_2 = @"D♭ Diminished 4-2";
	NSString *testStringDDiminished4_2 = @"D Diminished 4-2";
	NSString *testStringDSharpDiminished4_2 = @"D♯ Diminished 4-2";
	NSString *testStringEbDiminished4_2 = @"E♭ Diminished 4-2";
	NSString *testStringEDiminished4_2 = @"E Diminished 4-2";
	NSString *testStringFDiminished4_2 = @"F Diminished 4-2";
	NSString *testStringFSharpDiminished4_2 = @"F♯ Diminished 4-2";
	NSString *testStringGbDiminished4_2 = @"G♭ Diminished 4-2";
	NSString *testStringGDiminished4_2 = @"G Diminished 4-2";
	NSString *testStringGSharpDiminished4_2 = @"G♯ Diminished 4-2";
	NSString *testStringAbDiminished4_2 = @"A♭ Diminished 4-2";
	NSString *testStringADiminished4_2 = @"A Diminished 4-2";
	NSString *testStringASharpDiminished4_2 = @"A♯ Diminished 4-2";
	NSString *testStringBbDiminished4_2 = @"B♭ Diminished 4-2";
	NSString *testStringBDiminished4_2 = @"B Diminished 4-2";
	
	// *********** HALF-DIMINISHED 4_2 TEST STRINGS **********************
	NSString *testStringCHalfDiminished4_2 = @"C Half-Diminished 4-2";
	NSString *testStringCSharpHalfDiminished4_2 = @"C♯ Half-Diminished 4-2";
	NSString *testStringDbHalfDiminished4_2 = @"D♭ Half-Diminished 4-2";
	NSString *testStringDHalfDiminished4_2 = @"D Half-Diminished 4-2";
	NSString *testStringDSharpHalfDiminished4_2 = @"D♯ Half-Diminished 4-2";
	NSString *testStringEbHalfDiminished4_2 = @"E♭ Half-Diminished 4-2";
	NSString *testStringEHalfDiminished4_2 = @"E Half-Diminished 4-2";
	NSString *testStringFHalfDiminished4_2 = @"F Half-Diminished 4-2";
	NSString *testStringFSharpHalfDiminished4_2 = @"F♯ Half-Diminished 4-2";
	NSString *testStringGbHalfDiminished4_2 = @"G♭ Half-Diminished 4-2";
	NSString *testStringGHalfDiminished4_2 = @"G Half-Diminished 4-2";
	NSString *testStringGSharpHalfDiminished4_2 = @"G♯ Half-Diminished 4-2";
	NSString *testStringAbHalfDiminished4_2 = @"A♭ Half-Diminished 4-2";
	NSString *testStringAHalfDiminished4_2 = @"A Half-Diminished 4-2";
	NSString *testStringASharpHalfDiminished4_2 = @"A♯ Half-Diminished 4-2";
	NSString *testStringBbHalfDiminished4_2 = @"B♭ Half-Diminished 4-2";
	NSString *testStringBHalfDiminished4_2 = @"B Half-Diminished 4-2";	
	
	//*!*!*!*!*!*!*!**!!**!*!*!*!*!*!*!*!*!*!!*!*!*!*!*!*!*!*!*!!*!*!*!*!*!*!*!*!*!*!*!*!*!*!	
	// set UILabel to black when wrong chord combo happens
	if ([messageFromPicker isEqualToString: messageFromPicker] == YES)
	{
		label.text = [NSString stringWithFormat:@" "/*, messageFromPicker*/];
	}
	//*!*!*!*!*!*!*!**!!**!*!*!*!*!*!*!*!*!*!!*!*!*!*!*!*!*!*!*!!*!*!*!*!*!*!*!*!*!*!*!*!*!*!	
	//
	//
	//
	//
	//
	// IF STRING isEqualToString X XXXXXX ******************************************
	// *********** MAJOR ifs **********************
	
	if ([messageFromPicker isEqualToString: testStringCMajor] == YES)
	{
		label.text = [NSString stringWithFormat:@"C, E, G"];//@"test, C♯oø, E♭, Gxbb+, bbbº, c+7"
		//@"C Major 5:"
	}
	
	if ([messageFromPicker isEqualToString: testStringCSharpMajor] == YES)
	{
		label.text = [NSString stringWithFormat:@"C♯, E♯, G♯"];
		//@"C♯ Major 5:"
	}
	
	if ([messageFromPicker isEqualToString: testStringDbMajor] == YES)
	{
		label.text = [NSString stringWithFormat:@"D♭, F, A♭"];
		//@"D♭ Major 5:"
	}
	
	if ([messageFromPicker isEqualToString: testStringDMajor] == YES)
	{
		label.text = [NSString stringWithFormat:@"D, F♯, A"];
		//@"D Major 5:"
	}
	
	if ([messageFromPicker isEqualToString: testStringDSharpMajor] == YES)
	{
		label.text = [NSString stringWithFormat:@"D♯, Fx, A♯"];
		//@"D♯ Major 5:"
	}
	
	if ([messageFromPicker isEqualToString: testStringEbMajor] == YES)
	{
		label.text = [NSString stringWithFormat:@"E♭, G, B♭"];
		//@"E♭ Major 5:"
	}
	
	if ([messageFromPicker isEqualToString: testStringEMajor] == YES)
	{
		label.text = [NSString stringWithFormat:@"E, G♯, B"];
		//@"E Major 5:"
	}
	
	if ([messageFromPicker isEqualToString: testStringFMajor] == YES)
	{
		label.text = [NSString stringWithFormat:@"F, A, C"];
		//@"F Major 5:"
	}
	
	if ([messageFromPicker isEqualToString: testStringFSharpMajor] == YES)
	{
		label.text = [NSString stringWithFormat:@"F♯, A♯, C♯"];
		//@"F♯ Major 5:"
	}
	
	if ([messageFromPicker isEqualToString: testStringGbMajor] == YES)
	{
		label.text = [NSString stringWithFormat:@"G♭, B♭, D♭"];
		//@"G♭ Major 5:"
	}
	
	if ([messageFromPicker isEqualToString: testStringGMajor] == YES)
	{
		label.text = [NSString stringWithFormat:@"G, B, D"];
		//@"G Major 5:"
	}
	
	if ([messageFromPicker isEqualToString: testStringGSharpMajor] == YES)
	{
		label.text = [NSString stringWithFormat:@"G♯, B♯, D♯"];
		//@"G♯ Major 5:"
	}
	
	if ([messageFromPicker isEqualToString: testStringAbMajor] == YES)
	{
		label.text = [NSString stringWithFormat:@"A♭, C, E♭"];
		//@"A♭ Major 5:"
	}
	
	if ([messageFromPicker isEqualToString: testStringAMajor] == YES)
	{
		label.text = [NSString stringWithFormat:@"A, C♯, E"];
		//@"A Major 5:"
	}
	
	if ([messageFromPicker isEqualToString: testStringASharpMajor] == YES)
	{
		label.text = [NSString stringWithFormat:@"A♯, Cx, E♯"];
		//@"A♯ Major 5:"
	}
	
	if ([messageFromPicker isEqualToString: testStringBbMajor] == YES)
	{
		label.text = [NSString stringWithFormat:@"B♭, D, F"];
		//@"B♭ Major 5:"
	}
	
	if ([messageFromPicker isEqualToString: testStringBMajor] == YES)
	{
		label.text = [NSString stringWithFormat:@"B, D♯, F♯"];
		//@"B Major 5:"
	}
	
	// *********** MINOR ifs **********************
	
	if ([messageFromPicker isEqualToString: testStringCMinor] == YES)
	{
		label.text = [NSString stringWithFormat:@"C, E♭, G"];
		//@"C Minor:"
	}
	
	if ([messageFromPicker isEqualToString: testStringCSharpMinor] == YES)
	{
		label.text = [NSString stringWithFormat:@"C♯, E, G♯"];
		//@"C♯ Minor:"
	}
	
	if ([messageFromPicker isEqualToString: testStringDbMinor] == YES)
	{
		label.text = [NSString stringWithFormat:@"D♭, F♭, A♭"];
		//@"D♭ Minor:"
	}
	
	if ([messageFromPicker isEqualToString: testStringDMinor] == YES)
	{
		label.text = [NSString stringWithFormat:@"D, F, A"];
		//@"D Minor:"
	}
	
	if ([messageFromPicker isEqualToString: testStringDSharpMinor] == YES)
	{
		label.text = [NSString stringWithFormat:@"D♯, F♯, A♯"];
		//@"D♯ Minor:"
	}
	
	if ([messageFromPicker isEqualToString: testStringEbMinor] == YES)
	{
		label.text = [NSString stringWithFormat:@"E♭, G♭, B♭"];
		//@"E♭ Minor:"
	}
	
	if ([messageFromPicker isEqualToString: testStringEMinor] == YES)
	{
		label.text = [NSString stringWithFormat:@"E, G, B"];
		//@"E Minor:"
	}
	
	if ([messageFromPicker isEqualToString: testStringFMinor] == YES)
	{
		label.text = [NSString stringWithFormat:@"F, A♭, C"];
		//@"F Minor:"
	}
	
	if ([messageFromPicker isEqualToString: testStringFSharpMinor] == YES)
	{
		label.text = [NSString stringWithFormat:@"F♯, A, C♯"];
		//@"F♯ Minor:"
	}
	
	if ([messageFromPicker isEqualToString: testStringGbMinor] == YES)
	{
		label.text = [NSString stringWithFormat:@"G♭, B♭♭, D♭"];
		//@"G♭ Minor:"
	}
	
	if ([messageFromPicker isEqualToString: testStringGMinor] == YES)
	{
		label.text = [NSString stringWithFormat:@"G, B♭, D"];
		//@"G Minor:"
	}
	
	if ([messageFromPicker isEqualToString: testStringGSharpMinor] == YES)
	{
		label.text = [NSString stringWithFormat:@"G♯, B, D♯"];
		//@"G♯ Minor:"
	}
	
	if ([messageFromPicker isEqualToString: testStringAbMinor] == YES)
	{
		label.text = [NSString stringWithFormat:@"A♭, C♭, E♭"];
		//@"A♭ Minor:"
	}
	
	if ([messageFromPicker isEqualToString: testStringAMinor] == YES)
	{
		label.text = [NSString stringWithFormat:@"A, C, E"];
		//@"A Minor:"
	}
	
	if ([messageFromPicker isEqualToString: testStringASharpMinor] == YES)
	{
		label.text = [NSString stringWithFormat:@"A♯, C♯, E♯"];
		//@"A♯ Minor:"
	}
	
	if ([messageFromPicker isEqualToString: testStringBbMinor] == YES)
	{
		label.text = [NSString stringWithFormat:@"B♭, D♭, F"];
		//@"B♭ Minor:"
	}
	
	if ([messageFromPicker isEqualToString: testStringBMinor] == YES)
	{
		label.text = [NSString stringWithFormat:@"B, D, F♯"];
		//@"B Minor:"
	}
	
	// *********** AUGMENTED ifs **********************
	
	if ([messageFromPicker isEqualToString: testStringCAugmented] == YES)
	{
		label.text = [NSString stringWithFormat:@"C, E, G♯"];
		//@"C Augmented:"
	}
	
	if ([messageFromPicker isEqualToString: testStringCSharpAugmented] == YES)
	{
		label.text = [NSString stringWithFormat:@"C♯, E♯, Gx"];
		//@"C♯ Augmented:"
	}
	
	if ([messageFromPicker isEqualToString: testStringDbAugmented] == YES)
	{
		label.text = [NSString stringWithFormat:@"D♭, F, A"];
		//@"D♭ Augmented:"
	}
	
	if ([messageFromPicker isEqualToString: testStringDAugmented] == YES)
	{
		label.text = [NSString stringWithFormat:@"D, F♯, A♯"];
		//@"D Augmented:"
	}
	
	if ([messageFromPicker isEqualToString: testStringDSharpAugmented] == YES)
	{
		label.text = [NSString stringWithFormat:@"D♯, Fx, Ax"];
		//@"D♯ Augmented:"
	}
	
	if ([messageFromPicker isEqualToString: testStringEbAugmented] == YES)
	{
		label.text = [NSString stringWithFormat:@"E♭, G, B"];
		//@"E♭ Augmented:"
	}
	
	if ([messageFromPicker isEqualToString: testStringEAugmented] == YES)
	{
		label.text = [NSString stringWithFormat:@"E, G♯, B♯"];
		//@"E Augmented:"
	}
	
	if ([messageFromPicker isEqualToString: testStringFAugmented] == YES)
	{
		label.text = [NSString stringWithFormat:@"F, A, C♯"];
		//@"F Augmented:"
	}
	
	if ([messageFromPicker isEqualToString: testStringFSharpAugmented] == YES)
	{
		label.text = [NSString stringWithFormat:@"F♯, A♯, Cx"];
		//@"F♯ Augmented:"
	}
	
	if ([messageFromPicker isEqualToString: testStringGbAugmented] == YES)
	{
		label.text = [NSString stringWithFormat:@"G♭, B♭, D"];
		//@"G♭ Augmented:"
	}
	
	if ([messageFromPicker isEqualToString: testStringGAugmented] == YES)
	{
		label.text = [NSString stringWithFormat:@"G, B, D♯"];
		//@"G Augmented:"
	}
	
	if ([messageFromPicker isEqualToString: testStringGSharpAugmented] == YES)
	{
		label.text = [NSString stringWithFormat:@"G♯, B♯, Dx"];
		//@"G♯ Augmented:"
	}
	
	if ([messageFromPicker isEqualToString: testStringAbAugmented] == YES)
	{
		label.text = [NSString stringWithFormat:@"A♭, C, E"];
		//@"A♭ Augmented:"
	}
	
	if ([messageFromPicker isEqualToString: testStringAAugmented] == YES)
	{
		label.text = [NSString stringWithFormat:@"A, C♯, E♯"];
		//@"A Augmented:"
	}
	
	if ([messageFromPicker isEqualToString: testStringASharpAugmented] == YES)
	{
		label.text = [NSString stringWithFormat:@"A♯, Cx, Ex"];
		//@"A♯ Augmented:"
	}
	
	if ([messageFromPicker isEqualToString: testStringBbAugmented] == YES)
	{
		label.text = [NSString stringWithFormat:@"B♭, D, F♯"];
		//@"B♭ Augmented:"
	}
	
	if ([messageFromPicker isEqualToString: testStringBAugmented] == YES)
	{
		label.text = [NSString stringWithFormat:@"B, D♯, Fx"];
		//@"B Augmented:"
	}
	
	// *********** DIMINISHED ifs **********************
	
	if ([messageFromPicker isEqualToString: testStringCDiminished] == YES)
	{
		label.text = [NSString stringWithFormat:@"C, E♭, G♭"];
		//@"C Diminished:"
	}
	
	if ([messageFromPicker isEqualToString: testStringCSharpDiminished] == YES)
	{
		label.text = [NSString stringWithFormat:@"C♯, E, G"];
		//@"C♯ Diminished:"
	}
	
	if ([messageFromPicker isEqualToString: testStringDbDiminished] == YES)
	{
		label.text = [NSString stringWithFormat:@"D♭, F♭, A♭♭"];
		//@"D♭ Diminished:"
	}
	
	if ([messageFromPicker isEqualToString: testStringDDiminished] == YES)
	{
		label.text = [NSString stringWithFormat:@"D, F, A♭"];
		//@"D Diminished:"
	}
	
	if ([messageFromPicker isEqualToString: testStringDSharpDiminished] == YES)
	{
		label.text = [NSString stringWithFormat:@"D♯, F♯, A"];
		//@"D♯ Diminished:"
	}
	
	if ([messageFromPicker isEqualToString: testStringEbDiminished] == YES)
	{
		label.text = [NSString stringWithFormat:@"E♭, G♭, B♭♭"];
		//@"E♭ Diminished:"
	}
	
	if ([messageFromPicker isEqualToString: testStringEDiminished] == YES)
	{
		label.text = [NSString stringWithFormat:@"E, G, B♭"];
		//@"E Diminished:"
	}
	
	if ([messageFromPicker isEqualToString: testStringFDiminished] == YES)
	{
		label.text = [NSString stringWithFormat:@"F, A♭, C♭"];
		//@"F Diminished:"
	}
	
	if ([messageFromPicker isEqualToString: testStringFSharpDiminished] == YES)
	{
		label.text = [NSString stringWithFormat:@"F♯, A, C"];
		//@"F♯ Diminished:"
	}
	
	if ([messageFromPicker isEqualToString: testStringGbDiminished] == YES)
	{
		label.text = [NSString stringWithFormat:@"G♭, B♭♭, D♭♭"];
		//@"G♭ Diminished:"
	}
	
	if ([messageFromPicker isEqualToString: testStringGDiminished] == YES)
	{
		label.text = [NSString stringWithFormat:@"G, B♭, D♭"];
		//@"G Diminished:"
	}
	
	if ([messageFromPicker isEqualToString: testStringGSharpDiminished] == YES)
	{
		label.text = [NSString stringWithFormat:@"G♯, B, D"];
		//@"G♯ Diminished:"
	}
	
	if ([messageFromPicker isEqualToString: testStringAbDiminished] == YES)
	{
		label.text = [NSString stringWithFormat:@"A♭, C♭, E♭♭"];
		//@"A♭ Diminished:"
	}
	
	if ([messageFromPicker isEqualToString: testStringADiminished] == YES)
	{
		label.text = [NSString stringWithFormat:@"A, C, E♭"];
		//@"A Diminished:"
	}
	
	if ([messageFromPicker isEqualToString: testStringASharpDiminished] == YES)
	{
		label.text = [NSString stringWithFormat:@"A♯, C♯, E"];
		//@"A♯ Diminished:"
	}
	
	if ([messageFromPicker isEqualToString: testStringBbDiminished] == YES)
	{
		label.text = [NSString stringWithFormat:@"B♭, D♭, F♭"];
		//@"B♭ Diminished:"
	}
	
	if ([messageFromPicker isEqualToString: testStringBDiminished] == YES)
	{
		label.text = [NSString stringWithFormat:@"B, D, F"];
		//@"B Diminished:"
	}
	
	// *********** Major6 ifs **********************
	
	if ([messageFromPicker isEqualToString: testStringCMajor6] == YES)
	{
		label.text = [NSString stringWithFormat:@"E, G, C"];
		//@"C Major 6:"
	}
	
	if ([messageFromPicker isEqualToString: testStringCSharpMajor6] == YES)
	{
		label.text = [NSString stringWithFormat:@"E♯, G♯, C♯"];
		//@"C♯ Major 6:"
	}
	
	if ([messageFromPicker isEqualToString: testStringDbMajor6] == YES)
	{
		label.text = [NSString stringWithFormat:@"F, A♭, D♭"];
		//@"D♭ Major 6:"
	}
	
	if ([messageFromPicker isEqualToString: testStringDMajor6] == YES)
	{
		label.text = [NSString stringWithFormat:@"F♯, A, D"];
		//@"D Major 6:"
	}
	
	if ([messageFromPicker isEqualToString: testStringDSharpMajor6] == YES)
	{
		label.text = [NSString stringWithFormat:@"Fx, A♯, D♯"];
		//@"D♯ Major 6:"
	}
	
	if ([messageFromPicker isEqualToString: testStringEbMajor6] == YES)
	{
		label.text = [NSString stringWithFormat:@"G, B♭, E♭"];
		//@"E♭ Major 6:"
	}
	
	if ([messageFromPicker isEqualToString: testStringEMajor6] == YES)
	{
		label.text = [NSString stringWithFormat:@"G♯, B, E"];
		//@"E Major 6:"
	}
	
	if ([messageFromPicker isEqualToString: testStringFMajor6] == YES)
	{
		label.text = [NSString stringWithFormat:@"A, C, F"];
		//@"F Major 6:"
	}
	
	if ([messageFromPicker isEqualToString: testStringFSharpMajor6] == YES)
	{
		label.text = [NSString stringWithFormat:@"A♯, C♯, F♯"];
		//@"F♯ Major 6:"
	}
	
	if ([messageFromPicker isEqualToString: testStringGbMajor6] == YES)
	{
		label.text = [NSString stringWithFormat:@"B♭, D♭, G♭"];
		//@"G♭ Major 6:"
	}
	
	if ([messageFromPicker isEqualToString: testStringGMajor6] == YES)
	{
		label.text = [NSString stringWithFormat:@"B, D, G"];
		//@"G Major 6:"
	}
	
	if ([messageFromPicker isEqualToString: testStringGSharpMajor6] == YES)
	{
		label.text = [NSString stringWithFormat:@"B♯, D♯, G♯"];
		//@"G♯ Major 6:"
	}
	
	if ([messageFromPicker isEqualToString: testStringAbMajor6] == YES)
	{
		label.text = [NSString stringWithFormat:@"C, E♭, A♭"];
		//@"A♭ Major 6:"
	}
	
	if ([messageFromPicker isEqualToString: testStringAMajor6] == YES)
	{
		label.text = [NSString stringWithFormat:@"C♯, E, A"];
		//@"A Major 6:"
	}
	
	if ([messageFromPicker isEqualToString: testStringASharpMajor6] == YES)
	{
		label.text = [NSString stringWithFormat:@"Cx, E♯, A♯"];
		//@"A♯ Major 6:"
	}
	
	if ([messageFromPicker isEqualToString: testStringBbMajor6] == YES)
	{
		label.text = [NSString stringWithFormat:@"D, F, B♭"];
		//@"B♭ Major 6:"
	}
	
	if ([messageFromPicker isEqualToString: testStringBMajor6] == YES)
	{
		label.text = [NSString stringWithFormat:@"D♯, F♯, B"];
		//@"B Major 6:"
	}
	
	// *********** Minor6 ifs **********************
	
	if ([messageFromPicker isEqualToString: testStringCMinor6] == YES)
	{
		label.text = [NSString stringWithFormat:@"E♭, G, C"];
		//@"C Minor6:"
	}
	
	if ([messageFromPicker isEqualToString: testStringCSharpMinor6] == YES)
	{
		label.text = [NSString stringWithFormat:@"E, G♯, C♯"];
		//@"C♯ Minor6:"
	}
	
	if ([messageFromPicker isEqualToString: testStringDbMinor6] == YES)
	{
		label.text = [NSString stringWithFormat:@"F♭, A♭, D♭"];
		//@"D♭ Minor6:"
	}
	
	if ([messageFromPicker isEqualToString: testStringDMinor6] == YES)
	{
		label.text = [NSString stringWithFormat:@"F, A, D"];
		//@"D Minor6:"
	}
	
	if ([messageFromPicker isEqualToString: testStringDSharpMinor6] == YES)
	{
		label.text = [NSString stringWithFormat:@"F♯, A♯, D♯"];
		//@"D♯ Minor6:"
	}
	
	if ([messageFromPicker isEqualToString: testStringEbMinor6] == YES)
	{
		label.text = [NSString stringWithFormat:@"G♭, B♭, E♭"];
		//@"E♭ Minor6:"
	}
	
	if ([messageFromPicker isEqualToString: testStringEMinor6] == YES)
	{
		label.text = [NSString stringWithFormat:@"G, B, E"];
		//@"E Minor6:"
	}
	
	if ([messageFromPicker isEqualToString: testStringFMinor6] == YES)
	{
		label.text = [NSString stringWithFormat:@"A♭, C, F"];
		//@"F Minor6:"
	}
	
	if ([messageFromPicker isEqualToString: testStringFSharpMinor6] == YES)
	{
		label.text = [NSString stringWithFormat:@"A, C♯, F♯"];
		//@"F♯ Minor6:"
	}
	
	if ([messageFromPicker isEqualToString: testStringGbMinor6] == YES)
	{
		label.text = [NSString stringWithFormat:@"B♭♭, D♭, G♭"];
		//@"G♭ Minor6:"
	}
	
	if ([messageFromPicker isEqualToString: testStringGMinor6] == YES)
	{
		label.text = [NSString stringWithFormat:@"B♭, D, G"];
		//@"G Minor6:"
	}
	
	if ([messageFromPicker isEqualToString: testStringGSharpMinor6] == YES)
	{
		label.text = [NSString stringWithFormat:@"B, D♯, G♯"];
		//@"G♯ Minor6:"
	}
	
	if ([messageFromPicker isEqualToString: testStringAbMinor6] == YES)
	{
		label.text = [NSString stringWithFormat:@"C♭, E♭, A♭"];
		//@"A♭ Minor6:"
	}
	
	if ([messageFromPicker isEqualToString: testStringAMinor6] == YES)
	{
		label.text = [NSString stringWithFormat:@"C, E, A"];
		//@"A Minor6:"
	}
	
	if ([messageFromPicker isEqualToString: testStringASharpMinor6] == YES)
	{
		label.text = [NSString stringWithFormat:@"C♯, E♯, A♯"];
		//@"A♯ Minor6:"
	}
	
	if ([messageFromPicker isEqualToString: testStringBbMinor6] == YES)
	{
		label.text = [NSString stringWithFormat:@"D♭, F, B♭"];
		//@"B♭ Minor6:"
	}
	
	if ([messageFromPicker isEqualToString: testStringBMinor6] == YES)
	{
		label.text = [NSString stringWithFormat:@"D, F♯, B"];
		//@"B Minor6:"
	}
	
	// *********** Augmented6 ifs **********************
	
	if ([messageFromPicker isEqualToString: testStringCAugmented6] == YES)
	{
		label.text = [NSString stringWithFormat:@"E, G♯, C"];
		//@"C Augmented6:"
	}
	
	if ([messageFromPicker isEqualToString: testStringCSharpAugmented6] == YES)
	{
		label.text = [NSString stringWithFormat:@"E♯, Gx, C♯"];
		//@"C♯ Augmented6:"
	}
	
	if ([messageFromPicker isEqualToString: testStringDbAugmented6] == YES)
	{
		label.text = [NSString stringWithFormat:@"F, A, D♭"];
		//@"D♭ Augmented6:"
	}
	
	if ([messageFromPicker isEqualToString: testStringDAugmented6] == YES)
	{
		label.text = [NSString stringWithFormat:@"F♯, A♯, D"];
		//@"D Augmented6:"
	}
	
	if ([messageFromPicker isEqualToString: testStringDSharpAugmented6] == YES)
	{
		label.text = [NSString stringWithFormat:@"Fx, Ax, D♯"];
		//@"D♯ Augmented6:"
	}
	
	if ([messageFromPicker isEqualToString: testStringEbAugmented6] == YES)
	{
		label.text = [NSString stringWithFormat:@"G, B, E♭"];
		//@"E♭ Augmented6:"
	}
	
	if ([messageFromPicker isEqualToString: testStringEAugmented6] == YES)
	{
		label.text = [NSString stringWithFormat:@"G♯, B♯, E"];
		//@"E Augmented6:"
	}
	
	if ([messageFromPicker isEqualToString: testStringFAugmented6] == YES)
	{
		label.text = [NSString stringWithFormat:@"A, C♯, F"];
		//@"F Augmented6:"
	}
	
	if ([messageFromPicker isEqualToString: testStringFSharpAugmented6] == YES)
	{
		label.text = [NSString stringWithFormat:@"A♯, Cx, F♯"];
		//@"F♯ Augmented6:"
	}
	
	if ([messageFromPicker isEqualToString: testStringGbAugmented6] == YES)
	{
		label.text = [NSString stringWithFormat:@"B♭, D, G♭"];
		//@"G♭ Augmented6:"
	}
	
	if ([messageFromPicker isEqualToString: testStringGAugmented6] == YES)
	{
		label.text = [NSString stringWithFormat:@"B, D♯, G"];
		//@"G Augmented6:"
	}
	
	if ([messageFromPicker isEqualToString: testStringGSharpAugmented6] == YES)
	{
		label.text = [NSString stringWithFormat:@"B♯, Dx, G♯"];
		//@"G♯ Augmented6:"
	}
	
	if ([messageFromPicker isEqualToString: testStringAbAugmented6] == YES)
	{
		label.text = [NSString stringWithFormat:@"C, E, A♭"];
		//@"A♭ Augmented6:"
	}
	
	if ([messageFromPicker isEqualToString: testStringAAugmented6] == YES)
	{
		label.text = [NSString stringWithFormat:@"C♯, E♯, A"];
		//@"A Augmented6:"
	}
	
	if ([messageFromPicker isEqualToString: testStringASharpAugmented6] == YES)
	{
		label.text = [NSString stringWithFormat:@"Cx, Ex, A♯"];
		//@"A♯ Augmented6:"
	}
	
	if ([messageFromPicker isEqualToString: testStringBbAugmented6] == YES)
	{
		label.text = [NSString stringWithFormat:@"D, F♯, B♭"];
		//@"B♭ Augmented6:"
	}
	
	if ([messageFromPicker isEqualToString: testStringBAugmented6] == YES)
	{
		label.text = [NSString stringWithFormat:@"D♯, Fx, B"];
		//@"B Augmented6:"
	}
	
	// *********** Diminished6 ifs **********************
	
	if ([messageFromPicker isEqualToString: testStringCDiminished6] == YES)
	{
		label.text = [NSString stringWithFormat:@"E♭, G♭, C"];
		//@"C Diminished6:"
	}
	
	if ([messageFromPicker isEqualToString: testStringCSharpDiminished6] == YES)
	{
		label.text = [NSString stringWithFormat:@"E, G, C♯"];
		//@"C♯ Diminished6:"
	}
	
	if ([messageFromPicker isEqualToString: testStringDbDiminished6] == YES)
	{
		label.text = [NSString stringWithFormat:@"F♭, A♭♭, D♭"];
		//@"D♭ Diminished6:"
	}
	
	if ([messageFromPicker isEqualToString: testStringDDiminished6] == YES)
	{
		label.text = [NSString stringWithFormat:@"F, A♭, D"];
		//@"D Diminished6:"
	}
	
	if ([messageFromPicker isEqualToString: testStringDSharpDiminished6] == YES)
	{
		label.text = [NSString stringWithFormat:@"F♯, A, D♯"];
		//@"D♯ Diminished6:"
	}
	
	if ([messageFromPicker isEqualToString: testStringEbDiminished6] == YES)
	{
		label.text = [NSString stringWithFormat:@"G♭, B♭♭, E♭"];
		//@"E♭ Diminished6:"
	}
	
	if ([messageFromPicker isEqualToString: testStringEDiminished6] == YES)
	{
		label.text = [NSString stringWithFormat:@"G, B♭, E"];
		//@"E Diminished6:"
	}
	
	if ([messageFromPicker isEqualToString: testStringFDiminished6] == YES)
	{
		label.text = [NSString stringWithFormat:@"A♭, C♭, F"];
		//@"F Diminished6:"
	}
	
	if ([messageFromPicker isEqualToString: testStringFSharpDiminished6] == YES)
	{
		label.text = [NSString stringWithFormat:@"A, C, F♯"];
		//@"F♯ Diminished6:"
	}
	
	if ([messageFromPicker isEqualToString: testStringGbDiminished6] == YES)
	{
		label.text = [NSString stringWithFormat:@"B♭♭, D♭♭, G♭"];
		//@"G♭ Diminished6:"
	}
	
	if ([messageFromPicker isEqualToString: testStringGDiminished6] == YES)
	{
		label.text = [NSString stringWithFormat:@"B♭, D♭, G"];
		//@"G Diminished6:"
	}
	
	if ([messageFromPicker isEqualToString: testStringGSharpDiminished6] == YES)
	{
		label.text = [NSString stringWithFormat:@"B, D, G♯"];
		//@"G♯ Diminished6:"
	}
	
	if ([messageFromPicker isEqualToString: testStringAbDiminished6] == YES)
	{
		label.text = [NSString stringWithFormat:@"C♭, E♭♭, A♭"];
		//@"A♭ Diminished6:"
	}
	
	if ([messageFromPicker isEqualToString: testStringADiminished6] == YES)
	{
		label.text = [NSString stringWithFormat:@"C, E♭, A"];
		//@"A Diminished6:"
	}
	
	if ([messageFromPicker isEqualToString: testStringASharpDiminished6] == YES)
	{
		label.text = [NSString stringWithFormat:@"C♯, E, A♯"];
		//@"A♯ Diminished6:"
	}
	
	if ([messageFromPicker isEqualToString: testStringBbDiminished6] == YES)
	{
		label.text = [NSString stringWithFormat:@"D♭, F♭, B♭"];
		//@"B♭ Diminished6:"
	}
	
	if ([messageFromPicker isEqualToString: testStringBDiminished6] == YES)
	{
		label.text = [NSString stringWithFormat:@"D, F, B"];
		//@"B Diminished6:"
	}
	
	// *********** Major64 ifs **********************
	
	if ([messageFromPicker isEqualToString: testStringCMajor64] == YES)
	{
		label.text = [NSString stringWithFormat:@"G, C, E"];
		//@"C Major 6-4:"
	}
	
	if ([messageFromPicker isEqualToString: testStringCSharpMajor64] == YES)
	{
		label.text = [NSString stringWithFormat:@"G♯, C♯, E♯"];
		//@"C♯ Major 6-4:"
	}
	
	if ([messageFromPicker isEqualToString: testStringDbMajor64] == YES)
	{
		label.text = [NSString stringWithFormat:@"A♭, D♭, F"];
		//@"D♭ Major 6-4:"
	}
	
	if ([messageFromPicker isEqualToString: testStringDMajor64] == YES)
	{
		label.text = [NSString stringWithFormat:@"A, D, F♯"];
		//@"D Major 6-4:"
	}
	
	if ([messageFromPicker isEqualToString: testStringDSharpMajor64] == YES)
	{
		label.text = [NSString stringWithFormat:@"A♯, D♯, Fx"];
		//@"D♯ Major 6-4:"
	}
	
	if ([messageFromPicker isEqualToString: testStringEbMajor64] == YES)
	{
		label.text = [NSString stringWithFormat:@"B♭, E♭, G"];
		//@"E♭ Major 6-4:"
	}
	
	if ([messageFromPicker isEqualToString: testStringEMajor64] == YES)
	{
		label.text = [NSString stringWithFormat:@"B, E, G♯"];
		//@"E Major 6-4:"
	}
	
	if ([messageFromPicker isEqualToString: testStringFMajor64] == YES)
	{
		label.text = [NSString stringWithFormat:@"C, F, A"];
		//@"F Major 6-4:"
	}
	
	if ([messageFromPicker isEqualToString: testStringFSharpMajor64] == YES)
	{
		label.text = [NSString stringWithFormat:@"C♯, F♯, A♯"];
		//@"F♯ Major 6-4:"
	}
	
	if ([messageFromPicker isEqualToString: testStringGbMajor64] == YES)
	{
		label.text = [NSString stringWithFormat:@"D♭, G♭, B♭"];
		//@"G♭ Major 6-4:"
	}
	
	if ([messageFromPicker isEqualToString: testStringGMajor64] == YES)
	{
		label.text = [NSString stringWithFormat:@"D, G, B"];
		//@"G Major 6-4:"
	}
	
	if ([messageFromPicker isEqualToString: testStringGSharpMajor64] == YES)
	{
		label.text = [NSString stringWithFormat:@"D♯, G♯, B♯"];
		//@"G♯ Major 6-4:"
	}
	
	if ([messageFromPicker isEqualToString: testStringAbMajor64] == YES)
	{
		label.text = [NSString stringWithFormat:@"E♭, A♭, C"];
		//@"A♭ Major 6-4:"
	}
	
	if ([messageFromPicker isEqualToString: testStringAMajor64] == YES)
	{
		label.text = [NSString stringWithFormat:@"C♯, E, A"];
		//@"A Major 6-4:"
	}
	
	if ([messageFromPicker isEqualToString: testStringASharpMajor64] == YES)
	{
		label.text = [NSString stringWithFormat:@"E♯, A♯, Cx"];
		//@"A♯ Major 6-4:"
	}
	
	if ([messageFromPicker isEqualToString: testStringBbMajor64] == YES)
	{
		label.text = [NSString stringWithFormat:@"F, B♭, D"];
		//@"B♭ Major 6-4:"
	}
	
	if ([messageFromPicker isEqualToString: testStringBMajor64] == YES)
	{
		label.text = [NSString stringWithFormat:@"F♯, B, D♯"];
		//@"B Major 6-4:"
	}
	
	// *********** Minor64 ifs **********************
	
	if ([messageFromPicker isEqualToString: testStringCMinor64] == YES)
	{
		label.text = [NSString stringWithFormat:@"G, C, E♭"];
		//@"C Minor64:"
	}
	
	if ([messageFromPicker isEqualToString: testStringCSharpMinor64] == YES)
	{
		label.text = [NSString stringWithFormat:@"G♯, C♯, E"];
		//@"C♯ Minor64:"
	}
	
	if ([messageFromPicker isEqualToString: testStringDbMinor64] == YES)
	{
		label.text = [NSString stringWithFormat:@"A♭, D♭, F♭"];
		//@"D♭ Minor64:"
	}
	
	if ([messageFromPicker isEqualToString: testStringDMinor64] == YES)
	{
		label.text = [NSString stringWithFormat:@"A, D, F"];
		//@"D Minor64:"
	}
	
	if ([messageFromPicker isEqualToString: testStringDSharpMinor64] == YES)
	{
		label.text = [NSString stringWithFormat:@"A♯, D♯, F♯"];
		//@"D♯ Minor64:"
	}
	
	if ([messageFromPicker isEqualToString: testStringEbMinor64] == YES)
	{
		label.text = [NSString stringWithFormat:@"B♭, E♭, G♭"];
		//@"E♭ Minor64:"
	}
	
	if ([messageFromPicker isEqualToString: testStringEMinor64] == YES)
	{
		label.text = [NSString stringWithFormat:@"B, E, G"];
		//@"E Minor64:"
	}
	
	if ([messageFromPicker isEqualToString: testStringFMinor64] == YES)
	{
		label.text = [NSString stringWithFormat:@"C, F, A♭"];
		//@"F Minor64:"
	}
	
	if ([messageFromPicker isEqualToString: testStringFSharpMinor64] == YES)
	{
		label.text = [NSString stringWithFormat:@"C♯, F♯, A"];
		//@"F♯ Minor64:"
	}
	
	if ([messageFromPicker isEqualToString: testStringGbMinor64] == YES)
	{
		label.text = [NSString stringWithFormat:@"D♭, G♭, B♭♭"];
		//@"G♭ Minor64:"
	}
	
	if ([messageFromPicker isEqualToString: testStringGMinor64] == YES)
	{
		label.text = [NSString stringWithFormat:@"D, G, B♭"];
		//@"G Minor64:"
	}
	
	if ([messageFromPicker isEqualToString: testStringGSharpMinor64] == YES)
	{
		label.text = [NSString stringWithFormat:@"D♯, G♯, B"];
		//@"G♯ Minor64:"
	}
	
	if ([messageFromPicker isEqualToString: testStringAbMinor64] == YES)
	{
		label.text = [NSString stringWithFormat:@"E♭, A♭, C♭"];
		//@"A♭ Minor64:"
	}
	
	if ([messageFromPicker isEqualToString: testStringAMinor64] == YES)
	{
		label.text = [NSString stringWithFormat:@"E, A, C"];
		//@"A Minor64:"
	}
	
	if ([messageFromPicker isEqualToString: testStringASharpMinor64] == YES)
	{
		label.text = [NSString stringWithFormat:@"E♯, A♯, C♯"];
		//@"A♯ Minor64:"
	}
	
	if ([messageFromPicker isEqualToString: testStringBbMinor64] == YES)
	{
		label.text = [NSString stringWithFormat:@"F, B♭, D♭"];
		//@"B♭ Minor64:"
	}
	
	if ([messageFromPicker isEqualToString: testStringBMinor64] == YES)
	{
		label.text = [NSString stringWithFormat:@"F♯, B, D"];
		//@"B Minor64:"
	}
	
	// *********** Augmented64 ifs **********************
	
	if ([messageFromPicker isEqualToString: testStringCAugmented64] == YES)
	{
		label.text = [NSString stringWithFormat:@"G♯, C, E"];
		//@"C Augmented64:"
	}
	
	if ([messageFromPicker isEqualToString: testStringCSharpAugmented64] == YES)
	{
		label.text = [NSString stringWithFormat:@"Gx, C♯, E♯"];
		//@"C♯ Augmented64:"
	}
	
	if ([messageFromPicker isEqualToString: testStringDbAugmented64] == YES)
	{
		label.text = [NSString stringWithFormat:@"A, D♭, F"];
		//@"D♭ Augmented64:"
	}
	
	if ([messageFromPicker isEqualToString: testStringDAugmented64] == YES)
	{
		label.text = [NSString stringWithFormat:@"A♯, D, F♯"];
		//@"D Augmented64:"
	}
	
	if ([messageFromPicker isEqualToString: testStringDSharpAugmented64] == YES)
	{
		label.text = [NSString stringWithFormat:@"Ax, D♯, Fx"];
		//@"D♯ Augmented64:"
	}
	
	if ([messageFromPicker isEqualToString: testStringEbAugmented64] == YES)
	{
		label.text = [NSString stringWithFormat:@"B, E♭, G"];
		//@"E♭ Augmented64:"
	}
	
	if ([messageFromPicker isEqualToString: testStringEAugmented64] == YES)
	{
		label.text = [NSString stringWithFormat:@"B♯, E, G♯"];
		//@"E Augmented64:"
	}
	
	if ([messageFromPicker isEqualToString: testStringFAugmented64] == YES)
	{
		label.text = [NSString stringWithFormat:@"C♯, F, A"];
		//@"F Augmented64:"
	}
	
	if ([messageFromPicker isEqualToString: testStringFSharpAugmented64] == YES)
	{
		label.text = [NSString stringWithFormat:@"Cx, F♯, A♯"];
		//@"F♯ Augmented64:"
	}
	
	if ([messageFromPicker isEqualToString: testStringGbAugmented64] == YES)
	{
		label.text = [NSString stringWithFormat:@"D, G♭, B♭"];
		//@"G♭ Augmented64:"
	}
	
	if ([messageFromPicker isEqualToString: testStringGAugmented64] == YES)
	{
		label.text = [NSString stringWithFormat:@"D♯, G, B"];
		//@"G Augmented64:"
	}
	
	if ([messageFromPicker isEqualToString: testStringGSharpAugmented64] == YES)
	{
		label.text = [NSString stringWithFormat:@"Dx, G♯, B♯"];
		//@"G♯ Augmented64:"
	}
	
	if ([messageFromPicker isEqualToString: testStringAbAugmented64] == YES)
	{
		label.text = [NSString stringWithFormat:@"E, A♭, C"];
		//@"A♭ Augmented64:"
	}
	
	if ([messageFromPicker isEqualToString: testStringAAugmented64] == YES)
	{
		label.text = [NSString stringWithFormat:@"E♯, A, C♯"];
		//@"A Augmented64:"
	}
	
	if ([messageFromPicker isEqualToString: testStringASharpAugmented64] == YES)
	{
		label.text = [NSString stringWithFormat:@"Ex, A♯, Cx"];
		//@"A♯ Augmented64:"
	}
	
	if ([messageFromPicker isEqualToString: testStringBbAugmented64] == YES)
	{
		label.text = [NSString stringWithFormat:@"F♯, B♭, D"];
		//@"B♭ Augmented64:"
	}
	
	if ([messageFromPicker isEqualToString: testStringBAugmented64] == YES)
	{
		label.text = [NSString stringWithFormat:@"Fx, B, D♯"];
		//@"B Augmented64:"
	}
	
	// *********** Diminished64 ifs **********************
	
	if ([messageFromPicker isEqualToString: testStringCDiminished64] == YES)
	{
		label.text = [NSString stringWithFormat:@"G♭, C, E♭"];
		//@"C Diminished64:"
	}
	
	if ([messageFromPicker isEqualToString: testStringCSharpDiminished64] == YES)
	{
		label.text = [NSString stringWithFormat:@"G, C♯, E"];
		//@"C♯ Diminished64:"
	}
	
	if ([messageFromPicker isEqualToString: testStringDbDiminished64] == YES)
	{
		label.text = [NSString stringWithFormat:@"A♭♭, D♭, F♭"];
		//@"D♭ Diminished64:"
	}
	
	if ([messageFromPicker isEqualToString: testStringDDiminished64] == YES)
	{
		label.text = [NSString stringWithFormat:@"A♭, D, F"];
		//@"D Diminished64:"
	}
	
	if ([messageFromPicker isEqualToString: testStringDSharpDiminished64] == YES)
	{
		label.text = [NSString stringWithFormat:@"A, D♯, F♯"];
		//@"D♯ Diminished64:"
	}
	
	if ([messageFromPicker isEqualToString: testStringEbDiminished64] == YES)
	{
		label.text = [NSString stringWithFormat:@"B♭♭, E♭, G♭"];
		//@"E♭ Diminished64:"
	}
	
	if ([messageFromPicker isEqualToString: testStringEDiminished64] == YES)
	{
		label.text = [NSString stringWithFormat:@"B♭, E, G"];
		//@"E Diminished64:"
	}
	
	if ([messageFromPicker isEqualToString: testStringFDiminished64] == YES)
	{
		label.text = [NSString stringWithFormat:@"C♭, F, A♭"];
		//@"F Diminished64:"
	}
	
	if ([messageFromPicker isEqualToString: testStringFSharpDiminished64] == YES)
	{
		label.text = [NSString stringWithFormat:@"C, F♯, A"];
		//@"F♯ Diminished64:"
	}
	
	if ([messageFromPicker isEqualToString: testStringGbDiminished64] == YES)
	{
		label.text = [NSString stringWithFormat:@"D♭♭, G♭, B♭♭"];
		//@"G♭ Diminished64:"
	}
	
	if ([messageFromPicker isEqualToString: testStringGDiminished64] == YES)
	{
		label.text = [NSString stringWithFormat:@"D♭, G, B♭"];
		//@"G Diminished64:"
	}
	
	if ([messageFromPicker isEqualToString: testStringGSharpDiminished64] == YES)
	{
		label.text = [NSString stringWithFormat:@"D, G♯, B"];
		//@"G♯ Diminished64:"
	}
	
	if ([messageFromPicker isEqualToString: testStringAbDiminished64] == YES)
	{
		label.text = [NSString stringWithFormat:@"E♭♭, A♭, C♭"];
		//@"A♭ Diminished64:"
	}
	
	if ([messageFromPicker isEqualToString: testStringADiminished64] == YES)
	{
		label.text = [NSString stringWithFormat:@"E♭, A, C"];
		//@"A Diminished64:"
	}
	
	if ([messageFromPicker isEqualToString: testStringASharpDiminished64] == YES)
	{
		label.text = [NSString stringWithFormat:@"E, A♯, C♯"];
		//@"A♯ Diminished64:"
	}
	
	if ([messageFromPicker isEqualToString: testStringBbDiminished64] == YES)
	{
		label.text = [NSString stringWithFormat:@"F♭, B♭, D♭"];
		//@"B♭ Diminished64:"
	}
	
	if ([messageFromPicker isEqualToString: testStringBDiminished64] == YES)
	{
		label.text = [NSString stringWithFormat:@"F, B, D"];
		//@"B Diminished64:"
	}
	
	// *********** Italian ifs **********************
	
	if ([messageFromPicker isEqualToString: testStringCItalian] == YES)
	{
		//@"test, C♯oø, E♭, Gxbb+, bbbº, c+7"
		label.text = [NSString stringWithFormat:@"C, E, A♯"];
		//@"C♯ Italian +6:"
	}
	
	if ([messageFromPicker isEqualToString: testStringCSharpItalian] == YES)
	{
		label.text = [NSString stringWithFormat:@"C♯, E♯, Ax"];
		//@"C♯ Italian +6:"
	}
	
	if ([messageFromPicker isEqualToString: testStringDbItalian] == YES)
	{
		label.text = [NSString stringWithFormat:@"D♭, F, B"];
		//@"D♭ Italian +6:"
	}
	
	if ([messageFromPicker isEqualToString: testStringDItalian] == YES)
	{
		label.text = [NSString stringWithFormat:@"D, F♯, B♯"];
		//@"D Italian +6:"
	}
	
	if ([messageFromPicker isEqualToString: testStringDSharpItalian] == YES)
	{
		label.text = [NSString stringWithFormat:@"D♯, Fx, Bx"];
		//@"D♯ Italian +6:"
	}
	
	if ([messageFromPicker isEqualToString: testStringEbItalian] == YES)
	{
		label.text = [NSString stringWithFormat:@"E♭, G, C♯"];
		//@"E♭ Italian +6:"
	}
	
	if ([messageFromPicker isEqualToString: testStringEItalian] == YES)
	{
		label.text = [NSString stringWithFormat:@"E, G♯, Cx"];
		//@"E Italian +6:"
	}
	
	if ([messageFromPicker isEqualToString: testStringFItalian] == YES)
	{
		label.text = [NSString stringWithFormat:@"F, A, D♯"];
		//@"F Italian +6:"
	}
	
	if ([messageFromPicker isEqualToString: testStringFSharpItalian] == YES)
	{
		label.text = [NSString stringWithFormat:@"F♯, A♯, Dx"];
		//@"F♯ Italian +6:"
	}
	
	if ([messageFromPicker isEqualToString: testStringGbItalian] == YES)
	{
		label.text = [NSString stringWithFormat:@"G♭, B♭, E"];
		//@"G♭ Italian +6:"
	}
	
	if ([messageFromPicker isEqualToString: testStringGItalian] == YES)
	{
		label.text = [NSString stringWithFormat:@"G, B, E♯"];
		//@"G Italian +6:"
	}
	
	if ([messageFromPicker isEqualToString: testStringGSharpItalian] == YES)
	{
		label.text = [NSString stringWithFormat:@"G♯, B♯, Ex"];
		//@"G♯ Italian +6:"
	}
	
	if ([messageFromPicker isEqualToString: testStringAbItalian] == YES)
	{
		label.text = [NSString stringWithFormat:@"A♭, C, F♯"];
		//@"A♭ Italian +6:"
	}
	
	if ([messageFromPicker isEqualToString: testStringAItalian] == YES)
	{
		label.text = [NSString stringWithFormat:@"A, C♯, Fx"];
		//@"A Italian +6:"
	}
	
	if ([messageFromPicker isEqualToString: testStringASharpItalian] == YES)
	{
		label.text = [NSString stringWithFormat:@"A♯, Cx, Fx♯"];
		//@"A♯ Italian +6:"
	}
	
	if ([messageFromPicker isEqualToString: testStringBbItalian] == YES)
	{
		label.text = [NSString stringWithFormat:@"B♭, D, G♯"];
		//@"B♭ Italian +6:"
	}
	
	if ([messageFromPicker isEqualToString: testStringBItalian] == YES)
	{
		label.text = [NSString stringWithFormat:@"B, D♯, Gx"];
		//@"B Italian +6:"
	}
	
	// *********** French ifs **********************
	
	if ([messageFromPicker isEqualToString: testStringCFrench] == YES)
	{
		//@"test, C♯oø, E♭, Gxbb+, bbbº, c+7"
		label.text = [NSString stringWithFormat:@"C, E, F♯, A♯"];
		//@"C♯ French +6:"
	}
	
	if ([messageFromPicker isEqualToString: testStringCSharpFrench] == YES)
	{
		label.text = [NSString stringWithFormat:@"C♯, E♯, Fx, Ax"];
		//@"C♯ French +6:"
	}
	
	if ([messageFromPicker isEqualToString: testStringDbFrench] == YES)
	{
		label.text = [NSString stringWithFormat:@"D♭, F, G, B"];
		//@"D♭ French +6:"
	}
	
	if ([messageFromPicker isEqualToString: testStringDFrench] == YES)
	{
		label.text = [NSString stringWithFormat:@"D, F♯, G♯, B♯"];
		//@"D French +6:"
	}
	
	if ([messageFromPicker isEqualToString: testStringDSharpFrench] == YES)
	{
		label.text = [NSString stringWithFormat:@"D♯, Fx, Gx, Bx"];
		//@"D♯ French +6:"
	}
	
	if ([messageFromPicker isEqualToString: testStringEbFrench] == YES)
	{
		label.text = [NSString stringWithFormat:@"E♭, G, A, C♯"];
		//@"E♭ French +6:"
	}
	
	if ([messageFromPicker isEqualToString: testStringEFrench] == YES)
	{
		label.text = [NSString stringWithFormat:@"E, G♯, A♯, Cx"];
		//@"E French +6:"
	}
	
	if ([messageFromPicker isEqualToString: testStringFFrench] == YES)
	{
		label.text = [NSString stringWithFormat:@"F, A, B, D♯"];
		//@"F French +6:"
	}
	
	if ([messageFromPicker isEqualToString: testStringFSharpFrench] == YES)
	{
		label.text = [NSString stringWithFormat:@"F♯, A♯, B♯, Dx"];
		//@"F♯ French +6:"
	}
	
	if ([messageFromPicker isEqualToString: testStringGbFrench] == YES)
	{
		label.text = [NSString stringWithFormat:@"G♭, B♭, C, E"];
		//@"G♭ French +6:"
	}
	
	if ([messageFromPicker isEqualToString: testStringGFrench] == YES)
	{
		label.text = [NSString stringWithFormat:@"G, B, C♯, E♯"];
		//@"G French +6:"
	}
	
	if ([messageFromPicker isEqualToString: testStringGSharpFrench] == YES)
	{
		label.text = [NSString stringWithFormat:@"G♯, B♯, Cx, Ex"];
		//@"G♯ French +6:"
	}
	
	if ([messageFromPicker isEqualToString: testStringAbFrench] == YES)
	{
		label.text = [NSString stringWithFormat:@"A♭, C, D, F♯"];
		//@"A♭ French +6:"
	}
	
	if ([messageFromPicker isEqualToString: testStringAFrench] == YES)
	{
		label.text = [NSString stringWithFormat:@"A, C♯, D♯, Fx"];
		//@"A French +6:"
	}
	
	if ([messageFromPicker isEqualToString: testStringASharpFrench] == YES)
	{
		label.text = [NSString stringWithFormat:@"A♯, Cx, Dx, Fx♯"];
		//@"A♯ French +6:"
	}
	
	if ([messageFromPicker isEqualToString: testStringBbFrench] == YES)
	{
		label.text = [NSString stringWithFormat:@"B♭, D, E, G♯"];
		//@"B♭ French +6:"
	}
	
	if ([messageFromPicker isEqualToString: testStringBFrench] == YES)
	{
		label.text = [NSString stringWithFormat:@"B, D♯, E♯, Gx"];
		//@"B French +6:"
	}
	
	// *********** German ifs **********************
	
	if ([messageFromPicker isEqualToString: testStringCGerman] == YES)
	{
		//@"test, C♯oø, E♭, Gxbb+, bbbº, c+7"
		label.text = [NSString stringWithFormat:@"C, E, G, A♯"];
		//@"C♯ German +6:"
	}
	
	if ([messageFromPicker isEqualToString: testStringCSharpGerman] == YES)
	{
		label.text = [NSString stringWithFormat:@"C♯, E♯, G♯, Ax"];
		//@"C♯ German +6:"
	}
	
	if ([messageFromPicker isEqualToString: testStringDbGerman] == YES)
	{
		label.text = [NSString stringWithFormat:@"D♭, F, A♭, B"];
		//@"D♭ German +6:"
	}
	
	if ([messageFromPicker isEqualToString: testStringDGerman] == YES)
	{
		label.text = [NSString stringWithFormat:@"D, F♯, A, B♯"];
		//@"D German +6:"
	}
	
	if ([messageFromPicker isEqualToString: testStringDSharpGerman] == YES)
	{
		label.text = [NSString stringWithFormat:@"D♯, Fx, A♯, Bx"];
		//@"D♯ German +6:"
	}
	
	if ([messageFromPicker isEqualToString: testStringEbGerman] == YES)
	{
		label.text = [NSString stringWithFormat:@"E♭, G, B♭, A"];
		//@"E♭ German +6:"
	}
	
	if ([messageFromPicker isEqualToString: testStringEGerman] == YES)
	{
		label.text = [NSString stringWithFormat:@"E, G♯, B, Cx"];
		//@"E German +6:"
	}
	
	if ([messageFromPicker isEqualToString: testStringFGerman] == YES)
	{
		label.text = [NSString stringWithFormat:@"F, A, C, D♯"];
		//@"F German +6:"
	}
	
	if ([messageFromPicker isEqualToString: testStringFSharpGerman] == YES)
	{
		label.text = [NSString stringWithFormat:@"F♯, A♯, C♯, Dx"];
		//@"F♯ German +6:"
	}
	
	if ([messageFromPicker isEqualToString: testStringGbGerman] == YES)
	{
		label.text = [NSString stringWithFormat:@"G♭, B♭, D♭, E"];
		//@"G♭ German +6:"
	}
	
	if ([messageFromPicker isEqualToString: testStringGGerman] == YES)
	{
		label.text = [NSString stringWithFormat:@"G, B, D, E♯"];
		//@"G German +6:"
	}
	
	if ([messageFromPicker isEqualToString: testStringGSharpGerman] == YES)
	{
		label.text = [NSString stringWithFormat:@"G♯, B♯, D♯, Ex"];
		//@"G♯ German +6:"
	}
	
	if ([messageFromPicker isEqualToString: testStringAbGerman] == YES)
	{
		label.text = [NSString stringWithFormat:@"A♭, C, E♭, F♯"];
		//@"A♭ German +6:"
	}
	
	if ([messageFromPicker isEqualToString: testStringAGerman] == YES)
	{
		label.text = [NSString stringWithFormat:@"A, C♯, E, Fx"];
		//@"A German +6:"
	}
	
	if ([messageFromPicker isEqualToString: testStringASharpGerman] == YES)
	{
		label.text = [NSString stringWithFormat:@"A♯, Cx, E♯, Fx♯"];
		//@"A♯ German +6:"
	}
	
	if ([messageFromPicker isEqualToString: testStringBbGerman] == YES)
	{
		label.text = [NSString stringWithFormat:@"B♭, D, F, G♯"];
		//@"B♭ German +6:"
	}
	
	if ([messageFromPicker isEqualToString: testStringBGerman] == YES)
	{
		label.text = [NSString stringWithFormat:@"B, D♯, F♯, Gx"];
		//@"B German +6:"
	}	
	
	// *********** Major7 ifs **********************
	
	if ([messageFromPicker isEqualToString: testStringCMajor7] == YES)
	{
		// ********************%%%%%%%%%%%^^^^^^^^^^^^^^^$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$	
		//label.adjustsFontSizeToFitWidth = YES;
		//label.numberOfLines = 10;
		//label.sizeToFit;
		//label.minimumFontSize = 9.0f;
		label.text = [NSString stringWithFormat:@"C, E, G, B"];
		//@"C Major 7:"
	}
	
	if ([messageFromPicker isEqualToString: testStringCSharpMajor7] == YES)
	{
		label.text = [NSString stringWithFormat:@"C♯, E♯, G♯, B♯"];
		//@"C♯ Major 7:"
	}
	
	if ([messageFromPicker isEqualToString: testStringDbMajor7] == YES)
	{
		label.text = [NSString stringWithFormat:@"D♭, F, A♭, C"];
		//@"D♭ Major 7:"
	}
	
	if ([messageFromPicker isEqualToString: testStringDMajor7] == YES)
	{
		label.text = [NSString stringWithFormat:@"D, F♯, A, C♯"];
		//@"D Major 7:"
	}
	
	if ([messageFromPicker isEqualToString: testStringDSharpMajor7] == YES)
	{
		label.text = [NSString stringWithFormat:@"D♯, Fx, A♯, Cx"];
		//@"D♯ Major 7:"
	}
	
	if ([messageFromPicker isEqualToString: testStringEbMajor7] == YES)
	{
		label.text = [NSString stringWithFormat:@"E♭, G, B♭, D"];
		//@"E♭ Major 7:"
	}
	
	if ([messageFromPicker isEqualToString: testStringEMajor7] == YES)
	{
		label.text = [NSString stringWithFormat:@"E, G♯, B, D♯"];
		//@"E Major 7:"
	}
	
	if ([messageFromPicker isEqualToString: testStringFMajor7] == YES)
	{
		label.text = [NSString stringWithFormat:@"F, A, C, E"];
		//@"F Major 7:"
	}
	
	if ([messageFromPicker isEqualToString: testStringFSharpMajor7] == YES)
	{
		label.text = [NSString stringWithFormat:@"F♯, A♯, C♯, E♯"];
		//@"F♯ Major 7:"
	}
	
	if ([messageFromPicker isEqualToString: testStringGbMajor7] == YES)
	{
		label.text = [NSString stringWithFormat:@"G♭, B♭, D♭, F"];
		//@"G♭ Major 7:"
	}
	
	if ([messageFromPicker isEqualToString: testStringGMajor7] == YES)
	{
		label.text = [NSString stringWithFormat:@"G, B, D, F♯"];
		//@"G Major 7:"
	}
	
	if ([messageFromPicker isEqualToString: testStringGSharpMajor7] == YES)
	{
		label.text = [NSString stringWithFormat:@"G♯, B♯, D♯, Fx"];
		//@"G♯ Major 7:"
	}
	
	if ([messageFromPicker isEqualToString: testStringAbMajor7] == YES)
	{
		label.text = [NSString stringWithFormat:@"A♭, C, E♭, G"];
		//@"A♭ Major 7:"
	}
	
	if ([messageFromPicker isEqualToString: testStringAMajor7] == YES)
	{
		label.text = [NSString stringWithFormat:@"A, C♯, E, G♯"];
		//@"A Major 7:"
	}
	
	if ([messageFromPicker isEqualToString: testStringASharpMajor7] == YES)
	{
		label.text = [NSString stringWithFormat:@"A♯, Cx, E♯, Gx"];
		//@"A♯ Major 7:"
	}
	
	if ([messageFromPicker isEqualToString: testStringBbMajor7] == YES)
	{
		label.text = [NSString stringWithFormat:@"B♭, D, F, A"];
		//@"B♭ Major 7:"
	}
	
	if ([messageFromPicker isEqualToString: testStringBMajor7] == YES)
	{
		label.text = [NSString stringWithFormat:@"B, D♯, F♯, A♯"];
		//@"B Major 7:"
	}
	
	// *********** Minor7 ifs **********************
	
	if ([messageFromPicker isEqualToString: testStringCMinor7] == YES)
	{
		label.text = [NSString stringWithFormat:@"C, E♭, G, B♭"];
		//@"C Minor 7:"
	}
	
	if ([messageFromPicker isEqualToString: testStringCSharpMinor7] == YES)
	{
		label.text = [NSString stringWithFormat:@"C♯, E, G♯, B"];
		//@"C♯ Minor 7:"
	}
	
	if ([messageFromPicker isEqualToString: testStringDbMinor7] == YES)
	{
		label.text = [NSString stringWithFormat:@"D♭, F♭, A♭, C♭"];
		//@"D♭ Minor 7:"
	}
	
	if ([messageFromPicker isEqualToString: testStringDMinor7] == YES)
	{
		label.text = [NSString stringWithFormat:@"D, F, A, C"];
		//@"D Minor 7:"
	}
	
	if ([messageFromPicker isEqualToString: testStringDSharpMinor7] == YES)
	{
		label.text = [NSString stringWithFormat:@"D♯, F♯, A♯, C♯"];
		//@"D♯ Minor 7:"
	}
	
	if ([messageFromPicker isEqualToString: testStringEbMinor7] == YES)
	{
		label.text = [NSString stringWithFormat:@"E♭, G♭, B♭, D♭"];
		//@"E♭ Minor 7:"
	}
	
	if ([messageFromPicker isEqualToString: testStringEMinor7] == YES)
	{
		label.text = [NSString stringWithFormat:@"E, G, B, D"];
		//@"E Minor 7:"
	}
	
	if ([messageFromPicker isEqualToString: testStringFMinor7] == YES)
	{
		label.text = [NSString stringWithFormat:@"F, A♭, C, E♭"];
		//@"F Minor 7:"
	}
	
	if ([messageFromPicker isEqualToString: testStringFSharpMinor7] == YES)
	{
		label.text = [NSString stringWithFormat:@"F♯, A, C♯, E"];
		//@"F♯ Minor 7:"
	}
	
	if ([messageFromPicker isEqualToString: testStringGbMinor7] == YES)
	{
		label.text = [NSString stringWithFormat:@"G♭, B♭♭, D♭, F♭"];
		//@"G♭ Minor 7:"
	}
	
	if ([messageFromPicker isEqualToString: testStringGMinor7] == YES)
	{
		label.text = [NSString stringWithFormat:@"G, B♭, D, F"];
		//@"G Minor 7:"
	}
	
	if ([messageFromPicker isEqualToString: testStringGSharpMinor7] == YES)
	{
		label.text = [NSString stringWithFormat:@"G♯, B, D♯, F♯"];
		//@"G♯ Minor 7:"
	}
	
	if ([messageFromPicker isEqualToString: testStringAbMinor7] == YES)
	{
		label.text = [NSString stringWithFormat:@"A♭, C♭, E♭, G♭"];
		//@"A♭ Minor 7:"
	}
	
	if ([messageFromPicker isEqualToString: testStringAMinor7] == YES)
	{
		label.text = [NSString stringWithFormat:@"A, C, E, G"];
		//@"A Minor 7:"
	}
	
	if ([messageFromPicker isEqualToString: testStringASharpMinor7] == YES)
	{
		label.text = [NSString stringWithFormat:@"A♯, C♯, E♯, G♯"];
		//@"A♯ Minor 7:"
	}
	
	if ([messageFromPicker isEqualToString: testStringBbMinor7] == YES)
	{
		label.text = [NSString stringWithFormat:@"B♭, D♭, F, A♭"];
		//@"B♭ Minor 7:"
	}
	
	if ([messageFromPicker isEqualToString: testStringBMinor7] == YES)
	{
		label.text = [NSString stringWithFormat:@"B, D, F♯, A"];
		//@"B Minor 7:"
	}
	
	// *********** AUGMENTED 7 ifs **********************
	// M3,M3,m3
	if ([messageFromPicker isEqualToString: testStringCAugmented7] == YES)
	{
		label.text = [NSString stringWithFormat:@"C, E, G♯, B"];
		//@"C Augmented 7:"
	}
	
	if ([messageFromPicker isEqualToString: testStringCSharpAugmented7] == YES)
	{
		label.text = [NSString stringWithFormat:@"C♯, E♯, Gx, B♯"];
		//@"C♯ Augmented 7:"
	}
	
	if ([messageFromPicker isEqualToString: testStringDbAugmented7] == YES)
	{
		label.text = [NSString stringWithFormat:@"D♭, F, A, C"];
		//@"D♭ Augmented 7:"
	}
	
	if ([messageFromPicker isEqualToString: testStringDAugmented7] == YES)
	{
		label.text = [NSString stringWithFormat:@"D, F♯, A♯, C♯"];
		//@"D Augmented 7:"
	}
	
	if ([messageFromPicker isEqualToString: testStringDSharpAugmented7] == YES)
	{
		label.text = [NSString stringWithFormat:@"D♯, Fx, Ax, Cx"];
		//@"D♯ Augmented 7:"
	}
	
	if ([messageFromPicker isEqualToString: testStringEbAugmented7] == YES)
	{
		label.text = [NSString stringWithFormat:@"E♭, G, B, D"];
		//@"E♭ Augmented 7:"
	}
	
	if ([messageFromPicker isEqualToString: testStringEAugmented7] == YES)
	{
		label.text = [NSString stringWithFormat:@"E, G♯, B♯, D♯"];
		//@"E Augmented 7:"
	}
	
	if ([messageFromPicker isEqualToString: testStringFAugmented7] == YES)
	{
		label.text = [NSString stringWithFormat:@"F, A, C♯, E"];
		//@"F Augmented 7:"
	}
	
	if ([messageFromPicker isEqualToString: testStringFSharpAugmented7] == YES)
	{
		label.text = [NSString stringWithFormat:@"F♯, A♯, Cx, E♯"];
		//@"F♯ Augmented 7:"
	}
	
	if ([messageFromPicker isEqualToString: testStringGbAugmented7] == YES)
	{
		label.text = [NSString stringWithFormat:@"G♭, B♭, D, F"];
		//@"G♭ Augmented 7:"
	}
	
	if ([messageFromPicker isEqualToString: testStringGAugmented7] == YES)
	{
		label.text = [NSString stringWithFormat:@"G, B, D♯, F♯"];
		//@"G Augmented 7:"
	}
	
	if ([messageFromPicker isEqualToString: testStringGSharpAugmented7] == YES)
	{
		label.text = [NSString stringWithFormat:@"G♯, B♯, Dx, Fx"];
		//@"G♯ Augmented 7:"
	}
	
	if ([messageFromPicker isEqualToString: testStringAbAugmented7] == YES)
	{
		label.text = [NSString stringWithFormat:@"A♭, C, E, G"];
		//@"A♭ Augmented 7:"
	}
	
	if ([messageFromPicker isEqualToString: testStringAAugmented7] == YES)
	{
		label.text = [NSString stringWithFormat:@"A, C♯, E♯, G♯"];
		//@"A Augmented 7:"
	}
	
	if ([messageFromPicker isEqualToString: testStringASharpAugmented7] == YES)
	{
		label.text = [NSString stringWithFormat:@"A♯, Cx, Ex, Gx"];
		//@"A♯ Augmented 7:"
	}
	
	if ([messageFromPicker isEqualToString: testStringBbAugmented7] == YES)
	{
		label.text = [NSString stringWithFormat:@"B♭, D, F♯, A"];
		//@"B♭ Augmented 7:"
	}
	
	if ([messageFromPicker isEqualToString: testStringBAugmented7] == YES)
	{
		label.text = [NSString stringWithFormat:@"B, D♯, Fx, A♯"];
		//@"B Augmented 7:"
	}
	
	// *********** DIMINISHED 7 ifs **********************
	// m3, m3, M3
	if ([messageFromPicker isEqualToString: testStringCDiminished7] == YES)
	{
		label.text = [NSString stringWithFormat:@"C, E♭, G♭, B♭"];
		//@"C Diminished 7:"
	}
	
	if ([messageFromPicker isEqualToString: testStringCSharpDiminished7] == YES)
	{
		label.text = [NSString stringWithFormat:@"C♯, E, G, B"];
		//@"C♯ Diminished 7:"
	}
	
	if ([messageFromPicker isEqualToString: testStringDbDiminished7] == YES)
	{
		label.text = [NSString stringWithFormat:@"D♭, F♭, A♭♭, C♭"];
		//@"D♭ Diminished 7:"
	}
	
	if ([messageFromPicker isEqualToString: testStringDDiminished7] == YES)
	{
		label.text = [NSString stringWithFormat:@"D, F, A♭, C"];
		//@"D Diminished 7:"
	}
	
	if ([messageFromPicker isEqualToString: testStringDSharpDiminished7] == YES)
	{
		label.text = [NSString stringWithFormat:@"D♯, F♯, A, C♯"];
		//@"D♯ Diminished 7:"
	}
	
	if ([messageFromPicker isEqualToString: testStringEbDiminished7] == YES)
	{
		label.text = [NSString stringWithFormat:@"E♭, G♭, B♭♭, D♭"];
		//@"E♭ Diminished 7:"
	}
	
	if ([messageFromPicker isEqualToString: testStringEDiminished7] == YES)
	{
		label.text = [NSString stringWithFormat:@"E, G, B♭, D"];
		//@"E Diminished 7:"
	}
	
	if ([messageFromPicker isEqualToString: testStringFDiminished7] == YES)
	{
		label.text = [NSString stringWithFormat:@"F, A♭, C♭, E♭"];
		//@"F Diminished 7:"
	}
	
	if ([messageFromPicker isEqualToString: testStringFSharpDiminished7] == YES)
	{
		label.text = [NSString stringWithFormat:@"F♯, A, C, E"];
		//@"F♯ Diminished 7:"
	}
	
	if ([messageFromPicker isEqualToString: testStringGbDiminished7] == YES)
	{
		label.text = [NSString stringWithFormat:@"G♭, B♭♭, D♭♭, F♭"];
		//@"G♭ Diminished 7:"
	}
	
	if ([messageFromPicker isEqualToString: testStringGDiminished7] == YES)
	{
		label.text = [NSString stringWithFormat:@"G, B♭, D♭, F"];
		//@"G Diminished 7:"
	}
	
	if ([messageFromPicker isEqualToString: testStringGSharpDiminished7] == YES)
	{
		label.text = [NSString stringWithFormat:@"G♯, B, D, F♯"];
		//@"G♯ Diminished 7:"
	}
	
	if ([messageFromPicker isEqualToString: testStringAbDiminished7] == YES)
	{
		label.text = [NSString stringWithFormat:@"A♭, C♭, E♭♭, G♭"];
		//@"A♭ Diminished 7:"
	}
	
	if ([messageFromPicker isEqualToString: testStringADiminished7] == YES)
	{
		label.text = [NSString stringWithFormat:@"A, C, E♭, G"];
		//@"A Diminished 7:"
	}
	
	if ([messageFromPicker isEqualToString: testStringASharpDiminished7] == YES)
	{
		label.text = [NSString stringWithFormat:@"A♯, C♯, E, G♯"];
		//@"A♯ Diminished 7:"
	}
	
	if ([messageFromPicker isEqualToString: testStringBbDiminished7] == YES)
	{
		label.text = [NSString stringWithFormat:@"B♭, D♭, F♭, A♭"];
		//@"B♭ Diminished 7:"
	}
	
	if ([messageFromPicker isEqualToString: testStringBDiminished7] == YES)
	{
		label.text = [NSString stringWithFormat:@"B, D, F, A"];
		//@"B Diminished 7:"
	}
	
	// *********** Dominant7 ifs **********************
	
	if ([messageFromPicker isEqualToString: testStringCDominant7] == YES)
	{
		// ********************%%%%%%%%%%%^^^^^^^^^^^^^^^$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$	
		//label.adjustsFontSizeToFitWidth = YES;
		//label.numberOfLines = 10;
		//label.sizeToFit;
		//label.minimumFontSize = 9.0f;
		label.text = [NSString stringWithFormat:@"C, E, G, B♭"];
		//@"C Dominant 7:"
	}
	
	if ([messageFromPicker isEqualToString: testStringCSharpDominant7] == YES)
	{
		label.text = [NSString stringWithFormat:@"C♯, E♯, G♯, B"];
		//@"C♯ Dominant 7:"
	}
	
	if ([messageFromPicker isEqualToString: testStringDbDominant7] == YES)
	{
		label.text = [NSString stringWithFormat:@"D♭, F, A♭, C♭"];
		//@"D♭ Dominant 7:"
	}
	
	if ([messageFromPicker isEqualToString: testStringDDominant7] == YES)
	{
		label.text = [NSString stringWithFormat:@"D, F♯, A, C"];
		//@"D Dominant 7:"
	}
	
	if ([messageFromPicker isEqualToString: testStringDSharpDominant7] == YES)
	{
		label.text = [NSString stringWithFormat:@"D♯, Fx, A♯, C♯"];
		//@"D♯ Dominant 7:"
	}
	
	if ([messageFromPicker isEqualToString: testStringEbDominant7] == YES)
	{
		label.text = [NSString stringWithFormat:@"E♭, G, B♭, D♭"];
		//@"E♭ Dominant 7:"
	}
	
	if ([messageFromPicker isEqualToString: testStringEDominant7] == YES)
	{
		label.text = [NSString stringWithFormat:@"E, G♯, B, D"];
		//@"E Dominant 7:"
	}
	
	if ([messageFromPicker isEqualToString: testStringFDominant7] == YES)
	{
		label.text = [NSString stringWithFormat:@"F, A, C, E♭"];
		//@"F Dominant 7:"
	}
	
	if ([messageFromPicker isEqualToString: testStringFSharpDominant7] == YES)
	{
		label.text = [NSString stringWithFormat:@"F♯, A♯, C♯, E"];
		//@"F♯ Dominant 7:"
	}
	
	if ([messageFromPicker isEqualToString: testStringGbDominant7] == YES)
	{
		label.text = [NSString stringWithFormat:@"G♭, B♭, D♭, F♭"];
		//@"G♭ Dominant 7:"
	}
	
	if ([messageFromPicker isEqualToString: testStringGDominant7] == YES)
	{
		label.text = [NSString stringWithFormat:@"G, B, D, F"];
		//@"G Dominant 7:"
	}
	
	if ([messageFromPicker isEqualToString: testStringGSharpDominant7] == YES)
	{
		label.text = [NSString stringWithFormat:@"G♯, B♯, D♯, F♯"];
		//@"G♯ Dominant 7:"
	}
	
	if ([messageFromPicker isEqualToString: testStringAbDominant7] == YES)
	{
		label.text = [NSString stringWithFormat:@"A♭, C, E♭, G♭"];
		//@"A♭ Dominant 7:"
	}
	
	if ([messageFromPicker isEqualToString: testStringADominant7] == YES)
	{
		label.text = [NSString stringWithFormat:@"A, C♯, E, G"];
		//@"A Dominant 7:"
	}
	
	if ([messageFromPicker isEqualToString: testStringASharpDominant7] == YES)
	{
		label.text = [NSString stringWithFormat:@"A♯, Cx, E♯, G♯"];
		//@"A♯ Dominant 7:"
	}
	
	if ([messageFromPicker isEqualToString: testStringBbDominant7] == YES)
	{
		label.text = [NSString stringWithFormat:@"B♭, D, F, A♭"];
		//@"B♭ Dominant 7:"
	}
	
	if ([messageFromPicker isEqualToString: testStringBDominant7] == YES)
	{
		label.text = [NSString stringWithFormat:@"B, D♯, F♯, A"];
		//@"B Dominant 7:"
	}	
	
	// *********** Half-Diminished 7 ifs **********************
	// m3, m3, M3
	if ([messageFromPicker isEqualToString: testStringCHalfDiminished7] == YES)
	{
		label.text = [NSString stringWithFormat:@"C, E♭, G♭, B"];
		//@"C Half-Diminished 7:"
	}
	
	if ([messageFromPicker isEqualToString: testStringCSharpHalfDiminished7] == YES)
	{
		label.text = [NSString stringWithFormat:@"C♯, E, G, B♯"];
		//@"C♯ Half-Diminished 7:"
	}
	
	if ([messageFromPicker isEqualToString: testStringDbHalfDiminished7] == YES)
	{
		label.text = [NSString stringWithFormat:@"D♭, F♭, A♭♭, C"];
		//@"D♭ Half-Diminished 7:"
	}
	
	if ([messageFromPicker isEqualToString: testStringDHalfDiminished7] == YES)
	{
		label.text = [NSString stringWithFormat:@"D, F, A♭, C♯"];
		//@"D Half-Diminished 7:"
	}
	
	if ([messageFromPicker isEqualToString: testStringDSharpHalfDiminished7] == YES)
	{
		label.text = [NSString stringWithFormat:@"D♯, F♯, A, Cx"];
		//@"D♯ Half-Diminished 7:"
	}
	
	if ([messageFromPicker isEqualToString: testStringEbHalfDiminished7] == YES)
	{
		label.text = [NSString stringWithFormat:@"E♭, G♭, B♭♭, D"];
		//@"E♭ Half-Diminished 7:"
	}
	
	if ([messageFromPicker isEqualToString: testStringEHalfDiminished7] == YES)
	{
		label.text = [NSString stringWithFormat:@"E, G, B♭, D♯"];
		//@"E Half-Diminished 7:"
	}
	
	if ([messageFromPicker isEqualToString: testStringFHalfDiminished7] == YES)
	{
		label.text = [NSString stringWithFormat:@"F, A♭, C♭, E"];
		//@"F Half-Diminished 7:"
	}
	
	if ([messageFromPicker isEqualToString: testStringFSharpHalfDiminished7] == YES)
	{
		label.text = [NSString stringWithFormat:@"F♯, A, C, E♯"];
		//@"F♯ Half-Diminished 7:"
	}
	
	if ([messageFromPicker isEqualToString: testStringGbHalfDiminished7] == YES)
	{
		label.text = [NSString stringWithFormat:@"G♭, B♭♭, D♭♭, F"];
		//@"G♭ Half-Diminished 7:"
	}
	
	if ([messageFromPicker isEqualToString: testStringGHalfDiminished7] == YES)
	{
		label.text = [NSString stringWithFormat:@"G, B♭, D♭, F♯"];
		//@"G Half-Diminished 7:"
	}
	
	if ([messageFromPicker isEqualToString: testStringGSharpHalfDiminished7] == YES)
	{
		label.text = [NSString stringWithFormat:@"G♯, B, D, Fx"];
		//@"G♯ Half-Diminished 7:"
	}
	
	if ([messageFromPicker isEqualToString: testStringAbHalfDiminished7] == YES)
	{
		label.text = [NSString stringWithFormat:@"A♭, C♭, E♭♭, G"];
		//@"A♭ Half-Diminished 7:"
	}
	
	if ([messageFromPicker isEqualToString: testStringAHalfDiminished7] == YES)
	{
		label.text = [NSString stringWithFormat:@"A, C, E♭, G♯"];
		//@"A Half-Diminished 7:"
	}
	
	if ([messageFromPicker isEqualToString: testStringASharpHalfDiminished7] == YES)
	{
		label.text = [NSString stringWithFormat:@"A♯, C♯, E, Gx"];
		//@"A♯ Half-Diminished 7:"
	}
	
	if ([messageFromPicker isEqualToString: testStringBbHalfDiminished7] == YES)
	{
		label.text = [NSString stringWithFormat:@"B♭, D♭, F♭, A"];
		//@"B♭ Half-Diminished 7:"
	}
	
	if ([messageFromPicker isEqualToString: testStringBHalfDiminished7] == YES)
	{
		label.text = [NSString stringWithFormat:@"B, D, F, A♯"];
		//@"B Half-Diminished 7:"
	}
	
	// *********** Major6_5 ifs **********************
	
	if ([messageFromPicker isEqualToString: testStringCMajor6_5] == YES)
	{
		label.text = [NSString stringWithFormat:@"E, G, B, C"];
		//@"C Major 6-5:"
	}
	
	if ([messageFromPicker isEqualToString: testStringCSharpMajor6_5] == YES)
	{
		label.text = [NSString stringWithFormat:@"E♯, G♯, B♯, C♯"];
		//@"C♯ Major 6-5:"
	}
	
	if ([messageFromPicker isEqualToString: testStringDbMajor6_5] == YES)
	{
		label.text = [NSString stringWithFormat:@"F, A♭, C, D♭"];
		//@"D♭ Major 6-5:"
	}
	
	if ([messageFromPicker isEqualToString: testStringDMajor6_5] == YES)
	{
		label.text = [NSString stringWithFormat:@"F♯, A, C♯, D"];
		//@"D Major 6-5:"
	}
	
	if ([messageFromPicker isEqualToString: testStringDSharpMajor6_5] == YES)
	{
		label.text = [NSString stringWithFormat:@"Fx, A♯, Cx, D♯"];
		//@"D♯ Major 6-5:"
	}
	
	if ([messageFromPicker isEqualToString: testStringEbMajor6_5] == YES)
	{
		label.text = [NSString stringWithFormat:@"G, B♭, D, E♭"];
		//@"E♭ Major 6-5:"
	}
	
	if ([messageFromPicker isEqualToString: testStringEMajor6_5] == YES)
	{
		label.text = [NSString stringWithFormat:@"G♯, B, D♯, E"];
		//@"E Major 6-5:"
	}
	
	if ([messageFromPicker isEqualToString: testStringFMajor6_5] == YES)
	{
		label.text = [NSString stringWithFormat:@"A, C, E, F"];
		//@"F Major 6-5:"
	}
	
	if ([messageFromPicker isEqualToString: testStringFSharpMajor6_5] == YES)
	{
		label.text = [NSString stringWithFormat:@"A♯, C♯, E♯, F♯"];
		//@"F♯ Major 6-5:"
	}
	
	if ([messageFromPicker isEqualToString: testStringGbMajor6_5] == YES)
	{
		label.text = [NSString stringWithFormat:@"B♭, D♭, F, G♭"];
		//@"G♭ Major 6-5:"
	}
	
	if ([messageFromPicker isEqualToString: testStringGMajor6_5] == YES)
	{
		label.text = [NSString stringWithFormat:@"B, D, F♯, G"];
		//@"G Major 6-5:"
	}
	
	if ([messageFromPicker isEqualToString: testStringGSharpMajor6_5] == YES)
	{
		label.text = [NSString stringWithFormat:@"B♯, D♯, Fx, G♯"];
		//@"G♯ Major 6-5:"
	}
	
	if ([messageFromPicker isEqualToString: testStringAbMajor6_5] == YES)
	{
		label.text = [NSString stringWithFormat:@"C, E♭, G, A♭"];
		//@"A♭ Major 6-5:"
	}
	
	if ([messageFromPicker isEqualToString: testStringAMajor6_5] == YES)
	{
		label.text = [NSString stringWithFormat:@"C♯, E, G♯, A"];
		//@"A Major 6-5:"
	}
	
	if ([messageFromPicker isEqualToString: testStringASharpMajor6_5] == YES)
	{
		label.text = [NSString stringWithFormat:@"Cx, E♯, Gx, A♯"];
		//@"A♯ Major 6-5:"
	}
	
	if ([messageFromPicker isEqualToString: testStringBbMajor6_5] == YES)
	{
		label.text = [NSString stringWithFormat:@"D, F, A, B♭"];
		//@"B♭ Major 6-5:"
	}
	
	if ([messageFromPicker isEqualToString: testStringBMajor6_5] == YES)
	{
		label.text = [NSString stringWithFormat:@"D♯, F♯, A♯, B"];
		//@"B Major 6-5:"
	}
	
	// *********** Minor6_5 ifs **********************
	
	if ([messageFromPicker isEqualToString: testStringCMinor6_5] == YES)
	{
		label.text = [NSString stringWithFormat:@"E♭, G, B♭, C"];
		//@"C Minor 6-5:"
	}
	
	if ([messageFromPicker isEqualToString: testStringCSharpMinor6_5] == YES)
	{
		label.text = [NSString stringWithFormat:@"E, G♯, B, C♯"];
		//@"C♯ Minor 6-5:"
	}
	
	if ([messageFromPicker isEqualToString: testStringDbMinor6_5] == YES)
	{
		label.text = [NSString stringWithFormat:@"F♭, A♭, C♭, D♭"];
		//@"D♭ Minor 6-5:"
	}
	
	if ([messageFromPicker isEqualToString: testStringDMinor6_5] == YES)
	{
		label.text = [NSString stringWithFormat:@"F, A, C, D"];
		//@"D Minor 6-5:"
	}
	
	if ([messageFromPicker isEqualToString: testStringDSharpMinor6_5] == YES)
	{
		label.text = [NSString stringWithFormat:@"F♯, A♯, C♯, D♯"];
		//@"D♯ Minor 6-5:"
	}
	
	if ([messageFromPicker isEqualToString: testStringEbMinor6_5] == YES)
	{
		label.text = [NSString stringWithFormat:@"G♭, B♭, D♭, E♭"];
		//@"E♭ Minor 6-5:"
	}
	
	if ([messageFromPicker isEqualToString: testStringEMinor6_5] == YES)
	{
		label.text = [NSString stringWithFormat:@"G, B, D, E"];
		//@"E Minor 6-5:"
	}
	
	if ([messageFromPicker isEqualToString: testStringFMinor6_5] == YES)
	{
		label.text = [NSString stringWithFormat:@"A♭, C, E♭, F"];
		//@"F Minor 6-5:"
	}
	
	if ([messageFromPicker isEqualToString: testStringFSharpMinor6_5] == YES)
	{
		label.text = [NSString stringWithFormat:@"A, C♯, E, F♯"];
		//@"F♯ Minor 6-5:"
	}
	
	if ([messageFromPicker isEqualToString: testStringGbMinor6_5] == YES)
	{
		label.text = [NSString stringWithFormat:@"B♭♭, D♭, F♭, G♭"];
		//@"G♭ Minor 6-5:"
	}
	
	if ([messageFromPicker isEqualToString: testStringGMinor6_5] == YES)
	{
		label.text = [NSString stringWithFormat:@"B♭, D, F, G"];
		//@"G Minor 6-5:"
	}
	
	if ([messageFromPicker isEqualToString: testStringGSharpMinor6_5] == YES)
	{
		label.text = [NSString stringWithFormat:@"B, D♯, F♯, G♯"];
		//@"G♯ Minor 6-5:"
	}
	
	if ([messageFromPicker isEqualToString: testStringAbMinor6_5] == YES)
	{
		label.text = [NSString stringWithFormat:@"C♭, E♭, G♭, A♭"];
		//@"A♭ Minor 6-5:"
	}
	
	if ([messageFromPicker isEqualToString: testStringAMinor6_5] == YES)
	{
		label.text = [NSString stringWithFormat:@"C, E, G, A"];
		//@"A Minor 6-5:"
	}
	
	if ([messageFromPicker isEqualToString: testStringASharpMinor6_5] == YES)
	{
		label.text = [NSString stringWithFormat:@"C♯, E♯, G♯, A♯"];
		//@"A♯ Minor 6-5:"
	}
	
	if ([messageFromPicker isEqualToString: testStringBbMinor6_5] == YES)
	{
		label.text = [NSString stringWithFormat:@"D♭, F, A♭, B♭"];
		//@"B♭ Minor 6-5:"
	}
	
	if ([messageFromPicker isEqualToString: testStringBMinor6_5] == YES)
	{
		label.text = [NSString stringWithFormat:@"D, F♯, A, B"];
		//@"B Minor 6-5:"
	}
	
	// *********** Dominant4_3 ifs **********************
	
	if ([messageFromPicker isEqualToString: testStringCDominant4_3] == YES)
	{
		// ********************%%%%%%%%%%%^^^^^^^^^^^^^^^$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$	
		//label.adjustsFontSizeToFitWidth = YES;
		//label.numberOfLines = 10;
		//label.sizeToFit;
		//label.minimumFontSize = 9.0f;
		label.text = [NSString stringWithFormat:@"G, B♭, C, E"];
		//@"C Dominant 4-3:"
	}
	
	if ([messageFromPicker isEqualToString: testStringCSharpDominant4_3] == YES)
	{
		label.text = [NSString stringWithFormat:@"G♯, B, C♯, E♯"];
		//@"C♯ Dominant 4-3:"
	}
	
	if ([messageFromPicker isEqualToString: testStringDbDominant4_3] == YES)
	{
		label.text = [NSString stringWithFormat:@"A♭, C♭, D♭, F"];
		//@"D♭ Dominant 4-3:"
	}
	
	if ([messageFromPicker isEqualToString: testStringDDominant4_3] == YES)
	{
		label.text = [NSString stringWithFormat:@"A, C, D, F♯"];
		//@"D Dominant 4-3:"
	}
	
	if ([messageFromPicker isEqualToString: testStringDSharpDominant4_3] == YES)
	{
		label.text = [NSString stringWithFormat:@"A♯, C♯, D♯, Fx"];
		//@"D♯ Dominant 4-3:"
	}
	
	if ([messageFromPicker isEqualToString: testStringEbDominant4_3] == YES)
	{
		label.text = [NSString stringWithFormat:@"B♭, D♭, E♭, G"];
		//@"E♭ Dominant 4-3:"
	}
	
	if ([messageFromPicker isEqualToString: testStringEDominant4_3] == YES)
	{
		label.text = [NSString stringWithFormat:@"B, D, E, G♯"];
		//@"E Dominant 4-3:"
	}
	
	if ([messageFromPicker isEqualToString: testStringFDominant4_3] == YES)
	{
		label.text = [NSString stringWithFormat:@"C, E♭, F, A"];
		//@"F Dominant 4-3:"
	}
	
	if ([messageFromPicker isEqualToString: testStringFSharpDominant4_3] == YES)
	{
		label.text = [NSString stringWithFormat:@"C♯, E, F♯, A♯"];
		//@"F♯ Dominant 4-3:"
	}
	
	if ([messageFromPicker isEqualToString: testStringGbDominant4_3] == YES)
	{
		label.text = [NSString stringWithFormat:@"D♭, F♭, G♭, B♭"];
		//@"G♭ Dominant 4-3:"
	}
	
	if ([messageFromPicker isEqualToString: testStringGDominant4_3] == YES)
	{
		label.text = [NSString stringWithFormat:@"D, F, G, B"];
		//@"G Dominant 4-3:"
	}
	
	if ([messageFromPicker isEqualToString: testStringGSharpDominant4_3] == YES)
	{
		label.text = [NSString stringWithFormat:@"D♯, F♯, G♯, B♯"];
		//@"G♯ Dominant 4-3:"
	}
	
	if ([messageFromPicker isEqualToString: testStringAbDominant4_3] == YES)
	{
		label.text = [NSString stringWithFormat:@"E♭, G♭, A♭, C"];
		//@"A♭ Dominant 4-3:"
	}
	
	if ([messageFromPicker isEqualToString: testStringADominant4_3] == YES)
	{
		label.text = [NSString stringWithFormat:@"E, G, A, C♯"];
		//@"A Dominant 4-3:"
	}
	
	if ([messageFromPicker isEqualToString: testStringASharpDominant4_3] == YES)
	{
		label.text = [NSString stringWithFormat:@"E♯, G♯, A♯, Cx"];
		//@"A♯ Dominant 4-3:"
	}
	
	if ([messageFromPicker isEqualToString: testStringBbDominant4_3] == YES)
	{
		label.text = [NSString stringWithFormat:@"F, A♭, B♭, D"];
		//@"B♭ Dominant 4-3:"
	}
	
	if ([messageFromPicker isEqualToString: testStringBDominant4_3] == YES)
	{
		label.text = [NSString stringWithFormat:@"F♯, A, B, D♯"];
		//@"B Dominant 4-3:"
	}	
	
	// *********** AUGMENTED 6-5 ifs **********************
	// M3,M3,m3
	if ([messageFromPicker isEqualToString: testStringCAugmented6_5] == YES)
	{
		label.text = [NSString stringWithFormat:@"E, G♯, B, C"];
		//@"C Augmented 6-5:"
	}
	
	if ([messageFromPicker isEqualToString: testStringCSharpAugmented6_5] == YES)
	{
		label.text = [NSString stringWithFormat:@"E♯, Gx, B♯, C♯"];
		//@"C♯ Augmented 6-5:"
	}
	
	if ([messageFromPicker isEqualToString: testStringDbAugmented6_5] == YES)
	{
		label.text = [NSString stringWithFormat:@"F, A, C, D♭"];
		//@"D♭ Augmented 6-5:"
	}
	
	if ([messageFromPicker isEqualToString: testStringDAugmented6_5] == YES)
	{
		label.text = [NSString stringWithFormat:@"F♯, A♯, C♯, D"];
		//@"D Augmented 6-5:"
	}
	
	if ([messageFromPicker isEqualToString: testStringDSharpAugmented6_5] == YES)
	{
		label.text = [NSString stringWithFormat:@"Fx, Ax, Cx, D♯"];
		//@"D♯ Augmented 6-5:"
	}
	
	if ([messageFromPicker isEqualToString: testStringEbAugmented6_5] == YES)
	{
		label.text = [NSString stringWithFormat:@"G, B, D, E♭"];
		//@"E♭ Augmented 6-5:"
	}
	
	if ([messageFromPicker isEqualToString: testStringEAugmented6_5] == YES)
	{
		label.text = [NSString stringWithFormat:@"G♯, B♯, D♯, E"];
		//@"E Augmented 6-5:"
	}
	
	if ([messageFromPicker isEqualToString: testStringFAugmented6_5] == YES)
	{
		label.text = [NSString stringWithFormat:@"A, C♯, E, F"];
		//@"F Augmented 6-5:"
	}
	
	if ([messageFromPicker isEqualToString: testStringFSharpAugmented6_5] == YES)
	{
		label.text = [NSString stringWithFormat:@"A♯, Cx, E♯, F♯"];
		//@"F♯ Augmented 6-5:"
	}
	
	if ([messageFromPicker isEqualToString: testStringGbAugmented6_5] == YES)
	{
		label.text = [NSString stringWithFormat:@"B♭, D, F, G♭"];
		//@"G♭ Augmented 6-5:"
	}
	
	if ([messageFromPicker isEqualToString: testStringGAugmented6_5] == YES)
	{
		label.text = [NSString stringWithFormat:@"B, D♯, F♯, G"];
		//@"G Augmented 6-5:"
	}
	
	if ([messageFromPicker isEqualToString: testStringGSharpAugmented6_5] == YES)
	{
		label.text = [NSString stringWithFormat:@"B♯, Dx, Fx, G♯"];
		//@"G♯ Augmented 6-5:"
	}
	
	if ([messageFromPicker isEqualToString: testStringAbAugmented6_5] == YES)
	{
		label.text = [NSString stringWithFormat:@"C, E, G, A♭"];
		//@"A♭ Augmented 6-5:"
	}
	
	if ([messageFromPicker isEqualToString: testStringAAugmented6_5] == YES)
	{
		label.text = [NSString stringWithFormat:@"C♯, E♯, G♯, A"];
		//@"A Augmented 6-5:"
	}
	
	if ([messageFromPicker isEqualToString: testStringASharpAugmented6_5] == YES)
	{
		label.text = [NSString stringWithFormat:@"Cx, Ex, Gx, A♯"];
		//@"A♯ Augmented 6-5:"
	}
	
	if ([messageFromPicker isEqualToString: testStringBbAugmented6_5] == YES)
	{
		label.text = [NSString stringWithFormat:@"D, F♯, A, B♭"];
		//@"B♭ Augmented 6-5:"
	}
	
	if ([messageFromPicker isEqualToString: testStringBAugmented6_5] == YES)
	{
		label.text = [NSString stringWithFormat:@"D♯, Fx, A♯, B"];
		//@"B Augmented 6-5:"
	}
	
	// *********** Dominant6_5 ifs **********************
	
	if ([messageFromPicker isEqualToString: testStringCDominant6_5] == YES)
	{
		// ********************%%%%%%%%%%%^^^^^^^^^^^^^^^$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$	
		//label.adjustsFontSizeToFitWidth = YES;
		//label.numberOfLines = 10;
		//label.sizeToFit;
		//label.minimumFontSize = 9.0f;
		label.text = [NSString stringWithFormat:@"E, G, B♭, C"];
		//@"C Dominant 6-5:"
	}
	
	if ([messageFromPicker isEqualToString: testStringCSharpDominant6_5] == YES)
	{
		label.text = [NSString stringWithFormat:@"E♯, G♯, B, C♯"];
		//@"C♯ Dominant 6-5:"
	}
	
	if ([messageFromPicker isEqualToString: testStringDbDominant6_5] == YES)
	{
		label.text = [NSString stringWithFormat:@"F, A♭, C♭, D♭"];
		//@"D♭ Dominant 6-5:"
	}
	
	if ([messageFromPicker isEqualToString: testStringDDominant6_5] == YES)
	{
		label.text = [NSString stringWithFormat:@"F♯, A, C, D"];
		//@"D Dominant 6-5:"
	}
	
	if ([messageFromPicker isEqualToString: testStringDSharpDominant6_5] == YES)
	{
		label.text = [NSString stringWithFormat:@"Fx, A♯, C♯, D♯"];
		//@"D♯ Dominant 6-5:"
	}
	
	if ([messageFromPicker isEqualToString: testStringEbDominant6_5] == YES)
	{
		label.text = [NSString stringWithFormat:@"G, B♭, D♭, E♭"];
		//@"E♭ Dominant 6-5:"
	}
	
	if ([messageFromPicker isEqualToString: testStringEDominant6_5] == YES)
	{
		label.text = [NSString stringWithFormat:@"G♯, B, D, E"];
		//@"E Dominant 6-5:"
	}
	
	if ([messageFromPicker isEqualToString: testStringFDominant6_5] == YES)
	{
		label.text = [NSString stringWithFormat:@"A, C, E♭, F"];
		//@"F Dominant 6-5:"
	}
	
	if ([messageFromPicker isEqualToString: testStringFSharpDominant6_5] == YES)
	{
		label.text = [NSString stringWithFormat:@"A♯, C♯, E, F♯"];
		//@"F♯ Dominant 6-5:"
	}
	
	if ([messageFromPicker isEqualToString: testStringGbDominant6_5] == YES)
	{
		label.text = [NSString stringWithFormat:@"B♭, D♭, F♭, G♭"];
		//@"G♭ Dominant 6-5:"
	}
	
	if ([messageFromPicker isEqualToString: testStringGDominant6_5] == YES)
	{
		label.text = [NSString stringWithFormat:@"B, D, F, G"];
		//@"G Dominant 6-5:"
	}
	
	if ([messageFromPicker isEqualToString: testStringGSharpDominant6_5] == YES)
	{
		label.text = [NSString stringWithFormat:@"B♯, D♯, F♯, G♯"];
		//@"G♯ Dominant 6-5:"
	}
	
	if ([messageFromPicker isEqualToString: testStringAbDominant6_5] == YES)
	{
		label.text = [NSString stringWithFormat:@"C, E♭, G♭, A♭"];
		//@"A♭ Dominant 6-5:"
	}
	
	if ([messageFromPicker isEqualToString: testStringADominant6_5] == YES)
	{
		label.text = [NSString stringWithFormat:@"C♯, E, G, A"];
		//@"A Dominant 6-5:"
	}
	
	if ([messageFromPicker isEqualToString: testStringASharpDominant6_5] == YES)
	{
		label.text = [NSString stringWithFormat:@"Cx, E♯, G♯, A♯"];
		//@"A♯ Dominant 6-5:"
	}
	
	if ([messageFromPicker isEqualToString: testStringBbDominant6_5] == YES)
	{
		label.text = [NSString stringWithFormat:@"D, F, A♭, B♭"];
		//@"B♭ Dominant 6-5:"
	}
	
	if ([messageFromPicker isEqualToString: testStringBDominant6_5] == YES)
	{
		label.text = [NSString stringWithFormat:@"D♯, F♯, A, B"];
		//@"B Dominant 6-5:"
	}	
	
	// *********** DIMINISHED 6_5 ifs **********************
	// m3, m3, M3
	if ([messageFromPicker isEqualToString: testStringCDiminished6_5] == YES)
	{
		label.text = [NSString stringWithFormat:@"E♭, G♭, B♭, C"];
		//@"C Diminished 6-5:"
	}
	
	if ([messageFromPicker isEqualToString: testStringCSharpDiminished6_5] == YES)
	{
		label.text = [NSString stringWithFormat:@"E, G, B, C♯"];
		//@"C♯ Diminished 6-5:"
	}
	
	if ([messageFromPicker isEqualToString: testStringDbDiminished6_5] == YES)
	{
		label.text = [NSString stringWithFormat:@"F♭, A♭♭, C♭, D♭"];
		//@"D♭ Diminished 6-5:"
	}
	
	if ([messageFromPicker isEqualToString: testStringDDiminished6_5] == YES)
	{
		label.text = [NSString stringWithFormat:@"F, A♭, C, D"];
		//@"D Diminished 6-5:"
	}
	
	if ([messageFromPicker isEqualToString: testStringDSharpDiminished6_5] == YES)
	{
		label.text = [NSString stringWithFormat:@"F♯, A, C♯, D♯"];
		//@"D♯ Diminished 6-5:"
	}
	
	if ([messageFromPicker isEqualToString: testStringEbDiminished6_5] == YES)
	{
		label.text = [NSString stringWithFormat:@"G♭, B♭♭, D♭, E♭"];
		//@"E♭ Diminished 6-5:"
	}
	
	if ([messageFromPicker isEqualToString: testStringEDiminished6_5] == YES)
	{
		label.text = [NSString stringWithFormat:@"G, B♭, D, E"];
		//@"E Diminished 6-5:"
	}
	
	if ([messageFromPicker isEqualToString: testStringFDiminished6_5] == YES)
	{
		label.text = [NSString stringWithFormat:@"A♭, C♭, E♭, F"];
		//@"F Diminished 6-5:"
	}
	
	if ([messageFromPicker isEqualToString: testStringFSharpDiminished6_5] == YES)
	{
		label.text = [NSString stringWithFormat:@"A, C, E, F♯"];
		//@"F♯ Diminished 6-5:"
	}
	
	if ([messageFromPicker isEqualToString: testStringGbDiminished6_5] == YES)
	{
		label.text = [NSString stringWithFormat:@"B♭♭, D♭♭, F♭, G♭"];
		//@"G♭ Diminished 6-5:"
	}
	
	if ([messageFromPicker isEqualToString: testStringGDiminished6_5] == YES)
	{
		label.text = [NSString stringWithFormat:@"B♭, D♭, F, G"];
		//@"G Diminished 6-5:"
	}
	
	if ([messageFromPicker isEqualToString: testStringGSharpDiminished6_5] == YES)
	{
		label.text = [NSString stringWithFormat:@"B, D, F♯, G♯"];
		//@"G♯ Diminished 6-5:"
	}
	
	if ([messageFromPicker isEqualToString: testStringAbDiminished6_5] == YES)
	{
		label.text = [NSString stringWithFormat:@"C♭, E♭♭, G♭, A♭"];
		//@"A♭ Diminished 6-5:"
	}
	
	if ([messageFromPicker isEqualToString: testStringADiminished6_5] == YES)
	{
		label.text = [NSString stringWithFormat:@"C, E♭, G, A"];
		//@"A Diminished 6-5:"
	}
	
	if ([messageFromPicker isEqualToString: testStringASharpDiminished6_5] == YES)
	{
		label.text = [NSString stringWithFormat:@"C♯, E, G♯, A♯"];
		//@"A♯ Diminished 6-5:"
	}
	
	if ([messageFromPicker isEqualToString: testStringBbDiminished6_5] == YES)
	{
		label.text = [NSString stringWithFormat:@"D♭, F♭, A♭, B♭"];
		//@"B♭ Diminished 6-5:"
	}
	
	if ([messageFromPicker isEqualToString: testStringBDiminished6_5] == YES)
	{
		label.text = [NSString stringWithFormat:@"D, F, A, B"];
		//@"B Diminished 6-5:"
	}
	
	// *********** Half-Diminished 6_5 ifs **********************
	// m3, m3, M3
	if ([messageFromPicker isEqualToString: testStringCHalfDiminished6_5] == YES)
	{
		label.text = [NSString stringWithFormat:@"E♭, G♭, B, C"];
		//@"C Half-Diminished 6-5:"
	}
	
	if ([messageFromPicker isEqualToString: testStringCSharpHalfDiminished6_5] == YES)
	{
		label.text = [NSString stringWithFormat:@"E, G, B♯, C♯"];
		//@"C♯ Half-Diminished 6-5:"
	}
	
	if ([messageFromPicker isEqualToString: testStringDbHalfDiminished6_5] == YES)
	{
		label.text = [NSString stringWithFormat:@"F♭, A♭♭, C, D♭"];
		//@"D♭ Half-Diminished 6-5:"
	}
	
	if ([messageFromPicker isEqualToString: testStringDHalfDiminished6_5] == YES)
	{
		label.text = [NSString stringWithFormat:@"F, A♭, C♯, D"];
		//@"D Half-Diminished 6-5:"
	}
	
	if ([messageFromPicker isEqualToString: testStringDSharpHalfDiminished6_5] == YES)
	{
		label.text = [NSString stringWithFormat:@"F♯, A, Cx, D♯"];
		//@"D♯ Half-Diminished 6-5:"
	}
	
	if ([messageFromPicker isEqualToString: testStringEbHalfDiminished6_5] == YES)
	{
		label.text = [NSString stringWithFormat:@"G♭, B♭♭, D, E♭"];
		//@"E♭ Half-Diminished 6-5:"
	}
	
	if ([messageFromPicker isEqualToString: testStringEHalfDiminished6_5] == YES)
	{
		label.text = [NSString stringWithFormat:@"G, B♭, D♯, E"];
		//@"E Half-Diminished 6-5:"
	}
	
	if ([messageFromPicker isEqualToString: testStringFHalfDiminished6_5] == YES)
	{
		label.text = [NSString stringWithFormat:@"A♭, C♭, E, F"];
		//@"F Half-Diminished 6-5:"
	}
	
	if ([messageFromPicker isEqualToString: testStringFSharpHalfDiminished6_5] == YES)
	{
		label.text = [NSString stringWithFormat:@"A, C, E♯, F♯"];
		//@"F♯ Half-Diminished 6-5:"
	}
	
	if ([messageFromPicker isEqualToString: testStringGbHalfDiminished6_5] == YES)
	{
		label.text = [NSString stringWithFormat:@"B♭♭, D♭♭, F, G♭"];
		//@"G♭ Half-Diminished 6-5:"
	}
	
	if ([messageFromPicker isEqualToString: testStringGHalfDiminished6_5] == YES)
	{
		label.text = [NSString stringWithFormat:@"B♭, D♭, F♯, G"];
		//@"G Half-Diminished 6-5:"
	}
	
	if ([messageFromPicker isEqualToString: testStringGSharpHalfDiminished6_5] == YES)
	{
		label.text = [NSString stringWithFormat:@"B, D, Fx, G♯"];
		//@"G♯ Half-Diminished 6-5:"
	}
	
	if ([messageFromPicker isEqualToString: testStringAbHalfDiminished6_5] == YES)
	{
		label.text = [NSString stringWithFormat:@"C♭, E♭♭, G, A♭"];
		//@"A♭ Half-Diminished 6-5:"
	}
	
	if ([messageFromPicker isEqualToString: testStringAHalfDiminished6_5] == YES)
	{
		label.text = [NSString stringWithFormat:@"C, E♭, G♯, A"];
		//@"A Half-Diminished 6-5:"
	}
	
	if ([messageFromPicker isEqualToString: testStringASharpHalfDiminished6_5] == YES)
	{
		label.text = [NSString stringWithFormat:@"C♯, E, Gx, A♯"];
		//@"A♯ Half-Diminished 6-5:"
	}
	
	if ([messageFromPicker isEqualToString: testStringBbHalfDiminished6_5] == YES)
	{
		label.text = [NSString stringWithFormat:@"D♭, F♭, A, B♭"];
		//@"B♭ Half-Diminished 6-5:"
	}
	
	if ([messageFromPicker isEqualToString: testStringBHalfDiminished6_5] == YES)
		{
		label.text = [NSString stringWithFormat:@"D, F, A♯, B"];
		//@"B Half-Diminished 6-5:"
	}
		
	// *********** Major4_3 ifs **********************
	
	if ([messageFromPicker isEqualToString: testStringCMajor4_3] == YES)
	{
		label.text = [NSString stringWithFormat:@"G, B, C, E"];
		//@"C Major 4-3:"
	}
	
	if ([messageFromPicker isEqualToString: testStringCSharpMajor4_3] == YES)
	{
		label.text = [NSString stringWithFormat:@"G♯, B♯, C♯, E♯"];
		//@"C♯ Major 4-3:"
	}
	
	if ([messageFromPicker isEqualToString: testStringDbMajor4_3] == YES)
	{
		label.text = [NSString stringWithFormat:@"A♭, C, D♭, F"];
		//@"D♭ Major 4-3:"
	}
	
	if ([messageFromPicker isEqualToString: testStringDMajor4_3] == YES)
	{
		label.text = [NSString stringWithFormat:@"A, C♯, D, F♯"];
		//@"D Major 4-3:"
	}
	
	if ([messageFromPicker isEqualToString: testStringDSharpMajor4_3] == YES)
	{
		label.text = [NSString stringWithFormat:@"A♯, Cx, D♯, Fx"];
		//@"D♯ Major 4-3:"
	}
	
	if ([messageFromPicker isEqualToString: testStringEbMajor4_3] == YES)
	{
		label.text = [NSString stringWithFormat:@"B♭, D, E♭, G"];
		//@"E♭ Major 4-3:"
	}
	
	if ([messageFromPicker isEqualToString: testStringEMajor4_3] == YES)
	{
		label.text = [NSString stringWithFormat:@"B, D♯, E, G♯"];
		//@"E Major 4-3:"
	}
	
	if ([messageFromPicker isEqualToString: testStringFMajor4_3] == YES)
	{
		label.text = [NSString stringWithFormat:@"C, E, F, A"];
		//@"F Major 4-3:"
	}
	
	if ([messageFromPicker isEqualToString: testStringFSharpMajor4_3] == YES)
	{
		label.text = [NSString stringWithFormat:@"C♯, E♯, F♯, A♯"];
		//@"F♯ Major 4-3:"
	}
	
	if ([messageFromPicker isEqualToString: testStringGbMajor4_3] == YES)
	{
		label.text = [NSString stringWithFormat:@"D♭, F, G♭, B♭"];
		//@"G♭ Major 4-3:"
	}
	
	if ([messageFromPicker isEqualToString: testStringGMajor4_3] == YES)
	{
		label.text = [NSString stringWithFormat:@"D, F♯, G, B"];
		//@"G Major 4-3:"
	}
	
	if ([messageFromPicker isEqualToString: testStringGSharpMajor4_3] == YES)
	{
		label.text = [NSString stringWithFormat:@"D♯, Fx, G♯, B♯"];
		//@"G♯ Major 4-3:"
	}
	
	if ([messageFromPicker isEqualToString: testStringAbMajor4_3] == YES)
	{
		label.text = [NSString stringWithFormat:@"E♭, G, A♭, C"];
		//@"A♭ Major 4-3:"
	}
	
	if ([messageFromPicker isEqualToString: testStringAMajor4_3] == YES)
	{
		label.text = [NSString stringWithFormat:@"E, G♯, A, C♯"];
		//@"A Major 4-3:"
	}
	
	if ([messageFromPicker isEqualToString: testStringASharpMajor4_3] == YES)
	{
		label.text = [NSString stringWithFormat:@"E♯, Gx, A♯, Cx"];
		//@"A♯ Major 4-3:"
	}
	
	if ([messageFromPicker isEqualToString: testStringBbMajor4_3] == YES)
	{
		label.text = [NSString stringWithFormat:@"F, A, B♭, D"];
		//@"B♭ Major 4-3:"
	}
	
	if ([messageFromPicker isEqualToString: testStringBMajor4_3] == YES)
	{
		label.text = [NSString stringWithFormat:@"F♯, A♯, B, D♯"];
		//@"B Major 4-3:"
	}
	
	// *********** Minor4_3 ifs **********************
	
	if ([messageFromPicker isEqualToString: testStringCMinor4_3] == YES)
	{
		label.text = [NSString stringWithFormat:@"G, B♭, C, E♭"];
		//@"C Minor 4-3:"
	}
	
	if ([messageFromPicker isEqualToString: testStringCSharpMinor4_3] == YES)
	{
		label.text = [NSString stringWithFormat:@"G♯, B, C♯, E"];
		//@"C♯ Minor 4-3:"
	}
	
	if ([messageFromPicker isEqualToString: testStringDbMinor4_3] == YES)
	{
		label.text = [NSString stringWithFormat:@"A♭, C♭, D♭, F♭"];
		//@"D♭ Minor 4-3:"
	}
	
	if ([messageFromPicker isEqualToString: testStringDMinor4_3] == YES)
	{
		label.text = [NSString stringWithFormat:@"A, C, D, F"];
		//@"D Minor 4-3:"
	}
	
	if ([messageFromPicker isEqualToString: testStringDSharpMinor4_3] == YES)
	{
		label.text = [NSString stringWithFormat:@"A♯, C♯, D♯, F♯"];
		//@"D♯ Minor 4-3:"
	}
	
	if ([messageFromPicker isEqualToString: testStringEbMinor4_3] == YES)
	{
		label.text = [NSString stringWithFormat:@"B♭, D♭, E♭, G♭"];
		//@"E♭ Minor 4-3:"
	}
	
	if ([messageFromPicker isEqualToString: testStringEMinor4_3] == YES)
	{
		label.text = [NSString stringWithFormat:@"B, D, E, G"];
		//@"E Minor 4-3:"
	}
	
	if ([messageFromPicker isEqualToString: testStringFMinor4_3] == YES)
	{
		label.text = [NSString stringWithFormat:@"C, E♭, F, A♭"];
		//@"F Minor 4-3:"
	}
	
	if ([messageFromPicker isEqualToString: testStringFSharpMinor4_3] == YES)
	{
		label.text = [NSString stringWithFormat:@"C♯, E, F♯, A"];
		//@"F♯ Minor 4-3:"
	}
	
	if ([messageFromPicker isEqualToString: testStringGbMinor4_3] == YES)
	{
		label.text = [NSString stringWithFormat:@"D♭, F♭, G♭, B♭♭"];
		//@"G♭ Minor 4-3:"
	}
	
	if ([messageFromPicker isEqualToString: testStringGMinor4_3] == YES)
	{
		label.text = [NSString stringWithFormat:@"D, F, G, B♭"];
		//@"G Minor 4-3:"
	}
	
	if ([messageFromPicker isEqualToString: testStringGSharpMinor4_3] == YES)
	{
		label.text = [NSString stringWithFormat:@"D♯, F♯, G♯, B"];
		//@"G♯ Minor 4-3:"
	}
	
	if ([messageFromPicker isEqualToString: testStringAbMinor4_3] == YES)
	{
		label.text = [NSString stringWithFormat:@"C♭, E♭, G♭, A♭"];
		//@"A♭ Minor 4-3:"
	}
	
	if ([messageFromPicker isEqualToString: testStringAMinor4_3] == YES)
	{
		label.text = [NSString stringWithFormat:@"E, G, A, C"];
		//@"A Minor 4-3:"
	}
	
	if ([messageFromPicker isEqualToString: testStringASharpMinor4_3] == YES)
	{
		label.text = [NSString stringWithFormat:@"E♯, G♯, A♯, C♯"];
		//@"A♯ Minor 4-3:"
	}
	
	if ([messageFromPicker isEqualToString: testStringBbMinor4_3] == YES)
	{
		label.text = [NSString stringWithFormat:@"F, A♭, B♭, D♭"];
		//@"B♭ Minor 4-3:"
	}
	
	if ([messageFromPicker isEqualToString: testStringBMinor4_3] == YES)
	{
		label.text = [NSString stringWithFormat:@"F♯, A, B, D"];
		//@"B Minor 4-3:"
	}
	
	// *********** AUGMENTED 4-3 ifs **********************
	// M3,M3,m3
	if ([messageFromPicker isEqualToString: testStringCAugmented4_3] == YES)
	{
		label.text = [NSString stringWithFormat:@"G♯, B, C, E"];
		//@"C Augmented 4-3:"
	}
	
	if ([messageFromPicker isEqualToString: testStringCSharpAugmented4_3] == YES)
	{
		label.text = [NSString stringWithFormat:@"Gx, B♯, C♯, E♯"];
		//@"C♯ Augmented 4-3:"
	}
	
	if ([messageFromPicker isEqualToString: testStringDbAugmented4_3] == YES)
	{
		label.text = [NSString stringWithFormat:@"A, C, D♭, F"];
		//@"D♭ Augmented 4-3:"
	}
	
	if ([messageFromPicker isEqualToString: testStringDAugmented4_3] == YES)
	{
		label.text = [NSString stringWithFormat:@"A♯, C♯, D, F♯"];
		//@"D Augmented 4-3:"
	}
	
	if ([messageFromPicker isEqualToString: testStringDSharpAugmented4_3] == YES)
	{
		label.text = [NSString stringWithFormat:@"Ax, Cx, D♯, Fx"];
		//@"D♯ Augmented 4-3:"
	}
	
	if ([messageFromPicker isEqualToString: testStringEbAugmented4_3] == YES)
	{
		label.text = [NSString stringWithFormat:@"B, D, E♭, G"];
		//@"E♭ Augmented 4-3:"
	}
	
	if ([messageFromPicker isEqualToString: testStringEAugmented4_3] == YES)
	{
		label.text = [NSString stringWithFormat:@"B♯, D♯, E, G♯"];
		//@"E Augmented 4-3:"
	}
	
	if ([messageFromPicker isEqualToString: testStringFAugmented4_3] == YES)
	{
		label.text = [NSString stringWithFormat:@"C♯, E, F, A"];
		//@"F Augmented 4-3:"
	}
	
	if ([messageFromPicker isEqualToString: testStringFSharpAugmented4_3] == YES)
	{
		label.text = [NSString stringWithFormat:@"Cx, E♯, F♯, A♯"];
		//@"F♯ Augmented 4-3:"
	}
	
	if ([messageFromPicker isEqualToString: testStringGbAugmented4_3] == YES)
	{
		label.text = [NSString stringWithFormat:@"D, F, G♭, B♭"];
		//@"G♭ Augmented 4-3:"
	}
	
	if ([messageFromPicker isEqualToString: testStringGAugmented4_3] == YES)
	{
		label.text = [NSString stringWithFormat:@"D♯, F♯, G, B"];
		//@"G Augmented 4-3:"
	}
	
	if ([messageFromPicker isEqualToString: testStringGSharpAugmented4_3] == YES)
	{
		label.text = [NSString stringWithFormat:@"Dx, Fx, G♯, B♯"];
		//@"G♯ Augmented 4-3:"
	}
	
	if ([messageFromPicker isEqualToString: testStringAbAugmented4_3] == YES)
	{
		label.text = [NSString stringWithFormat:@"E, G, A♭, C"];
		//@"A♭ Augmented 4-3:"
	}
	
	if ([messageFromPicker isEqualToString: testStringAAugmented4_3] == YES)
	{
		label.text = [NSString stringWithFormat:@"E♯, G♯, A, C♯"];
		//@"A Augmented 4-3:"
	}
	
	if ([messageFromPicker isEqualToString: testStringASharpAugmented4_3] == YES)
	{
		label.text = [NSString stringWithFormat:@"Ex, Gx, A♯, Cx"];
		//@"A♯ Augmented 4-3:"
	}
	
	if ([messageFromPicker isEqualToString: testStringBbAugmented4_3] == YES)
	{
		label.text = [NSString stringWithFormat:@"F♯, A, B♭, D"];
		//@"B♭ Augmented 4-3:"
	}
	
	if ([messageFromPicker isEqualToString: testStringBAugmented4_3] == YES)
	{
		label.text = [NSString stringWithFormat:@"Fx, A♯, B, D♯"];
		//@"B Augmented 4-3:"
	}
	
	// *********** DIMINISHED 4_3 ifs **********************
	// m3, m3, M3
	if ([messageFromPicker isEqualToString: testStringCDiminished4_3] == YES)
	{
		label.text = [NSString stringWithFormat:@"G♭, B♭, C, E♭"];
		//@"C Diminished 4-3:"
	}
	
	if ([messageFromPicker isEqualToString: testStringCSharpDiminished4_3] == YES)
	{
		label.text = [NSString stringWithFormat:@"G, B, C♯, E"];
		//@"C♯ Diminished 4-3:"
	}
	
	if ([messageFromPicker isEqualToString: testStringDbDiminished4_3] == YES)
	{
		label.text = [NSString stringWithFormat:@"A♭♭, C♭, D♭, F♭"];
		//@"D♭ Diminished 4-3:"
	}
	
	if ([messageFromPicker isEqualToString: testStringDDiminished4_3] == YES)
	{
		label.text = [NSString stringWithFormat:@"A♭, C, D, F"];
		//@"D Diminished 4-3:"
	}
	
	if ([messageFromPicker isEqualToString: testStringDSharpDiminished4_3] == YES)
	{
		label.text = [NSString stringWithFormat:@"A, C♯, D♯, F♯"];
		//@"D♯ Diminished 4-3:"
	}
	
	if ([messageFromPicker isEqualToString: testStringEbDiminished4_3] == YES)
	{
		label.text = [NSString stringWithFormat:@"B♭♭, D♭, E♭, G♭"];
		//@"E♭ Diminished 4-3:"
	}
	
	if ([messageFromPicker isEqualToString: testStringEDiminished4_3] == YES)
	{
		label.text = [NSString stringWithFormat:@"B♭, D, E, G"];
		//@"E Diminished 4-3:"
	}
	
	if ([messageFromPicker isEqualToString: testStringFDiminished4_3] == YES)
	{
		label.text = [NSString stringWithFormat:@"C♭, E♭, F, A♭"];
		//@"F Diminished 4-3:"
	}
	
	if ([messageFromPicker isEqualToString: testStringFSharpDiminished4_3] == YES)
	{
		label.text = [NSString stringWithFormat:@"C, E, F♯, A"];
		//@"F♯ Diminished 4-3:"
	}
	
	if ([messageFromPicker isEqualToString: testStringGbDiminished4_3] == YES)
	{
		label.text = [NSString stringWithFormat:@"D♭♭, F♭, G♭, B♭♭"];
		//@"G♭ Diminished 4-3:"
	}
	
	if ([messageFromPicker isEqualToString: testStringGDiminished4_3] == YES)
	{
		label.text = [NSString stringWithFormat:@"D♭, F, G, B♭"];
		//@"G Diminished 4-3:"
	}
	
	if ([messageFromPicker isEqualToString: testStringGSharpDiminished4_3] == YES)
	{
		label.text = [NSString stringWithFormat:@"D, F♯, G♯, B"];
		//@"G♯ Diminished 4-3:"
	}
	
	if ([messageFromPicker isEqualToString: testStringAbDiminished4_3] == YES)
	{
		label.text = [NSString stringWithFormat:@"E♭♭, G♭, A♭, C♭"];
		//@"A♭ Diminished 4-3:"
	}
	
	if ([messageFromPicker isEqualToString: testStringADiminished4_3] == YES)
	{
		label.text = [NSString stringWithFormat:@"E♭, G, A, C"];
		//@"A Diminished 4-3:"
	}
	
	if ([messageFromPicker isEqualToString: testStringASharpDiminished4_3] == YES)
	{
		label.text = [NSString stringWithFormat:@"E, G♯, A♯, C♯"];
		//@"A♯ Diminished 4-3:"
	}
	
	if ([messageFromPicker isEqualToString: testStringBbDiminished4_3] == YES)
	{
		label.text = [NSString stringWithFormat:@"F♭, A♭, B♭, D♭"];
		//@"B♭ Diminished 4-3:"
	}
	
	if ([messageFromPicker isEqualToString: testStringBDiminished4_3] == YES)
	{
		label.text = [NSString stringWithFormat:@"F, A, B, D"];
		//@"B Diminished 4-3:"
	}
	
	// *********** Half-Diminished 4_3 ifs **********************
	// m3, m3, M3
	if ([messageFromPicker isEqualToString: testStringCHalfDiminished4_3] == YES)
	{
		label.text = [NSString stringWithFormat:@"G♭, B, C, E♭"];
		//@"C Half-Diminished 4-3:"
	}
	
	if ([messageFromPicker isEqualToString: testStringCSharpHalfDiminished4_3] == YES)
	{
		label.text = [NSString stringWithFormat:@"G, B♯, C♯, E"];
		//@"C♯ Half-Diminished 4-3:"
	}
	
	if ([messageFromPicker isEqualToString: testStringDbHalfDiminished4_3] == YES)
	{
		label.text = [NSString stringWithFormat:@"A♭♭, C, D♭, F♭"];
		//@"D♭ Half-Diminished 4-3:"
	}
	
	if ([messageFromPicker isEqualToString: testStringDHalfDiminished4_3] == YES)
	{
		label.text = [NSString stringWithFormat:@"A♭, C♯, D, F"];
		//@"D Half-Diminished 4-3:"
	}
	
	if ([messageFromPicker isEqualToString: testStringDSharpHalfDiminished4_3] == YES)
	{
		label.text = [NSString stringWithFormat:@"A, Cx, D♯, F♯"];
		//@"D♯ Half-Diminished 4-3:"
	}
	
	if ([messageFromPicker isEqualToString: testStringEbHalfDiminished4_3] == YES)
	{
		label.text = [NSString stringWithFormat:@"B♭♭, D, E♭, G♭"];
		//@"E♭ Half-Diminished 4-3:"
	}
	
	if ([messageFromPicker isEqualToString: testStringEHalfDiminished4_3] == YES)
	{
		label.text = [NSString stringWithFormat:@"B♭, D♯, E, G"];
		//@"E Half-Diminished 4-3:"
	}
	
	if ([messageFromPicker isEqualToString: testStringFHalfDiminished4_3] == YES)
	{
		label.text = [NSString stringWithFormat:@"C♭, E, F, A♭"];
		//@"F Half-Diminished 4-3:"
	}
	
	if ([messageFromPicker isEqualToString: testStringFSharpHalfDiminished4_3] == YES)
	{
		label.text = [NSString stringWithFormat:@"C, E♯, F♯, A"];
		//@"F♯ Half-Diminished 4-3:"
	}
	
	if ([messageFromPicker isEqualToString: testStringGbHalfDiminished4_3] == YES)
	{
		label.text = [NSString stringWithFormat:@"D♭♭, F, G♭, B♭♭"];
		//@"G♭ Half-Diminished 4-3:"
	}
	
	if ([messageFromPicker isEqualToString: testStringGHalfDiminished4_3] == YES)
	{
		label.text = [NSString stringWithFormat:@"D♭, F♯, G, B♭"];
		//@"G Half-Diminished 4-3:"
	}
	
	if ([messageFromPicker isEqualToString: testStringGSharpHalfDiminished4_3] == YES)
	{
		label.text = [NSString stringWithFormat:@"D, Fx, G♯, B"];
		//@"G♯ Half-Diminished 4-3:"
	}
	
	if ([messageFromPicker isEqualToString: testStringAbHalfDiminished4_3] == YES)
	{
		label.text = [NSString stringWithFormat:@"E♭♭, G, A♭, C♭"];
		//@"A♭ Half-Diminished 4-3:"
	}
	
	if ([messageFromPicker isEqualToString: testStringAHalfDiminished4_3] == YES)
	{
		label.text = [NSString stringWithFormat:@"E♭, G♯, A, C"];
		//@"A Half-Diminished 4-3:"
	}
	
	if ([messageFromPicker isEqualToString: testStringASharpHalfDiminished4_3] == YES)
	{
		label.text = [NSString stringWithFormat:@"E, Gx, A♯, C♯"];
		//@"A♯ Half-Diminished 4-3:"
	}
	
	if ([messageFromPicker isEqualToString: testStringBbHalfDiminished4_3] == YES)
	{
		label.text = [NSString stringWithFormat:@"F♭, A, B♭, D♭"];
		//@"B♭ Half-Diminished 4-3:"
	}
	
	if ([messageFromPicker isEqualToString: testStringBHalfDiminished4_3]== YES)
		{
		label.text = [NSString stringWithFormat:@"F, A♯, B, D"];
		//@"B Half-Diminished 4-3:"
	}
		
	// *********** Major4_2 ifs **********************
	
	if ([messageFromPicker isEqualToString: testStringCMajor4_2] == YES)
	{
		label.text = [NSString stringWithFormat:@"B, C, E, G"];
		//@"C Major 4-2:"
	}
	
	if ([messageFromPicker isEqualToString: testStringCSharpMajor4_2] == YES)
	{
		label.text = [NSString stringWithFormat:@"B♯, C♯, E♯, G♯"];
		//@"C♯ Major 4-2:"
	}
	
	if ([messageFromPicker isEqualToString: testStringDbMajor4_2] == YES)
	{
		label.text = [NSString stringWithFormat:@"C, D♭, F, A♭"];
		//@"D♭ Major 4-2:"
	}
	
	if ([messageFromPicker isEqualToString: testStringDMajor4_2] == YES)
	{
		label.text = [NSString stringWithFormat:@"C♯, D, F♯, A"];
		//@"D Major 4-2:"
	}
	
	if ([messageFromPicker isEqualToString: testStringDSharpMajor4_2] == YES)
	{
		label.text = [NSString stringWithFormat:@"Cx, D♯, Fx, A♯"];
		//@"D♯ Major 4-2:"
	}
	
	if ([messageFromPicker isEqualToString: testStringEbMajor4_2] == YES)
	{
		label.text = [NSString stringWithFormat:@"D, E♭, G, B♭"];
		//@"E♭ Major 4-2:"
	}
	
	if ([messageFromPicker isEqualToString: testStringEMajor4_2] == YES)
	{
		label.text = [NSString stringWithFormat:@"D♯, E, G♯, B"];
		//@"E Major 4-2:"
	}
	
	if ([messageFromPicker isEqualToString: testStringFMajor4_2] == YES)
	{
		label.text = [NSString stringWithFormat:@"E, F, A, C"];
		//@"F Major 4-2:"
	}
	
	if ([messageFromPicker isEqualToString: testStringFSharpMajor4_2] == YES)
	{
		label.text = [NSString stringWithFormat:@"E♯, F♯, A♯, C♯"];
		//@"F♯ Major 4-2:"
	}
	
	if ([messageFromPicker isEqualToString: testStringGbMajor4_2] == YES)
	{
		label.text = [NSString stringWithFormat:@"F, G♭, B♭, D♭"];
		//@"G♭ Major 4-2:"
	}
	
	if ([messageFromPicker isEqualToString: testStringGMajor4_2] == YES)
	{
		label.text = [NSString stringWithFormat:@"F♯, G, B, D"];
		//@"G Major 4-2:"
	}
	
	if ([messageFromPicker isEqualToString: testStringGSharpMajor4_2] == YES)
	{
		label.text = [NSString stringWithFormat:@"Fx, G♯, B♯, D♯"];
		//@"G♯ Major 4-2:"
	}
	
	if ([messageFromPicker isEqualToString: testStringAbMajor4_2] == YES)
	{
		label.text = [NSString stringWithFormat:@"G, A♭, C, E♭"];
		//@"A♭ Major 4-2:"
	}
	
	if ([messageFromPicker isEqualToString: testStringAMajor4_2] == YES)
	{
		label.text = [NSString stringWithFormat:@"G♯, A, C♯, E"];
		//@"A Major 4-2:"
	}
	
	if ([messageFromPicker isEqualToString: testStringASharpMajor4_2] == YES)
	{
		label.text = [NSString stringWithFormat:@"Gx, A♯, Cx, E♯"];
		//@"A♯ Major 4-2:"
	}
	
	if ([messageFromPicker isEqualToString: testStringBbMajor4_2] == YES)
	{
		label.text = [NSString stringWithFormat:@"A, B♭, D, F"];
		//@"B♭ Major 4-2:"
	}
	
	if ([messageFromPicker isEqualToString: testStringBMajor4_2] == YES)
	{
		label.text = [NSString stringWithFormat:@"A♯, B, D♯, F♯"];
		//@"B Major 4-2:"
	}
	
	// *********** Minor4_2 ifs **********************
	
	if ([messageFromPicker isEqualToString: testStringCMinor4_2] == YES)
	{
		label.text = [NSString stringWithFormat:@"B♭, C, E♭, G"];
		//@"C Minor 4-2:"
	}
	
	if ([messageFromPicker isEqualToString: testStringCSharpMinor4_2] == YES)
	{
		label.text = [NSString stringWithFormat:@"B, C♯, E, G♯"];
		//@"C♯ Minor 4-2:"
	}
	
	if ([messageFromPicker isEqualToString: testStringDbMinor4_2] == YES)
	{
		label.text = [NSString stringWithFormat:@"C♭, D♭, F♭, A♭"];
		//@"D♭ Minor 4-2:"
	}
	
	if ([messageFromPicker isEqualToString: testStringDMinor4_2] == YES)
	{
		label.text = [NSString stringWithFormat:@"C, D, F, A"];
		//@"D Minor 4-2:"
	}
	
	if ([messageFromPicker isEqualToString: testStringDSharpMinor4_2] == YES)
	{
		label.text = [NSString stringWithFormat:@"C♯, D♯, F♯, A♯"];
		//@"D♯ Minor 4-2:"
	}
	
	if ([messageFromPicker isEqualToString: testStringEbMinor4_2] == YES)
	{
		label.text = [NSString stringWithFormat:@"D♭, E♭, G♭, B♭"];
		//@"E♭ Minor 4-2:"
	}
	
	if ([messageFromPicker isEqualToString: testStringEMinor4_2] == YES)
	{
		label.text = [NSString stringWithFormat:@"D, E, G, B"];
		//@"E Minor 4-2:"
	}
	
	if ([messageFromPicker isEqualToString: testStringFMinor4_2] == YES)
	{
		label.text = [NSString stringWithFormat:@"E♭, F, A♭, C"];
		//@"F Minor 4-2:"
	}
	
	if ([messageFromPicker isEqualToString: testStringFSharpMinor4_2] == YES)
	{
		label.text = [NSString stringWithFormat:@"E, F♯, A, C♯"];
		//@"F♯ Minor 4-2:"
	}
	
	if ([messageFromPicker isEqualToString: testStringGbMinor4_2] == YES)
	{
		label.text = [NSString stringWithFormat:@"F♭, G♭, B♭♭, D♭"];
		//@"G♭ Minor 4-2:"
	}
	
	if ([messageFromPicker isEqualToString: testStringGMinor4_2] == YES)
	{
		label.text = [NSString stringWithFormat:@"F, G, B♭, D"];
		//@"G Minor 4-2:"
	}
	
	if ([messageFromPicker isEqualToString: testStringGSharpMinor4_2] == YES)
	{
		label.text = [NSString stringWithFormat:@"F♯, G♯, B, D♯"];
		//@"G♯ Minor 4-2:"
	}
	
	if ([messageFromPicker isEqualToString: testStringAbMinor4_2] == YES)
	{
		label.text = [NSString stringWithFormat:@"E♭, G♭, A♭, C♭"];
		//@"A♭ Minor 4-2:"
	}
	
	if ([messageFromPicker isEqualToString: testStringAMinor4_2] == YES)
	{
		label.text = [NSString stringWithFormat:@"G, A, C, E"];
		//@"A Minor 4-2:"
	}
	
	if ([messageFromPicker isEqualToString: testStringASharpMinor4_2] == YES)
	{
		label.text = [NSString stringWithFormat:@"G♯, A♯, C♯, E♯"];
		//@"A♯ Minor 4-2:"
	}
	
	if ([messageFromPicker isEqualToString: testStringBbMinor4_2] == YES)
	{
		label.text = [NSString stringWithFormat:@"A♭, B♭, D♭, F"];
		//@"B♭ Minor 4-2:"
	}
	
	if ([messageFromPicker isEqualToString: testStringBMinor4_2] == YES)
	{
		label.text = [NSString stringWithFormat:@"A, B, D, F♯"];
		//@"B Minor 4-2:"
	}
	
	// *********** AUGMENTED 4-2 ifs **********************
	// M3,M3,m3
	if ([messageFromPicker isEqualToString: testStringCAugmented4_2] == YES)
	{
		label.text = [NSString stringWithFormat:@"B, C, E, G♯"];
		//@"C Augmented 4-2:"
	}
	
	if ([messageFromPicker isEqualToString: testStringCSharpAugmented4_2] == YES)
	{
		label.text = [NSString stringWithFormat:@"B♯, C♯, E♯, Gx"];
		//@"C♯ Augmented 4-2:"
	}
	
	if ([messageFromPicker isEqualToString: testStringDbAugmented4_2] == YES)
	{
		label.text = [NSString stringWithFormat:@"C, D♭, F, A"];
		//@"D♭ Augmented 4-2:"
	}
	
	if ([messageFromPicker isEqualToString: testStringDAugmented4_2] == YES)
	{
		label.text = [NSString stringWithFormat:@"C♯, D, F♯, A♯"];
		//@"D Augmented 4-2:"
	}
	
	if ([messageFromPicker isEqualToString: testStringDSharpAugmented4_2] == YES)
	{
		label.text = [NSString stringWithFormat:@"Cx, D♯, Fx, Ax"];
		//@"D♯ Augmented 4-2:"
	}
	
	if ([messageFromPicker isEqualToString: testStringEbAugmented4_2] == YES)
	{
		label.text = [NSString stringWithFormat:@"D, E♭, G, B"];
		//@"E♭ Augmented 4-2:"
	}
	
	if ([messageFromPicker isEqualToString: testStringEAugmented4_2] == YES)
	{
		label.text = [NSString stringWithFormat:@"D♯, E, G♯, B♯"];
		//@"E Augmented 4-2:"
	}
	
	if ([messageFromPicker isEqualToString: testStringFAugmented4_2] == YES)
	{
		label.text = [NSString stringWithFormat:@"E, F, A, C♯"];
		//@"F Augmented 4-2:"
	}
	
	if ([messageFromPicker isEqualToString: testStringFSharpAugmented4_2] == YES)
	{
		label.text = [NSString stringWithFormat:@"E♯, F♯, A♯, Cx"];
		//@"F♯ Augmented 4-2:"
	}
	
	if ([messageFromPicker isEqualToString: testStringGbAugmented4_2] == YES)
	{
		label.text = [NSString stringWithFormat:@"F, G♭, B♭, D"];
		//@"G♭ Augmented 4-2:"
	}
	
	if ([messageFromPicker isEqualToString: testStringGAugmented4_2] == YES)
	{
		label.text = [NSString stringWithFormat:@"F♯, G, B, D♯"];
		//@"G Augmented 4-2:"
	}
	
	if ([messageFromPicker isEqualToString: testStringGSharpAugmented4_2] == YES)
	{
		label.text = [NSString stringWithFormat:@"Fx, G♯, B♯, Dx"];
		//@"G♯ Augmented 4-2:"
	}
	
	if ([messageFromPicker isEqualToString: testStringAbAugmented4_2] == YES)
	{
		label.text = [NSString stringWithFormat:@"G, A♭, C, E"];
		//@"A♭ Augmented 4-2:"
	}
	
	if ([messageFromPicker isEqualToString: testStringAAugmented4_2] == YES)
	{
		label.text = [NSString stringWithFormat:@"G♯, A, C♯, E♯"];
		//@"A Augmented 4-2:"
	}
	
	if ([messageFromPicker isEqualToString: testStringASharpAugmented4_2] == YES)
	{
		label.text = [NSString stringWithFormat:@"Gx, A♯, Cx, Ex"];
		//@"A♯ Augmented 4-2:"
	}
	
	if ([messageFromPicker isEqualToString: testStringBbAugmented4_2] == YES)
	{
		label.text = [NSString stringWithFormat:@"A, B♭, D, F♯"];
		//@"B♭ Augmented 4-2:"
	}
	
	if ([messageFromPicker isEqualToString: testStringBAugmented4_2] == YES)
	{
		label.text = [NSString stringWithFormat:@"A♯, B, D♯, Fx"];
		//@"B Augmented 4-2:"
	}
	
	// *********** DIMINISHED 4_2 ifs **********************
	// m3, m3, M3
	if ([messageFromPicker isEqualToString: testStringCDiminished4_2] == YES)
	{
		label.text = [NSString stringWithFormat:@"B♭, C, E♭, G♭"];
		//@"C Diminished 4-2:"
	}
	
	if ([messageFromPicker isEqualToString: testStringCSharpDiminished4_2] == YES)
	{
		label.text = [NSString stringWithFormat:@"B, C♯, E, G"];
		//@"C♯ Diminished 4-2:"
	}
	
	if ([messageFromPicker isEqualToString: testStringDbDiminished4_2] == YES)
	{
		label.text = [NSString stringWithFormat:@"C♭, D♭, F♭, A♭♭"];
		//@"D♭ Diminished 4-2:"
	}
	
	if ([messageFromPicker isEqualToString: testStringDDiminished4_2] == YES)
	{
		label.text = [NSString stringWithFormat:@"C, D, F, A♭"];
		//@"D Diminished 4-2:"
	}
	
	if ([messageFromPicker isEqualToString: testStringDSharpDiminished4_2] == YES)
	{
		label.text = [NSString stringWithFormat:@"C♯, D♯, F♯, A"];
		//@"D♯ Diminished 4-2:"
	}
	
	if ([messageFromPicker isEqualToString: testStringEbDiminished4_2] == YES)
	{
		label.text = [NSString stringWithFormat:@"D♭, E♭, G♭, B♭♭"];
		//@"E♭ Diminished 4-2:"
	}
	
	if ([messageFromPicker isEqualToString: testStringEDiminished4_2] == YES)
	{
		label.text = [NSString stringWithFormat:@"D, E, G, B♭"];
		//@"E Diminished 4-2:"
	}
	
	if ([messageFromPicker isEqualToString: testStringFDiminished4_2] == YES)
	{
		label.text = [NSString stringWithFormat:@"E♭, F, A♭, C♭"];
		//@"F Diminished 4-2:"
	}
	
	if ([messageFromPicker isEqualToString: testStringFSharpDiminished4_2] == YES)
	{
		label.text = [NSString stringWithFormat:@"E, F♯, A, C"];
		//@"F♯ Diminished 4-2:"
	}
	
	if ([messageFromPicker isEqualToString: testStringGbDiminished4_2] == YES)
	{
		label.text = [NSString stringWithFormat:@"F♭, G♭, B♭♭, D♭♭"];
		//@"G♭ Diminished 4-2:"
	}
	
	if ([messageFromPicker isEqualToString: testStringGDiminished4_2] == YES)
	{
		label.text = [NSString stringWithFormat:@"F, G, B♭, D♭"];
		//@"G Diminished 4-2:"
	}
	
	if ([messageFromPicker isEqualToString: testStringGSharpDiminished4_2] == YES)
	{
		label.text = [NSString stringWithFormat:@"F♯, G♯, B, D"];
		//@"G♯ Diminished 4-2:"
	}
	
	if ([messageFromPicker isEqualToString: testStringAbDiminished4_2] == YES)
	{
		label.text = [NSString stringWithFormat:@"G♭, A♭, C♭, E♭♭"];
		//@"A♭ Diminished 4-2:"
	}
	
	if ([messageFromPicker isEqualToString: testStringADiminished4_2] == YES)
	{
		label.text = [NSString stringWithFormat:@"G, A, C, E♭"];
		//@"A Diminished 4-2:"
	}
	
	if ([messageFromPicker isEqualToString: testStringASharpDiminished4_2] == YES)
	{
		label.text = [NSString stringWithFormat:@"G♯, A♯, C♯, E"];
		//@"A♯ Diminished 4-2:"
	}
	
	if ([messageFromPicker isEqualToString: testStringBbDiminished4_2] == YES)
	{
		label.text = [NSString stringWithFormat:@"A♭, B♭, D♭, F♭"];
		//@"B♭ Diminished 4-2:"
	}
	
	if ([messageFromPicker isEqualToString: testStringBDiminished4_2] == YES)
	{
		label.text = [NSString stringWithFormat:@"A, B, D, F"];
		//@"B Diminished 4-2:"
	}
	
	// *********** Half-Diminished 4_2 ifs **********************
	// m3, m3, M3
	if ([messageFromPicker isEqualToString: testStringCHalfDiminished4_2] == YES)
	{
		label.text = [NSString stringWithFormat:@"B, C, E♭, G♭"];
		//@"C Half-Diminished 4-2:"
	}
	
	if ([messageFromPicker isEqualToString: testStringCSharpHalfDiminished4_2] == YES)
	{
		label.text = [NSString stringWithFormat:@"B♯, C♯, E, G"];
		//@"C♯ Half-Diminished 4-2:"
	}
	
	if ([messageFromPicker isEqualToString: testStringDbHalfDiminished4_2] == YES)
	{
		label.text = [NSString stringWithFormat:@"C, D♭, F♭, A♭♭"];
		//@"D♭ Half-Diminished 4-2:"
	}
	
	if ([messageFromPicker isEqualToString: testStringDHalfDiminished4_2] == YES)
	{
		label.text = [NSString stringWithFormat:@"C♯, D, F, A♭"];
		//@"D Half-Diminished 4-2:"
	}
	
	if ([messageFromPicker isEqualToString: testStringDSharpHalfDiminished4_2] == YES)
	{
		label.text = [NSString stringWithFormat:@"Cx, D♯, F♯, A"];
		//@"D♯ Half-Diminished 4-2:"
	}
	
	if ([messageFromPicker isEqualToString: testStringEbHalfDiminished4_2] == YES)
	{
		label.text = [NSString stringWithFormat:@"D, E♭, G♭, B♭♭"];
		//@"E♭ Half-Diminished 4-2:"
	}
	
	if ([messageFromPicker isEqualToString: testStringEHalfDiminished4_2] == YES)
	{
		label.text = [NSString stringWithFormat:@"D♯, E, G, B♭"];
		//@"E Half-Diminished 4-2:"
	}
	
	if ([messageFromPicker isEqualToString: testStringFHalfDiminished4_2] == YES)
	{
		label.text = [NSString stringWithFormat:@"E, F, A♭, C♭"];
		//@"F Half-Diminished 4-2:"
	}
	
	if ([messageFromPicker isEqualToString: testStringFSharpHalfDiminished4_2] == YES)
	{
		label.text = [NSString stringWithFormat:@"E♯, F♯, A, C"];
		//@"F♯ Half-Diminished 4-2:"
	}
	
	if ([messageFromPicker isEqualToString: testStringGbHalfDiminished4_2] == YES)
	{
		label.text = [NSString stringWithFormat:@"F, G♭, B♭♭, D♭♭"];
		//@"G♭ Half-Diminished 4-2:"
	}
	
	if ([messageFromPicker isEqualToString: testStringGHalfDiminished4_2] == YES)
	{
		label.text = [NSString stringWithFormat:@"F♯, G, B♭, D♭"];
		//@"G Half-Diminished 4-2:"
	}
	
	if ([messageFromPicker isEqualToString: testStringGSharpHalfDiminished4_2] == YES)
	{
		label.text = [NSString stringWithFormat:@"Fx, G♯, B, D"];
		//@"G♯ Half-Diminished 4-2:"
	}
	
	if ([messageFromPicker isEqualToString: testStringAbHalfDiminished4_2] == YES)
	{
		label.text = [NSString stringWithFormat:@"G, A♭, C♭, E♭♭"];
		//@"A♭ Half-Diminished 4-2:"
	}
	
	if ([messageFromPicker isEqualToString: testStringAHalfDiminished4_2] == YES)
	{
		label.text = [NSString stringWithFormat:@"G♯, A, C, E♭"];
		//@"A Half-Diminished 4-2:"
	}
	
	if ([messageFromPicker isEqualToString: testStringASharpHalfDiminished4_2] == YES)
	{
		label.text = [NSString stringWithFormat:@"Gx, A♯, C♯, E"];
		//@"A♯ Half-Diminished 4-2:"
	}
	
	if ([messageFromPicker isEqualToString: testStringBbHalfDiminished4_2] == YES)
	{
		label.text = [NSString stringWithFormat:@"A, B♭, D♭, F♭"];
		//@"B♭ Half-Diminished 4-2:"
	}
	
	if ([messageFromPicker isEqualToString: testStringBHalfDiminished4_2] == YES)
	{
		label.text = [NSString stringWithFormat:@"A♯, B, D, F"];
		//@"B Half-Diminished 4-2:"
	}
	
	// *********** Dominant4_2 ifs **********************
	
	if ([messageFromPicker isEqualToString: testStringCDominant4_2] == YES)
	{
		// ********************%%%%%%%%%%%^^^^^^^^^^^^^^^$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$	
		//label.adjustsFontSizeToFitWidth = YES;
		//label.numberOfLines = 10;
		//label.sizeToFit;
		//label.minimumFontSize = 9.0f;
		label.text = [NSString stringWithFormat:@"B♭, C, E, G"];
		//@"C Dominant 4-2:"
	}
	
	if ([messageFromPicker isEqualToString: testStringCSharpDominant4_2] == YES)
	{
		label.text = [NSString stringWithFormat:@"B, C♯, E♯, G♯"];
		//@"C♯ Dominant 4-2:"
	}
	
	if ([messageFromPicker isEqualToString: testStringDbDominant4_2] == YES)
	{
		label.text = [NSString stringWithFormat:@"C♭, D♭, F, A♭"];
		//@"D♭ Dominant 4-2:"
	}
	
	if ([messageFromPicker isEqualToString: testStringDDominant4_2] == YES)
	{
		label.text = [NSString stringWithFormat:@"C, D, F♯, A"];
		//@"D Dominant 4-2:"
	}
	
	if ([messageFromPicker isEqualToString: testStringDSharpDominant4_2] == YES)
	{
		label.text = [NSString stringWithFormat:@"C♯, D♯, Fx, A♯"];
		//@"D♯ Dominant 4-2:"
	}
	
	if ([messageFromPicker isEqualToString: testStringEbDominant4_2] == YES)
	{
		label.text = [NSString stringWithFormat:@"D♭, E♭, G, B♭"];
		//@"E♭ Dominant 4-2:"
	}
	
	if ([messageFromPicker isEqualToString: testStringEDominant4_2] == YES)
	{
		label.text = [NSString stringWithFormat:@"D, E, G♯, B"];
		//@"E Dominant 4-2:"
	}
	
	if ([messageFromPicker isEqualToString: testStringFDominant4_2] == YES)
	{
		label.text = [NSString stringWithFormat:@"E♭, F, A, C"];
		//@"F Dominant 4-2:"
	}
	
	if ([messageFromPicker isEqualToString: testStringFSharpDominant4_2] == YES)
	{
		label.text = [NSString stringWithFormat:@"E, F♯, A♯, C♯"];
		//@"F♯ Dominant 4-2:"
	}
	
	if ([messageFromPicker isEqualToString: testStringGbDominant4_2] == YES)
	{
		label.text = [NSString stringWithFormat:@"F♭, G♭, B♭, D♭"];
		//@"G♭ Dominant 4-2:"
	}
	
	if ([messageFromPicker isEqualToString: testStringGDominant4_2] == YES)
	{
		label.text = [NSString stringWithFormat:@"F, G, B, D"];
		//@"G Dominant 4-2:"
	}
	
	if ([messageFromPicker isEqualToString: testStringGSharpDominant4_2] == YES)
	{
		label.text = [NSString stringWithFormat:@"F♯, G♯, B♯, D♯"];
		//@"G♯ Dominant 4-2:"
	}
	
	if ([messageFromPicker isEqualToString: testStringAbDominant4_2] == YES)
	{
		label.text = [NSString stringWithFormat:@"G♭, A♭, C, E♭"];
		//@"A♭ Dominant 4-2:"
	}
	
	if ([messageFromPicker isEqualToString: testStringADominant4_2] == YES)
	{
		label.text = [NSString stringWithFormat:@"G, A, C♯, E"];
		//@"A Dominant 4-2:"
	}
	
	if ([messageFromPicker isEqualToString: testStringASharpDominant4_2] == YES)
	{
		label.text = [NSString stringWithFormat:@"G♯, A♯, Cx, E♯"];
		//@"A♯ Dominant 4-2:"
	}
	
	if ([messageFromPicker isEqualToString: testStringBbDominant4_2] == YES)
	{
		label.text = [NSString stringWithFormat:@"A♭, B♭, D, F"];
		//@"B♭ Dominant 4-2:"
	}
	
	if ([messageFromPicker isEqualToString: testStringBDominant4_2] == YES)
	{
		label.text = [NSString stringWithFormat:@"A, B, D♯, F♯"];
		//@"B Dominant 4-2:"
	}
	
	// ********************************************************
	
	// ELSE UIAlertView ************************************************
	/*
	else 
	{	
	 NSString *bugMessage = @"Kindly email brianb.james@mac.com\nand explain what you just did to make this screen appear.";
	 //@"OOPS!\nThere seems to be a bug...." message:bugMessage delegate:nil cancelButtonTitle:@"OK"
	 UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"OOPS!\nThere seems to be a bug...." message:bugMessage delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
	 [alert show];
	 [alert release];	 
	 [bugMessage release];
	}*/
	
	// ***TEST STRING AUTORELEASE *******************************************
	// *********** Major 5 TEST STRING RELEASE **********************
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
	
	// *********** AUGMENTED TEST STRING RELEASE **********************
	[testStringCAugmented autorelease];
	[testStringCSharpAugmented autorelease];
	[testStringDbAugmented autorelease];
	[testStringDAugmented autorelease];
	[testStringDSharpAugmented autorelease];
	[testStringEbAugmented autorelease];
	[testStringEAugmented autorelease];
	[testStringFAugmented autorelease];
	[testStringFSharpAugmented autorelease];
	[testStringGbAugmented autorelease];
	[testStringGAugmented autorelease];
	[testStringGSharpAugmented autorelease];
	[testStringAbAugmented autorelease];
	[testStringAAugmented autorelease];
	[testStringASharpAugmented autorelease];
	[testStringBbAugmented autorelease];
	[testStringBAugmented autorelease];
	
	// *********** DIMINISHED TEST STRING RELEASE ***********
	[testStringCDiminished autorelease];
	[testStringCSharpDiminished autorelease];
	[testStringDbDiminished autorelease];
	[testStringDDiminished autorelease];
	[testStringDSharpDiminished autorelease];
	[testStringEbDiminished autorelease];
	[testStringEDiminished autorelease];
	[testStringFDiminished autorelease];
	[testStringFSharpDiminished autorelease];
	[testStringGbDiminished autorelease];
	[testStringGDiminished autorelease];
	[testStringGSharpDiminished autorelease];
	[testStringAbDiminished autorelease];
	[testStringADiminished autorelease];
	[testStringASharpDiminished autorelease];
	[testStringBbDiminished autorelease];
	[testStringBDiminished autorelease];
	
	// *********** Major 6 TEST STRING RELEASE **********************
	[testStringCMajor6 autorelease];
	[testStringCSharpMajor6 autorelease];
	[testStringDbMajor6 autorelease];
	[testStringDMajor6 autorelease];
	[testStringDSharpMajor6 autorelease];
	[testStringEbMajor6 autorelease];
	[testStringEMajor6 autorelease];
	[testStringFMajor6 autorelease];
	[testStringFSharpMajor6 autorelease];
	[testStringGbMajor6 autorelease];
	[testStringGMajor6 autorelease];
	[testStringGSharpMajor6 autorelease];
	[testStringAbMajor6 autorelease];
	[testStringAMajor6 autorelease];
	[testStringASharpMajor6 autorelease];
	[testStringBbMajor6 autorelease];
	[testStringBMajor6 autorelease];
	
	// *********** Minor6 TEST STRING RELEASE **********************
	[testStringCMinor6 autorelease];
	[testStringCSharpMinor6 autorelease];
	[testStringDbMinor6 autorelease];
	[testStringDMinor6 autorelease];
	[testStringDSharpMinor6 autorelease];
	[testStringEbMinor6 autorelease];
	[testStringEMinor6 autorelease];
	[testStringFMinor6 autorelease];
	[testStringFSharpMinor6 autorelease];
	[testStringGbMinor6 autorelease];
	[testStringGMinor6 autorelease];
	[testStringGSharpMinor6 autorelease];
	[testStringAbMinor6 autorelease];
	[testStringAMinor6 autorelease];
	[testStringASharpMinor6 autorelease];
	[testStringBbMinor6 autorelease];
	[testStringBMinor6 autorelease];
	
	// *********** Augmented6 TEST STRING RELEASE **********************
	[testStringCAugmented6 autorelease];
	[testStringCSharpAugmented6 autorelease];
	[testStringDbAugmented6 autorelease];
	[testStringDAugmented6 autorelease];
	[testStringDSharpAugmented6 autorelease];
	[testStringEbAugmented6 autorelease];
	[testStringEAugmented6 autorelease];
	[testStringFAugmented6 autorelease];
	[testStringFSharpAugmented6 autorelease];
	[testStringGbAugmented6 autorelease];
	[testStringGAugmented6 autorelease];
	[testStringGSharpAugmented6 autorelease];
	[testStringAbAugmented6 autorelease];
	[testStringAAugmented6 autorelease];
	[testStringASharpAugmented6 autorelease];
	[testStringBbAugmented6 autorelease];
	[testStringBAugmented6 autorelease];
	
	// *********** Diminished6 TEST STRING RELEASE ***********
	[testStringCDiminished6 autorelease];
	[testStringCSharpDiminished6 autorelease];
	[testStringDbDiminished6 autorelease];
	[testStringDDiminished6 autorelease];
	[testStringDSharpDiminished6 autorelease];
	[testStringEbDiminished6 autorelease];
	[testStringEDiminished6 autorelease];
	[testStringFDiminished6 autorelease];
	[testStringFSharpDiminished6 autorelease];
	[testStringGbDiminished6 autorelease];
	[testStringGDiminished6 autorelease];
	[testStringGSharpDiminished6 autorelease];
	[testStringAbDiminished6 autorelease];
	[testStringADiminished6 autorelease];
	[testStringASharpDiminished6 autorelease];
	[testStringBbDiminished6 autorelease];
	[testStringBDiminished6 autorelease];
	
	// *********** Major 6-4 TEST STRING RELEASE **********************
	[testStringCMajor64 autorelease];
	[testStringCSharpMajor64 autorelease];
	[testStringDbMajor64 autorelease];
	[testStringDMajor64 autorelease];
	[testStringDSharpMajor64 autorelease];
	[testStringEbMajor64 autorelease];
	[testStringEMajor64 autorelease];
	[testStringFMajor64 autorelease];
	[testStringFSharpMajor64 autorelease];
	[testStringGbMajor64 autorelease];
	[testStringGMajor64 autorelease];
	[testStringGSharpMajor64 autorelease];
	[testStringAbMajor64 autorelease];
	[testStringAMajor64 autorelease];
	[testStringASharpMajor64 autorelease];
	[testStringBbMajor64 autorelease];
	[testStringBMajor64 autorelease];
	
	// *********** Minor64 TEST STRING RELEASE **********************
	[testStringCMinor64 autorelease];
	[testStringCSharpMinor64 autorelease];
	[testStringDbMinor64 autorelease];
	[testStringDMinor64 autorelease];
	[testStringDSharpMinor64 autorelease];
	[testStringEbMinor64 autorelease];
	[testStringEMinor64 autorelease];
	[testStringFMinor64 autorelease];
	[testStringFSharpMinor64 autorelease];
	[testStringGbMinor64 autorelease];
	[testStringGMinor64 autorelease];
	[testStringGSharpMinor64 autorelease];
	[testStringAbMinor64 autorelease];
	[testStringAMinor64 autorelease];
	[testStringASharpMinor64 autorelease];
	[testStringBbMinor64 autorelease];
	[testStringBMinor64 autorelease];
	
	// *********** Augmented64 TEST STRING RELEASE **********************
	[testStringCAugmented64 autorelease];
	[testStringCSharpAugmented64 autorelease];
	[testStringDbAugmented64 autorelease];
	[testStringDAugmented64 autorelease];
	[testStringDSharpAugmented64 autorelease];
	[testStringEbAugmented64 autorelease];
	[testStringEAugmented64 autorelease];
	[testStringFAugmented64 autorelease];
	[testStringFSharpAugmented64 autorelease];
	[testStringGbAugmented64 autorelease];
	[testStringGAugmented64 autorelease];
	[testStringGSharpAugmented64 autorelease];
	[testStringAbAugmented64 autorelease];
	[testStringAAugmented64 autorelease];
	[testStringASharpAugmented64 autorelease];
	[testStringBbAugmented64 autorelease];
	[testStringBAugmented64 autorelease];
	
	// *********** Diminished64 TEST STRING RELEASE ***********
	[testStringCDiminished64 autorelease];
	[testStringCSharpDiminished64 autorelease];
	[testStringDbDiminished64 autorelease];
	[testStringDDiminished64 autorelease];
	[testStringDSharpDiminished64 autorelease];
	[testStringEbDiminished64 autorelease];
	[testStringEDiminished64 autorelease];
	[testStringFDiminished64 autorelease];
	[testStringFSharpDiminished64 autorelease];
	[testStringGbDiminished64 autorelease];
	[testStringGDiminished64 autorelease];
	[testStringGSharpDiminished64 autorelease];
	[testStringAbDiminished64 autorelease];
	[testStringADiminished64 autorelease];
	[testStringASharpDiminished64 autorelease];
	[testStringBbDiminished64 autorelease];
	[testStringBDiminished64 autorelease];
	
	// *********** Italian +6 TEST STRING RELEASE **********************
	[testStringCItalian autorelease];
	[testStringCSharpItalian autorelease];
	[testStringDbItalian autorelease];
	[testStringDItalian autorelease];
	[testStringDSharpItalian autorelease];
	[testStringEbItalian autorelease];
	[testStringEItalian autorelease];
	[testStringFItalian autorelease];
	[testStringFSharpItalian autorelease];
	[testStringGbItalian autorelease];
	[testStringGItalian autorelease];
	[testStringGSharpItalian autorelease];
	[testStringAbItalian autorelease];
	[testStringAItalian autorelease];
	[testStringASharpItalian autorelease];
	[testStringBbItalian autorelease];
	[testStringBItalian autorelease];
	
	// *********** French +6 TEST STRING RELEASE **********************
	[testStringCFrench autorelease];
	[testStringCSharpFrench autorelease];
	[testStringDbFrench autorelease];
	[testStringDFrench autorelease];
	[testStringDSharpFrench autorelease];
	[testStringEbFrench autorelease];
	[testStringEFrench autorelease];
	[testStringFFrench autorelease];
	[testStringFSharpFrench autorelease];
	[testStringGbFrench autorelease];
	[testStringGFrench autorelease];
	[testStringGSharpFrench autorelease];
	[testStringAbFrench autorelease];
	[testStringAFrench autorelease];
	[testStringASharpFrench autorelease];
	[testStringBbFrench autorelease];
	[testStringBFrench autorelease];
	
	// *********** German +6 TEST STRING RELEASE **********************
	[testStringCGerman autorelease];
	[testStringCSharpGerman autorelease];
	[testStringDbGerman autorelease];
	[testStringDGerman autorelease];
	[testStringDSharpGerman autorelease];
	[testStringEbGerman autorelease];
	[testStringEGerman autorelease];
	[testStringFGerman autorelease];
	[testStringFSharpGerman autorelease];
	[testStringGbGerman autorelease];
	[testStringGGerman autorelease];
	[testStringGSharpGerman autorelease];
	[testStringAbGerman autorelease];
	[testStringAGerman autorelease];
	[testStringASharpGerman autorelease];
	[testStringBbGerman autorelease];
	[testStringBGerman autorelease];
	
	// *********** Major7 TEST STRING RELEASE **********************
	[testStringCMajor7 autorelease];
	[testStringCSharpMajor7 autorelease];
	[testStringDbMajor7 autorelease];
	[testStringDMajor7 autorelease];
	[testStringDSharpMajor7 autorelease];
	[testStringEbMajor7 autorelease];
	[testStringEMajor7 autorelease];
	[testStringFMajor7 autorelease];
	[testStringFSharpMajor7 autorelease];
	[testStringGbMajor7 autorelease];
	[testStringGMajor7 autorelease];
	[testStringGSharpMajor7 autorelease];
	[testStringAbMajor7 autorelease];
	[testStringAMajor7 autorelease];
	[testStringASharpMajor7 autorelease];
	[testStringBbMajor7 autorelease];
	[testStringBMajor7 autorelease];
	
	// *********** Minor7 TEST STRING RELEASE **********************
	[testStringCMinor7 autorelease];
	[testStringCSharpMinor7 autorelease];
	[testStringDbMinor7 autorelease];
	[testStringDMinor7 autorelease];
	[testStringDSharpMinor7 autorelease];
	[testStringEbMinor7 autorelease];
	[testStringEMinor7 autorelease];
	[testStringFMinor7 autorelease];
	[testStringFSharpMinor7 autorelease];
	[testStringGbMinor7 autorelease];
	[testStringGMinor7 autorelease];
	[testStringGSharpMinor7 autorelease];
	[testStringAbMinor7 autorelease];
	[testStringAMinor7 autorelease];
	[testStringASharpMinor7 autorelease];
	[testStringBbMinor7 autorelease];
	[testStringBMinor7 autorelease];
	
	// *********** AUGMENTED 7 TEST STRING RELEASE **********************
	[testStringCAugmented7 autorelease];
	[testStringCSharpAugmented7 autorelease];
	[testStringDbAugmented7 autorelease];
	[testStringDAugmented7 autorelease];
	[testStringDSharpAugmented7 autorelease];
	[testStringEbAugmented7 autorelease];
	[testStringEAugmented7 autorelease];
	[testStringFAugmented7 autorelease];
	[testStringFSharpAugmented7 autorelease];
	[testStringGbAugmented7 autorelease];
	[testStringGAugmented7 autorelease];
	[testStringGSharpAugmented7 autorelease];
	[testStringAbAugmented7 autorelease];
	[testStringAAugmented7 autorelease];
	[testStringASharpAugmented7 autorelease];
	[testStringBbAugmented7 autorelease];
	[testStringBAugmented7 autorelease];
	
	// *********** DIMINISHED7 TEST STRING RELEASE ***********
	[testStringCDiminished7 autorelease];
	[testStringCSharpDiminished7 autorelease];
	[testStringDbDiminished7 autorelease];
	[testStringDDiminished7 autorelease];
	[testStringDSharpDiminished7 autorelease];
	[testStringEbDiminished7 autorelease];
	[testStringEDiminished7 autorelease];
	[testStringFDiminished7 autorelease];
	[testStringFSharpDiminished7 autorelease];
	[testStringGbDiminished7 autorelease];
	[testStringGDiminished7 autorelease];
	[testStringGSharpDiminished7 autorelease];
	[testStringAbDiminished7 autorelease];
	[testStringADiminished7 autorelease];
	[testStringASharpDiminished7 autorelease];
	[testStringBbDiminished7 autorelease];
	[testStringBDiminished7 autorelease];
	
	// *********** HalfDiminished7 TEST STRING RELEASE ***********
	[testStringCHalfDiminished7 autorelease];
	[testStringCSharpHalfDiminished7 autorelease];
	[testStringDbHalfDiminished7 autorelease];
	[testStringDHalfDiminished7 autorelease];
	[testStringDSharpHalfDiminished7 autorelease];
	[testStringEbHalfDiminished7 autorelease];
	[testStringEHalfDiminished7 autorelease];
	[testStringFHalfDiminished7 autorelease];
	[testStringFSharpHalfDiminished7 autorelease];
	[testStringGbHalfDiminished7 autorelease];
	[testStringGHalfDiminished7 autorelease];
	[testStringGSharpHalfDiminished7 autorelease];
	[testStringAbHalfDiminished7 autorelease];
	[testStringAHalfDiminished7 autorelease];
	[testStringASharpHalfDiminished7 autorelease];
	[testStringBbHalfDiminished7 autorelease];
	[testStringBHalfDiminished7 autorelease];
	
	// *********** Dominant7 TEST STRING RELEASE **********************
	[testStringCDominant7 autorelease];
	[testStringCSharpDominant7 autorelease];
	[testStringDbDominant7 autorelease];
	[testStringDDominant7 autorelease];
	[testStringDSharpDominant7 autorelease];
	[testStringEbDominant7 autorelease];
	[testStringEDominant7 autorelease];
	[testStringFDominant7 autorelease];
	[testStringFSharpDominant7 autorelease];
	[testStringGbDominant7 autorelease];
	[testStringGDominant7 autorelease];
	[testStringGSharpDominant7 autorelease];
	[testStringAbDominant7 autorelease];
	[testStringADominant7 autorelease];
	[testStringASharpDominant7 autorelease];
	[testStringBbDominant7 autorelease];
	[testStringBDominant7 autorelease];	
		
	// *********** Major6_5 TEST STRING RELEASE **********************
	[testStringCMajor6_5 autorelease];
	[testStringCSharpMajor6_5 autorelease];
	[testStringDbMajor6_5 autorelease];
	[testStringDMajor6_5 autorelease];
	[testStringDSharpMajor6_5 autorelease];
	[testStringEbMajor6_5 autorelease];
	[testStringEMajor6_5 autorelease];
	[testStringFMajor6_5 autorelease];
	[testStringFSharpMajor6_5 autorelease];
	[testStringGbMajor6_5 autorelease];
	[testStringGMajor6_5 autorelease];
	[testStringGSharpMajor6_5 autorelease];
	[testStringAbMajor6_5 autorelease];
	[testStringAMajor6_5 autorelease];
	[testStringASharpMajor6_5 autorelease];
	[testStringBbMajor6_5 autorelease];
	[testStringBMajor6_5 autorelease];
	
	// *********** Minor6_5 TEST STRING RELEASE **********************
	[testStringCMinor6_5 autorelease];
	[testStringCSharpMinor6_5 autorelease];
	[testStringDbMinor6_5 autorelease];
	[testStringDMinor6_5 autorelease];
	[testStringDSharpMinor6_5 autorelease];
	[testStringEbMinor6_5 autorelease];
	[testStringEMinor6_5 autorelease];
	[testStringFMinor6_5 autorelease];
	[testStringFSharpMinor6_5 autorelease];
	[testStringGbMinor6_5 autorelease];
	[testStringGMinor6_5 autorelease];
	[testStringGSharpMinor6_5 autorelease];
	[testStringAbMinor6_5 autorelease];
	[testStringAMinor6_5 autorelease];
	[testStringASharpMinor6_5 autorelease];
	[testStringBbMinor6_5 autorelease];
	[testStringBMinor6_5 autorelease];
	
	// *********** AUGMENTED 6-5 TEST STRING RELEASE **********************
	[testStringCAugmented6_5 autorelease];
	[testStringCSharpAugmented6_5 autorelease];
	[testStringDbAugmented6_5 autorelease];
	[testStringDAugmented6_5 autorelease];
	[testStringDSharpAugmented6_5 autorelease];
	[testStringEbAugmented6_5 autorelease];
	[testStringEAugmented6_5 autorelease];
	[testStringFAugmented6_5 autorelease];
	[testStringFSharpAugmented6_5 autorelease];
	[testStringGbAugmented6_5 autorelease];
	[testStringGAugmented6_5 autorelease];
	[testStringGSharpAugmented6_5 autorelease];
	[testStringAbAugmented6_5 autorelease];
	[testStringAAugmented6_5 autorelease];
	[testStringASharpAugmented6_5 autorelease];
	[testStringBbAugmented6_5 autorelease];
	[testStringBAugmented6_5 autorelease];
	
	// *********** Dominant6_5 TEST STRING RELEASE **********************
	[testStringCDominant6_5 autorelease];
	[testStringCSharpDominant6_5 autorelease];
	[testStringDbDominant6_5 autorelease];
	[testStringDDominant6_5 autorelease];
	[testStringDSharpDominant6_5 autorelease];
	[testStringEbDominant6_5 autorelease];
	[testStringEDominant6_5 autorelease];
	[testStringFDominant6_5 autorelease];
	[testStringFSharpDominant6_5 autorelease];
	[testStringGbDominant6_5 autorelease];
	[testStringGDominant6_5 autorelease];
	[testStringGSharpDominant6_5 autorelease];
	[testStringAbDominant6_5 autorelease];
	[testStringADominant6_5 autorelease];
	[testStringASharpDominant6_5 autorelease];
	[testStringBbDominant6_5 autorelease];
	[testStringBDominant6_5 autorelease];	
	
	// *********** DIMINISHED 6-5 TEST STRING RELEASE ***********
	[testStringCDiminished6_5 autorelease];
	[testStringCSharpDiminished6_5 autorelease];
	[testStringDbDiminished6_5 autorelease];
	[testStringDDiminished6_5 autorelease];
	[testStringDSharpDiminished6_5 autorelease];
	[testStringEbDiminished6_5 autorelease];
	[testStringEDiminished6_5 autorelease];
	[testStringFDiminished6_5 autorelease];
	[testStringFSharpDiminished6_5 autorelease];
	[testStringGbDiminished6_5 autorelease];
	[testStringGDiminished6_5 autorelease];
	[testStringGSharpDiminished6_5 autorelease];
	[testStringAbDiminished6_5 autorelease];
	[testStringADiminished6_5 autorelease];
	[testStringASharpDiminished6_5 autorelease];
	[testStringBbDiminished6_5 autorelease];
	[testStringBDiminished6_5 autorelease];
	
	// *********** HalfDiminished 6-5 TEST STRING RELEASE ***********
	[testStringCHalfDiminished6_5 autorelease];
	[testStringCSharpHalfDiminished6_5 autorelease];
	[testStringDbHalfDiminished6_5 autorelease];
	[testStringDHalfDiminished6_5 autorelease];
	[testStringDSharpHalfDiminished6_5 autorelease];
	[testStringEbHalfDiminished6_5 autorelease];
	[testStringEHalfDiminished6_5 autorelease];
	[testStringFHalfDiminished6_5 autorelease];
	[testStringFSharpHalfDiminished6_5 autorelease];
	[testStringGbHalfDiminished6_5 autorelease];
	[testStringGHalfDiminished6_5 autorelease];
	[testStringGSharpHalfDiminished6_5 autorelease];
	[testStringAbHalfDiminished6_5 autorelease];
	[testStringAHalfDiminished6_5 autorelease];
	[testStringASharpHalfDiminished6_5 autorelease];
	[testStringBbHalfDiminished6_5 autorelease];
	[testStringBHalfDiminished6_5 autorelease];
		
	// *********** Major4_3 TEST STRING RELEASE **********************
	[testStringCMajor4_3 autorelease];
	[testStringCSharpMajor4_3 autorelease];
	[testStringDbMajor4_3 autorelease];
	[testStringDMajor4_3 autorelease];
	[testStringDSharpMajor4_3 autorelease];
	[testStringEbMajor4_3 autorelease];
	[testStringEMajor4_3 autorelease];
	[testStringFMajor4_3 autorelease];
	[testStringFSharpMajor4_3 autorelease];
	[testStringGbMajor4_3 autorelease];
	[testStringGMajor4_3 autorelease];
	[testStringGSharpMajor4_3 autorelease];
	[testStringAbMajor4_3 autorelease];
	[testStringAMajor4_3 autorelease];
	[testStringASharpMajor4_3 autorelease];
	[testStringBbMajor4_3 autorelease];
	[testStringBMajor4_3 autorelease];
	
	// *********** Minor4_3 TEST STRING RELEASE **********************
	[testStringCMinor4_3 autorelease];
	[testStringCSharpMinor4_3 autorelease];
	[testStringDbMinor4_3 autorelease];
	[testStringDMinor4_3 autorelease];
	[testStringDSharpMinor4_3 autorelease];
	[testStringEbMinor4_3 autorelease];
	[testStringEMinor4_3 autorelease];
	[testStringFMinor4_3 autorelease];
	[testStringFSharpMinor4_3 autorelease];
	[testStringGbMinor4_3 autorelease];
	[testStringGMinor4_3 autorelease];
	[testStringGSharpMinor4_3 autorelease];
	[testStringAbMinor4_3 autorelease];
	[testStringAMinor4_3 autorelease];
	[testStringASharpMinor4_3 autorelease];
	[testStringBbMinor4_3 autorelease];
	[testStringBMinor4_3 autorelease];
	
	// *********** AUGMENTED 4-3 TEST STRING RELEASE **********************
	[testStringCAugmented4_3 autorelease];
	[testStringCSharpAugmented4_3 autorelease];
	[testStringDbAugmented4_3 autorelease];
	[testStringDAugmented4_3 autorelease];
	[testStringDSharpAugmented4_3 autorelease];
	[testStringEbAugmented4_3 autorelease];
	[testStringEAugmented4_3 autorelease];
	[testStringFAugmented4_3 autorelease];
	[testStringFSharpAugmented4_3 autorelease];
	[testStringGbAugmented4_3 autorelease];
	[testStringGAugmented4_3 autorelease];
	[testStringGSharpAugmented4_3 autorelease];
	[testStringAbAugmented4_3 autorelease];
	[testStringAAugmented4_3 autorelease];
	[testStringASharpAugmented4_3 autorelease];
	[testStringBbAugmented4_3 autorelease];
	[testStringBAugmented4_3 autorelease];
	
	// *********** DIMINISHED 4-3 TEST STRING RELEASE ***********
	[testStringCDiminished4_3 autorelease];
	[testStringCSharpDiminished4_3 autorelease];
	[testStringDbDiminished4_3 autorelease];
	[testStringDDiminished4_3 autorelease];
	[testStringDSharpDiminished4_3 autorelease];
	[testStringEbDiminished4_3 autorelease];
	[testStringEDiminished4_3 autorelease];
	[testStringFDiminished4_3 autorelease];
	[testStringFSharpDiminished4_3 autorelease];
	[testStringGbDiminished4_3 autorelease];
	[testStringGDiminished4_3 autorelease];
	[testStringGSharpDiminished4_3 autorelease];
	[testStringAbDiminished4_3 autorelease];
	[testStringADiminished4_3 autorelease];
	[testStringASharpDiminished4_3 autorelease];
	[testStringBbDiminished4_3 autorelease];
	[testStringBDiminished4_3 autorelease];
	
	// *********** Dominant4_3 TEST STRING RELEASE **********************
	[testStringCDominant4_3 autorelease];
	[testStringCSharpDominant4_3 autorelease];
	[testStringDbDominant4_3 autorelease];
	[testStringDDominant4_3 autorelease];
	[testStringDSharpDominant4_3 autorelease];
	[testStringEbDominant4_3 autorelease];
	[testStringEDominant4_3 autorelease];
	[testStringFDominant4_3 autorelease];
	[testStringFSharpDominant4_3 autorelease];
	[testStringGbDominant4_3 autorelease];
	[testStringGDominant4_3 autorelease];
	[testStringGSharpDominant4_3 autorelease];
	[testStringAbDominant4_3 autorelease];
	[testStringADominant4_3 autorelease];
	[testStringASharpDominant4_3 autorelease];
	[testStringBbDominant4_3 autorelease];
	[testStringBDominant4_3 autorelease];	
	
	// *********** HalfDiminished 4-3 TEST STRING RELEASE ***********
	[testStringCHalfDiminished4_3 autorelease];
	[testStringCSharpHalfDiminished4_3 autorelease];
	[testStringDbHalfDiminished4_3 autorelease];
	[testStringDHalfDiminished4_3 autorelease];
	[testStringDSharpHalfDiminished4_3 autorelease];
	[testStringEbHalfDiminished4_3 autorelease];
	[testStringEHalfDiminished4_3 autorelease];
	[testStringFHalfDiminished4_3 autorelease];
	[testStringFSharpHalfDiminished4_3 autorelease];
	[testStringGbHalfDiminished4_3 autorelease];
	[testStringGHalfDiminished4_3 autorelease];
	[testStringGSharpHalfDiminished4_3 autorelease];
	[testStringAbHalfDiminished4_3 autorelease];
	[testStringAHalfDiminished4_3 autorelease];
	[testStringASharpHalfDiminished4_3 autorelease];
	[testStringBbHalfDiminished4_3 autorelease];
	[testStringBHalfDiminished4_3 autorelease];
	
	// *********** Major4_2 TEST STRING RELEASE **********************
	[testStringCMajor4_2 autorelease];
	[testStringCSharpMajor4_2 autorelease];
	[testStringDbMajor4_2 autorelease];
	[testStringDMajor4_2 autorelease];
	[testStringDSharpMajor4_2 autorelease];
	[testStringEbMajor4_2 autorelease];
	[testStringEMajor4_2 autorelease];
	[testStringFMajor4_2 autorelease];
	[testStringFSharpMajor4_2 autorelease];
	[testStringGbMajor4_2 autorelease];
	[testStringGMajor4_2 autorelease];
	[testStringGSharpMajor4_2 autorelease];
	[testStringAbMajor4_2 autorelease];
	[testStringAMajor4_2 autorelease];
	[testStringASharpMajor4_2 autorelease];
	[testStringBbMajor4_2 autorelease];
	[testStringBMajor4_2 autorelease];
	
	// *********** Minor4_2 TEST STRING RELEASE **********************
	[testStringCMinor4_2 autorelease];
	[testStringCSharpMinor4_2 autorelease];
	[testStringDbMinor4_2 autorelease];
	[testStringDMinor4_2 autorelease];
	[testStringDSharpMinor4_2 autorelease];
	[testStringEbMinor4_2 autorelease];
	[testStringEMinor4_2 autorelease];
	[testStringFMinor4_2 autorelease];
	[testStringFSharpMinor4_2 autorelease];
	[testStringGbMinor4_2 autorelease];
	[testStringGMinor4_2 autorelease];
	[testStringGSharpMinor4_2 autorelease];
	[testStringAbMinor4_2 autorelease];
	[testStringAMinor4_2 autorelease];
	[testStringASharpMinor4_2 autorelease];
	[testStringBbMinor4_2 autorelease];
	[testStringBMinor4_2 autorelease];
	
	// *********** Dominant4_2 TEST STRING RELEASE **********************
	[testStringCDominant4_2 autorelease];
	[testStringCSharpDominant4_2 autorelease];
	[testStringDbDominant4_2 autorelease];
	[testStringDDominant4_2 autorelease];
	[testStringDSharpDominant4_2 autorelease];
	[testStringEbDominant4_2 autorelease];
	[testStringEDominant4_2 autorelease];
	[testStringFDominant4_2 autorelease];
	[testStringFSharpDominant4_2 autorelease];
	[testStringGbDominant4_2 autorelease];
	[testStringGDominant4_2 autorelease];
	[testStringGSharpDominant4_2 autorelease];
	[testStringAbDominant4_2 autorelease];
	[testStringADominant4_2 autorelease];
	[testStringASharpDominant4_2 autorelease];
	[testStringBbDominant4_2 autorelease];
	[testStringBDominant4_2 autorelease];	
	
	// *********** AUGMENTED 4-2 TEST STRING RELEASE **********************
	[testStringCAugmented4_2 autorelease];
	[testStringCSharpAugmented4_2 autorelease];
	[testStringDbAugmented4_2 autorelease];
	[testStringDAugmented4_2 autorelease];
	[testStringDSharpAugmented4_2 autorelease];
	[testStringEbAugmented4_2 autorelease];
	[testStringEAugmented4_2 autorelease];
	[testStringFAugmented4_2 autorelease];
	[testStringFSharpAugmented4_2 autorelease];
	[testStringGbAugmented4_2 autorelease];
	[testStringGAugmented4_2 autorelease];
	[testStringGSharpAugmented4_2 autorelease];
	[testStringAbAugmented4_2 autorelease];
	[testStringAAugmented4_2 autorelease];
	[testStringASharpAugmented4_2 autorelease];
	[testStringBbAugmented4_2 autorelease];
	[testStringBAugmented4_2 autorelease];
	
	// *********** DIMINISHED 4-2 TEST STRING RELEASE ***********
	[testStringCDiminished4_2 autorelease];
	[testStringCSharpDiminished4_2 autorelease];
	[testStringDbDiminished4_2 autorelease];
	[testStringDDiminished4_2 autorelease];
	[testStringDSharpDiminished4_2 autorelease];
	[testStringEbDiminished4_2 autorelease];
	[testStringEDiminished4_2 autorelease];
	[testStringFDiminished4_2 autorelease];
	[testStringFSharpDiminished4_2 autorelease];
	[testStringGbDiminished4_2 autorelease];
	[testStringGDiminished4_2 autorelease];
	[testStringGSharpDiminished4_2 autorelease];
	[testStringAbDiminished4_2 autorelease];
	[testStringADiminished4_2 autorelease];
	[testStringASharpDiminished4_2 autorelease];
	[testStringBbDiminished4_2 autorelease];
	[testStringBDiminished4_2 autorelease];
	
	// *********** HalfDiminished 4-2 TEST STRING RELEASE ***********
	[testStringCHalfDiminished4_2 autorelease];
	[testStringCSharpHalfDiminished4_2 autorelease];
	[testStringDbHalfDiminished4_2 autorelease];
	[testStringDHalfDiminished4_2 autorelease];
	[testStringDSharpHalfDiminished4_2 autorelease];
	[testStringEbHalfDiminished4_2 autorelease];
	[testStringEHalfDiminished4_2 autorelease];
	[testStringFHalfDiminished4_2 autorelease];
	[testStringFSharpHalfDiminished4_2 autorelease];
	[testStringGbHalfDiminished4_2 autorelease];
	[testStringGHalfDiminished4_2 autorelease];
	[testStringGSharpHalfDiminished4_2 autorelease];
	[testStringAbHalfDiminished4_2 autorelease];
	[testStringAHalfDiminished4_2 autorelease];
	[testStringASharpHalfDiminished4_2 autorelease];
	[testStringBbHalfDiminished4_2 autorelease];
	[testStringBHalfDiminished4_2 autorelease];	
		
	// ********************************************************
	// ^*^^^^^^*^*^^*^*^*^*^^^^^*^*^^*^*^*^*^^*^*^*^^*^*^*^*^^^^^*^*^
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
	if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
		// Initialization code
	}
	return self;
}

// picker arrays
- (void)viewDidLoad {
	NSArray *qualityArray = [[NSArray alloc] initWithObjects:@"Major", @"Minor", @"Augmented", @"Diminished", @"Half-Diminished", @"Dominant", @"Italian +6", @"French +6", @"German +6", nil];
	self.chordTypes = qualityArray;
	[qualityArray release];
	
	NSArray *rootArray = [[NSArray alloc] initWithObjects:@"C", @"C♯", @"D♭", @"D", @"D♯", @"E♭", @"E", @"F", @"F♯", @"G♭", @"G", @"G♯", @"A♭", @"A", @"A♯", @"B♭", @"B", nil];
	self.chordRoot = rootArray;
	[rootArray release];
	
	NSArray *inversionArray = [[NSArray alloc] initWithObjects:@"5", @"6", @"6-4", @"7", @"6-5", @"4-3", @"4-2", nil];
	self.inversionTypes = inversionArray;
	[inversionArray release];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	// Return YES for supported orientations
	return (interfaceOrientation == UIInterfaceOrientationPortrait);
	return NO;
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning]; // Releases the view if it doesn't have a superview
	// Release anything that's not essential, such as cached data
}

// clean-up
- (void)dealloc {
	[doublePicker release];
	[chordTypes release];
	[chordRoot release];
	[inversionTypes release];
	[super dealloc];
}

#pragma mark -
#pragma mark Picker Data Source Methods
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
	return 3;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
	if (component == kChordComponent)
		return [self.chordTypes count];
	if (component == kRootComponent)
		return [self.chordRoot count];
	return [self.inversionTypes count];
}

#pragma mark Picker Delegate Methods
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
	if (component == kChordComponent)
		return [self.chordTypes objectAtIndex:row];
	if (component == kRootComponent)
		return [self.chordRoot objectAtIndex:row];
	return [self.inversionTypes objectAtIndex:row];
}

@end
