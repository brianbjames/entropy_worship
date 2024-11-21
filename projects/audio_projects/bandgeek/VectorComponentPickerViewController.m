//
//  VectorComponentPickerViewController.m
//  Harmony
//
//  Created by Brian B. James on 5/24/09.
//  Copyright Brian B. James 2009. All rights reserved.
//

#import "VectorComponentPickerViewController.h"

@implementation VectorComponentPickerViewController

@synthesize doublePicker;
@synthesize chordRoot;
@synthesize label;

/*
 ********** BUG BUG BUG BUG BUG BUG BUG BUG BUG *********************************
 ********** BUG BUG BUG BUG BUG BUG BUG BUG BUG *********************************
 ********** BUG BUG BUG BUG BUG BUG BUG BUG BUG *********************************
 ********** BUG BUG BUG BUG BUG BUG BUG BUG BUG *********************************
 
 Verify that this is the correct interval vector:
 
 if ([messageFromPicker isEqualToString: testString01234689] == YES)
 {
 label.text = [NSString stringWithFormat:@"Octachord\rForte: 8-Z15\rVector: 555553"];
 //@"Pitch Class Set (01234689):" 
 } 
 
 */
- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
	return 300;
}

// didSelectRow
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
	NSInteger rootRow = [doublePicker selectedRowInComponent:kRootComponent];
	NSString *theRoot = [self.chordRoot objectAtIndex:rootRow];
		
	// THE MESSAGE FROM THE PICKER
	NSMutableString *messageFromPicker = [[NSMutableString alloc] initWithFormat:@"%@", theRoot];
	
	// *********** Trichords TEST STRINGS **********************
	NSString *testString012 = @"(012)";
	NSString *testString013 = @"(013)";
	NSString *testString014 = @"(014)";
	NSString *testString015 = @"(015)";
	NSString *testString016 = @"(016)";
	NSString *testString024 = @"(024)";
	NSString *testString025 = @"(025)";
	NSString *testString026 = @"(026)";
	NSString *testString027 = @"(027)";
	NSString *testString036 = @"(036)";
	NSString *testString037 = @"(037)";
	NSString *testString048 = @"(048)";
	
	// *********** Tetrachords TEST STRINGS **********************
	NSString *testString0123 = @"(0123)";
	NSString *testString0124 = @"(0124)";
	NSString *testString0125 = @"(0125)";
	NSString *testString0126 = @"(0126)";
	NSString *testString0127 = @"(0127)";
	NSString *testString0134 = @"(0134)";
	NSString *testString0135 = @"(0135)";
	NSString *testString0136 = @"(0136)";
	NSString *testString0137 = @"(0137)";
	NSString *testString0145 = @"(0145)";
	NSString *testString0146 = @"(0146)";
	NSString *testString0147 = @"(0147)";
	NSString *testString0148 = @"(0148)";
	NSString *testString0156 = @"(0156)";
	NSString *testString0157 = @"(0157)";
	NSString *testString0158 = @"(0158)";
	NSString *testString0167 = @"(0167)";
	NSString *testString0235 = @"(0235)";
	NSString *testString0236 = @"(0236)";
	NSString *testString0237 = @"(0237)";
	NSString *testString0246 = @"(0246)";
	NSString *testString0247 = @"(0247)";
	NSString *testString0248 = @"(0248)";
	NSString *testString0257 = @"(0257)";
	NSString *testString0258 = @"(0258)";
	NSString *testString0268 = @"(0268)";
	NSString *testString0347 = @"(0347)";
	NSString *testString0358 = @"(0358)";
	NSString *testString0369 = @"(0369)";
	
	// *********** Pentachords TEST STRINGS **********************
	NSString *testString01234 = @"(01234)";
	NSString *testString01235 = @"(01235)";
	NSString *testString01236 = @"(01236)";
	NSString *testString01237 = @"(01237)";
	NSString *testString01245 = @"(01245)";
	NSString *testString01246 = @"(01246)";
	NSString *testString01247 = @"(01247)";
	NSString *testString01248 = @"(01248)";
	NSString *testString01256 = @"(01256)";
	NSString *testString01257 = @"(01257)";
	NSString *testString01258 = @"(01258)";
	NSString *testString01267 = @"(01267)";
	NSString *testString01268 = @"(01268)";
	NSString *testString01346 = @"(01346)";
	NSString *testString01347 = @"(01347)";
	NSString *testString01348 = @"(01348)";
	NSString *testString01356 = @"(01356)";
	NSString *testString01357 = @"(01357)";
	NSString *testString01358 = @"(01358)";
	NSString *testString01367 = @"(01367)";
	NSString *testString01368 = @"(01368)";
	NSString *testString01369 = @"(01369)";
	NSString *testString01457 = @"(01457)";
	NSString *testString01458 = @"(01458)";
	NSString *testString01468 = @"(01468)";
	NSString *testString01469 = @"(01469)";
	NSString *testString01478 = @"(01478)";
	NSString *testString01568 = @"(01568)";
	NSString *testString02346 = @"(02346)";
	NSString *testString02347 = @"(02347)";
	NSString *testString02357 = @"(02357)";
	NSString *testString02358 = @"(02358)";
	NSString *testString02368 = @"(02368)";
	NSString *testString02458 = @"(02458)";
	NSString *testString02468 = @"(02468)";
	NSString *testString02469 = @"(02469)";
	NSString *testString02479 = @"(02479)";
	NSString *testString03458 = @"(03458)";
	
	// *********** Pentachords TEST STRINGS **********************
	NSString *testString012345 = @"(012345)";
	NSString *testString012346 = @"(012346)";
	NSString *testString012347 = @"(012347)";
	NSString *testString012348 = @"(012348)";
	NSString *testString012356 = @"(012356)";
	NSString *testString012357 = @"(012357)";
	NSString *testString012358 = @"(012358)";
	NSString *testString012367 = @"(012367)";
	NSString *testString012368 = @"(012368)";
	NSString *testString012369 = @"(012369)";
	NSString *testString012378 = @"(012378)";
	NSString *testString012456 = @"(012456)";
	NSString *testString012457 = @"(012457)";
	NSString *testString012458 = @"(012458)";
	NSString *testString012467 = @"(012467)";
	NSString *testString012468 = @"(012468)";
	NSString *testString012469 = @"(012469)";
	NSString *testString012478 = @"(012478)";
	NSString *testString012479 = @"(012479)";
	NSString *testString012567 = @"(012567)";
	NSString *testString012568 = @"(012568)";
	NSString *testString012569 = @"(012569)";
	NSString *testString012578 = @"(012578)";
	NSString *testString012579 = @"(012579)";
	NSString *testString012678 = @"(012678)";
	NSString *testString013457 = @"(013457)";
	NSString *testString013458 = @"(013458)";
	NSString *testString013467 = @"(013467)";
	NSString *testString013468 = @"(013468)";
	NSString *testString013469 = @"(013469)";
	NSString *testString013478 = @"(013478)";
	NSString *testString013479 = @"(013479)";
	NSString *testString013568 = @"(013568)";
	NSString *testString013569 = @"(013569)";
	NSString *testString013578 = @"(013578)";
	NSString *testString013579 = @"(013579)";
	NSString *testString013679 = @"(013679)";
	NSString *testString014568 = @"(014568)";
	NSString *testString014579 = @"(014579)";
	NSString *testString014589 = @"(014589)";
	NSString *testString014679 = @"(014679)";
	NSString *testString023457 = @"(023457)";
	NSString *testString023458 = @"(023458)";
	NSString *testString023468 = @"(023468)";
	NSString *testString023469 = @"(023469)";
	NSString *testString023568 = @"(023568)";
	NSString *testString023579 = @"(023579)";
	NSString *testString023679 = @"(023679)";
	NSString *testString024579 = @"(024579)";
	NSString *testString02468T = @"(02468T)";
	
	// *********** Septachords TEST STRINGS **********************
	NSString *testString0123456 = @"(0123456)";
	NSString *testString0123457 = @"(0123457)";
	NSString *testString0123458 = @"(0123458)";
	NSString *testString0123467 = @"(0123467)";
	NSString *testString0123468 = @"(0123468)";
	NSString *testString0123469 = @"(0123469)";
	NSString *testString0123478 = @"(0123478)";
	NSString *testString0123479 = @"(0123479)";
	NSString *testString0123567 = @"(0123567)";
	NSString *testString0123568 = @"(0123568)";
	NSString *testString0123569 = @"(0123569)";
	NSString *testString0123578 = @"(0123578)";
	NSString *testString0123579 = @"(0123579)";
	NSString *testString0123678 = @"(0123678)";
	NSString *testString0123679 = @"(0123679)";
	NSString *testString013468T = @"(013468T)";
	NSString *testString0124568 = @"(0124568)";
	NSString *testString0124569 = @"(0124569)";
	NSString *testString0124578 = @"(0124578)";
	NSString *testString0124579 = @"(0124579)";
	NSString *testString0124589 = @"(0124589)";
	NSString *testString0124678 = @"(0124678)";
	NSString *testString0124679 = @"(0124679)";
	NSString *testString012468T = @"(012468T)";
	NSString *testString0124689 = @"(0124689)";
	NSString *testString0125679 = @"(0125679)";
	NSString *testString0125689 = @"(0125689)";
	NSString *testString0134568 = @"(0134568)";
	NSString *testString0134578 = @"(0134578)";
	NSString *testString0134579 = @"(0134579)";
	NSString *testString0134679 = @"(0134679)";
	NSString *testString0134689 = @"(0134689)";
	NSString *testString0135679 = @"(0135679)";
	NSString *testString0145679 = @"(0145679)";
	NSString *testString0234568 = @"(0234568)";
	NSString *testString0234679 = @"(0234679)";
	
	// *********** Octachords TEST STRINGS **********************
	NSString *testString01234567 = @"(01234567)";
	NSString *testString01234568 = @"(01234568)";
	NSString *testString01234578 = @"(01234578)";
	NSString *testString01234678 = @"(01234678)";
	NSString *testString01235678 = @"(01235678)";
	NSString *testString01234569 = @"(01234569)";
	NSString *testString01234579 = @"(01234579)";
	NSString *testString01234679 = @"(01234679)";
	NSString *testString01235679 = @"(01235679)";
	NSString *testString01234589 = @"(01234589)";
	NSString *testString01234689 = @"(01234689)";
	NSString *testString01235689 = @"(01235689)";
	NSString *testString01245689 = @"(01245689)";
	NSString *testString01234789 = @"(01234789)";
	NSString *testString01235789 = @"(01235789)";
	NSString *testString01245789 = @"(01245789)";
	NSString *testString01236789 = @"(01236789)";
	NSString *testString02345679 = @"(02345679)";
	NSString *testString01345679 = @"(01345679)";
	NSString *testString01245679 = @"(01245679)";
	NSString *testString0123468T = @"(0123468T)";
	NSString *testString0123568T = @"(0123568T)";
	NSString *testString0124568T = @"(0124568T)";
	NSString *testString0123578T = @"(0123578T)";
	NSString *testString0124578T = @"(0124578T)";
	NSString *testString0124678T = @"(0124678T)";
	NSString *testString01345689 = @"(01345689)";
	NSString *testString0134578T = @"(0134578T)";
	NSString *testString0134679T = @"(0134679T)";
	
	// *********** Nonachords TEST STRINGS **********************
	NSString *testString012345678 = @"(012345678)";
	NSString *testString012345679 = @"(012345679)";
	NSString *testString012345689 = @"(012345689)";
	NSString *testString012345789 = @"(012345789)";
	NSString *testString012346789 = @"(012346789)";
	NSString *testString01234568T = @"(01234568T)";
	NSString *testString01234578T = @"(01234578T)";
	NSString *testString01234678T = @"(01234678T)";
	NSString *testString01235678T = @"(01235678T)";
	NSString *testString01234679T = @"(01234679T)";
	NSString *testString01235679T = @"(01235679T)";
	NSString *testString01245689T = @"(01245689T)";	
	
	// IF STRING isEqualToString X XXXXXX ******************************************
	// *********** Trichords ifs **********************
	if ([messageFromPicker isEqualToString: testString012] == YES)
	{
		label.text = [NSString stringWithFormat:@"Trichord\rForte: 3-1\rVector: 210000\r"];
		// ADD IN 1.1: \rDegree of Transpositional Symmetry: 1\rDegree of Inversional Symmetry: 1\rIndex Vector: 123210000000\rIndex Vector T0I to the Prime Form: 100000001232\rComplimentary Set Class: (012345678)
	}
	
	if ([messageFromPicker isEqualToString: testString013] == YES)
	{
		label.text = [NSString stringWithFormat:@"Trichord\rForte: 3-2\rVector: 111000"];// ADD IN 1.1: \rDegree of Transpositional Symmetry: 1\rDegree of Inversional Symmetry: 0\rIndex Vector: 121220100000\rIndex Vector T0I to the Prime Form: 100000102212\rComplimentary Set Class: (012345679)
	}
	
	if ([messageFromPicker isEqualToString: testString014] == YES)
	{
		label.text = [NSString stringWithFormat:@"Trichord\rForte: 3-3\r Vector: 101100"];
	}
	
	if ([messageFromPicker isEqualToString: testString015] == YES)
	{
		label.text = [NSString stringWithFormat:@"Trichord\rForte: 3-4\rVector: 100110"];
	}
	
	if ([messageFromPicker isEqualToString: testString016] == YES)
	{
		label.text = [NSString stringWithFormat:@"Trichord\rForte: 3-5\rVector: 100011"];
	}
	
	if ([messageFromPicker isEqualToString: testString024] == YES)
	{
		label.text = [NSString stringWithFormat:@"Trichord\rForte: 3-6\rVector: 020100"];
	}
	
	if ([messageFromPicker isEqualToString: testString025] == YES)
	{
		label.text = [NSString stringWithFormat:@"Trichord\rForte: 3-7\rVector: 011010"];
	}
	
	if ([messageFromPicker isEqualToString: testString026] == YES)
	{
		label.text = [NSString stringWithFormat:@"Trichord\rForte: 3-8\rVector: 010101"];
	}
	
	if ([messageFromPicker isEqualToString: testString027] == YES)
	{
		label.text = [NSString stringWithFormat:@"Trichord\rForte: 3-9\rVector: 010020"];
	}
	
	if ([messageFromPicker isEqualToString: testString036] == YES)
	{
		label.text = [NSString stringWithFormat:@"Trichord\rForte: 3-10\rVector: 002001"];
	}
	
	if ([messageFromPicker isEqualToString: testString037] == YES)
	{
		label.text = [NSString stringWithFormat:@"Trichord\rForte: 3-11\rVector: 001110"];
	}
	
	if ([messageFromPicker isEqualToString: testString048] == YES)
	{
		label.text = [NSString stringWithFormat:@"Trichord\rForte: 3-12\rVector: 000300"];
	}
	
	// *********** Tetrachords ifs **********************
	if ([messageFromPicker isEqualToString: testString0123] == YES)
	{
		label.text = [NSString stringWithFormat:@"Tetrachord\rForte: 4-1\rVector: 321000"];
	}
	
	if ([messageFromPicker isEqualToString: testString0124] == YES)
	{
		label.text = [NSString stringWithFormat:@"Tetrachord\rForte: 4-2\rVector: 221100"];
	}
	
	if ([messageFromPicker isEqualToString: testString0125] == YES)
	{
		label.text = [NSString stringWithFormat:@"Tetrachord\rForte: 4-4\rVector: 211110"];
	}
	
	if ([messageFromPicker isEqualToString: testString0126] == YES)
	{
		label.text = [NSString stringWithFormat:@"Tetrachord\rForte: 4-5\rVector: 210111"];
	}
	
	if ([messageFromPicker isEqualToString: testString0127] == YES)
	{
		label.text = [NSString stringWithFormat:@"Tetrachord\rForte: 4-6\rVector: 210021"];
	}
	
	if ([messageFromPicker isEqualToString: testString0134] == YES)
	{
		label.text = [NSString stringWithFormat:@"Tetrachord\rForte: 4-3\rVector: 212100"];
	}
	
	if ([messageFromPicker isEqualToString: testString0135] == YES)
	{
		label.text = [NSString stringWithFormat:@"Tetrachord\rForte: 4-11\rVector: 121110"];
	}
	
	if ([messageFromPicker isEqualToString: testString0136] == YES)
	{
		label.text = [NSString stringWithFormat:@"Tetrachord\rForte: 4-13\rVector: 010101"];
	}
	
	if ([messageFromPicker isEqualToString: testString0137] == YES)
	{
		label.text = [NSString stringWithFormat:@"Tetrachord\rForte: 4-Z29\rVector: 111111"];
	}
	
	if ([messageFromPicker isEqualToString: testString0145] == YES)
	{
		label.text = [NSString stringWithFormat:@"Tetrachord\rForte: 4-7\rVector: 201210"];
	}
	
	if ([messageFromPicker isEqualToString: testString0146] == YES)
	{
		label.text = [NSString stringWithFormat:@"Tetrachord\rForte: 4-Z15\rVector: 111111"];
	}
	
	if ([messageFromPicker isEqualToString: testString0147] == YES)
	{
		label.text = [NSString stringWithFormat:@"Tetrachord\rForte: 4-18\rVector: 102111"];
	}
	
	if ([messageFromPicker isEqualToString: testString0148] == YES)
	{
		label.text = [NSString stringWithFormat:@"Tetrachord\rForte: 4-19\rVector: 101310"];
	}
	
	if ([messageFromPicker isEqualToString: testString0156] == YES)
	{
		label.text = [NSString stringWithFormat:@"Tetrachord\rForte: 4-8\rVector: 200121"];
	}
	
	if ([messageFromPicker isEqualToString: testString0157] == YES)
	{
		label.text = [NSString stringWithFormat:@"Tetrachord\rForte: 4-16\rVector: 110121"];
	}
	
	if ([messageFromPicker isEqualToString: testString0158] == YES)
	{
		label.text = [NSString stringWithFormat:@"Tetrachord\rForte: 4-20\rVector: 101220"];
	}
	
	if ([messageFromPicker isEqualToString: testString0167] == YES)
	{
		label.text = [NSString stringWithFormat:@"Tetrachord\rForte: 4-9\rVector: 200022"];
	}
	
	if ([messageFromPicker isEqualToString: testString0235] == YES)
	{
		label.text = [NSString stringWithFormat:@"Tetrachord\rForte: 4-10\rVector: 122010"];
	}
	
	if ([messageFromPicker isEqualToString: testString0236] == YES)
	{
		label.text = [NSString stringWithFormat:@"Tetrachord\rForte: 4-12\rVector: 112101"];
	}
	
	if ([messageFromPicker isEqualToString: testString0237] == YES)
	{
		label.text = [NSString stringWithFormat:@"Tetrachord\rForte: 4-14\rVector: 111120"];
	}
	
	if ([messageFromPicker isEqualToString: testString0246] == YES)
	{
		label.text = [NSString stringWithFormat:@"Tetrachord\rForte: 4-21\rVector: 030201"];
	}
	
	if ([messageFromPicker isEqualToString: testString0247] == YES)
	{
		label.text = [NSString stringWithFormat:@"Tetrachord\rForte: 4-22\rVector: 021120"];
	}
	
	if ([messageFromPicker isEqualToString: testString0248] == YES)
	{
		label.text = [NSString stringWithFormat:@"Tetrachord\rForte: 4-24\rVector: 020301"];
	}
	
	if ([messageFromPicker isEqualToString: testString0257] == YES)
	{
		label.text = [NSString stringWithFormat:@"Tetrachord\rForte: 4-23\rVector: 021030"];
	}
	
	if ([messageFromPicker isEqualToString: testString0258] == YES)
	{
		label.text = [NSString stringWithFormat:@"Tetrachord\rForte: 4-27\rVector: 012111"];
	}
	
	if ([messageFromPicker isEqualToString: testString0268] == YES)
	{
		label.text = [NSString stringWithFormat:@"Tetrachord\rForte: 4-25\rVector: 020202"];
		//@"Pitch Class Set (0268):" 
	}
	
	if ([messageFromPicker isEqualToString: testString0347] == YES)
	{
		label.text = [NSString stringWithFormat:@"Tetrachord\rForte: 4-17\rVector: 102210"];
		//@"Pitch Class Set (0347):" 
	}
	
	if ([messageFromPicker isEqualToString: testString0358] == YES)
	{
		label.text = [NSString stringWithFormat:@"Tetrachord\rForte: 4-26\rVector: 012120"];
		//@"Pitch Class Set (0358):" 
	}
	
	if ([messageFromPicker isEqualToString: testString0369] == YES)
	
	{
		label.text = [NSString stringWithFormat:@"Tetrachord\rForte: 4-28\rVector: 004002"];
		//@"Pitch Class Set (0369):" 
	}
	
	// *********** Pentachords ifs **********************
	if ([messageFromPicker isEqualToString: testString01234] == YES)
	{
		label.text = [NSString stringWithFormat:@"Pentachord\rForte: 5-1\rVector: 432100"];// ADD IN X.X: \rDegree of Transpositional Symmetry: X\rDegree of Inversional Symmetry: X\rIndex Vector: XXXXXXXXXXXX\rIndex Vector T0I to the Prime Form: XXXXXXXXXXXX\rComplimentary Set Class: (XXXXXXXXXX)
		//@"Pitch Class Set (01234):" 
	}
	
	if ([messageFromPicker isEqualToString: testString01235] == YES)
	{
		label.text = [NSString stringWithFormat:@"Pentachord\rForte: 5-2\rVector: 332110"];
		//@"Pitch Class Set (01235):" 
	}
	
	if ([messageFromPicker isEqualToString: testString01236] == YES)
	{
		label.text = [NSString stringWithFormat:@"Pentachord\rForte: 5-4\rVector: 322111"];
		//@"Pitch Class Set (01236):" 
	}
	
	if ([messageFromPicker isEqualToString: testString01237] == YES)
	{
		label.text = [NSString stringWithFormat:@"Pentachord\rForte: 5-5\rVector: 321121"];
		//@"Pitch Class Set (01237):" 
	}
	
	if ([messageFromPicker isEqualToString: testString01245] == YES)
	{
		label.text = [NSString stringWithFormat:@"Pentachord\rForte: 5-3\rVector: 322210"];
		//@"Pitch Class Set (01245):" 
	}
	
	if ([messageFromPicker isEqualToString: testString01246] == YES)
	{
		label.text = [NSString stringWithFormat:@"Pentachord\rForte: 5-9\rVector: 231211"];
		//@"Pitch Class Set (01246):" 
	}
	
	if ([messageFromPicker isEqualToString: testString01247] == YES)
	{
		label.text = [NSString stringWithFormat:@"Pentachord\rForte: 5-Z36\rVector: 222121"];
		//@"Pitch Class Set (01247):" 
	}
	
	if ([messageFromPicker isEqualToString: testString01248] == YES)
	{
		label.text = [NSString stringWithFormat:@"Pentachord\rForte: 5-13\rVector: 221311"];
		//@"Pitch Class Set (01248):" 
	}
	
	if ([messageFromPicker isEqualToString: testString01256] == YES)
	{
		label.text = [NSString stringWithFormat:@"Pentachord\rForte: 5-6\rVector: 311221"];
		//@"Pitch Class Set (01256):" 
	}
	
	if ([messageFromPicker isEqualToString: testString01257] == YES)
	{
		label.text = [NSString stringWithFormat:@"Pentachord\rForte: 5-14\rVector: 221131"];
		//@"Pitch Class Set (01257):" 
	}
	
	if ([messageFromPicker isEqualToString: testString01258] == YES)
	{
		label.text = [NSString stringWithFormat:@"Pentachord\rForte: 5-Z38\rVector: 212221"];
		//@"Pitch Class Set (01258):" 
	}
	
	if ([messageFromPicker isEqualToString: testString01267] == YES)
	{
		label.text = [NSString stringWithFormat:@"Pentachord\rForte: 5-7\rVector: 310132"];
		//@"Pitch Class Set (01267):" 
	}
	
	if ([messageFromPicker isEqualToString: testString01268] == YES)
	{
		label.text = [NSString stringWithFormat:@"Pentachord\rForte: 5-15\rVector: 220222"];// ADD IN X.X: \rDegree of Transpositional Symmetry: X\rDegree of Inversional Symmetry: X\rIndex Vector: XXXXXXXXXXXX\rIndex Vector T0I to the Prime Form: XXXXXXXXXXXX\rComplimentary Set Class: (XXXXXXXXXX)
		//@"Pitch Class Set (01268):" 
	}
	
	if ([messageFromPicker isEqualToString: testString01346] == YES)
	{
		label.text = [NSString stringWithFormat:@"Pentachord\rForte: 5-10\rVector: 223111"];
		//@"Pitch Class Set (01346):" 
	}
	
	if ([messageFromPicker isEqualToString: testString01347] == YES)
	{
		label.text = [NSString stringWithFormat:@"Pentachord\rForte: 5-16\rVector: 213211"];
		//@"Pitch Class Set (01347):" 
	}
	
	if ([messageFromPicker isEqualToString: testString01348] == YES)
	{
		label.text = [NSString stringWithFormat:@"Pentachord\rForte: 5-Z17\rVector: 212320"];
		//@"Pitch Class Set (01348):" 
	}
	
	if ([messageFromPicker isEqualToString: testString01356] == YES)
	{
		label.text = [NSString stringWithFormat:@"Pentachord\rForte: 5-Z12\rVector: 222121"];
		//@"Pitch Class Set (01356):" 
	}
	
	if ([messageFromPicker isEqualToString: testString01357] == YES)
	{
		label.text = [NSString stringWithFormat:@"Pentachord\rForte: 5-24\rVector: 131221"];
		//@"Pitch Class Set (01357):" 
	}
	
	if ([messageFromPicker isEqualToString: testString01358] == YES)
	{
		label.text = [NSString stringWithFormat:@"Pentachord\rForte: 5-27\rVector: 122230"];
		//@"Pitch Class Set (01358):" 
	}
	
	if ([messageFromPicker isEqualToString: testString01367] == YES)
	{
		label.text = [NSString stringWithFormat:@"Pentachord\rForte: 5-19\rVector: 212122"];
		//@"Pitch Class Set (01367):" 
	}
	
	if ([messageFromPicker isEqualToString: testString01368] == YES)
	{
		label.text = [NSString stringWithFormat:@"Pentachord\rForte: 5-29\rVector: 122131"];
		//@"Pitch Class Set (01368):" 
	}
	
	if ([messageFromPicker isEqualToString: testString01369] == YES)
	{
		label.text = [NSString stringWithFormat:@"Pentachord\rForte: 5-31\rVector: 114112"];
		//@"Pitch Class Set (01369):" 
	}
	
	if ([messageFromPicker isEqualToString: testString01457] == YES)
	{
		label.text = [NSString stringWithFormat:@"Pentachord\rForte: 5-Z18\rVector: 212221"];
		//@"Pitch Class Set (01457):" 
		
	}
	
	if ([messageFromPicker isEqualToString: testString01458] == YES)
	{
		label.text = [NSString stringWithFormat:@"Pentachord\rForte: 5-21\rVector: 202420"];
		//@"Pitch Class Set (01458):" 
		
	}
	
	if ([messageFromPicker isEqualToString: testString01468] == YES)
	{
		label.text = [NSString stringWithFormat:@"Pentachord\rForte: 5-30\rVector: 121321"];
		//@"Pitch Class Set (01468):" 
	}
	
	if ([messageFromPicker isEqualToString: testString01469] == YES)
	{
		label.text = [NSString stringWithFormat:@"Pentachord\rForte: 5-32\rVector: 113221"];
		//@"Pitch Class Set (01469):" 
	}
	
	if ([messageFromPicker isEqualToString: testString01478] == YES)
	{
		label.text = [NSString stringWithFormat:@"Pentachord\rForte: 5-22\rVector: 202321"];
		//@"Pitch Class Set (01478):" 
	}
	
	if ([messageFromPicker isEqualToString: testString01568] == YES)
	{
		label.text = [NSString stringWithFormat:@"Pentachord\rForte: 5-20\rVector: 211231"];
		//@"Pitch Class Set (01568):" 
	}
	
	if ([messageFromPicker isEqualToString: testString02346] == YES)
	{
		label.text = [NSString stringWithFormat:@"Pentachord\rForte: 5-8\rVector: 232201"];
		//@"Pitch Class Set (02346):" 
	}
	
	if ([messageFromPicker isEqualToString: testString02347] == YES)
	{
		label.text = [NSString stringWithFormat:@"Pentachord\rForte: 5-11\rVector: 222220"];// ADD IN 1.1: \rDegree of Transpositional Symmetry: 1\rDegree of Inversional Symmetry: 1\rIndex Vector: 123210000000\rIndex Vector T0I to the Prime Form: 100000001232\rComplimentary Set Class: (012345678)
		//@"Pitch Class Set (02347):" 
	}
	
	if ([messageFromPicker isEqualToString: testString02357] == YES)
	{
		label.text = [NSString stringWithFormat:@"Pentachord\rForte: 5-23\rVector: 132130"];// ADD IN 1.1: \rDegree of Transpositional Symmetry: 1\rDegree of Inversional Symmetry: 0\rIndex Vector: 121220100000\rIndex Vector T0I to the Prime Form: 100000102212\rComplimentary Set Class: (012345679)
		//@"Pitch Class Set (02357):" 
	}
	
	if ([messageFromPicker isEqualToString: testString02358] == YES)
	{
		label.text = [NSString stringWithFormat:@"Pentachord\rForte: 5-25\rVector: 123121"];
		//@"Pitch Class Set (02358):" 
	}
	
	if ([messageFromPicker isEqualToString: testString02368] == YES)
	{
		label.text = [NSString stringWithFormat:@"Pentachord\rForte: 5-28\rVector: 122212"];
		//@"Pitch Class Set (02368):" 
	}
	
	if ([messageFromPicker isEqualToString: testString02458] == YES)
	{
		label.text = [NSString stringWithFormat:@"Pentachord\rForte: 5-26\rVector: 122311"];
		//@"Pitch Class Set (02458):" 
	}
	
	if ([messageFromPicker isEqualToString: testString02468] == YES)
	{
		label.text = [NSString stringWithFormat:@"Pentachord\rForte: 5-33\rVector: 040402"];
		//@"Pitch Class Set (02468):" 
	}
	
	if ([messageFromPicker isEqualToString: testString02469] == YES)
	{
		label.text = [NSString stringWithFormat:@"Pentachord\rForte: 5-34\rVector: 032221"];
		//@"Pitch Class Set (02469):" 
	}
	
	if ([messageFromPicker isEqualToString: testString02479] == YES)
	{
		label.text = [NSString stringWithFormat:@"Pentachord\rForte: 5-35\rVector: 032140"];
		//@"Pitch Class Set (02479):" 
	}
	
	if ([messageFromPicker isEqualToString: testString03458] == YES)
	{
		label.text = [NSString stringWithFormat:@"Pentachord\rForte: 5-Z37\rVector: 212320"];
		//@"Pitch Class Set (03458):" 
	}
	
	// *********** Hexachords ifs **********************
	if ([messageFromPicker isEqualToString: testString012345] == YES)
	{
		label.text = [NSString stringWithFormat:@"Hexachord\rForte: 6-1\rVector: 543210"];// ADD IN X.X: \rDegree of Transpositional Symmetry: X\rDegree of Inversional Symmetry: X\rIndex Vector: XXXXXXXXXXXX\rIndex Vector T0I to the Prime Form: XXXXXXXXXXXX\rComplimentary Set Class: (XXXXXXXXXX)
		//@"Pitch Class Set (012345):" 
	}
	
	if ([messageFromPicker isEqualToString: testString012346] == YES)
	{
		label.text = [NSString stringWithFormat:@"Hexachord\rForte: 6-2\rVector: 443211"];
		//@"Pitch Class Set (012346):" 
	}
	
	if ([messageFromPicker isEqualToString: testString012347] == YES)
	{
		label.text = [NSString stringWithFormat:@"Hexachord\rForte: 6-Z36\rVector: 433221"];
		//@"Pitch Class Set (012347):" 
	}
	
	if ([messageFromPicker isEqualToString: testString012348] == YES)
	{
		label.text = [NSString stringWithFormat:@"Hexachord\rForte: 6-Z37\rVector: 432321"];
		//@"Pitch Class Set (012348):" 
	}
	
	if ([messageFromPicker isEqualToString: testString012356] == YES)
	{
		label.text = [NSString stringWithFormat:@"Hexachord\rForte: 6-Z3\rVector: 433221"];
		//@"Pitch Class Set (012356):" 
	}
	
	if ([messageFromPicker isEqualToString: testString012357] == YES)
	{
		label.text = [NSString stringWithFormat:@"Hexachord\rForte: 6-9\rVector: 342231"];
		//@"Pitch Class Set (012357):" 
	}
	
	if ([messageFromPicker isEqualToString: testString012358] == YES)
	{
		label.text = [NSString stringWithFormat:@"Hexachord\rForte: 6-Z40\rVector: 333231"];
		//@"Pitch Class Set (012358):" 
	}
	
	if ([messageFromPicker isEqualToString: testString012367] == YES)
	{
		label.text = [NSString stringWithFormat:@"Hexachord\rForte: 6-5\rVector: 422232"];
		//@"Pitch Class Set (012367):" 
	}
	
	if ([messageFromPicker isEqualToString: testString012368] == YES)
	{
		label.text = [NSString stringWithFormat:@"Hexachord\rForte: 6-Z41\rVector: 332232"];
		//@"Pitch Class Set (012368):" 
	}
	
	if ([messageFromPicker isEqualToString: testString012369] == YES)
	{
		label.text = [NSString stringWithFormat:@"Hexachord\rForte: 6-Z42\rVector: 324222"];
		//@"Pitch Class Set (012369):" 
	}
	
	if ([messageFromPicker isEqualToString: testString012378] == YES)
	{
		label.text = [NSString stringWithFormat:@"Hexachord\rForte: 6-Z38\rVector: 421242"];
		//@"Pitch Class Set (012378):" 
	}
	
	if ([messageFromPicker isEqualToString: testString012456] == YES)
	{
		label.text = [NSString stringWithFormat:@"Hexachord\rForte: 6-Z4\rVector: 432321"];
		//@"Pitch Class Set (012456):" 
	}
	
	if ([messageFromPicker isEqualToString: testString012457] == YES)
	{
		label.text = [NSString stringWithFormat:@"Hexachord\rForte: 6-Z11\rVector: 333231"];
		//@"Pitch Class Set (012457):" 
	}
	
	if ([messageFromPicker isEqualToString: testString012458] == YES)
	{
		label.text = [NSString stringWithFormat:@"Hexachord\rForte: 6-15\rVector: 323421"];
		//@"Pitch Class Set (012458):" 
	}
	
	if ([messageFromPicker isEqualToString: testString012467] == YES)
	{
		label.text = [NSString stringWithFormat:@"Hexachord\rForte: 6-Z12\rVector: 332232"];
		//@"Pitch Class Set (012467):" 
	}
	
	if ([messageFromPicker isEqualToString: testString012468] == YES)
	{
		label.text = [NSString stringWithFormat:@"Hexachord\rForte: 6-22\rVector: 241422"];
		//@"Pitch Class Set (012468):" 
	}
	
	if ([messageFromPicker isEqualToString: testString012469] == YES)
	{
		label.text = [NSString stringWithFormat:@"Hexachord\rForte: 6-Z46\rVector: 233331"];// ADD IN X.X: \rDegree of Transpositional Symmetry: X\rDegree of Inversional Symmetry: X\rIndex Vector: XXXXXXXXXXXX\rIndex Vector T0I to the Prime Form: XXXXXXXXXXXX\rComplimentary Set Class: (XXXXXXXXXX)
		//@"Pitch Class Set (012469):" 
	}
	
	if ([messageFromPicker isEqualToString: testString012478] == YES)
	{
		label.text = [NSString stringWithFormat:@"Hexachord\rForte: 6-Z17\rVector: 322332"];
		//@"Pitch Class Set (012478):" 
	}
	
	if ([messageFromPicker isEqualToString: testString012479] == YES)
	{
		label.text = [NSString stringWithFormat:@"Hexachord\rForte: 6-Z47\rVector: 233241"];
		//@"Pitch Class Set (012479):" 
	}
	
	if ([messageFromPicker isEqualToString: testString012567] == YES)
	{
		label.text = [NSString stringWithFormat:@"Hexachord\rForte: 6-Z6\rVector: 421242"];
		//@"Pitch Class Set (012567):" 
	}
	
	if ([messageFromPicker isEqualToString: testString012568] == YES)
	{
		label.text = [NSString stringWithFormat:@"Hexachord\rForte: 6-Z43\rVector: 322332"];
		//@"Pitch Class Set (012568):" 
	}
	
	if ([messageFromPicker isEqualToString: testString012569] == YES)
	{
		label.text = [NSString stringWithFormat:@"Hexachord\rForte: 6-Z44\rVector: 313431"];
		//@"Pitch Class Set (012569):" 
	}
	
	if ([messageFromPicker isEqualToString: testString012578] == YES)
	{
		label.text = [NSString stringWithFormat:@"Hexachord\rForte: 6-18\rVector: 322242"];
		//@"Pitch Class Set (012578):" 
	}
	
	if ([messageFromPicker isEqualToString: testString012579] == YES)
	{
		label.text = [NSString stringWithFormat:@"Hexachord\rForte: 6-Z48\rVector: 232341"];
		//@"Pitch Class Set (012579):" 
	}
	
	if ([messageFromPicker isEqualToString: testString012678] == YES)
	{
		label.text = [NSString stringWithFormat:@"Hexachord\rForte: 6-7\rVector: 420243"];
		//@"Pitch Class Set (012678):" 
	}
	
	if ([messageFromPicker isEqualToString: testString013457] == YES)
	{
		label.text = [NSString stringWithFormat:@"Hexachord\rForte: 6-10\rVector: 333321"];
		//@"Pitch Class Set (013457):" 
	}
	
	if ([messageFromPicker isEqualToString: testString013458] == YES)
	{
		label.text = [NSString stringWithFormat:@"Hexachord\rForte: 6-14\rVector: 323430"];
		//@"Pitch Class Set (013458):" 
	}
	
	if ([messageFromPicker isEqualToString: testString013467] == YES)
	{
		label.text = [NSString stringWithFormat:@"Hexachord\rForte: 6-Z13\rVector: 324222"];
		//@"Pitch Class Set (013467):" 
	}
	
	if ([messageFromPicker isEqualToString: testString013468] == YES)
	{
		label.text = [NSString stringWithFormat:@"Hexachord\rForte: 6-Z24\rVector: 233331"];
		//@"Pitch Class Set (013468):" 
	}
	
	if ([messageFromPicker isEqualToString: testString013469] == YES)
	{
		label.text = [NSString stringWithFormat:@"Hexachord\rForte: 6-27\rVector: 225222"];
		//@"Pitch Class Set (013469):" 
	}
	
	if ([messageFromPicker isEqualToString: testString013478] == YES)
	{
		label.text = [NSString stringWithFormat:@"Hexachord\rForte: 6-Z19\rVector: 313431"];
		//@"Pitch Class Set (013478):" 
	}
	
	if ([messageFromPicker isEqualToString: testString013479] == YES)
	{
		label.text = [NSString stringWithFormat:@"Hexachord\rForte: 6-Z49\rVector: 224322"];
		//@"Pitch Class Set (013479):" 
	}
	
	if ([messageFromPicker isEqualToString: testString013568] == YES)
	{
		label.text = [NSString stringWithFormat:@"Hexachord\rForte: 6-Z25\rVector: 233241"];
		//@"Pitch Class Set (013568):" 
	}
	
	if ([messageFromPicker isEqualToString: testString013569] == YES)
	{
		label.text = [NSString stringWithFormat:@"Hexachord\rForte: 6-Z28\rVector: 224322"];
		//@"Pitch Class Set (013569):" 
	}
	
	if ([messageFromPicker isEqualToString: testString013578] == YES)
	{
		label.text = [NSString stringWithFormat:@"Hexachord\rForte: 6-Z26\rVector: 232341"];
		//@"Pitch Class Set (013578):" 
	}
	
	if ([messageFromPicker isEqualToString: testString013579] == YES)
	{
		label.text = [NSString stringWithFormat:@"Hexachord\rForte: 6-34\rVector: 142422"];
		//@"Pitch Class Set (013579):" 
	}
	
	if ([messageFromPicker isEqualToString: testString013679] == YES)
	{
		label.text = [NSString stringWithFormat:@"Hexachord\rForte: 6-30\rVector: 224223"];
		//@"Pitch Class Set (013679):" 
	}
	
	if ([messageFromPicker isEqualToString: testString014568] == YES)
	{
		label.text = [NSString stringWithFormat:@"Hexachord\rForte: 6-16\rVector: 322431"];
		//@"Pitch Class Set (014568):" 
	}
	
	if ([messageFromPicker isEqualToString: testString014579] == YES)
	{
		label.text = [NSString stringWithFormat:@"Hexachord\rForte: 6-31\rVector: 223431"];
		//@"Pitch Class Set (014579):" 
	}
	
	if ([messageFromPicker isEqualToString: testString014589] == YES)
	{
		label.text = [NSString stringWithFormat:@"Hexachord\rForte: 6-20\rVector: 303630"];
		//@"Pitch Class Set (014589):" 
	}
	
	if ([messageFromPicker isEqualToString: testString014679] == YES)
	{
		label.text = [NSString stringWithFormat:@"Hexachord\rForte: 6-Z29\rVector: 224232"];
		//@"Pitch Class Set (014679):" 
	}
	
	if ([messageFromPicker isEqualToString: testString023457] == YES)
	{
		label.text = [NSString stringWithFormat:@"Hexachord\rForte: 6-8\rVector: 343230"];// ADD IN 1.1: \rDegree of Transpositional Symmetry: 1\rDegree of Inversional Symmetry: 1\rIndex Vector: 123210000000\rIndex Vector T0I to the Prime Form: 100000001232\rComplimentary Set Class: (012345678)
		//@"Pitch Class Set (023457):" 
	}
	
	if ([messageFromPicker isEqualToString: testString023458] == YES)
	{
		label.text = [NSString stringWithFormat:@"Hexachord\rForte: 6-Z39\rVector: 333321"];
		//@"Pitch Class Set (023458):" 
	}
	
	if ([messageFromPicker isEqualToString: testString023468] == YES)
	{
		label.text = [NSString stringWithFormat:@"Hexachord\rForte: 6-21\rVector: 242412"];// ADD IN 1.1: \rDegree of Transpositional Symmetry: 1\rDegree of Inversional Symmetry: 0\rIndex Vector: 121220100000\rIndex Vector T0I to the Prime Form: 100000102212\rComplimentary Set Class: (012345679)
		//@"Pitch Class Set (023468):" 
	}
	
	if ([messageFromPicker isEqualToString: testString023469] == YES)
	{
		label.text = [NSString stringWithFormat:@"Hexachord\rForte: 6-Z45\rVector: 234222"];
		//@"Pitch Class Set (023469):" 
	}
	
	if ([messageFromPicker isEqualToString: testString023568] == YES)
	{
		label.text = [NSString stringWithFormat:@"Hexachord\rForte: 6-Z23\rVector: 234222"];
		//@"Pitch Class Set (023568):" 
	}
	
	if ([messageFromPicker isEqualToString: testString023579] == YES)
	{
		label.text = [NSString stringWithFormat:@"Hexachord\rForte: 6-33\rVector: 143241"];
		//@"Pitch Class Set (023579):" 
	}
	
	if ([messageFromPicker isEqualToString: testString023679] == YES)
	{
		label.text = [NSString stringWithFormat:@"Hexachord\rForte: 6-Z29\rVector: 224232"];
		//@"Pitch Class Set (023679):" 
	}
	
	if ([messageFromPicker isEqualToString: testString024579] == YES)
	{
		label.text = [NSString stringWithFormat:@"Hexachord\rForte: 6-32\rVector: 122311"];
		//@"Pitch Class Set (024579):" 
	}
	
	if ([messageFromPicker isEqualToString: testString02468T] == YES)
	{
		label.text = [NSString stringWithFormat:@"Hexachord\rForte: 6-35\rVector: 040402"];
		//@"Pitch Class Set (02468T):" 
	}
	
	// THESE MAY BE DUPLICATES
	/*
	if ([messageFromPicker isEqualToString: testString02469] == YES)
	{
		label.text = [NSString stringWithFormat:@"Hexachord\rForte: 6-34\rVector: 032221"];
		//@"Pitch Class Set (02469):" 
	}
	
	if ([messageFromPicker isEqualToString: testString02479] == YES)
	{
		label.text = [NSString stringWithFormat:@"Hexachord\rForte: 6-35\rVector: 032140"];
		//@"Pitch Class Set (02479):" 
	}
	
	if ([messageFromPicker isEqualToString: testString03458] == YES)
	{
		label.text = [NSString stringWithFormat:@"Hexachord\rForte: 6-Z37\rVector: 212320"];
		//@"Pitch Class Set (03458):" 
	}*/
	
	// *********** Septachords ifs **********************
	if ([messageFromPicker isEqualToString: testString0123456] == YES)
	{
		label.text = [NSString stringWithFormat:@"Septachord\rForte: 7-2\rVector: 654321"];// ADD IN X.X: \rDegree of Transpositional Symmetry: X\rDegree of Inversional Symmetry: X\rIndex Vector: XXXXXXXXXXXX\rIndex Vector T0I to the Prime Form: XXXXXXXXXXXX\rComplimentary Set Class: (XXXXXXXXXX)
		//@"Pitch Class Set (0123456):" 
	}
	
	if ([messageFromPicker isEqualToString: testString0123457] == YES)
	{
		label.text = [NSString stringWithFormat:@"Septachord\rForte: 7-2\rVector: 554331"];
		//@"Pitch Class Set (0123457):" 
	}
	
	if ([messageFromPicker isEqualToString: testString0123458] == YES)
	{
		label.text = [NSString stringWithFormat:@"Septachord\rForte: 7-3\rVector: 433221"];
		//@"Pitch Class Set (0123458):" 
	}
	
	if ([messageFromPicker isEqualToString: testString0123467] == YES)
	{
		label.text = [NSString stringWithFormat:@"Septachord\rForte: 7-4\rVector: 432321"];
		//@"Pitch Class Set (0123467):" 
	}
	
	if ([messageFromPicker isEqualToString: testString0123468] == YES)
	{
		label.text = [NSString stringWithFormat:@"Septachord\rForte: 7-9\rVector: 453432"];
		//@"Pitch Class Set (0123468):" 
	}
	
	if ([messageFromPicker isEqualToString: testString0123469] == YES)
	{
		label.text = [NSString stringWithFormat:@"Septachord\rForte: 7-10\rVector: 445332"];
		//@"Pitch Class Set (0123469):" 
	}
	
	if ([messageFromPicker isEqualToString: testString0123478] == YES)
	{
		label.text = [NSString stringWithFormat:@"Septachord\rForte: 7-6\rVector: 533442"];
		//@"Pitch Class Set (0123478):" 
	}
	
	if ([messageFromPicker isEqualToString: testString0123479] == YES)
	{
		label.text = [NSString stringWithFormat:@"Septachord\rForte: 7-Z12\rVector: 444342"];
		//@"Pitch Class Set (0123479):" 
	}
	
	if ([messageFromPicker isEqualToString: testString0123567] == YES)
	{
		label.text = [NSString stringWithFormat:@"Septachord\rForte: 7-5\rVector: 543342"];
		//@"Pitch Class Set (0123567):" 
	}
	
	if ([messageFromPicker isEqualToString: testString0123568] == YES)
	{
		label.text = [NSString stringWithFormat:@"Septachord\rForte: 7-Z36\rVector: 444342"];
		//@"Pitch Class Set (0123568):" 
	}
	
	if ([messageFromPicker isEqualToString: testString0123569] == YES)
	{
		label.text = [NSString stringWithFormat:@"Septachord\rForte: 7-16\rVector: 435432"];
		//@"Pitch Class Set (0123569):" 
	}
	
	if ([messageFromPicker isEqualToString: testString0123578] == YES)
	{
		label.text = [NSString stringWithFormat:@"Septachord\rForte: 7-14\rVector: 443352"];
		//@"Pitch Class Set (0123578):" 
	}
	
	if ([messageFromPicker isEqualToString: testString0123579] == YES)
	{
		label.text = [NSString stringWithFormat:@"Septachord\rForte: 7-24\rVector: 353442"];
		//@"Pitch Class Set (0123579):" 
	}
	
	if ([messageFromPicker isEqualToString: testString0123678] == YES)
	{
		label.text = [NSString stringWithFormat:@"Septachord\rForte: 7-7\rVector: 532353"];
		//@"Pitch Class Set (0123678):" 
	}
	
	if ([messageFromPicker isEqualToString: testString0123679] == YES)
	{
		label.text = [NSString stringWithFormat:@"Septachord\rForte: 7-19\rVector: 434343"];
		//@"Pitch Class Set (0123679):" 
	}
	
	if ([messageFromPicker isEqualToString: testString013468T] == YES)
	{
		label.text = [NSString stringWithFormat:@"Septachord\rForte: 7-34\rVector: 254442"];
		//@"Pitch Class Set (013468T):" 
	}
	
	if ([messageFromPicker isEqualToString: testString0124568] == YES)
	{
		label.text = [NSString stringWithFormat:@"Septachord\rForte: 7-13\rVector: 443532"];
		//@"Pitch Class Set (0124568):" 
	}
	
	if ([messageFromPicker isEqualToString: testString0124569] == YES)
	{
		label.text = [NSString stringWithFormat:@"Septachord\rForte: 7-Z17\rVector: 434541"];
		//@"Pitch Class Set (0124569):" 
	}
	
	if ([messageFromPicker isEqualToString: testString0124578] == YES)
	{
		label.text = [NSString stringWithFormat:@"Septachord\rForte: 7-Z38\rVector: 434442"];
		//@"Pitch Class Set (0124578):" 
	}
	
	if ([messageFromPicker isEqualToString: testString0124579] == YES)
	{
		label.text = [NSString stringWithFormat:@"Septachord\rForte: 7-27\rVector: 344451"];
		//@"Pitch Class Set (0124579):" 
	}
	
	if ([messageFromPicker isEqualToString: testString0124589] == YES)
	{
		label.text = [NSString stringWithFormat:@"Septachord\rForte: 7-21\rVector: 424641"];
		//@"Pitch Class Set (0124589):" 
	}
	
	if ([messageFromPicker isEqualToString: testString0124678] == YES)
	{
		label.text = [NSString stringWithFormat:@"Septachord\rForte: 7-15\rVector: 442443"];
		//@"Pitch Class Set (0124678):" 
	}
	
	if ([messageFromPicker isEqualToString: testString0124679] == YES)
	{
		label.text = [NSString stringWithFormat:@"Septachord\rForte: 7-29\rVector: 344352"];
		//@"Pitch Class Set (0124679):" 
	}
	
	if ([messageFromPicker isEqualToString: testString012468T] == YES)
	{
		label.text = [NSString stringWithFormat:@"Septachord\rForte: 7-33\rVector: 262623"];
		//@"Pitch Class Set (012468T):" 
	}
	
	if ([messageFromPicker isEqualToString: testString0124689] == YES)
	{
		label.text = [NSString stringWithFormat:@"Septachord\rForte: 7-30\rVector: 343542"];
		//@"Pitch Class Set (0124689):" 
	}
	
	if ([messageFromPicker isEqualToString: testString0125679] == YES)
	{
		label.text = [NSString stringWithFormat:@"Septachord\rForte: 7-20\rVector: 433452"];
		//@"Pitch Class Set (0125679):" 
	}
	
	if ([messageFromPicker isEqualToString: testString0125689] == YES)
	{
		label.text = [NSString stringWithFormat:@"Septachord\rForte: 7-22\rVector: 424542"];
		//@"Pitch Class Set (0125689):" 
	}
	
	if ([messageFromPicker isEqualToString: testString0134568] == YES)
	{
		label.text = [NSString stringWithFormat:@"Septachord\rForte: 7-11\rVector: 444441"];
		//@"Pitch Class Set (0134568):" 
	}
	
	if ([messageFromPicker isEqualToString: testString0134578] == YES)
	{
		label.text = [NSString stringWithFormat:@"Septachord\rForte: 7-Z37\rVector: 434541"];
		//@"Pitch Class Set (0134578):" 
	}
	
	if ([messageFromPicker isEqualToString: testString0134579] == YES)
	{
		label.text = [NSString stringWithFormat:@"Septachord\rForte: 7-26\rVector: 344532"];
		//@"Pitch Class Set (0134579):" 
	}
	
	if ([messageFromPicker isEqualToString: testString0134679] == YES)
	{
		label.text = [NSString stringWithFormat:@"Septachord\rForte: 7-31\rVector: 336333"];
		//@"Pitch Class Set (0134679):" 
	}
	
	if ([messageFromPicker isEqualToString: testString0134689] == YES)
	{
		label.text = [NSString stringWithFormat:@"Septachord\rForte: 7-32\rVector: 335442"];
		//@"Pitch Class Set (0134689):" 
	}
	
	if ([messageFromPicker isEqualToString: testString0135679] == YES)
	{
		label.text = [NSString stringWithFormat:@"Septachord\rForte: 7-28\rVector: 344433"];
		//@"Pitch Class Set (0135679):" 
	}
	
	if ([messageFromPicker isEqualToString: testString0145679] == YES)
	{
		label.text = [NSString stringWithFormat:@"Septachord\rForte: 7-18\rVector: 434442"];
		//@"Pitch Class Set (0145679):" 
	}
	
	if ([messageFromPicker isEqualToString: testString0234568] == YES)
	{
		label.text = [NSString stringWithFormat:@"Septachord\rForte: 7-8\rVector: 454422"];
		//@"Pitch Class Set (0234568):" 
	}
	
	if ([messageFromPicker isEqualToString: testString0234679] == YES)
	{
		label.text = [NSString stringWithFormat:@"Septachord\rForte: 7-25\rVector: 345342"];
		//@"Pitch Class Set (0234679):" 
	}
	
	// *********** Octachords ifs **********************
	if ([messageFromPicker isEqualToString: testString01234567] == YES)
	{
		label.text = [NSString stringWithFormat:@"Octachord\rForte: 8-1\rVector: 765442"];// ADD IN X.X: \rDegree of Transpositional Symmetry: X\rDegree of Inversional Symmetry: X\rIndex Vector: XXXXXXXXXXXX\rIndex Vector T0I to the Prime Form: XXXXXXXXXXXX\rComplimentary Set Class: (XXXXXXXXXX)
		//@"Pitch Class Set (01234567):" 
	}
	
	if ([messageFromPicker isEqualToString: testString01234568] == YES)
	{
		label.text = [NSString stringWithFormat:@"Octachord\rForte: 8-2\rVector: 665542"];
		//@"Pitch Class Set (01234568):" 
	}
	
	if ([messageFromPicker isEqualToString: testString01234578] == YES)
	{
		label.text = [NSString stringWithFormat:@"Octachord\rForte: 8-4\rVector: 655552"];
		//@"Pitch Class Set (01234578):" 
	}
	
	if ([messageFromPicker isEqualToString: testString01234678] == YES)
	{
		label.text = [NSString stringWithFormat:@"Octachord\rForte: 8-5\rVector: 654553"];
		//@"Pitch Class Set (01234678):" 
	}
	
	if ([messageFromPicker isEqualToString: testString01235678] == YES)
	{
		label.text = [NSString stringWithFormat:@"Octachord\rForte: 8-6\rVector: 654463"];
		//@"Pitch Class Set (01235678):" 
	}
	
	if ([messageFromPicker isEqualToString: testString01234569] == YES)
	{
		label.text = [NSString stringWithFormat:@"Octachord\rForte: 8-3\rVector: 656542"];
		//@"Pitch Class Set (01234569):" 
	}
	
	if ([messageFromPicker isEqualToString: testString01234579] == YES)
	{
		label.text = [NSString stringWithFormat:@"Octachord\rForte: 8-11\rVector: 565552"];
		//@"Pitch Class Set (01234579):" 
	}
	
	if ([messageFromPicker isEqualToString: testString01234679] == YES)
	{
		label.text = [NSString stringWithFormat:@"Octachord\rForte: 8-13\rVector: 556453"];
		//@"Pitch Class Set (01234679):" 
	}
	
	if ([messageFromPicker isEqualToString: testString01235679] == YES)
	{
		label.text = [NSString stringWithFormat:@"Octachord\rForte: 8-Z29\rVector: 555553"];
		//@"Pitch Class Set (01235679):" 
	}
	
	if ([messageFromPicker isEqualToString: testString01234589] == YES)
	{
		label.text = [NSString stringWithFormat:@"Octachord\rForte: 8-7\rVector: 645652"];
		//@"Pitch Class Set (01234589):" 
	}
	
	if ([messageFromPicker isEqualToString: testString01234689] == YES)
	{
		label.text = [NSString stringWithFormat:@"Octachord\rForte: 8-Z15\rVector: 555553"];
		//@"Pitch Class Set (01234689):" 
	}
	
	if ([messageFromPicker isEqualToString: testString01235689] == YES)
	{
		label.text = [NSString stringWithFormat:@"Octachord\rForte: 8-18\rVector: 546553"];
		//@"Pitch Class Set (01235689):" 
	}
	
	if ([messageFromPicker isEqualToString: testString01245689] == YES)
	{
		label.text = [NSString stringWithFormat:@"Octachord\rForte: 8-19\rVector: 545752"];
		//@"Pitch Class Set (01245689):" 
	}
	
	if ([messageFromPicker isEqualToString: testString01234789] == YES)
	{
		label.text = [NSString stringWithFormat:@"Octachord\rForte: 8-8\rVector: 644563"];
		//@"Pitch Class Set (01234789):" 
	}
	
	if ([messageFromPicker isEqualToString: testString01235789] == YES)
	{
		label.text = [NSString stringWithFormat:@"Octachord\rForte: 8-16\rVector: 554563"];
		//@"Pitch Class Set (01235789):" 
	}
	
	if ([messageFromPicker isEqualToString: testString01245789] == YES)
	{
		label.text = [NSString stringWithFormat:@"Octachord\rForte: 8-20\rVector: 545662"];
		//@"Pitch Class Set (01245789):" 
	}
	
	if ([messageFromPicker isEqualToString: testString01236789] == YES)
	{
		label.text = [NSString stringWithFormat:@"Octachord\rForte: 8-9\rVector: 644464"];
		//@"Pitch Class Set (01236789):" 
	}
	
	if ([messageFromPicker isEqualToString: testString02345679] == YES)
	{
		label.text = [NSString stringWithFormat:@"Octachord\rForte: 8-10\rVector: 566452"];
		//@"Pitch Class Set (02345679):" 
	}
	
	if ([messageFromPicker isEqualToString: testString01345679] == YES)
	{
		label.text = [NSString stringWithFormat:@"Octachord\rForte: 8-12\rVector: 556543"];
		//@"Pitch Class Set (01345679):" 
	}
	
	if ([messageFromPicker isEqualToString: testString01245679] == YES)
	{
		label.text = [NSString stringWithFormat:@"Octachord\rForte: 8-14\rVector: 555562"];
		//@"Pitch Class Set (01245679):" 
	}
	
	if ([messageFromPicker isEqualToString: testString0123468T] == YES)
	{
		label.text = [NSString stringWithFormat:@"Octachord\rForte: 8-21\rVector: 474643"];
		//@"Pitch Class Set (0123468T):" 
	}
	
	if ([messageFromPicker isEqualToString: testString0123568T] == YES)
	{
		label.text = [NSString stringWithFormat:@"Octachord\rForte: 8-22\rVector: 465562"];
		//@"Pitch Class Set (0123568T):" 
	}
	
	if ([messageFromPicker isEqualToString: testString0124568T] == YES)
	{
		label.text = [NSString stringWithFormat:@"Octachord\rForte: 8-24\rVector: 464743"];
		//@"Pitch Class Set (0124568T):" 
	}
	
	if ([messageFromPicker isEqualToString: testString0123578T] == YES)
	{
		label.text = [NSString stringWithFormat:@"Octachord\rForte: 8-23\rVector: 465472"];
		//@"Pitch Class Set (0123578T):" 
	}
	
	if ([messageFromPicker isEqualToString: testString0124578T] == YES)
	{
		label.text = [NSString stringWithFormat:@"Octachord\rForte: 8-27\rVector: 456553"];
		//@"Pitch Class Set (0124578T):" 
	}
	
	if ([messageFromPicker isEqualToString: testString0124678T] == YES)
	{
		label.text = [NSString stringWithFormat:@"Octachord\rForte: 8-25\rVector: 464644"];
		//@"Pitch Class Set (0124678T):" 
	}
	
	if ([messageFromPicker isEqualToString: testString01345689] == YES)
	{
		label.text = [NSString stringWithFormat:@"Octachord\rForte: 8-17\rVector: 546652"];
		//@"Pitch Class Set (01345689):" 
	}
	
	if ([messageFromPicker isEqualToString: testString0134578T] == YES)
	{
		label.text = [NSString stringWithFormat:@"Octachord\rForte: 8-26\rVector: 456562"];
		//@"Pitch Class Set (0134578T):" 
	}
	
	if ([messageFromPicker isEqualToString: testString0134679T] == YES)
	{
		label.text = [NSString stringWithFormat:@"Octachord\rForte: 8-28\rVector: 448444"];
		//@"Pitch Class Set (0134679T):" 
	}
	
	// *********** Nonachords ifs **********************
	if ([messageFromPicker isEqualToString: testString012345678] == YES)
	{
		label.text = [NSString stringWithFormat:@"Nonachord\rForte: 9-1\rVector: 876663"];// ADD IN X.X: \rDegree of Transpositional Symmetry: X\rDegree of Inversional Symmetry: X\rIndex Vector: XXXXXXXXXXXX\rIndex Vector T0I to the Prime Form: XXXXXXXXXXXX\rComplimentary Set Class: (XXXXXXXXXX)
		//@"Pitch Class Set (012345678):" 
	}
	
	if ([messageFromPicker isEqualToString: testString012345679] == YES)
	{
		label.text = [NSString stringWithFormat:@"Nonachord\rForte: 9-2\rVector: 777663"];
		//@"Pitch Class Set (012345679):" 
	}
	
	if ([messageFromPicker isEqualToString: testString012345689] == YES)
	{
		label.text = [NSString stringWithFormat:@"Nonachord\rForte: 9-3\rVector: 767763"];
		//@"Pitch Class Set (012345689):" 
	}
	
	if ([messageFromPicker isEqualToString: testString012345789] == YES)
	{
		label.text = [NSString stringWithFormat:@"Nonachord\rForte: 9-4\rVector: 766773"];
		//@"Pitch Class Set (012345789):" 
	}
	
	if ([messageFromPicker isEqualToString: testString012346789] == YES)
	{
		label.text = [NSString stringWithFormat:@"Nonachord\rForte: 9-5\rVector: 766674"];
		//@"Pitch Class Set (012346789):" 
	}
	
	if ([messageFromPicker isEqualToString: testString01234568T] == YES)
	{
		label.text = [NSString stringWithFormat:@"Nonachord\rForte: 9-6\rVector: 686763"];
		//@"Pitch Class Set (01234568T):" 
	}
	
	if ([messageFromPicker isEqualToString: testString01234578T] == YES)
	{
		label.text = [NSString stringWithFormat:@"Nonachord\rForte: 9-7\rVector: 677673"];
		//@"Pitch Class Set (01234578T):" 
	}
	
	if ([messageFromPicker isEqualToString: testString01234678T] == YES)
	{
		label.text = [NSString stringWithFormat:@"Nonachord\rForte: 9-8\rVector: 676764"];
		//@"Pitch Class Set (01234678T):" 
	}
	
	if ([messageFromPicker isEqualToString: testString01235678T] == YES)
	{
		label.text = [NSString stringWithFormat:@"Nonachord\rForte: 9-9\rVector: 676683"];
		//@"Pitch Class Set (01235678T):" 
	}
	
	if ([messageFromPicker isEqualToString: testString01234679T] == YES)
	{
		label.text = [NSString stringWithFormat:@"Nonachord\rForte: 9-10\rVector: 645652"];
		//@"Pitch Class Set (01234679T):" 
	}
	
	if ([messageFromPicker isEqualToString: testString01235679T] == YES)
	{
		label.text = [NSString stringWithFormat:@"Nonachord\rForte: 9-11\rVector: 667773"];
		//@"Pitch Class Set (01235679T):" 
	}
	
	if ([messageFromPicker isEqualToString: testString01245689T] == YES)
	{
		label.text = [NSString stringWithFormat:@"Nonachord\rForte: 9-12\rVector: 666963"];
		//@"Pitch Class Set (01245689T):" 
	}																	
	
	// ***TEST STRING AUTORELEASE *******************************************
	// *********** Trichords TEST STRING RELEASE **********************
	[testString012 autorelease];
	[testString013 autorelease];
	[testString014 autorelease];
	[testString015 autorelease];
	[testString016 autorelease];
	[testString024 autorelease];
	[testString025 autorelease];
	[testString026 autorelease];
	[testString027 autorelease];
	[testString036 autorelease];
	[testString037 autorelease];
	[testString048 autorelease];
	
	// *********** Tetrachords TEST STRING RELEASE **********************
	[testString0123 autorelease];
	[testString0124 autorelease];
	[testString0125 autorelease];
	[testString0126 autorelease];
	[testString0127 autorelease];
	[testString0134 autorelease];
	[testString0135 autorelease];
	[testString0136 autorelease];
	[testString0137 autorelease];
	[testString0145 autorelease];
	[testString0146 autorelease];
	[testString0147 autorelease];
	[testString0148 autorelease];
	[testString0156 autorelease];
	[testString0157 autorelease];
	[testString0158 autorelease];
	[testString0167 autorelease];
	[testString0235 autorelease];
	[testString0236 autorelease];
	[testString0237 autorelease];
	[testString0246 autorelease];
	[testString0247 autorelease];
	[testString0248 autorelease];
	[testString0257 autorelease];
	[testString0258 autorelease];
	[testString0268 autorelease];
	[testString0347 autorelease];
	[testString0358 autorelease];
	[testString0369 autorelease];
	
	// *********** Pentachords TEST STRING RELEASE **********************
	[testString01234 autorelease];
	[testString01235 autorelease];
	[testString01236 autorelease];
	[testString01237 autorelease];
	[testString01245 autorelease];
	[testString01246 autorelease];
	[testString01247 autorelease];
	[testString01248 autorelease];
	[testString01256 autorelease];
	[testString01257 autorelease];
	[testString01258 autorelease];
	[testString01267 autorelease];
	[testString01268 autorelease];
	[testString01346 autorelease];
	[testString01347 autorelease];
	[testString01348 autorelease];
	[testString01356 autorelease];
	[testString01357 autorelease];
	[testString01358 autorelease];
	[testString01367 autorelease];
	[testString01368 autorelease];
	[testString01369 autorelease];
	[testString01457 autorelease];
	[testString01458 autorelease];
	[testString01468 autorelease];
	[testString01469 autorelease];
	[testString01478 autorelease];
	[testString01568 autorelease];
	[testString02346 autorelease];
	[testString02347 autorelease];
	[testString02357 autorelease];
	[testString02358 autorelease];
	[testString02368 autorelease];
	[testString02458 autorelease];
	[testString02468 autorelease];
	[testString02469 autorelease];
	[testString02479 autorelease];
	[testString03458 autorelease];
	
	// *********** Pentachords TEST STRING RELEASE **********************
	[testString012345 autorelease];
	[testString012346 autorelease];
	[testString012347 autorelease];
	[testString012348 autorelease];
	[testString012356 autorelease];
	[testString012357 autorelease];
	[testString012358 autorelease];
	[testString012367 autorelease];
	[testString012368 autorelease];
	[testString012369 autorelease];
	[testString012378 autorelease];
	[testString012456 autorelease];
	[testString012457 autorelease];
	[testString012458 autorelease];
	[testString012468 autorelease];
	[testString012467 autorelease];
	[testString012469 autorelease];
	[testString012478 autorelease];
	[testString012479 autorelease];
	[testString012567 autorelease];
	[testString012568 autorelease];
	[testString012569 autorelease];
	[testString012578 autorelease];
	[testString012579 autorelease];
	[testString012678 autorelease];
	[testString013457 autorelease];
	[testString013458 autorelease];
	[testString013467 autorelease];
	[testString013468 autorelease];
	[testString013469 autorelease];
	[testString013478 autorelease];
	[testString013479 autorelease];
	[testString013568 autorelease];
	[testString013569 autorelease];
	[testString013578 autorelease];
	[testString013579 autorelease];
	[testString013679 autorelease];
	[testString014568 autorelease];
	[testString014579 autorelease];
	[testString014589 autorelease];
	[testString014679 autorelease];
	[testString023457 autorelease];
	[testString023458 autorelease];
	[testString023468 autorelease];
	[testString023568 autorelease];
	[testString023469 autorelease];
	[testString023579 autorelease];
	[testString023679 autorelease];
	[testString024579 autorelease];
	[testString02468T autorelease];
	
	// *********** Septachords TEST STRING RELEASE **********************
	[testString0123456 autorelease];
	[testString0123457 autorelease];
	[testString0123458 autorelease];
	[testString0123467 autorelease];
	[testString0123468 autorelease];
	[testString0123469 autorelease];
	[testString0123478 autorelease];
	[testString0123479 autorelease];
	[testString0123567 autorelease];
	[testString0123568 autorelease];
	[testString0123569 autorelease];
	[testString0123578 autorelease];
	[testString0123579 autorelease];
	[testString0123678 autorelease];
	[testString0123679 autorelease];
	[testString0124568 autorelease];
	[testString0124569 autorelease];
	[testString0124578 autorelease];
	[testString0124579 autorelease];
	[testString0124589 autorelease];
	[testString0124678 autorelease];
	[testString0124679 autorelease];
	[testString012468T autorelease];
	[testString0124689 autorelease];
	[testString0125679 autorelease];
	[testString0125689 autorelease];
	[testString0134568 autorelease];
	[testString0134578 autorelease];
	[testString0134579 autorelease];
	[testString0134679 autorelease];
	[testString0134689 autorelease];
	[testString0135679 autorelease];
	[testString0145679 autorelease];
	[testString0234568 autorelease];
	[testString0234679 autorelease];
	[testString013468T autorelease];
	
	// *********** Octachords TEST STRING RELEASE **********************
	[testString01234567 autorelease];
	[testString01234568 autorelease];
	[testString01234578 autorelease];
	[testString01234678 autorelease];
	[testString01235678 autorelease];
	[testString01234569 autorelease];
	[testString01234579 autorelease];
	[testString01234679 autorelease];
	[testString01235679 autorelease];
	[testString01234589 autorelease];
	[testString01234689 autorelease];
	[testString01235689 autorelease];
	[testString01245689 autorelease];
	[testString01234789 autorelease];
	[testString01235789 autorelease];
	[testString01236789 autorelease];
	[testString02345679 autorelease];
	[testString01345679 autorelease];
	[testString01245679 autorelease];
	[testString0123468T autorelease];
	[testString0123568T autorelease];
	[testString0124568T autorelease];
	[testString0123578T autorelease];
	[testString0124578T autorelease];
	[testString0124678T autorelease];
	[testString01345689 autorelease];
	[testString0134578T autorelease];
	[testString0134679T autorelease];
	[testString01245789 autorelease];
	
	// *********** Nonachords TEST STRING RELEASE **********************
	[testString012345678 autorelease];
	[testString012345679 autorelease];
	[testString012345689 autorelease];
	[testString012345789 autorelease];
	[testString012346789 autorelease];
	[testString01234568T autorelease];
	[testString01234578T autorelease];
	[testString01234678T autorelease];
	[testString01235678T autorelease];
	[testString01234679T autorelease];
	[testString01235679T autorelease];
	[testString01245689T autorelease];
	
	// ^*^^^^^^*^*^^*^*^*^*^^^^^*^*^^*^*^*^*^^*^*^*^^*^*^*^*^^^^^*^*^
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
	if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
		// Initialization code
	}
	return self;
}

