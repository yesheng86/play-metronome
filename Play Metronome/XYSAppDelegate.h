//
//  XYSAppDelegate.h
//  Play Metronome
//
//  Created by Xu Yesheng on 5/24/14.
//  Copyright (c) 2014 yesheng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XYSDataKeeper.h"
#import "XYSALSoundMaker.h"
#import "XYSStoreAgent.h"
#import "XYSViewController.h"

@interface XYSAppDelegate : UIResponder <UIApplicationDelegate>
@property XYSDataKeeper *dataKeeper;
@property XYSALSoundMaker *soundMaker;
@property XYSStoreAgent *storeAgent;
@property XYSViewController *viewController;
@property (strong, nonatomic) UIWindow *window;
@end
