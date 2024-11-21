//
//  DoubleComponentPickerViewController.h
//  Harmony
//
//  Created by Brian B. James on 5/24/09.
//  Copyright Brian B. James 2009. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kRootComponent 0
#define kChordComponent 1
#define kInversionComponent 2

@interface DoubleComponentPickerViewController : UIViewController <UIPickerViewDelegate, UIPickerViewDataSource> 
{
	IBOutlet	UIPickerView *doublePicker;
	IBOutlet UILabel *label;
	NSArray *chordRoot;
	NSArray *chordTypes;
	NSArray *inversionTypes;
}

@property(nonatomic, retain) UIPickerView *doublePicker;
@property(nonatomic, retain) UILabel *label;
@property(nonatomic, retain) NSArray *chordRoot;
@property(nonatomic, retain) NSArray *chordTypes;
@property(nonatomic, retain) NSArray *inversionTypes;

@end
