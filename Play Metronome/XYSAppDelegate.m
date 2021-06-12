//
//  XYSAppDelegate.m
//  Play Metronome
//
//  Created by Xu Yesheng on 5/24/14.
//  Copyright (c) 2014 yesheng. All rights reserved.
//

#import "XYSAppDelegate.h"


@implementation XYSAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    _dataKeeper = [XYSDataKeeper sharedInstance];
    _soundMaker = [XYSALSoundMaker sharedInstance];
    _storeAgent = [XYSStoreAgent sharedInstance];
    _viewController = NULL;
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    NSLog(@"applicationWillResignActive");
    //[_viewController breakIntoInterruption];
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    NSLog(@"View entered background");
    [_dataKeeper storeData];
    [_viewController stopMetronomeAnimation];
    if (_viewController == NULL) {
        _viewController = (XYSViewController *)[_window rootViewController];
    }
    // sometimes touch is still holding
    [_viewController clearDisplayLink];
    [_viewController setInBackground:YES];
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    NSLog(@"View will enter foreground");
    // sound interrupted in background, context not yet restored
    [_soundMaker restoreContext];
    if ([_dataKeeper beating]) {
        [_viewController scheduleResetAnimation];
    }
    if (_viewController == NULL) {
        _viewController = (XYSViewController *)[_window rootViewController];
    }
    [_viewController setInBackground:NO];
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    NSLog(@"applicationDidBecomeActive");
    //[_viewController resumeFromInterruption];
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    NSLog(@"applicationWillTerminate");
    [_dataKeeper storeData];
}

@end
