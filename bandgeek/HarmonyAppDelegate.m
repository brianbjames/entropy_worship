//
//  HarmonyAppDelegate.m
//  Harmony
//
//  Created by Brian B. James on 5/24/09.
//  Copyright Brian B. James 2009. All rights reserved.
//

#import "HarmonyAppDelegate.h"


@implementation HarmonyAppDelegate

@synthesize window;
@synthesize tabBarController;

- (void)applicationDidFinishLaunching:(UIApplication *)application {
	
	navigationController = [[UINavigationController alloc] init];
    // Add the tab bar controller's current view as a subview of the window
    [window addSubview:tabBarController.view addSubview:navigationController.view];
	FirstViewController *viewController = [[FirstViewController alloc] initWithNibName:@"FirstView" bundle:nil];
    [navigationController pushViewController:viewController animated:NO];
    [viewController release];
    
    // Override point for customization after application launch
    [window makeKeyAndVisible];	
}

/*
// Optional UITabBarControllerDelegate method
- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController {
}
*/

/*
// Optional UITabBarControllerDelegate method
- (void)tabBarController:(UITabBarController *)tabBarController didEndCustomizingViewControllers:(NSArray *)viewControllers changed:(BOOL)changed {
}
*/

- (void)dealloc {
	[tabBarController release];
    [navigationController release];
    [window release];
    [super dealloc];
}

@end

