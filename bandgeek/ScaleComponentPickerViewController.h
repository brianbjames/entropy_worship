//
//  ScaleComponentPickerViewController.h
//  Harmony
//
//  Created by Brian B. James on 5/24/09.
//  Copyright Brian B. James 2009. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kRootComponent 0
#define kModeComponent 1

@interface ScaleComponentPickerViewController : UIViewController <UIPickerViewDelegate, UIPickerViewDataSource> 
{
	IBOutlet	UIPickerView *doublePicker;
	IBOutlet UILabel *label;
	NSArray *modeRoot;
	NSArray *modeTypes;
}

@property(nonatomic, retain) UIPickerView *doublePicker;
@property(nonatomic, retain) UILabel *label;
@property(nonatomic, retain) NSArray *modeRoot;
@property(nonatomic, retain) NSArray *modeTypes;

@end