// array
- (void)viewDidLoad {
	NSArray *rootArray = [[NSArray alloc] initWithObjects:@"(012)", @"(013)", @"(014)", @"(015)", @"(016)", @"(024)", @"(025)", @"(026)", @"(027)", @"(036)", @"(037)", @"(048)", @"(0123)", @"(0124)", @"(0125)", @"(0126)", @"(0127)", @"(0134)", @"(0135)", @"(0136)", @"(0137)", @"(0145)", @"(0146)", @"(0147)", @"(0148)", @"(0156)", @"(0157)", @"(0158)", @"(0167)", @"(0235)", @"(0236)", @"(0237)", @"(0246)", @"(0247)", @"(0248)", @"(0257)", @"(0258)", @"(0268)", @"(0347)", @"(0358)", @"(0369)", @"(01234)", @"(01235)", @"(01236)", @"(01237)", @"(01245)", @"(01246)", @"(01247)", @"(01248)", @"(01256)", @"(01257)", @"(01258)", @"(01267)", @"(01268)", @"(01346)", @"(01347)", @"(01348)", @"(01356)", @"(01357)", @"(01358)", @"(01367)", @"(01368)", @"(01369)", @"(01457)", @"(01458)", @"(01468)", @"(01469)", @"(01478)", @"(01568)", @"(02346)", @"(02347)", @"(02357)", @"(02358)", @"(02368)", @"(02458)", @"(02468)", @"(02469)", @"(02479)", @"(03458)", @"(012345)", @"(012346)", @"(012347)", @"(012348)", @"(012356)", @"(012357)", @"(012358)", @"(012367)", @"(012368)", @"(012369)", @"(012378)", @"(012456)", @"(012457)", @"(012458)", @"(012467)", @"(012468)", @"(012469)", @"(012478)", @"(012479)", @"(012567)", @"(012568)", @"(012569)", @"(012578)", @"(012579)", @"(012678)", @"(013457)", @"(013458)", @"(013467)", @"(013468)", @"(013469)", @"(013478)", @"(013479)", @"(013568)", @"(013569)", @"(013578)", @"(013579)", @"(013679)", @"(014568)", @"(014579)", @"(014589)", @"(014679)", @"(023457)", @"(023458)", @"(023468)", @"(023469)", @"(023568)", @"(023579)", @"(023679)", @"(024579)", @"(02468T)", @"(0123456)", @"(0123457)", @"(0123458)", @"(0123467)", @"(0123468)", @"(0123469)", @"(0123478)", @"(0123479)", @"(0123567)", @"(0123568)", @"(0123569)", @"(0123578)", @"(0123579)", @"(0123678)", @"(0123679)", @"(0124568)", @"(0124569)", @"(0124578)", @"(0124579)", @"(0124589)", @"(0124678)", @"(0124679)", @"(0124689)", @"(012468T)", @"(0125679)", @"(0125689)", @"(0134568)", @"(0134578)", @"(0134579)", @"(0134679)", @"(0134689)", @"(013468T)", @"(0135679)", @"(0145679)", @"(0234568)", @"(0234679)", @"(01234567)", @"(01234568)", @"(01234578)", @"(01234678)", @"(01235678)", @"(01234569)", @"(01234579)", @"(01234679)", @"(01235679)", @"(01234589)", @"(01234689)", @"(01235689)", @"(01245689)", @"(01234789)", @"(01235789)", @"(01236789)", @"(01245679)", @"(0123468T)", @"(0123568T)", @"(0124568T)", @"(0123578T)", @"(0124578T)", @"(0124678T)", @"(01345679)", @"(01345689)", @"(0134578T)", @"(0134679T)", @"(01245789)", @"(02345679)", @"(012345678)", @"(012345679)", @"(012345689)", @"(012345789)", @"(012346789)", @"(01234568T)", @"(01234578T)", @"(01234678T)", @"(01235678T)", @"(01234679T)", @"(01235679T)", @"(01245689T)", nil];
	self.chordRoot = rootArray;
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
	//[chordTypes release];
	[chordRoot release];
	[super dealloc];
}

#pragma mark -
#pragma mark Picker Data Source Methods
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
	return 1;
	//return 2;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
	/*
	 if (component == kChordComponent)
	 return [self.chordTypes count];
	 */
	
	return [self.chordRoot count];
}

#pragma mark Picker Delegate Methods
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
	/*
	 if (component == kChordComponent)
	 return [self.chordTypes objectAtIndex:row];
	 */
	
	return [self.chordRoot objectAtIndex:row];
}

@end
