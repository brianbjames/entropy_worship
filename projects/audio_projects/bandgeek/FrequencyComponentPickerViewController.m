//
//  FrequencyComponentPickerViewController.m
//  Harmony
//
//  Created by Brian B. James on 5/24/09.
//  Copyright Brian B. James 2009. All rights reserved.
//

#import "FrequencyComponentPickerViewController.h"

@implementation FrequencyComponentPickerViewController

@synthesize doublePicker;
@synthesize chordTypes;
@synthesize chordRoot;
@synthesize label;
@synthesize inversionTypes;

- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
	if (component == kRootComponent)
		return 55;
	if (component == kChordComponent)
		return 65;
	return 180;
	/*
	if (component == kRootComponent)
		return 90;
	return 210;*/
}

// didSelectRow
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
	NSInteger chordRow = [doublePicker selectedRowInComponent:kChordComponent];
	NSInteger rootRow = [doublePicker selectedRowInComponent:kRootComponent];
	NSInteger inversionRow = [doublePicker selectedRowInComponent:kInversionComponent];
	
	NSString *chord = [self.chordTypes objectAtIndex:chordRow];
	NSString *theRoot = [self.chordRoot objectAtIndex:rootRow];
	NSString *theInversion = [self.inversionTypes objectAtIndex:inversionRow];
	
	// THE MESSAGE FROM THE PICKER
	NSMutableString *messageFromPicker = [[NSMutableString alloc] initWithFormat:@"%@ %@ %@", theRoot, chord, theInversion];
	
	// *********** -1 Frequency TEST STRINGS **********************
	NSString *testStringC_1Frequency = @"C -1 Frequency";
	NSString *testStringCSharp_1Frequency = @"C♯ -1 Frequency";
	NSString *testStringDb_1Frequency = @"D♭ -1 Frequency";
	NSString *testStringD_1Frequency = @"D -1 Frequency";
	NSString *testStringDSharp_1Frequency = @"D♯ -1 Frequency";
	NSString *testStringEb_1Frequency = @"E♭ -1 Frequency";
	NSString *testStringE_1Frequency = @"E -1 Frequency";
	NSString *testStringF_1Frequency = @"F -1 Frequency";
	NSString *testStringFSharp_1Frequency = @"F♯ -1 Frequency";
	NSString *testStringGb_1Frequency = @"G♭ -1 Frequency";
	NSString *testStringG_1Frequency = @"G -1 Frequency";
	NSString *testStringGSharp_1Frequency = @"G♯ -1 Frequency";
	NSString *testStringAb_1Frequency = @"A♭ -1 Frequency";
	NSString *testStringA_1Frequency = @"A -1 Frequency";
	NSString *testStringASharp_1Frequency = @"A♯ -1 Frequency";
	NSString *testStringBb_1Frequency = @"B♭ -1 Frequency";
	NSString *testStringB_1Frequency = @"B -1 Frequency";	
	
	// *********** 0 Frequency TEST STRINGS **********************
	NSString *testStringC0Frequency = @"C 0 Frequency";
	NSString *testStringCSharp0Frequency = @"C♯ 0 Frequency";
	NSString *testStringDb0Frequency = @"D♭ 0 Frequency";
	NSString *testStringD0Frequency = @"D 0 Frequency";
	NSString *testStringDSharp0Frequency = @"D♯ 0 Frequency";
	NSString *testStringEb0Frequency = @"E♭ 0 Frequency";
	NSString *testStringE0Frequency = @"E 0 Frequency";
	NSString *testStringF0Frequency = @"F 0 Frequency";
	NSString *testStringFSharp0Frequency = @"F♯ 0 Frequency";
	NSString *testStringGb0Frequency = @"G♭ 0 Frequency";
	NSString *testStringG0Frequency = @"G 0 Frequency";
	NSString *testStringGSharp0Frequency = @"G♯ 0 Frequency";
	NSString *testStringAb0Frequency = @"A♭ 0 Frequency";
	NSString *testStringA0Frequency = @"A 0 Frequency";
	NSString *testStringASharp0Frequency = @"A♯ 0 Frequency";
	NSString *testStringBb0Frequency = @"B♭ 0 Frequency";
	NSString *testStringB0Frequency = @"B 0 Frequency";
	
	// *********** 1 Frequency TEST STRINGS **********************
	NSString *testStringC1Frequency = @"C 1 Frequency";
	NSString *testStringCSharp1Frequency = @"C♯ 1 Frequency";
	NSString *testStringDb1Frequency = @"D♭ 1 Frequency";
	NSString *testStringD1Frequency = @"D 1 Frequency";
	NSString *testStringDSharp1Frequency = @"D♯ 1 Frequency";
	NSString *testStringEb1Frequency = @"E♭ 1 Frequency";
	NSString *testStringE1Frequency = @"E 1 Frequency";
	NSString *testStringF1Frequency = @"F 1 Frequency";
	NSString *testStringFSharp1Frequency = @"F♯ 1 Frequency";
	NSString *testStringGb1Frequency = @"G♭ 1 Frequency";
	NSString *testStringG1Frequency = @"G 1 Frequency";
	NSString *testStringGSharp1Frequency = @"G♯ 1 Frequency";
	NSString *testStringAb1Frequency = @"A♭ 1 Frequency";
	NSString *testStringA1Frequency = @"A 1 Frequency";
	NSString *testStringASharp1Frequency = @"A♯ 1 Frequency";
	NSString *testStringBb1Frequency = @"B♭ 1 Frequency";
	NSString *testStringB1Frequency = @"B 1 Frequency";
	
	// *********** 2 Frequency TEST STRINGS **********************
	NSString *testStringC2Frequency = @"C 2 Frequency";
	NSString *testStringCSharp2Frequency = @"C♯ 2 Frequency";
	NSString *testStringDb2Frequency = @"D♭ 2 Frequency";
	NSString *testStringD2Frequency = @"D 2 Frequency";
	NSString *testStringDSharp2Frequency = @"D♯ 2 Frequency";
	NSString *testStringEb2Frequency = @"E♭ 2 Frequency";
	NSString *testStringE2Frequency = @"E 2 Frequency";
	NSString *testStringF2Frequency = @"F 2 Frequency";
	NSString *testStringFSharp2Frequency = @"F♯ 2 Frequency";
	NSString *testStringGb2Frequency = @"G♭ 2 Frequency";
	NSString *testStringG2Frequency = @"G 2 Frequency";
	NSString *testStringGSharp2Frequency = @"G♯ 2 Frequency";
	NSString *testStringAb2Frequency = @"A♭ 2 Frequency";
	NSString *testStringA2Frequency = @"A 2 Frequency";
	NSString *testStringASharp2Frequency = @"A♯ 2 Frequency";
	NSString *testStringBb2Frequency = @"B♭ 2 Frequency";
	NSString *testStringB2Frequency = @"B 2 Frequency";
	
	// *********** 3 Frequency TEST STRINGS **********************
	NSString *testStringC3Frequency = @"C 3 Frequency";
	NSString *testStringCSharp3Frequency = @"C♯ 3 Frequency";
	NSString *testStringDb3Frequency = @"D♭ 3 Frequency";
	NSString *testStringD3Frequency = @"D 3 Frequency";
	NSString *testStringDSharp3Frequency = @"D♯ 3 Frequency";
	NSString *testStringEb3Frequency = @"E♭ 3 Frequency";
	NSString *testStringE3Frequency = @"E 3 Frequency";
	NSString *testStringF3Frequency = @"F 3 Frequency";
	NSString *testStringFSharp3Frequency = @"F♯ 3 Frequency";
	NSString *testStringGb3Frequency = @"G♭ 3 Frequency";
	NSString *testStringG3Frequency = @"G 3 Frequency";
	NSString *testStringGSharp3Frequency = @"G♯ 3 Frequency";
	NSString *testStringAb3Frequency = @"A♭ 3 Frequency";
	NSString *testStringA3Frequency = @"A 3 Frequency";
	NSString *testStringASharp3Frequency = @"A♯ 3 Frequency";
	NSString *testStringBb3Frequency = @"B♭ 3 Frequency";
	NSString *testStringB3Frequency = @"B 3 Frequency";
	
	// *********** 4 Frequency TEST STRINGS **********************
	NSString *testStringC4Frequency = @"C 4 Frequency";
	NSString *testStringCSharp4Frequency = @"C♯ 4 Frequency";
	NSString *testStringDb4Frequency = @"D♭ 4 Frequency";
	NSString *testStringD4Frequency = @"D 4 Frequency";
	NSString *testStringDSharp4Frequency = @"D♯ 4 Frequency";
	NSString *testStringEb4Frequency = @"E♭ 4 Frequency";
	NSString *testStringE4Frequency = @"E 4 Frequency";
	NSString *testStringF4Frequency = @"F 4 Frequency";
	NSString *testStringFSharp4Frequency = @"F♯ 4 Frequency";
	NSString *testStringGb4Frequency = @"G♭ 4 Frequency";
	NSString *testStringG4Frequency = @"G 4 Frequency";
	NSString *testStringGSharp4Frequency = @"G♯ 4 Frequency";
	NSString *testStringAb4Frequency = @"A♭ 4 Frequency";
	NSString *testStringA4Frequency = @"A 4 Frequency";
	NSString *testStringASharp4Frequency = @"A♯ 4 Frequency";
	NSString *testStringBb4Frequency = @"B♭ 4 Frequency";
	NSString *testStringB4Frequency = @"B 4 Frequency";
	
	// *********** 5 Frequency TEST STRINGS **********************
	NSString *testStringC5Frequency = @"C 5 Frequency";
	NSString *testStringCSharp5Frequency = @"C♯ 5 Frequency";
	NSString *testStringDb5Frequency = @"D♭ 5 Frequency";
	NSString *testStringD5Frequency = @"D 5 Frequency";
	NSString *testStringDSharp5Frequency = @"D♯ 5 Frequency";
	NSString *testStringEb5Frequency = @"E♭ 5 Frequency";
	NSString *testStringE5Frequency = @"E 5 Frequency";
	NSString *testStringF5Frequency = @"F 5 Frequency";
	NSString *testStringFSharp5Frequency = @"F♯ 5 Frequency";
	NSString *testStringGb5Frequency = @"G♭ 5 Frequency";
	NSString *testStringG5Frequency = @"G 5 Frequency";
	NSString *testStringGSharp5Frequency = @"G♯ 5 Frequency";
	NSString *testStringAb5Frequency = @"A♭ 5 Frequency";
	NSString *testStringA5Frequency = @"A 5 Frequency";
	NSString *testStringASharp5Frequency = @"A♯ 5 Frequency";
	NSString *testStringBb5Frequency = @"B♭ 5 Frequency";
	NSString *testStringB5Frequency = @"B 5 Frequency";
	
	// *********** 6 Frequency TEST STRINGS **********************
	NSString *testStringC6Frequency = @"C 6 Frequency";
	NSString *testStringCSharp6Frequency = @"C♯ 6 Frequency";
	NSString *testStringDb6Frequency = @"D♭ 6 Frequency";
	NSString *testStringD6Frequency = @"D 6 Frequency";
	NSString *testStringDSharp6Frequency = @"D♯ 6 Frequency";
	NSString *testStringEb6Frequency = @"E♭ 6 Frequency";
	NSString *testStringE6Frequency = @"E 6 Frequency";
	NSString *testStringF6Frequency = @"F 6 Frequency";
	NSString *testStringFSharp6Frequency = @"F♯ 6 Frequency";
	NSString *testStringGb6Frequency = @"G♭ 6 Frequency";
	NSString *testStringG6Frequency = @"G 6 Frequency";
	NSString *testStringGSharp6Frequency = @"G♯ 6 Frequency";
	NSString *testStringAb6Frequency = @"A♭ 6 Frequency";
	NSString *testStringA6Frequency = @"A 6 Frequency";
	NSString *testStringASharp6Frequency = @"A♯ 6 Frequency";
	NSString *testStringBb6Frequency = @"B♭ 6 Frequency";
	NSString *testStringB6Frequency = @"B 6 Frequency";
	
	// *********** 7 Frequency TEST STRINGS **********************
	NSString *testStringC7Frequency = @"C 7 Frequency";
	NSString *testStringCSharp7Frequency = @"C♯ 7 Frequency";
	NSString *testStringDb7Frequency = @"D♭ 7 Frequency";
	NSString *testStringD7Frequency = @"D 7 Frequency";
	NSString *testStringDSharp7Frequency = @"D♯ 7 Frequency";
	NSString *testStringEb7Frequency = @"E♭ 7 Frequency";
	NSString *testStringE7Frequency = @"E 7 Frequency";
	NSString *testStringF7Frequency = @"F 7 Frequency";
	NSString *testStringFSharp7Frequency = @"F♯ 7 Frequency";
	NSString *testStringGb7Frequency = @"G♭ 7 Frequency";
	NSString *testStringG7Frequency = @"G 7 Frequency";
	NSString *testStringGSharp7Frequency = @"G♯ 7 Frequency";
	NSString *testStringAb7Frequency = @"A♭ 7 Frequency";
	NSString *testStringA7Frequency = @"A 7 Frequency";
	NSString *testStringASharp7Frequency = @"A♯ 7 Frequency";
	NSString *testStringBb7Frequency = @"B♭ 7 Frequency";
	NSString *testStringB7Frequency = @"B 7 Frequency";
	
	// *********** 8 Frequency TEST STRINGS **********************
	NSString *testStringC8Frequency = @"C 8 Frequency";
	NSString *testStringCSharp8Frequency = @"C♯ 8 Frequency";
	NSString *testStringDb8Frequency = @"D♭ 8 Frequency";
	NSString *testStringD8Frequency = @"D 8 Frequency";
	NSString *testStringDSharp8Frequency = @"D♯ 8 Frequency";
	NSString *testStringEb8Frequency = @"E♭ 8 Frequency";
	NSString *testStringE8Frequency = @"E 8 Frequency";
	NSString *testStringF8Frequency = @"F 8 Frequency";
	NSString *testStringFSharp8Frequency = @"F♯ 8 Frequency";
	NSString *testStringGb8Frequency = @"G♭ 8 Frequency";
	NSString *testStringG8Frequency = @"G 8 Frequency";
	NSString *testStringGSharp8Frequency = @"G♯ 8 Frequency";
	NSString *testStringAb8Frequency = @"A♭ 8 Frequency";
	NSString *testStringA8Frequency = @"A 8 Frequency";
	NSString *testStringASharp8Frequency = @"A♯ 8 Frequency";
	NSString *testStringBb8Frequency = @"B♭ 8 Frequency";
	NSString *testStringB8Frequency = @"B 8 Frequency";
	
	// *********** 9 Frequency TEST STRINGS **********************
	NSString *testStringC9Frequency = @"C 9 Frequency";
	NSString *testStringCSharp9Frequency = @"C♯ 9 Frequency";
	NSString *testStringDb9Frequency = @"D♭ 9 Frequency";
	NSString *testStringD9Frequency = @"D 9 Frequency";
	NSString *testStringDSharp9Frequency = @"D♯ 9 Frequency";
	NSString *testStringEb9Frequency = @"E♭ 9 Frequency";
	NSString *testStringE9Frequency = @"E 9 Frequency";
	NSString *testStringF9Frequency = @"F 9 Frequency";
	NSString *testStringFSharp9Frequency = @"F♯ 9 Frequency";
	NSString *testStringGb9Frequency = @"G♭ 9 Frequency";
	NSString *testStringG9Frequency = @"G 9 Frequency";
	NSString *testStringGSharp9Frequency = @"G♯ 9 Frequency";
	NSString *testStringAb9Frequency = @"A♭ 9 Frequency";
	NSString *testStringA9Frequency = @"A 9 Frequency";
	NSString *testStringASharp9Frequency = @"A♯ 9 Frequency";
	NSString *testStringBb9Frequency = @"B♭ 9 Frequency";
	NSString *testStringB9Frequency = @"B 9 Frequency";	
		
	// *********** -1 MIDI TEST STRINGS **********************
	NSString *testStringC_1MIDI = @"C -1 MIDI";
	NSString *testStringCSharp_1MIDI = @"C♯ -1 MIDI";
	NSString *testStringDb_1MIDI = @"D♭ -1 MIDI";
	NSString *testStringD_1MIDI = @"D -1 MIDI";
	NSString *testStringDSharp_1MIDI = @"D♯ -1 MIDI";
	NSString *testStringEb_1MIDI = @"E♭ -1 MIDI";
	NSString *testStringE_1MIDI = @"E -1 MIDI";
	NSString *testStringF_1MIDI = @"F -1 MIDI";
	NSString *testStringFSharp_1MIDI = @"F♯ -1 MIDI";
	NSString *testStringGb_1MIDI = @"G♭ -1 MIDI";
	NSString *testStringG_1MIDI = @"G -1 MIDI";
	NSString *testStringGSharp_1MIDI = @"G♯ -1 MIDI";
	NSString *testStringAb_1MIDI = @"A♭ -1 MIDI";
	NSString *testStringA_1MIDI = @"A -1 MIDI";
	NSString *testStringASharp_1MIDI = @"A♯ -1 MIDI";
	NSString *testStringBb_1MIDI = @"B♭ -1 MIDI";
	NSString *testStringB_1MIDI = @"B -1 MIDI";	
	
	// *********** 0 MIDI TEST STRINGS **********************
	NSString *testStringC0MIDI = @"C 0 MIDI";
	NSString *testStringCSharp0MIDI = @"C♯ 0 MIDI";
	NSString *testStringDb0MIDI = @"D♭ 0 MIDI";
	NSString *testStringD0MIDI = @"D 0 MIDI";
	NSString *testStringDSharp0MIDI = @"D♯ 0 MIDI";
	NSString *testStringEb0MIDI = @"E♭ 0 MIDI";
	NSString *testStringE0MIDI = @"E 0 MIDI";
	NSString *testStringF0MIDI = @"F 0 MIDI";
	NSString *testStringFSharp0MIDI = @"F♯ 0 MIDI";
	NSString *testStringGb0MIDI = @"G♭ 0 MIDI";
	NSString *testStringG0MIDI = @"G 0 MIDI";
	NSString *testStringGSharp0MIDI = @"G♯ 0 MIDI";
	NSString *testStringAb0MIDI = @"A♭ 0 MIDI";
	NSString *testStringA0MIDI = @"A 0 MIDI";
	NSString *testStringASharp0MIDI = @"A♯ 0 MIDI";
	NSString *testStringBb0MIDI = @"B♭ 0 MIDI";
	NSString *testStringB0MIDI = @"B 0 MIDI";
	
	// *********** 1 MIDI TEST STRINGS **********************
	NSString *testStringC1MIDI = @"C 1 MIDI";
	NSString *testStringCSharp1MIDI = @"C♯ 1 MIDI";
	NSString *testStringDb1MIDI = @"D♭ 1 MIDI";
	NSString *testStringD1MIDI = @"D 1 MIDI";
	NSString *testStringDSharp1MIDI = @"D♯ 1 MIDI";
	NSString *testStringEb1MIDI = @"E♭ 1 MIDI";
	NSString *testStringE1MIDI = @"E 1 MIDI";
	NSString *testStringF1MIDI = @"F 1 MIDI";
	NSString *testStringFSharp1MIDI = @"F♯ 1 MIDI";
	NSString *testStringGb1MIDI = @"G♭ 1 MIDI";
	NSString *testStringG1MIDI = @"G 1 MIDI";
	NSString *testStringGSharp1MIDI = @"G♯ 1 MIDI";
	NSString *testStringAb1MIDI = @"A♭ 1 MIDI";
	NSString *testStringA1MIDI = @"A 1 MIDI";
	NSString *testStringASharp1MIDI = @"A♯ 1 MIDI";
	NSString *testStringBb1MIDI = @"B♭ 1 MIDI";
	NSString *testStringB1MIDI = @"B 1 MIDI";
	
	// *********** 2 MIDI TEST STRINGS **********************
	NSString *testStringC2MIDI = @"C 2 MIDI";
	NSString *testStringCSharp2MIDI = @"C♯ 2 MIDI";
	NSString *testStringDb2MIDI = @"D♭ 2 MIDI";
	NSString *testStringD2MIDI = @"D 2 MIDI";
	NSString *testStringDSharp2MIDI = @"D♯ 2 MIDI";
	NSString *testStringEb2MIDI = @"E♭ 2 MIDI";
	NSString *testStringE2MIDI = @"E 2 MIDI";
	NSString *testStringF2MIDI = @"F 2 MIDI";
	NSString *testStringFSharp2MIDI = @"F♯ 2 MIDI";
	NSString *testStringGb2MIDI = @"G♭ 2 MIDI";
	NSString *testStringG2MIDI = @"G 2 MIDI";
	NSString *testStringGSharp2MIDI = @"G♯ 2 MIDI";
	NSString *testStringAb2MIDI = @"A♭ 2 MIDI";
	NSString *testStringA2MIDI = @"A 2 MIDI";
	NSString *testStringASharp2MIDI = @"A♯ 2 MIDI";
	NSString *testStringBb2MIDI = @"B♭ 2 MIDI";
	NSString *testStringB2MIDI = @"B 2 MIDI";
	
	// *********** 3 MIDI TEST STRINGS **********************
	NSString *testStringC3MIDI = @"C 3 MIDI";
	NSString *testStringCSharp3MIDI = @"C♯ 3 MIDI";
	NSString *testStringDb3MIDI = @"D♭ 3 MIDI";
	NSString *testStringD3MIDI = @"D 3 MIDI";
	NSString *testStringDSharp3MIDI = @"D♯ 3 MIDI";
	NSString *testStringEb3MIDI = @"E♭ 3 MIDI";
	NSString *testStringE3MIDI = @"E 3 MIDI";
	NSString *testStringF3MIDI = @"F 3 MIDI";
	NSString *testStringFSharp3MIDI = @"F♯ 3 MIDI";
	NSString *testStringGb3MIDI = @"G♭ 3 MIDI";
	NSString *testStringG3MIDI = @"G 3 MIDI";
	NSString *testStringGSharp3MIDI = @"G♯ 3 MIDI";
	NSString *testStringAb3MIDI = @"A♭ 3 MIDI";
	NSString *testStringA3MIDI = @"A 3 MIDI";
	NSString *testStringASharp3MIDI = @"A♯ 3 MIDI";
	NSString *testStringBb3MIDI = @"B♭ 3 MIDI";
	NSString *testStringB3MIDI = @"B 3 MIDI";
	
	// *********** 4 MIDI TEST STRINGS **********************
	NSString *testStringC4MIDI = @"C 4 MIDI";
	NSString *testStringCSharp4MIDI = @"C♯ 4 MIDI";
	NSString *testStringDb4MIDI = @"D♭ 4 MIDI";
	NSString *testStringD4MIDI = @"D 4 MIDI";
	NSString *testStringDSharp4MIDI = @"D♯ 4 MIDI";
	NSString *testStringEb4MIDI = @"E♭ 4 MIDI";
	NSString *testStringE4MIDI = @"E 4 MIDI";
	NSString *testStringF4MIDI = @"F 4 MIDI";
	NSString *testStringFSharp4MIDI = @"F♯ 4 MIDI";
	NSString *testStringGb4MIDI = @"G♭ 4 MIDI";
	NSString *testStringG4MIDI = @"G 4 MIDI";
	NSString *testStringGSharp4MIDI = @"G♯ 4 MIDI";
	NSString *testStringAb4MIDI = @"A♭ 4 MIDI";
	NSString *testStringA4MIDI = @"A 4 MIDI";
	NSString *testStringASharp4MIDI = @"A♯ 4 MIDI";
	NSString *testStringBb4MIDI = @"B♭ 4 MIDI";
	NSString *testStringB4MIDI = @"B 4 MIDI";
	
	// *********** 5 MIDI TEST STRINGS **********************
	NSString *testStringC5MIDI = @"C 5 MIDI";
	NSString *testStringCSharp5MIDI = @"C♯ 5 MIDI";
	NSString *testStringDb5MIDI = @"D♭ 5 MIDI";
	NSString *testStringD5MIDI = @"D 5 MIDI";
	NSString *testStringDSharp5MIDI = @"D♯ 5 MIDI";
	NSString *testStringEb5MIDI = @"E♭ 5 MIDI";
	NSString *testStringE5MIDI = @"E 5 MIDI";
	NSString *testStringF5MIDI = @"F 5 MIDI";
	NSString *testStringFSharp5MIDI = @"F♯ 5 MIDI";
	NSString *testStringGb5MIDI = @"G♭ 5 MIDI";
	NSString *testStringG5MIDI = @"G 5 MIDI";
	NSString *testStringGSharp5MIDI = @"G♯ 5 MIDI";
	NSString *testStringAb5MIDI = @"A♭ 5 MIDI";
	NSString *testStringA5MIDI = @"A 5 MIDI";
	NSString *testStringASharp5MIDI = @"A♯ 5 MIDI";
	NSString *testStringBb5MIDI = @"B♭ 5 MIDI";
	NSString *testStringB5MIDI = @"B 5 MIDI";
	
	// *********** 6 MIDI TEST STRINGS **********************
	NSString *testStringC6MIDI = @"C 6 MIDI";
	NSString *testStringCSharp6MIDI = @"C♯ 6 MIDI";
	NSString *testStringDb6MIDI = @"D♭ 6 MIDI";
	NSString *testStringD6MIDI = @"D 6 MIDI";
	NSString *testStringDSharp6MIDI = @"D♯ 6 MIDI";
	NSString *testStringEb6MIDI = @"E♭ 6 MIDI";
	NSString *testStringE6MIDI = @"E 6 MIDI";
	NSString *testStringF6MIDI = @"F 6 MIDI";
	NSString *testStringFSharp6MIDI = @"F♯ 6 MIDI";
	NSString *testStringGb6MIDI = @"G♭ 6 MIDI";
	NSString *testStringG6MIDI = @"G 6 MIDI";
	NSString *testStringGSharp6MIDI = @"G♯ 6 MIDI";
	NSString *testStringAb6MIDI = @"A♭ 6 MIDI";
	NSString *testStringA6MIDI = @"A 6 MIDI";
	NSString *testStringASharp6MIDI = @"A♯ 6 MIDI";
	NSString *testStringBb6MIDI = @"B♭ 6 MIDI";
	NSString *testStringB6MIDI = @"B 6 MIDI";
	
	// *********** 7 MIDI TEST STRINGS **********************
	NSString *testStringC7MIDI = @"C 7 MIDI";
	NSString *testStringCSharp7MIDI = @"C♯ 7 MIDI";
	NSString *testStringDb7MIDI = @"D♭ 7 MIDI";
	NSString *testStringD7MIDI = @"D 7 MIDI";
	NSString *testStringDSharp7MIDI = @"D♯ 7 MIDI";
	NSString *testStringEb7MIDI = @"E♭ 7 MIDI";
	NSString *testStringE7MIDI = @"E 7 MIDI";
	NSString *testStringF7MIDI = @"F 7 MIDI";
	NSString *testStringFSharp7MIDI = @"F♯ 7 MIDI";
	NSString *testStringGb7MIDI = @"G♭ 7 MIDI";
	NSString *testStringG7MIDI = @"G 7 MIDI";
	NSString *testStringGSharp7MIDI = @"G♯ 7 MIDI";
	NSString *testStringAb7MIDI = @"A♭ 7 MIDI";
	NSString *testStringA7MIDI = @"A 7 MIDI";
	NSString *testStringASharp7MIDI = @"A♯ 7 MIDI";
	NSString *testStringBb7MIDI = @"B♭ 7 MIDI";
	NSString *testStringB7MIDI = @"B 7 MIDI";
	
	// *********** 8 MIDI TEST STRINGS **********************
	NSString *testStringC8MIDI = @"C 8 MIDI";
	NSString *testStringCSharp8MIDI = @"C♯ 8 MIDI";
	NSString *testStringDb8MIDI = @"D♭ 8 MIDI";
	NSString *testStringD8MIDI = @"D 8 MIDI";
	NSString *testStringDSharp8MIDI = @"D♯ 8 MIDI";
	NSString *testStringEb8MIDI = @"E♭ 8 MIDI";
	NSString *testStringE8MIDI = @"E 8 MIDI";
	NSString *testStringF8MIDI = @"F 8 MIDI";
	NSString *testStringFSharp8MIDI = @"F♯ 8 MIDI";
	NSString *testStringGb8MIDI = @"G♭ 8 MIDI";
	NSString *testStringG8MIDI = @"G 8 MIDI";
	NSString *testStringGSharp8MIDI = @"G♯ 8 MIDI";
	NSString *testStringAb8MIDI = @"A♭ 8 MIDI";
	NSString *testStringA8MIDI = @"A 8 MIDI";
	NSString *testStringASharp8MIDI = @"A♯ 8 MIDI";
	NSString *testStringBb8MIDI = @"B♭ 8 MIDI";
	NSString *testStringB8MIDI = @"B 8 MIDI";
	
	// *********** 9 MIDI TEST STRINGS **********************
	NSString *testStringC9MIDI = @"C 9 MIDI";
	NSString *testStringCSharp9MIDI = @"C♯ 9 MIDI";
	NSString *testStringDb9MIDI = @"D♭ 9 MIDI";
	NSString *testStringD9MIDI = @"D 9 MIDI";
	NSString *testStringDSharp9MIDI = @"D♯ 9 MIDI";
	NSString *testStringEb9MIDI = @"E♭ 9 MIDI";
	NSString *testStringE9MIDI = @"E 9 MIDI";
	NSString *testStringF9MIDI = @"F 9 MIDI";
	NSString *testStringFSharp9MIDI = @"F♯ 9 MIDI";
	NSString *testStringGb9MIDI = @"G♭ 9 MIDI";
	NSString *testStringG9MIDI = @"G 9 MIDI";
	NSString *testStringGSharp9MIDI = @"G♯ 9 MIDI";
	NSString *testStringAb9MIDI = @"A♭ 9 MIDI";
	NSString *testStringA9MIDI = @"A 9 MIDI";
	NSString *testStringASharp9MIDI = @"A♯ 9 MIDI";
	NSString *testStringBb9MIDI = @"B♭ 9 MIDI";
	NSString *testStringB9MIDI = @"B 9 MIDI";	
	
	// IF STRING isEqualToString X XXXXXX ******************************************
	
	// *********** _1Frequency ifs **********************
	
	if ([messageFromPicker isEqualToString: testStringC_1Frequency] == YES)
	{
		label.text = [NSString stringWithFormat:@"8.18 Hz"];//@"test, C♯oø, E♭, Gxbb+, bbbº, c+7"
		//@"C _1Frequency"
	}
	
	if ([messageFromPicker isEqualToString: testStringCSharp_1Frequency] == YES)
	{
		label.text = [NSString stringWithFormat:@"8.66 Hz"];
		//@"C♯ _1Frequency"
	}
	
	if ([messageFromPicker isEqualToString: testStringDb_1Frequency] == YES)
	{
		label.text = [NSString stringWithFormat:@"8.66 Hz"];
		//@"D♭ _1Frequency"
	}
	
	if ([messageFromPicker isEqualToString: testStringD_1Frequency] == YES)
	{
		label.text = [NSString stringWithFormat:@"9.18 Hz"];
		//@"D _1Frequency"
	}
	
	if ([messageFromPicker isEqualToString: testStringDSharp_1Frequency] == YES)
	{
		label.text = [NSString stringWithFormat:@"9.73 Hz"];
		//@"D♯ _1Frequency"
	}
	
	if ([messageFromPicker isEqualToString: testStringEb_1Frequency] == YES)
	{
		label.text = [NSString stringWithFormat:@"9.73 Hz"];
		//@"E♭ _1Frequency"
	}
	
	if ([messageFromPicker isEqualToString: testStringE_1Frequency] == YES)
	{
		label.text = [NSString stringWithFormat:@"10.30 Hz"];
		//@"E _1Frequency"
	}
	
	if ([messageFromPicker isEqualToString: testStringF_1Frequency] == YES)
	{
		label.text = [NSString stringWithFormat:@"10.92 Hz"];
		//@"F _1Frequency"
	}
	
	if ([messageFromPicker isEqualToString: testStringFSharp_1Frequency] == YES)
	{
		label.text = [NSString stringWithFormat:@"11.56 Hz"];
		//@"F♯ _1Frequency"
	}
	
	if ([messageFromPicker isEqualToString: testStringGb_1Frequency] == YES)
	{
		label.text = [NSString stringWithFormat:@"11.56 Hz"];
		//@"G♭ _1Frequency"
	}
	
	if ([messageFromPicker isEqualToString: testStringG_1Frequency] == YES)
	{
		label.text = [NSString stringWithFormat:@"12.3 Hz"];
		//@"G _1Frequency"
	}
	
	if ([messageFromPicker isEqualToString: testStringGSharp_1Frequency] == YES)
	{
		label.text = [NSString stringWithFormat:@"12.98 Hz"];
		//@"G♯ _1Frequency"
	}
	
	if ([messageFromPicker isEqualToString: testStringAb_1Frequency] == YES)
	{
		label.text = [NSString stringWithFormat:@"12.98 Hz"];
		//@"A♭ _1Frequency"
	}
	
	if ([messageFromPicker isEqualToString: testStringA_1Frequency] == YES)
	{
		label.text = [NSString stringWithFormat:@"13.75 Hz"];
		//@"A _1Frequency"
	}
	
	if ([messageFromPicker isEqualToString: testStringASharp_1Frequency] == YES)
	{
		label.text = [NSString stringWithFormat:@"14.57 Hz"];
		//@"A♯ _1Frequency"
	}
	
	if ([messageFromPicker isEqualToString: testStringBb_1Frequency] == YES)
	{
		label.text = [NSString stringWithFormat:@"14.57 Hz"];
		//@"B♭ _1Frequency"
	}
	
	if ([messageFromPicker isEqualToString: testStringB_1Frequency] == YES)
	{
		label.text = [NSString stringWithFormat:@"15.44 Hz"];
		//@"B _1Frequency"
	}	
	
	// *********** 0Frequency ifs **********************
	
	if ([messageFromPicker isEqualToString: testStringC0Frequency] == YES)
	{
		label.text = [NSString stringWithFormat:@"16.35 Hz"];//@"test, C♯oø, E♭, Gxbb+, bbbº, c+7"
		//@"C 0Frequency"
	}
	
	if ([messageFromPicker isEqualToString: testStringCSharp0Frequency] == YES)
	{
		label.text = [NSString stringWithFormat:@"17.32 Hz"];
		//@"C♯ 0Frequency"
	}
	
	if ([messageFromPicker isEqualToString: testStringDb0Frequency] == YES)
	{
		label.text = [NSString stringWithFormat:@"17.32 Hz"];
		//@"D♭ 0Frequency"
	}
	
	if ([messageFromPicker isEqualToString: testStringD0Frequency] == YES)
	{
		label.text = [NSString stringWithFormat:@"18.35 Hz"];
		//@"D 0Frequency"
	}
	
	if ([messageFromPicker isEqualToString: testStringDSharp0Frequency] == YES)
	{
		label.text = [NSString stringWithFormat:@"19.45 Hz"];
		//@"D♯ 0Frequency"
	}
	
	if ([messageFromPicker isEqualToString: testStringEb0Frequency] == YES)
	{
		label.text = [NSString stringWithFormat:@"19.45 Hz"];
		//@"E♭ 0Frequency"
	}
	
	if ([messageFromPicker isEqualToString: testStringE0Frequency] == YES)
	{
		label.text = [NSString stringWithFormat:@"20.60 Hz"];
		//@"E 0Frequency"
	}
	
	if ([messageFromPicker isEqualToString: testStringF0Frequency] == YES)
	{
		label.text = [NSString stringWithFormat:@"21.83 Hz"];
		//@"F 0Frequency"
	}
	
	if ([messageFromPicker isEqualToString: testStringFSharp0Frequency] == YES)
	{
		label.text = [NSString stringWithFormat:@"23.12 Hz"];
		//@"F♯ 0Frequency"
	}
	
	if ([messageFromPicker isEqualToString: testStringGb0Frequency] == YES)
	{
		label.text = [NSString stringWithFormat:@"23.12 Hz"];
		//@"G♭ 0Frequency"
	}
	
	if ([messageFromPicker isEqualToString: testStringG0Frequency] == YES)
	{
		label.text = [NSString stringWithFormat:@"24.50 Hz"];
		//@"G 0Frequency"
	}
	
	if ([messageFromPicker isEqualToString: testStringGSharp0Frequency] == YES)
	{
		label.text = [NSString stringWithFormat:@"25.96 Hz"];
		//@"G♯ 0Frequency"
	}
	
	if ([messageFromPicker isEqualToString: testStringAb0Frequency] == YES)
	{
		label.text = [NSString stringWithFormat:@"25.96 Hz"];
		//@"A♭ 0Frequency"
	}
	
	if ([messageFromPicker isEqualToString: testStringA0Frequency] == YES)
	{
		label.text = [NSString stringWithFormat:@"27.50 Hz"];
		//@"A 0Frequency"
	}
	
	if ([messageFromPicker isEqualToString: testStringASharp0Frequency] == YES)
	{
		label.text = [NSString stringWithFormat:@"29.14 Hz"];
		//@"A♯ 0Frequency"
	}
	
	if ([messageFromPicker isEqualToString: testStringBb0Frequency] == YES)
	{
		label.text = [NSString stringWithFormat:@"29.14 Hz"];
		//@"B♭ 0Frequency"
	}
	
	if ([messageFromPicker isEqualToString: testStringB0Frequency] == YES)
	{
		label.text = [NSString stringWithFormat:@"30.87 Hz"];
		//@"B 0Frequency"
	}
	
	// *********** 1Frequency ifs **********************
	
	if ([messageFromPicker isEqualToString: testStringC1Frequency] == YES)
	{
		label.text = [NSString stringWithFormat:@"32.70 Hz"];//@"test, C♯oø, E♭, Gxbb+, bbbº, c+7"
		//@"C 1Frequency"
	}
	
	if ([messageFromPicker isEqualToString: testStringCSharp1Frequency] == YES)
	{
		label.text = [NSString stringWithFormat:@"34.65 Hz"];
		//@"C♯ 1Frequency"
	}
	
	if ([messageFromPicker isEqualToString: testStringDb1Frequency] == YES)
	{
		label.text = [NSString stringWithFormat:@"34.65 Hz"];
		//@"D♭ 1Frequency"
	}
	
	if ([messageFromPicker isEqualToString: testStringD1Frequency] == YES)
	{
		label.text = [NSString stringWithFormat:@"36.71 Hz"];
		//@"D 1Frequency"
	}
	
	if ([messageFromPicker isEqualToString: testStringDSharp1Frequency] == YES)
	{
		label.text = [NSString stringWithFormat:@"38.89 Hz"];
		//@"D♯ 1Frequency"
	}
	
	if ([messageFromPicker isEqualToString: testStringEb1Frequency] == YES)
	{
		label.text = [NSString stringWithFormat:@"38.89 Hz"];
		//@"E♭ 1Frequency"
	}
	
	if ([messageFromPicker isEqualToString: testStringE1Frequency] == YES)
	{
		label.text = [NSString stringWithFormat:@"41.20 Hz"];
		//@"E 1Frequency"
	}
	
	if ([messageFromPicker isEqualToString: testStringF1Frequency] == YES)
	{
		label.text = [NSString stringWithFormat:@"43.65 Hz"];
		//@"F 1Frequency"
	}
	
	if ([messageFromPicker isEqualToString: testStringFSharp1Frequency] == YES)
	{
		label.text = [NSString stringWithFormat:@"46.25 Hz"];
		//@"F♯ 1Frequency"
	}
	
	if ([messageFromPicker isEqualToString: testStringGb1Frequency] == YES)
	{
		label.text = [NSString stringWithFormat:@"46.25 Hz"];
		//@"G♭ 1Frequency"
	}
	
	if ([messageFromPicker isEqualToString: testStringG1Frequency] == YES)
	{
		label.text = [NSString stringWithFormat:@"49.00 Hz"];
		//@"G 1Frequency"
	}
	
	if ([messageFromPicker isEqualToString: testStringGSharp1Frequency] == YES)
	{
		label.text = [NSString stringWithFormat:@"51.91 Hz"];
		//@"G♯ 1Frequency"
	}
	
	if ([messageFromPicker isEqualToString: testStringAb1Frequency] == YES)
	{
		label.text = [NSString stringWithFormat:@"51.91 Hz"];
		//@"A♭ 1Frequency"
	}
	
	if ([messageFromPicker isEqualToString: testStringA1Frequency] == YES)
	{
		label.text = [NSString stringWithFormat:@"55.00 Hz"];
		//@"A 1Frequency"
	}
	
	if ([messageFromPicker isEqualToString: testStringASharp1Frequency] == YES)
	{
		label.text = [NSString stringWithFormat:@"58.27 Hz"];
		//@"A♯ 1Frequency"
	}
	
	if ([messageFromPicker isEqualToString: testStringBb1Frequency] == YES)
	{
		label.text = [NSString stringWithFormat:@"58.27 Hz"];
		//@"B♭ 1Frequency"
	}
	
	if ([messageFromPicker isEqualToString: testStringB1Frequency] == YES)
	{
		label.text = [NSString stringWithFormat:@"61.74 Hz"];
		//@"B 1Frequency"
	}
	
	// *********** 2Frequency ifs **********************
	
	if ([messageFromPicker isEqualToString: testStringC2Frequency] == YES)
	{
		label.text = [NSString stringWithFormat:@"65.41 Hz"];//@"test, C♯oø, E♭, Gxbb+, bbbº, c+7"
		//@"C 2Frequency"
	}
	
	if ([messageFromPicker isEqualToString: testStringCSharp2Frequency] == YES)
	{
		label.text = [NSString stringWithFormat:@"69.30 Hz"];
		//@"C♯ 2Frequency"
	}
	
	if ([messageFromPicker isEqualToString: testStringDb2Frequency] == YES)
	{
		label.text = [NSString stringWithFormat:@"69.30 Hz"];
		//@"D♭ 2Frequency"
	}
	
	if ([messageFromPicker isEqualToString: testStringD2Frequency] == YES)
	{
		label.text = [NSString stringWithFormat:@"73.42 Hz"];
		//@"D 2Frequency"
	}
	
	if ([messageFromPicker isEqualToString: testStringDSharp2Frequency] == YES)
	{
		label.text = [NSString stringWithFormat:@"77.78 Hz"];
		//@"D♯ 2Frequency"
	}
	
	if ([messageFromPicker isEqualToString: testStringEb2Frequency] == YES)
	{
		label.text = [NSString stringWithFormat:@"77.78 Hz"];
		//@"E♭ 2Frequency"
	}
	
	if ([messageFromPicker isEqualToString: testStringE2Frequency] == YES)
	{
		label.text = [NSString stringWithFormat:@"82.41 Hz"];
		//@"E 2Frequency"
	}
	
	if ([messageFromPicker isEqualToString: testStringF2Frequency] == YES)
	{
		label.text = [NSString stringWithFormat:@"87.31 Hz"];
		//@"F 2Frequency"
	}
	
	if ([messageFromPicker isEqualToString: testStringFSharp2Frequency] == YES)
	{
		label.text = [NSString stringWithFormat:@"92.50 Hz"];
		//@"F♯ 2Frequency"
	}
	
	if ([messageFromPicker isEqualToString: testStringGb2Frequency] == YES)
	{
		label.text = [NSString stringWithFormat:@"92.50 Hz"];
		//@"G♭ 2Frequency"
	}
	
	if ([messageFromPicker isEqualToString: testStringG2Frequency] == YES)
	{
		label.text = [NSString stringWithFormat:@"98.00 Hz"];
		//@"G 2Frequency"
	}
	
	if ([messageFromPicker isEqualToString: testStringGSharp2Frequency] == YES)
	{
		label.text = [NSString stringWithFormat:@"103.83 Hz"];
		//@"G♯ 2Frequency"
	}
	
	if ([messageFromPicker isEqualToString: testStringAb2Frequency] == YES)
	{
		label.text = [NSString stringWithFormat:@"103.83 Hz"];
		//@"A♭ 2Frequency"
	}
	
	if ([messageFromPicker isEqualToString: testStringA2Frequency] == YES)
	{
		label.text = [NSString stringWithFormat:@"110.00 Hz"];
		//@"A 2Frequency"
	}
	
	if ([messageFromPicker isEqualToString: testStringASharp2Frequency] == YES)
	{
		label.text = [NSString stringWithFormat:@"116.54 Hz"];
		//@"A♯ 2Frequency"
	}
	
	if ([messageFromPicker isEqualToString: testStringBb2Frequency] == YES)
	{
		label.text = [NSString stringWithFormat:@"116.54 Hz"];
		//@"B♭ 2Frequency"
	}
	
	if ([messageFromPicker isEqualToString: testStringB2Frequency] == YES)
	{
		label.text = [NSString stringWithFormat:@"123.47 Hz"];
		//@"B 2Frequency"
	}
	
	// *********** 3Frequency ifs **********************
	
	if ([messageFromPicker isEqualToString: testStringC3Frequency] == YES)
	{
		label.text = [NSString stringWithFormat:@"130.81 Hz"];//@"test, C♯oø, E♭, Gxbb+, bbbº, c+7"
		//@"C 3Frequency"
	}
	
	if ([messageFromPicker isEqualToString: testStringCSharp3Frequency] == YES)
	{
		label.text = [NSString stringWithFormat:@"138.59 Hz"];
		//@"C♯ 3Frequency"
	}
	
	if ([messageFromPicker isEqualToString: testStringDb3Frequency] == YES)
	{
		label.text = [NSString stringWithFormat:@"138.59 Hz"];
		//@"D♭ 3Frequency"
	}
	
	if ([messageFromPicker isEqualToString: testStringD3Frequency] == YES)
	{
		label.text = [NSString stringWithFormat:@"146.83 Hz"];
		//@"D 3Frequency"
	}
	
	if ([messageFromPicker isEqualToString: testStringDSharp3Frequency] == YES)
	{
		label.text = [NSString stringWithFormat:@"155.56 Hz"];
		//@"D♯ 3Frequency"
	}
	
	if ([messageFromPicker isEqualToString: testStringEb3Frequency] == YES)
	{
		label.text = [NSString stringWithFormat:@"155.56 Hz"];
		//@"E♭ 3Frequency"
	}
	
	if ([messageFromPicker isEqualToString: testStringE3Frequency] == YES)
	{
		label.text = [NSString stringWithFormat:@"164.81 Hz"];
		//@"E 3Frequency"
	}
	
	if ([messageFromPicker isEqualToString: testStringF3Frequency] == YES)
	{
		label.text = [NSString stringWithFormat:@"174.61 Hz"];
		//@"F 3Frequency"
	}
	
	if ([messageFromPicker isEqualToString: testStringFSharp3Frequency] == YES)
	{
		label.text = [NSString stringWithFormat:@"185.00 Hz"];
		//@"F♯ 3Frequency"
	}
	
	if ([messageFromPicker isEqualToString: testStringGb3Frequency] == YES)
	{
		label.text = [NSString stringWithFormat:@"185.00 Hz"];
		//@"G♭ 3Frequency"
	}
	
	if ([messageFromPicker isEqualToString: testStringG3Frequency] == YES)
	{
		label.text = [NSString stringWithFormat:@"196.00 Hz"];
		//@"G 3Frequency"
	}
	
	if ([messageFromPicker isEqualToString: testStringGSharp3Frequency] == YES)
	{
		label.text = [NSString stringWithFormat:@"207.65 Hz"];
		//@"G♯ 3Frequency"
	}
	
	if ([messageFromPicker isEqualToString: testStringAb3Frequency] == YES)
	{
		label.text = [NSString stringWithFormat:@"207.65 Hz"];
		//@"A♭ 3Frequency"
	}
	
	if ([messageFromPicker isEqualToString: testStringA3Frequency] == YES)
	{
		label.text = [NSString stringWithFormat:@"220.00 Hz"];
		//@"A 3Frequency"
	}
	
	if ([messageFromPicker isEqualToString: testStringASharp3Frequency] == YES)
	{
		label.text = [NSString stringWithFormat:@"233.08 Hz"];
		//@"A♯ 3Frequency"
	}
	
	if ([messageFromPicker isEqualToString: testStringBb3Frequency] == YES)
	{
		label.text = [NSString stringWithFormat:@"233.08 Hz"];
		//@"B♭ 3Frequency"
	}
	
	if ([messageFromPicker isEqualToString: testStringB3Frequency] == YES)
	{
		label.text = [NSString stringWithFormat:@"246.94 Hz"];
		//@"B 3Frequency"
	}
	
	// *********** 4Frequency ifs **********************
	
	if ([messageFromPicker isEqualToString: testStringC4Frequency] == YES)
	{
		label.text = [NSString stringWithFormat:@"261.63 Hz"];//@"test, C♯oø, E♭, Gxbb+, bbbº, c+7"
		//@"C 4Frequency"
	}
	
	if ([messageFromPicker isEqualToString: testStringCSharp4Frequency] == YES)
	{
		label.text = [NSString stringWithFormat:@"277.18 Hz"];
		//@"C♯ 4Frequency"
	}
	
	if ([messageFromPicker isEqualToString: testStringDb4Frequency] == YES)
	{
		label.text = [NSString stringWithFormat:@"277.18 Hz"];
		//@"D♭ 4Frequency"
	}
	
	if ([messageFromPicker isEqualToString: testStringD4Frequency] == YES)
	{
		label.text = [NSString stringWithFormat:@"293.66 Hz"];
		//@"D 4Frequency"
	}
	
	if ([messageFromPicker isEqualToString: testStringDSharp4Frequency] == YES)
	{
		label.text = [NSString stringWithFormat:@"311.13 Hz"];
		//@"D♯ 4Frequency"
	}
	
	if ([messageFromPicker isEqualToString: testStringEb4Frequency] == YES)
	{
		label.text = [NSString stringWithFormat:@"311.13 Hz"];
		//@"E♭ 4Frequency"
	}
	
	if ([messageFromPicker isEqualToString: testStringE4Frequency] == YES)
	{
		label.text = [NSString stringWithFormat:@"329.63 Hz"];
		//@"E 4Frequency"
	}
	
	if ([messageFromPicker isEqualToString: testStringF4Frequency] == YES)
	{
		label.text = [NSString stringWithFormat:@"349.23 Hz"];
		//@"F 4Frequency"
	}
	
	if ([messageFromPicker isEqualToString: testStringFSharp4Frequency] == YES)
	{
		label.text = [NSString stringWithFormat:@"369.99 Hz"];
		//@"F♯ 4Frequency"
	}
	
	if ([messageFromPicker isEqualToString: testStringGb4Frequency] == YES)
	{
		label.text = [NSString stringWithFormat:@"369.99 Hz"];
		//@"G♭ 4Frequency"
	}
	
	if ([messageFromPicker isEqualToString: testStringG4Frequency] == YES)
	{
		label.text = [NSString stringWithFormat:@"392.00 Hz"];
		//@"G 4Frequency"
	}
	
	if ([messageFromPicker isEqualToString: testStringGSharp4Frequency] == YES)
	{
		label.text = [NSString stringWithFormat:@"415.30 Hz"];
		//@"G♯ 4Frequency"
	}
	
	if ([messageFromPicker isEqualToString: testStringAb4Frequency] == YES)
	{
		label.text = [NSString stringWithFormat:@"415.30 Hz"];
		//@"A♭ 4Frequency"
	}
	
	if ([messageFromPicker isEqualToString: testStringA4Frequency] == YES)
	{
		label.text = [NSString stringWithFormat:@"440.00 Hz"];
		//@"A 4Frequency"
	}
	
	if ([messageFromPicker isEqualToString: testStringASharp4Frequency] == YES)
	{
		label.text = [NSString stringWithFormat:@"466.16 Hz"];
		//@"A♯ 4Frequency"
	}
	
	if ([messageFromPicker isEqualToString: testStringBb4Frequency] == YES)
	{
		label.text = [NSString stringWithFormat:@"466.16 Hz"];
		//@"B♭ 4Frequency"
	}
	
	if ([messageFromPicker isEqualToString: testStringB4Frequency] == YES)
	{
		label.text = [NSString stringWithFormat:@"493.88 Hz"];
		//@"B 4Frequency"
	}
	
	// *********** 5Frequency ifs **********************
	
	if ([messageFromPicker isEqualToString: testStringC5Frequency] == YES)
	{
		label.text = [NSString stringWithFormat:@"523.25 Hz"];//@"test, C♯oø, E♭, Gxbb+, bbbº, c+7"
		//@"C 5Frequency"
	}
	
	if ([messageFromPicker isEqualToString: testStringCSharp5Frequency] == YES)
	{
		label.text = [NSString stringWithFormat:@"554.37 Hz"];
		//@"C♯ 5Frequency"
	}
	
	if ([messageFromPicker isEqualToString: testStringDb5Frequency] == YES)
	{
		label.text = [NSString stringWithFormat:@"554.37 Hz"];
		//@"D♭ 5Frequency"
	}
	
	if ([messageFromPicker isEqualToString: testStringD5Frequency] == YES)
	{
		label.text = [NSString stringWithFormat:@"587.33 Hz"];
		//@"D 5Frequency"
	}
	
	if ([messageFromPicker isEqualToString: testStringDSharp5Frequency] == YES)
	{
		label.text = [NSString stringWithFormat:@"622.25 Hz"];
		//@"D♯ 5Frequency"
	}
	
	if ([messageFromPicker isEqualToString: testStringEb5Frequency] == YES)
	{
		label.text = [NSString stringWithFormat:@"622.25 Hz"];
		//@"E♭ 5Frequency"
	}
	
	if ([messageFromPicker isEqualToString: testStringE5Frequency] == YES)
	{
		label.text = [NSString stringWithFormat:@"659.26 Hz"];
		//@"E 5Frequency"
	}
	
	if ([messageFromPicker isEqualToString: testStringF5Frequency] == YES)
	{
		label.text = [NSString stringWithFormat:@"698.46 Hz"];
		//@"F 5Frequency"
	}
	
	if ([messageFromPicker isEqualToString: testStringFSharp5Frequency] == YES)
	{
		label.text = [NSString stringWithFormat:@"739.99 Hz"];
		//@"F♯ 5Frequency"
	}
	
	if ([messageFromPicker isEqualToString: testStringGb5Frequency] == YES)
	{
		label.text = [NSString stringWithFormat:@"739.99 Hz"];
		//@"G♭ 5Frequency"
	}
	
	if ([messageFromPicker isEqualToString: testStringG5Frequency] == YES)
	{
		label.text = [NSString stringWithFormat:@"783.99 Hz"];
		//@"G 5Frequency"
	}
	
	if ([messageFromPicker isEqualToString: testStringGSharp5Frequency] == YES)
	{
		label.text = [NSString stringWithFormat:@"830.61 Hz"];
		//@"G♯ 5Frequency"
	}
	
	if ([messageFromPicker isEqualToString: testStringAb5Frequency] == YES)
	{
		label.text = [NSString stringWithFormat:@"830.61 Hz"];
		//@"A♭ 5Frequency"
	}
	
	if ([messageFromPicker isEqualToString: testStringA5Frequency] == YES)
	{
		label.text = [NSString stringWithFormat:@"880.00 Hz"];
		//@"A 5Frequency"
	}
	
	if ([messageFromPicker isEqualToString: testStringASharp5Frequency] == YES)
	{
		label.text = [NSString stringWithFormat:@"932.33 Hz"];
		//@"A♯ 5Frequency"
	}
	
	if ([messageFromPicker isEqualToString: testStringBb5Frequency] == YES)
	{
		label.text = [NSString stringWithFormat:@"932.33 Hz"];
		//@"B♭ 5Frequency"
	}
	
	if ([messageFromPicker isEqualToString: testStringB5Frequency] == YES)
	{
		label.text = [NSString stringWithFormat:@"987.77 Hz"];
		//@"B 5Frequency"
	}
	
	// *********** 6Frequency ifs **********************
	
	if ([messageFromPicker isEqualToString: testStringC6Frequency] == YES)
	{
		label.text = [NSString stringWithFormat:@"1046.50 Hz"];//@"test, C♯oø, E♭, Gxbb+, bbbº, c+7"
		//@"C 6Frequency"
	}
	
	if ([messageFromPicker isEqualToString: testStringCSharp6Frequency] == YES)
	{
		label.text = [NSString stringWithFormat:@"1108.73 Hz"];
		//@"C♯ 6Frequency"
	}
	
	if ([messageFromPicker isEqualToString: testStringDb6Frequency] == YES)
	{
		label.text = [NSString stringWithFormat:@"1108.73 Hz"];
		//@"D♭ 6Frequency"
	}
	
	if ([messageFromPicker isEqualToString: testStringD6Frequency] == YES)
	{
		label.text = [NSString stringWithFormat:@"1174.66 Hz"];
		//@"D 6Frequency"
	}
	
	if ([messageFromPicker isEqualToString: testStringDSharp6Frequency] == YES)
	{
		label.text = [NSString stringWithFormat:@"1244.51 Hz"];
		//@"D♯ 6Frequency"
	}
	
	if ([messageFromPicker isEqualToString: testStringEb6Frequency] == YES)
	{
		label.text = [NSString stringWithFormat:@"1244.51 Hz"];
		//@"E♭ 6Frequency"
	}
	
	if ([messageFromPicker isEqualToString: testStringE6Frequency] == YES)
	{
		label.text = [NSString stringWithFormat:@"1318.51 Hz"];
		//@"E 6Frequency"
	}
	
	if ([messageFromPicker isEqualToString: testStringF6Frequency] == YES)
	{
		label.text = [NSString stringWithFormat:@"1396.91 Hz"];
		//@"F 6Frequency"
	}
	
	if ([messageFromPicker isEqualToString: testStringFSharp6Frequency] == YES)
	{
		label.text = [NSString stringWithFormat:@"1479.98 Hz"];
		//@"F♯ 6Frequency"
	}
	
	if ([messageFromPicker isEqualToString: testStringGb6Frequency] == YES)
	{
		label.text = [NSString stringWithFormat:@"1479.98 Hz"];
		//@"G♭ 6Frequency"
	}
	
	if ([messageFromPicker isEqualToString: testStringG6Frequency] == YES)
	{
		label.text = [NSString stringWithFormat:@"1567.98 Hz"];
		//@"G 6Frequency"
	}
	
	if ([messageFromPicker isEqualToString: testStringGSharp6Frequency] == YES)
	{
		label.text = [NSString stringWithFormat:@"1661.22 Hz"];
		//@"G♯ 6Frequency"
	}
	
	if ([messageFromPicker isEqualToString: testStringAb6Frequency] == YES)
	{
		label.text = [NSString stringWithFormat:@"1661.22 Hz"];
		//@"A♭ 6Frequency"
	}
	
	if ([messageFromPicker isEqualToString: testStringA6Frequency] == YES)
	{
		label.text = [NSString stringWithFormat:@"1760.00 Hz"];
		//@"A 6Frequency"
	}
	
	if ([messageFromPicker isEqualToString: testStringASharp6Frequency] == YES)
	{
		label.text = [NSString stringWithFormat:@"1864.66 Hz"];
		//@"A♯ 6Frequency"
	}
	
	if ([messageFromPicker isEqualToString: testStringBb6Frequency] == YES)
	{
		label.text = [NSString stringWithFormat:@"1864.66 Hz"];
		//@"B♭ 6Frequency"
	}
	
	if ([messageFromPicker isEqualToString: testStringB6Frequency] == YES)
	{
		label.text = [NSString stringWithFormat:@"1975.53 Hz"];
		//@"B 6Frequency"
	}
	
	// *********** 7Frequency ifs **********************
	
	if ([messageFromPicker isEqualToString: testStringC7Frequency] == YES)
	{
		label.text = [NSString stringWithFormat:@"2093.00 Hz"];//@"test, C♯oø, E♭, Gxbb+, bbbº, c+7"
		//@"C 7Frequency"
	}
	
	if ([messageFromPicker isEqualToString: testStringCSharp7Frequency] == YES)
	{
		label.text = [NSString stringWithFormat:@"2217.46 Hz"];
		//@"C♯ 7Frequency"
	}
	
	if ([messageFromPicker isEqualToString: testStringDb7Frequency] == YES)
	{
		label.text = [NSString stringWithFormat:@"2217.46 Hz"];
		//@"D♭ 7Frequency"
	}
	
	if ([messageFromPicker isEqualToString: testStringD7Frequency] == YES)
	{
		label.text = [NSString stringWithFormat:@"2349.32 Hz"];
		//@"D 7Frequency"
	}
	
	if ([messageFromPicker isEqualToString: testStringDSharp7Frequency] == YES)
	{
		label.text = [NSString stringWithFormat:@"2489.02 Hz"];
		//@"D♯ 7Frequency"
	}
	
	if ([messageFromPicker isEqualToString: testStringEb7Frequency] == YES)
	{
		label.text = [NSString stringWithFormat:@"2489.02 Hz"];
		//@"E♭ 7Frequency"
	}
	
	if ([messageFromPicker isEqualToString: testStringE7Frequency] == YES)
	{
		label.text = [NSString stringWithFormat:@"2637.02 Hz"];
		//@"E 7Frequency"
	}
	
	if ([messageFromPicker isEqualToString: testStringF7Frequency] == YES)
	{
		label.text = [NSString stringWithFormat:@"2793.83 Hz"];
		//@"F 7Frequency"
	}
	
	if ([messageFromPicker isEqualToString: testStringFSharp7Frequency] == YES)
	{
		label.text = [NSString stringWithFormat:@"2959.96 Hz"];
		//@"F♯ 7Frequency"
	}
	
	if ([messageFromPicker isEqualToString: testStringGb7Frequency] == YES)
	{
		label.text = [NSString stringWithFormat:@"2959.96 Hz"];
		//@"G♭ 7Frequency"
	}
	
	if ([messageFromPicker isEqualToString: testStringG7Frequency] == YES)
	{
		label.text = [NSString stringWithFormat:@"3135.96 Hz"];
		//@"G 7Frequency"
	}
	
	if ([messageFromPicker isEqualToString: testStringGSharp7Frequency] == YES)
	{
		label.text = [NSString stringWithFormat:@"3322.44 Hz"];
		//@"G♯ 7Frequency"
	}
	
	if ([messageFromPicker isEqualToString: testStringAb7Frequency] == YES)
	{
		label.text = [NSString stringWithFormat:@"3322.44 Hz"];
		//@"A♭ 7Frequency"
	}
	
	if ([messageFromPicker isEqualToString: testStringA7Frequency] == YES)
	{
		label.text = [NSString stringWithFormat:@"3520.00 Hz"];
		//@"A 7Frequency"
	}
	
	if ([messageFromPicker isEqualToString: testStringASharp7Frequency] == YES)
	{
		label.text = [NSString stringWithFormat:@"3729.31 Hz"];
		//@"A♯ 7Frequency"
	}
	
	if ([messageFromPicker isEqualToString: testStringBb7Frequency] == YES)
	{
		label.text = [NSString stringWithFormat:@"3729.31 Hz"];
		//@"B♭ 7Frequency"
	}
	
	if ([messageFromPicker isEqualToString: testStringB7Frequency] == YES)
	{
		label.text = [NSString stringWithFormat:@"3951.07 Hz"];
		//@"B 7Frequency"
	}
	
	// *********** 8Frequency ifs **********************
	
	if ([messageFromPicker isEqualToString: testStringC8Frequency] == YES)
	{
		label.text = [NSString stringWithFormat:@"4186.00 Hz"];//@"test, C♯oø, E♭, Gxbb+, bbbº, c+7"
		//@"C 8Frequency"
	}
	
	if ([messageFromPicker isEqualToString: testStringCSharp8Frequency] == YES)
	{
		label.text = [NSString stringWithFormat:@"4434.92 Hz"];
		//@"C♯ 8Frequency"
	}
	
	if ([messageFromPicker isEqualToString: testStringDb8Frequency] == YES)
	{
		label.text = [NSString stringWithFormat:@"4434.92 Hz"];
		//@"D♭ 8Frequency"
	}
	
	if ([messageFromPicker isEqualToString: testStringD8Frequency] == YES)
	{
		label.text = [NSString stringWithFormat:@"4698.64 Hz"];
		//@"D 8Frequency"
	}
	
	if ([messageFromPicker isEqualToString: testStringDSharp8Frequency] == YES)
	{
		label.text = [NSString stringWithFormat:@"4978.04 Hz"];
		//@"D♯ 8Frequency"
	}
	
	if ([messageFromPicker isEqualToString: testStringEb8Frequency] == YES)
	{
		label.text = [NSString stringWithFormat:@"4978.04 Hz"];
		//@"E♭ 8Frequency"
	}
	
	if ([messageFromPicker isEqualToString: testStringE8Frequency] == YES)
	{
		label.text = [NSString stringWithFormat:@"5274.04 Hz"];
		//@"E 8Frequency"
	}
	
	if ([messageFromPicker isEqualToString: testStringF8Frequency] == YES)
	{
		label.text = [NSString stringWithFormat:@"5587.66 Hz"];
		//@"F 8Frequency"
	}
	
	if ([messageFromPicker isEqualToString: testStringFSharp8Frequency] == YES)
	{
		label.text = [NSString stringWithFormat:@"5919.92 Hz"];
		//@"F♯ 8Frequency"
	}
	
	if ([messageFromPicker isEqualToString: testStringGb8Frequency] == YES)
	{
		label.text = [NSString stringWithFormat:@"5919.92 Hz"];
		//@"G♭ 8Frequency"
	}
	
	if ([messageFromPicker isEqualToString: testStringG8Frequency] == YES)
	{
		label.text = [NSString stringWithFormat:@"6271.92 Hz"];
		//@"G 8Frequency"
	}
	
	if ([messageFromPicker isEqualToString: testStringGSharp8Frequency] == YES)
	{
		label.text = [NSString stringWithFormat:@"6644.88 Hz"];
		//@"G♯ 8Frequency"
	}
	
	if ([messageFromPicker isEqualToString: testStringAb8Frequency] == YES)
	{
		label.text = [NSString stringWithFormat:@"6644.88 Hz"];
		//@"A♭ 8Frequency"
	}
	
	if ([messageFromPicker isEqualToString: testStringA8Frequency] == YES)
	{
		label.text = [NSString stringWithFormat:@"7040.00 Hz"];
		//@"A 8Frequency"
	}
	
	if ([messageFromPicker isEqualToString: testStringASharp8Frequency] == YES)
	{
		label.text = [NSString stringWithFormat:@"7458.00 Hz"];
		//@"A♯ 8Frequency"
	}
	
	if ([messageFromPicker isEqualToString: testStringBb8Frequency] == YES)
	{
		label.text = [NSString stringWithFormat:@"7458.00 Hz"];
		//@"B♭ 8Frequency"
	}
	
	if ([messageFromPicker isEqualToString: testStringB8Frequency] == YES)
	{
		label.text = [NSString stringWithFormat:@"7902.14 Hz"];
		//@"B 8Frequency"
	}
	
	// *********** 9Frequency ifs **********************
	
	if ([messageFromPicker isEqualToString: testStringC9Frequency] == YES)
	{
		label.text = [NSString stringWithFormat:@"8372.00 Hz"];//@"test, C♯oø, E♭, Gxbb+, bbbº, c+7"
		//@"C 9Frequency"
	}
	
	if ([messageFromPicker isEqualToString: testStringCSharp9Frequency] == YES)
	{
		label.text = [NSString stringWithFormat:@"8869.84 Hz"];
		//@"C♯ 9Frequency"
	}
	
	if ([messageFromPicker isEqualToString: testStringDb9Frequency] == YES)
	{
		label.text = [NSString stringWithFormat:@"8869.84 Hz"];
		//@"D♭ 9Frequency"
	}
	
	if ([messageFromPicker isEqualToString: testStringD9Frequency] == YES)
	{
		label.text = [NSString stringWithFormat:@"9397.28 Hz"];
		//@"D 9Frequency"
	}
	
	if ([messageFromPicker isEqualToString: testStringDSharp9Frequency] == YES)
	{
		label.text = [NSString stringWithFormat:@"9956.08 Hz"];
		//@"D♯ 9Frequency"
	}
	
	if ([messageFromPicker isEqualToString: testStringEb9Frequency] == YES)
	{
		label.text = [NSString stringWithFormat:@"9956.08 Hz"];
		//@"E♭ 9Frequency"
	}
	
	if ([messageFromPicker isEqualToString: testStringE9Frequency] == YES)
	{
		label.text = [NSString stringWithFormat:@"10548.08 Hz"];
		//@"E 9Frequency"
	}
	
	if ([messageFromPicker isEqualToString: testStringF9Frequency] == YES)
	{
		label.text = [NSString stringWithFormat:@"11175.32 Hz"];
		//@"F 9Frequency"
	}
	
	if ([messageFromPicker isEqualToString: testStringFSharp9Frequency] == YES)
	{
		label.text = [NSString stringWithFormat:@"11839.84 Hz"];
		//@"F♯ 9Frequency"
	}
	
	if ([messageFromPicker isEqualToString: testStringGb9Frequency] == YES)
	{
		label.text = [NSString stringWithFormat:@"11839.84 Hz"];
		//@"G♭ 9Frequency"
	}
	
	if ([messageFromPicker isEqualToString: testStringG9Frequency] == YES)
	{
		label.text = [NSString stringWithFormat:@"12543.84 Hz"];
		//@"G 9Frequency"
	}
	
	if ([messageFromPicker isEqualToString: testStringGSharp9Frequency] == YES)
	{
		label.text = [NSString stringWithFormat:@"13289.76 Hz"];
		//@"G♯ 9Frequency"
	}
	
	if ([messageFromPicker isEqualToString: testStringAb9Frequency] == YES)
	{
		label.text = [NSString stringWithFormat:@"13289.76 Hz"];
		//@"A♭ 9Frequency"
	}
	
	if ([messageFromPicker isEqualToString: testStringA9Frequency] == YES)
	{
		label.text = [NSString stringWithFormat:@"14080.00 Hz"];
		//@"A 9Frequency"
	}
	
	if ([messageFromPicker isEqualToString: testStringASharp9Frequency] == YES)
	{
		label.text = [NSString stringWithFormat:@"14916.00 Hz"];
		//@"A♯ 9Frequency"
	}
	
	if ([messageFromPicker isEqualToString: testStringBb9Frequency] == YES)
	{
		label.text = [NSString stringWithFormat:@"14916.00 Hz"];
		//@"B♭ 9Frequency"
	}
	
	if ([messageFromPicker isEqualToString: testStringB9Frequency] == YES)
	{
		label.text = [NSString stringWithFormat:@"15804.28 Hz"];
		//@"B 9Frequency"
	}	
	
	// *********** 0MIDI ifs **********************
	
	if ([messageFromPicker isEqualToString: testStringC0MIDI] == YES)
	{
		label.text = [NSString stringWithFormat:@"12"];//@"test, C♯oø, E♭, Gxbb+, bbbº, c+7"
		//@"C 0MIDI"
	}
	
	if ([messageFromPicker isEqualToString: testStringCSharp0MIDI] == YES)
	{
		label.text = [NSString stringWithFormat:@"13"];
		//@"C♯ 0MIDI"
	}
	
	if ([messageFromPicker isEqualToString: testStringDb0MIDI] == YES)
	{
		label.text = [NSString stringWithFormat:@"13"];
		//@"D♭ 0MIDI"
	}
	
	if ([messageFromPicker isEqualToString: testStringD0MIDI] == YES)
	{
		label.text = [NSString stringWithFormat:@"14"];
		//@"D 0MIDI"
	}
	
	if ([messageFromPicker isEqualToString: testStringDSharp0MIDI] == YES)
	{
		label.text = [NSString stringWithFormat:@"15"];
		//@"D♯ 0MIDI"
	}
	
	if ([messageFromPicker isEqualToString: testStringEb0MIDI] == YES)
	{
		label.text = [NSString stringWithFormat:@"15"];
		//@"E♭ 0MIDI"
	}
	
	if ([messageFromPicker isEqualToString: testStringE0MIDI] == YES)
	{
		label.text = [NSString stringWithFormat:@"16"];
		//@"E 0MIDI"
	}
	
	if ([messageFromPicker isEqualToString: testStringF0MIDI] == YES)
	{
		label.text = [NSString stringWithFormat:@"17"];
		//@"F 0MIDI"
	}
	
	if ([messageFromPicker isEqualToString: testStringFSharp0MIDI] == YES)
	{
		label.text = [NSString stringWithFormat:@"18"];
		//@"F♯ 0MIDI"
	}
	
	if ([messageFromPicker isEqualToString: testStringGb0MIDI] == YES)
	{
		label.text = [NSString stringWithFormat:@"18"];
		//@"G♭ 0MIDI"
	}
	
	if ([messageFromPicker isEqualToString: testStringG0MIDI] == YES)
	{
		label.text = [NSString stringWithFormat:@"19"];
		//@"G 0MIDI"
	}
	
	if ([messageFromPicker isEqualToString: testStringGSharp0MIDI] == YES)
	{
		label.text = [NSString stringWithFormat:@"20"];
		//@"G♯ 0MIDI"
	}
	
	if ([messageFromPicker isEqualToString: testStringAb0MIDI] == YES)
	{
		label.text = [NSString stringWithFormat:@"20"];
		//@"A♭ 0MIDI"
	}
	
	if ([messageFromPicker isEqualToString: testStringA0MIDI] == YES)
	{
		label.text = [NSString stringWithFormat:@"21"];
		//@"A 0MIDI"
	}
	
	if ([messageFromPicker isEqualToString: testStringASharp0MIDI] == YES)
	{
		label.text = [NSString stringWithFormat:@"22"];
		//@"A♯ 0MIDI"
	}
	
	if ([messageFromPicker isEqualToString: testStringBb0MIDI] == YES)
	{
		label.text = [NSString stringWithFormat:@"22"];
		//@"B♭ 0MIDI"
	}
	
	if ([messageFromPicker isEqualToString: testStringB0MIDI] == YES)
	{
		label.text = [NSString stringWithFormat:@"23"];
		//@"B 0MIDI"
	}
	
	// *********** 1MIDI ifs **********************
	
	if ([messageFromPicker isEqualToString: testStringC1MIDI] == YES)
	{
		label.text = [NSString stringWithFormat:@"24"];//@"test, C♯oø, E♭, Gxbb+, bbbº, c+7"
		//@"C 1MIDI"
	}
	
	if ([messageFromPicker isEqualToString: testStringCSharp1MIDI] == YES)
	{
		label.text = [NSString stringWithFormat:@"25"];
		//@"C♯ 1MIDI"
	}
	
	if ([messageFromPicker isEqualToString: testStringDb1MIDI] == YES)
	{
		label.text = [NSString stringWithFormat:@"25"];
		//@"D♭ 1MIDI"
	}
	
	if ([messageFromPicker isEqualToString: testStringD1MIDI] == YES)
	{
		label.text = [NSString stringWithFormat:@"26"];
		//@"D 1MIDI"
	}
	
	if ([messageFromPicker isEqualToString: testStringDSharp1MIDI] == YES)
	{
		label.text = [NSString stringWithFormat:@"27"];
		//@"D♯ 1MIDI"
	}
	
	if ([messageFromPicker isEqualToString: testStringEb1MIDI] == YES)
	{
		label.text = [NSString stringWithFormat:@"27"];
		//@"E♭ 1MIDI"
	}
	
	if ([messageFromPicker isEqualToString: testStringE1MIDI] == YES)
	{
		label.text = [NSString stringWithFormat:@"28"];
		//@"E 1MIDI"
	}
	
	if ([messageFromPicker isEqualToString: testStringF1MIDI] == YES)
	{
		label.text = [NSString stringWithFormat:@"29"];
		//@"F 1MIDI"
	}
	
	if ([messageFromPicker isEqualToString: testStringFSharp1MIDI] == YES)
	{
		label.text = [NSString stringWithFormat:@"30"];
		//@"F♯ 1MIDI"
	}
	
	if ([messageFromPicker isEqualToString: testStringGb1MIDI] == YES)
	{
		label.text = [NSString stringWithFormat:@"30"];
		//@"G♭ 1MIDI"
	}
	
	if ([messageFromPicker isEqualToString: testStringG1MIDI] == YES)
	{
		label.text = [NSString stringWithFormat:@"31"];
		//@"G 1MIDI"
	}
	
	if ([messageFromPicker isEqualToString: testStringGSharp1MIDI] == YES)
	{
		label.text = [NSString stringWithFormat:@"32"];
		//@"G♯ 1MIDI"
	}
	
	if ([messageFromPicker isEqualToString: testStringAb1MIDI] == YES)
	{
		label.text = [NSString stringWithFormat:@"32"];
		//@"A♭ 1MIDI"
	}
	
	if ([messageFromPicker isEqualToString: testStringA1MIDI] == YES)
	{
		label.text = [NSString stringWithFormat:@"33"];
		//@"A 1MIDI"
	}
	
	if ([messageFromPicker isEqualToString: testStringASharp1MIDI] == YES)
	{
		label.text = [NSString stringWithFormat:@"34"];
		//@"A♯ 1MIDI"
	}
	
	if ([messageFromPicker isEqualToString: testStringBb1MIDI] == YES)
	{
		label.text = [NSString stringWithFormat:@"34"];
		//@"B♭ 1MIDI"
	}
	
	if ([messageFromPicker isEqualToString: testStringB1MIDI] == YES)
	{
		label.text = [NSString stringWithFormat:@"35"];
		//@"B 1MIDI"
	}
	
	// *********** 2MIDI ifs **********************
	
	if ([messageFromPicker isEqualToString: testStringC2MIDI] == YES)
	{
		label.text = [NSString stringWithFormat:@"36"];//@"test, C♯oø, E♭, Gxbb+, bbbº, c+7"
		//@"C 2MIDI"
	}
	
	if ([messageFromPicker isEqualToString: testStringCSharp2MIDI] == YES)
	{
		label.text = [NSString stringWithFormat:@"37"];
		//@"C♯ 2MIDI"
	}
	
	if ([messageFromPicker isEqualToString: testStringDb2MIDI] == YES)
	{
		label.text = [NSString stringWithFormat:@"37"];
		//@"D♭ 2MIDI"
	}
	
	if ([messageFromPicker isEqualToString: testStringD2MIDI] == YES)
	{
		label.text = [NSString stringWithFormat:@"38"];
		//@"D 2MIDI"
	}
	
	if ([messageFromPicker isEqualToString: testStringDSharp2MIDI] == YES)
	{
		label.text = [NSString stringWithFormat:@"39"];
		//@"D♯ 2MIDI"
	}
	
	if ([messageFromPicker isEqualToString: testStringEb2MIDI] == YES)
	{
		label.text = [NSString stringWithFormat:@"39"];
		//@"E♭ 2MIDI"
	}
	
	if ([messageFromPicker isEqualToString: testStringE2MIDI] == YES)
	{
		label.text = [NSString stringWithFormat:@"40"];
		//@"E 2MIDI"
	}
	
	if ([messageFromPicker isEqualToString: testStringF2MIDI] == YES)
	{
		label.text = [NSString stringWithFormat:@"41"];
		//@"F 2MIDI"
	}
	
	if ([messageFromPicker isEqualToString: testStringFSharp2MIDI] == YES)
	{
		label.text = [NSString stringWithFormat:@"42"];
		//@"F♯ 2MIDI"
	}
	
	if ([messageFromPicker isEqualToString: testStringGb2MIDI] == YES)
	{
		label.text = [NSString stringWithFormat:@"42"];
		//@"G♭ 2MIDI"
	}
	
	if ([messageFromPicker isEqualToString: testStringG2MIDI] == YES)
	{
		label.text = [NSString stringWithFormat:@"43"];
		//@"G 2MIDI"
	}
	
	if ([messageFromPicker isEqualToString: testStringGSharp2MIDI] == YES)
	{
		label.text = [NSString stringWithFormat:@"44"];
		//@"G♯ 2MIDI"
	}
	
	if ([messageFromPicker isEqualToString: testStringAb2MIDI] == YES)
	{
		label.text = [NSString stringWithFormat:@"44"];
		//@"A♭ 2MIDI"
	}
	
	if ([messageFromPicker isEqualToString: testStringA2MIDI] == YES)
	{
		label.text = [NSString stringWithFormat:@"45"];
		//@"A 2MIDI"
	}
	
	if ([messageFromPicker isEqualToString: testStringASharp2MIDI] == YES)
	{
		label.text = [NSString stringWithFormat:@"46"];
		//@"A♯ 2MIDI"
	}
	
	if ([messageFromPicker isEqualToString: testStringBb2MIDI] == YES)
	{
		label.text = [NSString stringWithFormat:@"46"];
		//@"B♭ 2MIDI"
	}
	
	if ([messageFromPicker isEqualToString: testStringB2MIDI] == YES)
	{
		label.text = [NSString stringWithFormat:@"47"];
		//@"B 2MIDI"
	}
	
	// *********** 3MIDI ifs **********************
	
	if ([messageFromPicker isEqualToString: testStringC3MIDI] == YES)
	{
		label.text = [NSString stringWithFormat:@"48"];//@"test, C♯oø, E♭, Gxbb+, bbbº, c+7"
		//@"C 3MIDI"
	}
	
	if ([messageFromPicker isEqualToString: testStringCSharp3MIDI] == YES)
	{
		label.text = [NSString stringWithFormat:@"49"];
		//@"C♯ 3MIDI"
	}
	
	if ([messageFromPicker isEqualToString: testStringDb3MIDI] == YES)
	{
		label.text = [NSString stringWithFormat:@"49"];
		//@"D♭ 3MIDI"
	}
	
	if ([messageFromPicker isEqualToString: testStringD3MIDI] == YES)
	{
		label.text = [NSString stringWithFormat:@"50"];
		//@"D 3MIDI"
	}
	
	if ([messageFromPicker isEqualToString: testStringDSharp3MIDI] == YES)
	{
		label.text = [NSString stringWithFormat:@"51"];
		//@"D♯ 3MIDI"
	}
	
	if ([messageFromPicker isEqualToString: testStringEb3MIDI] == YES)
	{
		label.text = [NSString stringWithFormat:@"51"];
		//@"E♭ 3MIDI"
	}
	
	if ([messageFromPicker isEqualToString: testStringE3MIDI] == YES)
	{
		label.text = [NSString stringWithFormat:@"52"];
		//@"E 3MIDI"
	}
	
	if ([messageFromPicker isEqualToString: testStringF3MIDI] == YES)
	{
		label.text = [NSString stringWithFormat:@"53"];
		//@"F 3MIDI"
	}
	
	if ([messageFromPicker isEqualToString: testStringFSharp3MIDI] == YES)
	{
		label.text = [NSString stringWithFormat:@"54"];
		//@"F♯ 3MIDI"
	}
	
	if ([messageFromPicker isEqualToString: testStringGb3MIDI] == YES)
	{
		label.text = [NSString stringWithFormat:@"54"];
		//@"G♭ 3MIDI"
	}
	
	if ([messageFromPicker isEqualToString: testStringG3MIDI] == YES)
	{
		label.text = [NSString stringWithFormat:@"55"];
		//@"G 3MIDI"
	}
	
	if ([messageFromPicker isEqualToString: testStringGSharp3MIDI] == YES)
	{
		label.text = [NSString stringWithFormat:@"56"];
		//@"G♯ 3MIDI"
	}
	
	if ([messageFromPicker isEqualToString: testStringAb3MIDI] == YES)
	{
		label.text = [NSString stringWithFormat:@"56"];
		//@"A♭ 3MIDI"
	}
	
	if ([messageFromPicker isEqualToString: testStringA3MIDI] == YES)
	{
		label.text = [NSString stringWithFormat:@"57"];
		//@"A 3MIDI"
	}
	
	if ([messageFromPicker isEqualToString: testStringASharp3MIDI] == YES)
	{
		label.text = [NSString stringWithFormat:@"58"];
		//@"A♯ 3MIDI"
	}
	
	if ([messageFromPicker isEqualToString: testStringBb3MIDI] == YES)
	{
		label.text = [NSString stringWithFormat:@"58"];
		//@"B♭ 3MIDI"
	}
	
	if ([messageFromPicker isEqualToString: testStringB3MIDI] == YES)
	{
		label.text = [NSString stringWithFormat:@"59"];
		//@"B 3MIDI"
	}
	
	// *********** 4MIDI ifs **********************
	
	if ([messageFromPicker isEqualToString: testStringC4MIDI] == YES)
	{
		label.text = [NSString stringWithFormat:@"60"];//@"test, C♯oø, E♭, Gxbb+, bbbº, c+7"
		//@"C 4MIDI"
	}
	
	if ([messageFromPicker isEqualToString: testStringCSharp4MIDI] == YES)
	{
		label.text = [NSString stringWithFormat:@"61"];
		//@"C♯ 4MIDI"
	}
	
	if ([messageFromPicker isEqualToString: testStringDb4MIDI] == YES)
	{
		label.text = [NSString stringWithFormat:@"61"];
		//@"D♭ 4MIDI"
	}
	
	if ([messageFromPicker isEqualToString: testStringD4MIDI] == YES)
	{
		label.text = [NSString stringWithFormat:@"62"];
		//@"D 4MIDI"
	}
	
	if ([messageFromPicker isEqualToString: testStringDSharp4MIDI] == YES)
	{
		label.text = [NSString stringWithFormat:@"63"];
		//@"D♯ 4MIDI"
	}
	
	if ([messageFromPicker isEqualToString: testStringEb4MIDI] == YES)
	{
		label.text = [NSString stringWithFormat:@"63"];
		//@"E♭ 4MIDI"
	}
	
	if ([messageFromPicker isEqualToString: testStringE4MIDI] == YES)
	{
		label.text = [NSString stringWithFormat:@"64"];
		//@"E 4MIDI"
	}
	
	if ([messageFromPicker isEqualToString: testStringF4MIDI] == YES)
	{
		label.text = [NSString stringWithFormat:@"65"];
		//@"F 4MIDI"
	}
	
	if ([messageFromPicker isEqualToString: testStringFSharp4MIDI] == YES)
	{
		label.text = [NSString stringWithFormat:@"66"];
		//@"F♯ 4MIDI"
	}
	
	if ([messageFromPicker isEqualToString: testStringGb4MIDI] == YES)
	{
		label.text = [NSString stringWithFormat:@"66"];
		//@"G♭ 4MIDI"
	}
	
	if ([messageFromPicker isEqualToString: testStringG4MIDI] == YES)
	{
		label.text = [NSString stringWithFormat:@"67"];
		//@"G 4MIDI"
	}
	
	if ([messageFromPicker isEqualToString: testStringGSharp4MIDI] == YES)
	{
		label.text = [NSString stringWithFormat:@"68"];
		//@"G♯ 4MIDI"
	}
	
	if ([messageFromPicker isEqualToString: testStringAb4MIDI] == YES)
	{
		label.text = [NSString stringWithFormat:@"68"];
		//@"A♭ 4MIDI"
	}
	
	if ([messageFromPicker isEqualToString: testStringA4MIDI] == YES)
	{
		label.text = [NSString stringWithFormat:@"69"];
		//@"A 4MIDI"
	}
	
	if ([messageFromPicker isEqualToString: testStringASharp4MIDI] == YES)
	{
		label.text = [NSString stringWithFormat:@"70"];
		//@"A♯ 4MIDI"
	}
	
	if ([messageFromPicker isEqualToString: testStringBb4MIDI] == YES)
	{
		label.text = [NSString stringWithFormat:@"70"];
		//@"B♭ 4MIDI"
	}
	
	if ([messageFromPicker isEqualToString: testStringB4MIDI] == YES)
	{
		label.text = [NSString stringWithFormat:@"71"];
		//@"B 4MIDI"
	}
	
	// *********** 5MIDI ifs **********************
	
	if ([messageFromPicker isEqualToString: testStringC5MIDI] == YES)
	{
		label.text = [NSString stringWithFormat:@"72"];//@"test, C♯oø, E♭, Gxbb+, bbbº, c+7"
		//@"C 5MIDI"
	}
	
	if ([messageFromPicker isEqualToString: testStringCSharp5MIDI] == YES)
	{
		label.text = [NSString stringWithFormat:@"73"];
		//@"C♯ 5MIDI"
	}
	
	if ([messageFromPicker isEqualToString: testStringDb5MIDI] == YES)
	{
		label.text = [NSString stringWithFormat:@"73"];
		//@"D♭ 5MIDI"
	}
	
	if ([messageFromPicker isEqualToString: testStringD5MIDI] == YES)
	{
		label.text = [NSString stringWithFormat:@"74"];
		//@"D 5MIDI"
	}
	
	if ([messageFromPicker isEqualToString: testStringDSharp5MIDI] == YES)
	{
		label.text = [NSString stringWithFormat:@"75"];
		//@"D♯ 5MIDI"
	}
	
	if ([messageFromPicker isEqualToString: testStringEb5MIDI] == YES)
	{
		label.text = [NSString stringWithFormat:@"75"];
		//@"E♭ 5MIDI"
	}
	
	if ([messageFromPicker isEqualToString: testStringE5MIDI] == YES)
	{
		label.text = [NSString stringWithFormat:@"76"];
		//@"E 5MIDI"
	}
	
	if ([messageFromPicker isEqualToString: testStringF5MIDI] == YES)
	{
		label.text = [NSString stringWithFormat:@"77"];
		//@"F 5MIDI"
	}
	
	if ([messageFromPicker isEqualToString: testStringFSharp5MIDI] == YES)
	{
		label.text = [NSString stringWithFormat:@"78"];
		//@"F♯ 5MIDI"
	}
	
	if ([messageFromPicker isEqualToString: testStringGb5MIDI] == YES)
	{
		label.text = [NSString stringWithFormat:@"78"];
		//@"G♭ 5MIDI"
	}
	
	if ([messageFromPicker isEqualToString: testStringG5MIDI] == YES)
	{
		label.text = [NSString stringWithFormat:@"79"];
		//@"G 5MIDI"
	}
	
	if ([messageFromPicker isEqualToString: testStringGSharp5MIDI] == YES)
	{
		label.text = [NSString stringWithFormat:@"80"];
		//@"G♯ 5MIDI"
	}
	
	if ([messageFromPicker isEqualToString: testStringAb5MIDI] == YES)
	{
		label.text = [NSString stringWithFormat:@"80"];
		//@"A♭ 5MIDI"
	}
	
	if ([messageFromPicker isEqualToString: testStringA5MIDI] == YES)
	{
		label.text = [NSString stringWithFormat:@"81"];
		//@"A 5MIDI"
	}
	
	if ([messageFromPicker isEqualToString: testStringASharp5MIDI] == YES)
	{
		label.text = [NSString stringWithFormat:@"82"];
		//@"A♯ 5MIDI"
	}
	
	if ([messageFromPicker isEqualToString: testStringBb5MIDI] == YES)
	{
		label.text = [NSString stringWithFormat:@"82"];
		//@"B♭ 5MIDI"
	}
	
	if ([messageFromPicker isEqualToString: testStringB5MIDI] == YES)
	{
		label.text = [NSString stringWithFormat:@"83"];
		//@"B 5MIDI"
	}
	
	// *********** 6MIDI ifs **********************
	
	if ([messageFromPicker isEqualToString: testStringC6MIDI] == YES)
	{
		label.text = [NSString stringWithFormat:@"84"];//@"test, C♯oø, E♭, Gxbb+, bbbº, c+7"
		//@"C 6MIDI"
	}
	
	if ([messageFromPicker isEqualToString: testStringCSharp6MIDI] == YES)
	{
		label.text = [NSString stringWithFormat:@"85"];
		//@"C♯ 6MIDI"
	}
	
	if ([messageFromPicker isEqualToString: testStringDb6MIDI] == YES)
	{
		label.text = [NSString stringWithFormat:@"85"];
		//@"D♭ 6MIDI"
	}
	
	if ([messageFromPicker isEqualToString: testStringD6MIDI] == YES)
	{
		label.text = [NSString stringWithFormat:@"86"];
		//@"D 6MIDI"
	}
	
	if ([messageFromPicker isEqualToString: testStringDSharp6MIDI] == YES)
	{
		label.text = [NSString stringWithFormat:@"87"];
		//@"D♯ 6MIDI"
	}
	
	if ([messageFromPicker isEqualToString: testStringEb6MIDI] == YES)
	{
		label.text = [NSString stringWithFormat:@"87"];
		//@"E♭ 6MIDI"
	}
	
	if ([messageFromPicker isEqualToString: testStringE6MIDI] == YES)
	{
		label.text = [NSString stringWithFormat:@"88"];
		//@"E 6MIDI"
	}
	
	if ([messageFromPicker isEqualToString: testStringF6MIDI] == YES)
	{
		label.text = [NSString stringWithFormat:@"89"];
		//@"F 6MIDI"
	}
	
	if ([messageFromPicker isEqualToString: testStringFSharp6MIDI] == YES)
	{
		label.text = [NSString stringWithFormat:@"90"];
		//@"F♯ 6MIDI"
	}
	
	if ([messageFromPicker isEqualToString: testStringGb6MIDI] == YES)
	{
		label.text = [NSString stringWithFormat:@"90"];
		//@"G♭ 6MIDI"
	}
	
	if ([messageFromPicker isEqualToString: testStringG6MIDI] == YES)
	{
		label.text = [NSString stringWithFormat:@"91"];
		//@"G 6MIDI"
	}
	
	if ([messageFromPicker isEqualToString: testStringGSharp6MIDI] == YES)
	{
		label.text = [NSString stringWithFormat:@"92"];
		//@"G♯ 6MIDI"
	}
	
	if ([messageFromPicker isEqualToString: testStringAb6MIDI] == YES)
	{
		label.text = [NSString stringWithFormat:@"92"];
		//@"A♭ 6MIDI"
	}
	
	if ([messageFromPicker isEqualToString: testStringA6MIDI] == YES)
	{
		label.text = [NSString stringWithFormat:@"93"];
		//@"A 6MIDI"
	}
	
	if ([messageFromPicker isEqualToString: testStringASharp6MIDI] == YES)
	{
		label.text = [NSString stringWithFormat:@"94"];
		//@"A♯ 6MIDI"
	}
	
	if ([messageFromPicker isEqualToString: testStringBb6MIDI] == YES)
	{
		label.text = [NSString stringWithFormat:@"94"];
		//@"B♭ 6MIDI"
	}
	
	if ([messageFromPicker isEqualToString: testStringB6MIDI] == YES)
	{
		label.text = [NSString stringWithFormat:@"95"];
		//@"B 6MIDI"
	}
	
	// *********** 7MIDI ifs **********************
	
	if ([messageFromPicker isEqualToString: testStringC7MIDI] == YES)
	{
		label.text = [NSString stringWithFormat:@"96"];//@"test, C♯oø, E♭, Gxbb+, bbbº, c+7"
		//@"C 7MIDI"
	}
	
	if ([messageFromPicker isEqualToString: testStringCSharp7MIDI] == YES)
	{
		label.text = [NSString stringWithFormat:@"97"];
		//@"C♯ 7MIDI"
	}
	
	if ([messageFromPicker isEqualToString: testStringDb7MIDI] == YES)
	{
		label.text = [NSString stringWithFormat:@"97"];
		//@"D♭ 7MIDI"
	}
	
	if ([messageFromPicker isEqualToString: testStringD7MIDI] == YES)
	{
		label.text = [NSString stringWithFormat:@"98"];
		//@"D 7MIDI"
	}
	
	if ([messageFromPicker isEqualToString: testStringDSharp7MIDI] == YES)
	{
		label.text = [NSString stringWithFormat:@"99"];
		//@"D♯ 7MIDI"
	}
	
	if ([messageFromPicker isEqualToString: testStringEb7MIDI] == YES)
	{
		label.text = [NSString stringWithFormat:@"99"];
		//@"E♭ 7MIDI"
	}
	
	if ([messageFromPicker isEqualToString: testStringE7MIDI] == YES)
	{
		label.text = [NSString stringWithFormat:@"100"];
		//@"E 7MIDI"
	}
	
	if ([messageFromPicker isEqualToString: testStringF7MIDI] == YES)
	{
		label.text = [NSString stringWithFormat:@"101"];
		//@"F 7MIDI"
	}
	
	if ([messageFromPicker isEqualToString: testStringFSharp7MIDI] == YES)
	{
		label.text = [NSString stringWithFormat:@"102"];
		//@"F♯ 7MIDI"
	}
	
	if ([messageFromPicker isEqualToString: testStringGb7MIDI] == YES)
	{
		label.text = [NSString stringWithFormat:@"102"];
		//@"G♭ 7MIDI"
	}
	
	if ([messageFromPicker isEqualToString: testStringG7MIDI] == YES)
	{
		label.text = [NSString stringWithFormat:@"103"];
		//@"G 7MIDI"
	}
	
	if ([messageFromPicker isEqualToString: testStringGSharp7MIDI] == YES)
	{
		label.text = [NSString stringWithFormat:@"104"];
		//@"G♯ 7MIDI"
	}
	
	if ([messageFromPicker isEqualToString: testStringAb7MIDI] == YES)
	{
		label.text = [NSString stringWithFormat:@"104"];
		//@"A♭ 7MIDI"
	}
	
	if ([messageFromPicker isEqualToString: testStringA7MIDI] == YES)
	{
		label.text = [NSString stringWithFormat:@"105"];
		//@"A 7MIDI"
	}
	
	if ([messageFromPicker isEqualToString: testStringASharp7MIDI] == YES)
	{
		label.text = [NSString stringWithFormat:@"106"];
		//@"A♯ 7MIDI"
	}
	
	if ([messageFromPicker isEqualToString: testStringBb7MIDI] == YES)
	{
		label.text = [NSString stringWithFormat:@"106"];
		//@"B♭ 7MIDI"
	}
	
	if ([messageFromPicker isEqualToString: testStringB7MIDI] == YES)
	{
		label.text = [NSString stringWithFormat:@"107"];
		//@"B 7MIDI"
	}
	
	// *********** _1MIDI ifs **********************
	
	if ([messageFromPicker isEqualToString: testStringC_1MIDI] == YES)
	{
		label.text = [NSString stringWithFormat:@"0"];//@"test, C♯oø, E♭, Gxbb+, bbbº, c+7"
		//@"C _1MIDI"
	}
	
	if ([messageFromPicker isEqualToString: testStringCSharp_1MIDI] == YES)
	{
		label.text = [NSString stringWithFormat:@"1"];
		//@"C♯ _1MIDI"
	}
	
	if ([messageFromPicker isEqualToString: testStringDb_1MIDI] == YES)
	{
		label.text = [NSString stringWithFormat:@"1"];
		//@"D♭ _1MIDI"
	}
	
	if ([messageFromPicker isEqualToString: testStringD_1MIDI] == YES)
	{
		label.text = [NSString stringWithFormat:@"2"];
		//@"D _1MIDI"
	}
	
	if ([messageFromPicker isEqualToString: testStringDSharp_1MIDI] == YES)
	{
		label.text = [NSString stringWithFormat:@"3"];
		//@"D♯ _1MIDI"
	}
	
	if ([messageFromPicker isEqualToString: testStringEb_1MIDI] == YES)
	{
		label.text = [NSString stringWithFormat:@"3"];
		//@"E♭ _1MIDI"
	}
	
	if ([messageFromPicker isEqualToString: testStringE_1MIDI] == YES)
	{
		label.text = [NSString stringWithFormat:@"4"];
		//@"E _1MIDI"
	}
	
	if ([messageFromPicker isEqualToString: testStringF_1MIDI] == YES)
	{
		label.text = [NSString stringWithFormat:@"5"];
		//@"F _1MIDI"
	}
	
	if ([messageFromPicker isEqualToString: testStringFSharp_1MIDI] == YES)
	{
		label.text = [NSString stringWithFormat:@"6"];
		//@"F♯ _1MIDI"
	}
	
	if ([messageFromPicker isEqualToString: testStringGb_1MIDI] == YES)
	{
		label.text = [NSString stringWithFormat:@"6"];
		//@"G♭ _1MIDI"
	}
	
	if ([messageFromPicker isEqualToString: testStringG_1MIDI] == YES)
	{
		label.text = [NSString stringWithFormat:@"7"];
		//@"G _1MIDI"
	}
	
	if ([messageFromPicker isEqualToString: testStringGSharp_1MIDI] == YES)
	{
		label.text = [NSString stringWithFormat:@"8"];
		//@"G♯ _1MIDI"
	}
	
	if ([messageFromPicker isEqualToString: testStringAb_1MIDI] == YES)
	{
		label.text = [NSString stringWithFormat:@"8"];
		//@"A♭ _1MIDI"
	}
	
	if ([messageFromPicker isEqualToString: testStringA_1MIDI] == YES)
	{
		label.text = [NSString stringWithFormat:@"9"];
		//@"A _1MIDI"
	}
	
	if ([messageFromPicker isEqualToString: testStringASharp_1MIDI] == YES)
	{
		label.text = [NSString stringWithFormat:@"10"];
		//@"A♯ _1MIDI"
	}
	
	if ([messageFromPicker isEqualToString: testStringBb_1MIDI] == YES)
	{
		label.text = [NSString stringWithFormat:@"10"];
		//@"B♭ _1MIDI"
	}
	
	if ([messageFromPicker isEqualToString: testStringB_1MIDI] == YES)
	{
		label.text = [NSString stringWithFormat:@"11"];
		//@"B _1MIDI"
	}
	
	// *********** 8MIDI ifs **********************
	
	if ([messageFromPicker isEqualToString: testStringC8MIDI] == YES)
	{
		label.text = [NSString stringWithFormat:@"108"];//@"test, C♯oø, E♭, Gxbb+, bbbº, c+7"
		//@"C 8MIDI"
	}
	
	if ([messageFromPicker isEqualToString: testStringCSharp8MIDI] == YES)
	{
		label.text = [NSString stringWithFormat:@"109"];
		//@"C♯ 8MIDI"
	}
	
	if ([messageFromPicker isEqualToString: testStringDb8MIDI] == YES)
	{
		label.text = [NSString stringWithFormat:@"109"];
		//@"D♭ 8MIDI"
	}
	
	if ([messageFromPicker isEqualToString: testStringD8MIDI] == YES)
	{
		label.text = [NSString stringWithFormat:@"110"];
		//@"D 8MIDI"
	}
	
	if ([messageFromPicker isEqualToString: testStringDSharp8MIDI] == YES)
	{
		label.text = [NSString stringWithFormat:@"111"];
		//@"D♯ 8MIDI"
	}
	
	if ([messageFromPicker isEqualToString: testStringEb8MIDI] == YES)
	{
		label.text = [NSString stringWithFormat:@"111"];
		//@"E♭ 8MIDI"
	}
	
	if ([messageFromPicker isEqualToString: testStringE8MIDI] == YES)
	{
		label.text = [NSString stringWithFormat:@"112"];
		//@"E 8MIDI"
	}
	
	if ([messageFromPicker isEqualToString: testStringF8MIDI] == YES)
	{
		label.text = [NSString stringWithFormat:@"113"];
		//@"F 8MIDI"
	}
	
	if ([messageFromPicker isEqualToString: testStringFSharp8MIDI] == YES)
	{
		label.text = [NSString stringWithFormat:@"114"];
		//@"F♯ 8MIDI"
	}
	
	if ([messageFromPicker isEqualToString: testStringGb8MIDI] == YES)
	{
		label.text = [NSString stringWithFormat:@"114"];
		//@"G♭ 8MIDI"
	}
	
	if ([messageFromPicker isEqualToString: testStringG8MIDI] == YES)
	{
		label.text = [NSString stringWithFormat:@"115"];
		//@"G 8MIDI"
	}
	
	if ([messageFromPicker isEqualToString: testStringGSharp8MIDI] == YES)
	{
		label.text = [NSString stringWithFormat:@"116"];
		//@"G♯ 8MIDI"
	}
	
	if ([messageFromPicker isEqualToString: testStringAb8MIDI] == YES)
	{
		label.text = [NSString stringWithFormat:@"116"];
		//@"A♭ 8MIDI"
	}
	
	if ([messageFromPicker isEqualToString: testStringA8MIDI] == YES)
	{
		label.text = [NSString stringWithFormat:@"117"];
		//@"A 8MIDI"
	}
	
	if ([messageFromPicker isEqualToString: testStringASharp8MIDI] == YES)
	{
		label.text = [NSString stringWithFormat:@"118"];
		//@"A♯ 8MIDI"
	}
	
	if ([messageFromPicker isEqualToString: testStringBb8MIDI] == YES)
	{
		label.text = [NSString stringWithFormat:@"118"];
		//@"B♭ 8MIDI"
	}
	
	if ([messageFromPicker isEqualToString: testStringB8MIDI] == YES)
	{
		label.text = [NSString stringWithFormat:@"119"];
		//@"B 8MIDI"
	}
	
	// *********** 9MIDI ifs **********************
	
	if ([messageFromPicker isEqualToString: testStringC9MIDI] == YES)
	{
		label.text = [NSString stringWithFormat:@"120"];//@"test, C♯oø, E♭, Gxbb+, bbbº, c+7"
		//@"C 9MIDI"
	}
	
	if ([messageFromPicker isEqualToString: testStringCSharp9MIDI] == YES)
	{
		label.text = [NSString stringWithFormat:@"121"];
		//@"C♯ 9MIDI"
	}
	
	if ([messageFromPicker isEqualToString: testStringDb9MIDI] == YES)
	{
		label.text = [NSString stringWithFormat:@"121"];
		//@"D♭ 9MIDI"
	}
	
	if ([messageFromPicker isEqualToString: testStringD9MIDI] == YES)
	{
		label.text = [NSString stringWithFormat:@"122"];
		//@"D 9MIDI"
	}
	
	if ([messageFromPicker isEqualToString: testStringDSharp9MIDI] == YES)
	{
		label.text = [NSString stringWithFormat:@"123"];
		//@"D♯ 9MIDI"
	}
	
	if ([messageFromPicker isEqualToString: testStringEb9MIDI] == YES)
	{
		label.text = [NSString stringWithFormat:@"123"];
		//@"E♭ 9MIDI"
	}
	
	if ([messageFromPicker isEqualToString: testStringE9MIDI] == YES)
	{
		label.text = [NSString stringWithFormat:@"124"];
		//@"E 9MIDI"
	}
	
	if ([messageFromPicker isEqualToString: testStringF9MIDI] == YES)
	{
		label.text = [NSString stringWithFormat:@"125"];
		//@"F 9MIDI"
	}
	
	if ([messageFromPicker isEqualToString: testStringFSharp9MIDI] == YES)
	{
		label.text = [NSString stringWithFormat:@"126"];
		//@"F♯ 9MIDI"
	}
	
	if ([messageFromPicker isEqualToString: testStringGb9MIDI] == YES)
	{
		label.text = [NSString stringWithFormat:@"126"];
		//@"G♭ 9MIDI"
	}
	
	if ([messageFromPicker isEqualToString: testStringG9MIDI] == YES)
	{
		label.text = [NSString stringWithFormat:@"127"];
		//@"G 9MIDI"
	}
	
	if ([messageFromPicker isEqualToString: testStringGSharp9MIDI] == YES)
	{
		label.text = [NSString stringWithFormat:@"No MIDI for this Pitch Class"];
		//@"G♯ 9MIDI"
	}
	
	if ([messageFromPicker isEqualToString: testStringAb9MIDI] == YES)
	{
		label.text = [NSString stringWithFormat:@"No MIDI for this Pitch Class"];
		//@"A♭ 9MIDI"
	}
	
	if ([messageFromPicker isEqualToString: testStringA9MIDI] == YES)
	{
		label.text = [NSString stringWithFormat:@"No MIDI for this Pitch Class"];
		//@"A 9MIDI"
	}
	
	if ([messageFromPicker isEqualToString: testStringASharp9MIDI] == YES)
	{
		label.text = [NSString stringWithFormat:@"No MIDI for this Pitch Class"];
		//@"A♯ 9MIDI"
	}
	
	if ([messageFromPicker isEqualToString: testStringBb9MIDI] == YES)
	{
		label.text = [NSString stringWithFormat:@"No MIDI for this Pitch Class"];
		//@"B♭ 9MIDI"
	}
	
	if ([messageFromPicker isEqualToString: testStringB9MIDI] == YES)
	{
		label.text = [NSString stringWithFormat:@"No MIDI for this Pitch Class"];
		//@"B 9MIDI"
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
	// *********** _1Frequency TEST STRING RELEASE **********************
	[testStringC_1Frequency autorelease];
	[testStringCSharp_1Frequency autorelease];
	[testStringDb_1Frequency autorelease];
	[testStringD_1Frequency autorelease];
	[testStringDSharp_1Frequency autorelease];
	[testStringEb_1Frequency autorelease];
	[testStringE_1Frequency autorelease];
	[testStringF_1Frequency autorelease];
	[testStringFSharp_1Frequency autorelease];
	[testStringGb_1Frequency autorelease];
	[testStringG_1Frequency autorelease];
	[testStringGSharp_1Frequency autorelease];
	[testStringAb_1Frequency autorelease];
	[testStringA_1Frequency autorelease];
	[testStringASharp_1Frequency autorelease];
	[testStringBb_1Frequency autorelease];
	[testStringB_1Frequency autorelease];
	
	// *********** 0Frequency TEST STRING RELEASE **********************
	[testStringC0Frequency autorelease];
	[testStringCSharp0Frequency autorelease];
	[testStringDb0Frequency autorelease];
	[testStringD0Frequency autorelease];
	[testStringDSharp0Frequency autorelease];
	[testStringEb0Frequency autorelease];
	[testStringE0Frequency autorelease];
	[testStringF0Frequency autorelease];
	[testStringFSharp0Frequency autorelease];
	[testStringGb0Frequency autorelease];
	[testStringG0Frequency autorelease];
	[testStringGSharp0Frequency autorelease];
	[testStringAb0Frequency autorelease];
	[testStringA0Frequency autorelease];
	[testStringASharp0Frequency autorelease];
	[testStringBb0Frequency autorelease];
	[testStringB0Frequency autorelease];
	
	// *********** 1Frequency TEST STRING RELEASE **********************
	[testStringC1Frequency autorelease];
	[testStringCSharp1Frequency autorelease];
	[testStringDb1Frequency autorelease];
	[testStringD1Frequency autorelease];
	[testStringDSharp1Frequency autorelease];
	[testStringEb1Frequency autorelease];
	[testStringE1Frequency autorelease];
	[testStringF1Frequency autorelease];
	[testStringFSharp1Frequency autorelease];
	[testStringGb1Frequency autorelease];
	[testStringG1Frequency autorelease];
	[testStringGSharp1Frequency autorelease];
	[testStringAb1Frequency autorelease];
	[testStringA1Frequency autorelease];
	[testStringASharp1Frequency autorelease];
	[testStringBb1Frequency autorelease];
	[testStringB1Frequency autorelease];
	
	// *********** 2Frequency TEST STRING RELEASE **********************
	[testStringC2Frequency autorelease];
	[testStringCSharp2Frequency autorelease];
	[testStringDb2Frequency autorelease];
	[testStringD2Frequency autorelease];
	[testStringDSharp2Frequency autorelease];
	[testStringEb2Frequency autorelease];
	[testStringE2Frequency autorelease];
	[testStringF2Frequency autorelease];
	[testStringFSharp2Frequency autorelease];
	[testStringGb2Frequency autorelease];
	[testStringG2Frequency autorelease];
	[testStringGSharp2Frequency autorelease];
	[testStringAb2Frequency autorelease];
	[testStringA2Frequency autorelease];
	[testStringASharp2Frequency autorelease];
	[testStringBb2Frequency autorelease];
	[testStringB2Frequency autorelease];
	
	// *********** 3Frequency TEST STRING RELEASE **********************
	[testStringC3Frequency autorelease];
	[testStringCSharp3Frequency autorelease];
	[testStringDb3Frequency autorelease];
	[testStringD3Frequency autorelease];
	[testStringDSharp3Frequency autorelease];
	[testStringEb3Frequency autorelease];
	[testStringE3Frequency autorelease];
	[testStringF3Frequency autorelease];
	[testStringFSharp3Frequency autorelease];
	[testStringGb3Frequency autorelease];
	[testStringG3Frequency autorelease];
	[testStringGSharp3Frequency autorelease];
	[testStringAb3Frequency autorelease];
	[testStringA3Frequency autorelease];
	[testStringASharp3Frequency autorelease];
	[testStringBb3Frequency autorelease];
	[testStringB3Frequency autorelease];
	
	// *********** 4Frequency TEST STRING RELEASE **********************
	[testStringC4Frequency autorelease];
	[testStringCSharp4Frequency autorelease];
	[testStringDb4Frequency autorelease];
	[testStringD4Frequency autorelease];
	[testStringDSharp4Frequency autorelease];
	[testStringEb4Frequency autorelease];
	[testStringE4Frequency autorelease];
	[testStringF4Frequency autorelease];
	[testStringFSharp4Frequency autorelease];
	[testStringGb4Frequency autorelease];
	[testStringG4Frequency autorelease];
	[testStringGSharp4Frequency autorelease];
	[testStringAb4Frequency autorelease];
	[testStringA4Frequency autorelease];
	[testStringASharp4Frequency autorelease];
	[testStringBb4Frequency autorelease];
	[testStringB4Frequency autorelease];
	
	// *********** 5Frequency TEST STRING RELEASE **********************
	[testStringC5Frequency autorelease];
	[testStringCSharp5Frequency autorelease];
	[testStringDb5Frequency autorelease];
	[testStringD5Frequency autorelease];
	[testStringDSharp5Frequency autorelease];
	[testStringEb5Frequency autorelease];
	[testStringE5Frequency autorelease];
	[testStringF5Frequency autorelease];
	[testStringFSharp5Frequency autorelease];
	[testStringGb5Frequency autorelease];
	[testStringG5Frequency autorelease];
	[testStringGSharp5Frequency autorelease];
	[testStringAb5Frequency autorelease];
	[testStringA5Frequency autorelease];
	[testStringASharp5Frequency autorelease];
	[testStringBb5Frequency autorelease];
	[testStringB5Frequency autorelease];
	
	// *********** 6Frequency TEST STRING RELEASE **********************
	[testStringC6Frequency autorelease];
	[testStringCSharp6Frequency autorelease];
	[testStringDb6Frequency autorelease];
	[testStringD6Frequency autorelease];
	[testStringDSharp6Frequency autorelease];
	[testStringEb6Frequency autorelease];
	[testStringE6Frequency autorelease];
	[testStringF6Frequency autorelease];
	[testStringFSharp6Frequency autorelease];
	[testStringGb6Frequency autorelease];
	[testStringG6Frequency autorelease];
	[testStringGSharp6Frequency autorelease];
	[testStringAb6Frequency autorelease];
	[testStringA6Frequency autorelease];
	[testStringASharp6Frequency autorelease];
	[testStringBb6Frequency autorelease];
	[testStringB6Frequency autorelease];
	
	// *********** 7Frequency TEST STRING RELEASE **********************
	[testStringC7Frequency autorelease];
	[testStringCSharp7Frequency autorelease];
	[testStringDb7Frequency autorelease];
	[testStringD7Frequency autorelease];
	[testStringDSharp7Frequency autorelease];
	[testStringEb7Frequency autorelease];
	[testStringE7Frequency autorelease];
	[testStringF7Frequency autorelease];
	[testStringFSharp7Frequency autorelease];
	[testStringGb7Frequency autorelease];
	[testStringG7Frequency autorelease];
	[testStringGSharp7Frequency autorelease];
	[testStringAb7Frequency autorelease];
	[testStringA7Frequency autorelease];
	[testStringASharp7Frequency autorelease];
	[testStringBb7Frequency autorelease];
	[testStringB7Frequency autorelease];
	
	// *********** 8Frequency TEST STRING RELEASE **********************
	[testStringC8Frequency autorelease];
	[testStringCSharp8Frequency autorelease];
	[testStringDb8Frequency autorelease];
	[testStringD8Frequency autorelease];
	[testStringDSharp8Frequency autorelease];
	[testStringEb8Frequency autorelease];
	[testStringE8Frequency autorelease];
	[testStringF8Frequency autorelease];
	[testStringFSharp8Frequency autorelease];
	[testStringGb8Frequency autorelease];
	[testStringG8Frequency autorelease];
	[testStringGSharp8Frequency autorelease];
	[testStringAb8Frequency autorelease];
	[testStringA8Frequency autorelease];
	[testStringASharp8Frequency autorelease];
	[testStringBb8Frequency autorelease];
	[testStringB8Frequency autorelease];
	
	// *********** 9Frequency TEST STRING RELEASE **********************
	[testStringC9Frequency autorelease];
	[testStringCSharp9Frequency autorelease];
	[testStringDb9Frequency autorelease];
	[testStringD9Frequency autorelease];
	[testStringDSharp9Frequency autorelease];
	[testStringEb9Frequency autorelease];
	[testStringE9Frequency autorelease];
	[testStringF9Frequency autorelease];
	[testStringFSharp9Frequency autorelease];
	[testStringGb9Frequency autorelease];
	[testStringG9Frequency autorelease];
	[testStringGSharp9Frequency autorelease];
	[testStringAb9Frequency autorelease];
	[testStringA9Frequency autorelease];
	[testStringASharp9Frequency autorelease];
	[testStringBb9Frequency autorelease];
	[testStringB9Frequency autorelease];	
	
	// *********** _1MIDI TEST STRING RELEASE **********************
	[testStringC_1MIDI autorelease];
	[testStringCSharp_1MIDI autorelease];
	[testStringDb_1MIDI autorelease];
	[testStringD_1MIDI autorelease];
	[testStringDSharp_1MIDI autorelease];
	[testStringEb_1MIDI autorelease];
	[testStringE_1MIDI autorelease];
	[testStringF_1MIDI autorelease];
	[testStringFSharp_1MIDI autorelease];
	[testStringGb_1MIDI autorelease];
	[testStringG_1MIDI autorelease];
	[testStringGSharp_1MIDI autorelease];
	[testStringAb_1MIDI autorelease];
	[testStringA_1MIDI autorelease];
	[testStringASharp_1MIDI autorelease];
	[testStringBb_1MIDI autorelease];
	[testStringB_1MIDI autorelease];	
	
	// *********** 0MIDI TEST STRING RELEASE **********************
	[testStringC0MIDI autorelease];
	[testStringCSharp0MIDI autorelease];
	[testStringDb0MIDI autorelease];
	[testStringD0MIDI autorelease];
	[testStringDSharp0MIDI autorelease];
	[testStringEb0MIDI autorelease];
	[testStringE0MIDI autorelease];
	[testStringF0MIDI autorelease];
	[testStringFSharp0MIDI autorelease];
	[testStringGb0MIDI autorelease];
	[testStringG0MIDI autorelease];
	[testStringGSharp0MIDI autorelease];
	[testStringAb0MIDI autorelease];
	[testStringA0MIDI autorelease];
	[testStringASharp0MIDI autorelease];
	[testStringBb0MIDI autorelease];
	[testStringB0MIDI autorelease];
	
	// *********** 1MIDI TEST STRING RELEASE **********************
	[testStringC1MIDI autorelease];
	[testStringCSharp1MIDI autorelease];
	[testStringDb1MIDI autorelease];
	[testStringD1MIDI autorelease];
	[testStringDSharp1MIDI autorelease];
	[testStringEb1MIDI autorelease];
	[testStringE1MIDI autorelease];
	[testStringF1MIDI autorelease];
	[testStringFSharp1MIDI autorelease];
	[testStringGb1MIDI autorelease];
	[testStringG1MIDI autorelease];
	[testStringGSharp1MIDI autorelease];
	[testStringAb1MIDI autorelease];
	[testStringA1MIDI autorelease];
	[testStringASharp1MIDI autorelease];
	[testStringBb1MIDI autorelease];
	[testStringB1MIDI autorelease];
	
	// *********** 2MIDI TEST STRING RELEASE **********************
	[testStringC2MIDI autorelease];
	[testStringCSharp2MIDI autorelease];
	[testStringDb2MIDI autorelease];
	[testStringD2MIDI autorelease];
	[testStringDSharp2MIDI autorelease];
	[testStringEb2MIDI autorelease];
	[testStringE2MIDI autorelease];
	[testStringF2MIDI autorelease];
	[testStringFSharp2MIDI autorelease];
	[testStringGb2MIDI autorelease];
	[testStringG2MIDI autorelease];
	[testStringGSharp2MIDI autorelease];
	[testStringAb2MIDI autorelease];
	[testStringA2MIDI autorelease];
	[testStringASharp2MIDI autorelease];
	[testStringBb2MIDI autorelease];
	[testStringB2MIDI autorelease];
	
	// *********** 3MIDI TEST STRING RELEASE **********************
	[testStringC3MIDI autorelease];
	[testStringCSharp3MIDI autorelease];
	[testStringDb3MIDI autorelease];
	[testStringD3MIDI autorelease];
	[testStringDSharp3MIDI autorelease];
	[testStringEb3MIDI autorelease];
	[testStringE3MIDI autorelease];
	[testStringF3MIDI autorelease];
	[testStringFSharp3MIDI autorelease];
	[testStringGb3MIDI autorelease];
	[testStringG3MIDI autorelease];
	[testStringGSharp3MIDI autorelease];
	[testStringAb3MIDI autorelease];
	[testStringA3MIDI autorelease];
	[testStringASharp3MIDI autorelease];
	[testStringBb3MIDI autorelease];
	[testStringB3MIDI autorelease];
	
	// *********** 4MIDI TEST STRING RELEASE **********************
	[testStringC4MIDI autorelease];
	[testStringCSharp4MIDI autorelease];
	[testStringDb4MIDI autorelease];
	[testStringD4MIDI autorelease];
	[testStringDSharp4MIDI autorelease];
	[testStringEb4MIDI autorelease];
	[testStringE4MIDI autorelease];
	[testStringF4MIDI autorelease];
	[testStringFSharp4MIDI autorelease];
	[testStringGb4MIDI autorelease];
	[testStringG4MIDI autorelease];
	[testStringGSharp4MIDI autorelease];
	[testStringAb4MIDI autorelease];
	[testStringA4MIDI autorelease];
	[testStringASharp4MIDI autorelease];
	[testStringBb4MIDI autorelease];
	[testStringB4MIDI autorelease];
	
	// *********** 5MIDI TEST STRING RELEASE **********************
	[testStringC5MIDI autorelease];
	[testStringCSharp5MIDI autorelease];
	[testStringDb5MIDI autorelease];
	[testStringD5MIDI autorelease];
	[testStringDSharp5MIDI autorelease];
	[testStringEb5MIDI autorelease];
	[testStringE5MIDI autorelease];
	[testStringF5MIDI autorelease];
	[testStringFSharp5MIDI autorelease];
	[testStringGb5MIDI autorelease];
	[testStringG5MIDI autorelease];
	[testStringGSharp5MIDI autorelease];
	[testStringAb5MIDI autorelease];
	[testStringA5MIDI autorelease];
	[testStringASharp5MIDI autorelease];
	[testStringBb5MIDI autorelease];
	[testStringB5MIDI autorelease];
	
	// *********** 6MIDI TEST STRING RELEASE **********************
	[testStringC6MIDI autorelease];
	[testStringCSharp6MIDI autorelease];
	[testStringDb6MIDI autorelease];
	[testStringD6MIDI autorelease];
	[testStringDSharp6MIDI autorelease];
	[testStringEb6MIDI autorelease];
	[testStringE6MIDI autorelease];
	[testStringF6MIDI autorelease];
	[testStringFSharp6MIDI autorelease];
	[testStringGb6MIDI autorelease];
	[testStringG6MIDI autorelease];
	[testStringGSharp6MIDI autorelease];
	[testStringAb6MIDI autorelease];
	[testStringA6MIDI autorelease];
	[testStringASharp6MIDI autorelease];
	[testStringBb6MIDI autorelease];
	[testStringB6MIDI autorelease];
	
	// *********** 7MIDI TEST STRING RELEASE **********************
	[testStringC7MIDI autorelease];
	[testStringCSharp7MIDI autorelease];
	[testStringDb7MIDI autorelease];
	[testStringD7MIDI autorelease];
	[testStringDSharp7MIDI autorelease];
	[testStringEb7MIDI autorelease];
	[testStringE7MIDI autorelease];
	[testStringF7MIDI autorelease];
	[testStringFSharp7MIDI autorelease];
	[testStringGb7MIDI autorelease];
	[testStringG7MIDI autorelease];
	[testStringGSharp7MIDI autorelease];
	[testStringAb7MIDI autorelease];
	[testStringA7MIDI autorelease];
	[testStringASharp7MIDI autorelease];
	[testStringBb7MIDI autorelease];
	[testStringB7MIDI autorelease];
	
	// *********** 8MIDI TEST STRING RELEASE **********************
	[testStringC8MIDI autorelease];
	[testStringCSharp8MIDI autorelease];
	[testStringDb8MIDI autorelease];
	[testStringD8MIDI autorelease];
	[testStringDSharp8MIDI autorelease];
	[testStringEb8MIDI autorelease];
	[testStringE8MIDI autorelease];
	[testStringF8MIDI autorelease];
	[testStringFSharp8MIDI autorelease];
	[testStringGb8MIDI autorelease];
	[testStringG8MIDI autorelease];
	[testStringGSharp8MIDI autorelease];
	[testStringAb8MIDI autorelease];
	[testStringA8MIDI autorelease];
	[testStringASharp8MIDI autorelease];
	[testStringBb8MIDI autorelease];
	[testStringB8MIDI autorelease];	
	
	// *********** 9MIDI TEST STRING RELEASE **********************
	[testStringC9MIDI autorelease];
	[testStringCSharp9MIDI autorelease];
	[testStringDb9MIDI autorelease];
	[testStringD9MIDI autorelease];
	[testStringDSharp9MIDI autorelease];
	[testStringEb9MIDI autorelease];
	[testStringE9MIDI autorelease];
	[testStringF9MIDI autorelease];
	[testStringFSharp9MIDI autorelease];
	[testStringGb9MIDI autorelease];
	[testStringG9MIDI autorelease];
	[testStringGSharp9MIDI autorelease];
	[testStringAb9MIDI autorelease];
	[testStringA9MIDI autorelease];
	[testStringASharp9MIDI autorelease];
	[testStringBb9MIDI autorelease];
	[testStringB9MIDI autorelease];	
		
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
	NSArray *qualityArray = [[NSArray alloc] initWithObjects:@"-1", @"0", @"1", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", nil];
	self.chordTypes = qualityArray;
	[qualityArray release];
	
	NSArray *rootArray = [[NSArray alloc] initWithObjects:@"C", @"C♯", @"D♭", @"D", @"D♯", @"E♭", @"E", @"F", @"F♯", @"G♭", @"G", @"G♯", @"A♭", @"A", @"A♯", @"B♭", @"B", nil];
	self.chordRoot = rootArray;
	[rootArray release];
	
	NSArray *inversionArray = [[NSArray alloc] initWithObjects:@"Frequency", @"MIDI", nil];
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
