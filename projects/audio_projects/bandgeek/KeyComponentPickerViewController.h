//
//  KeyComponentPickerViewController.h
//  Harmony
//
//  Created by Brian B. James on 5/24/09.
//  Copyright Brian B. James 2009. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kRootComponent 0
#define kKeyComponent 1

@interface KeyComponentPickerViewController : UIViewController <UIPickerViewDelegate, UIPickerViewDataSource> 
{
	IBOutlet	UIPickerView *doublePicker;
	IBOutlet UILabel *label;
	NSArray *keyRoot;
	NSArray *keyTypes;
}

@property(nonatomic, retain) UIPickerView *doublePicker;
@property(nonatomic, retain) UILabel *label;
@property(nonatomic, retain) NSArray *keyRoot;
@property(nonatomic, retain) NSArray *keyTypes;

@end
