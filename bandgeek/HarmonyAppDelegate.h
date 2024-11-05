//
//  HarmonyAppDelegate.h
//  Harmony
//
//  Created by Brian B. James on 5/24/09.
//  Copyright Brian B. James 2009. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HarmonyAppDelegate : NSObject <UIApplicationDelegate, UITabBarControllerDelegate> {
    UIWindow *window;
    UITabBarController *tabBarController;
	UINavigationController *navigationController;
	//IBOutlet UITabBarController *rootController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet UITabBarController *tabBarController;

@end
