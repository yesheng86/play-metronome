//
//  XYSViewController.h
//  Play Metronome
//
//  Created by Xu Yesheng on 5/24/14.
//  Copyright (c) 2014 yesheng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <iAd/iAd.h>
#import "XYSContainerView.h"
#import "XYSMetronomeView.h"
#import "XYSDataKeeper.h"
#import "XYSALSoundMaker.h"
#import "XYSStoreAgent.h"

@interface ProcessingParameter : NSObject
@property PurchaseState purchaseState;
@property NSString *infoMessage;
@property NSString *errorMessage;
@property NSTimeInterval timeout;
+ (ProcessingParameter *)processParameterWithState:(PurchaseState)state Info:(NSString *)infoString Error:(NSString *)errorString Timeout:(NSTimeInterval)timeout;
@end

@interface XYSViewController : UIViewController  <ADBannerViewDelegate, XYSStoreAgentDelegate>

@property XYSContainerView *containerView;
@property XYSMetronomeView *metronomeView;
@property CADisplayLink *displayLink;
@property BOOL displayLinkWorking;
@property CGPoint holdLocation;

// data keeper
@property XYSDataKeeper *dataKeeper;

// sound maker
@property XYSALSoundMaker *alSoundMaker;

// store agent
@property XYSStoreAgent *storeAgent;

// weather app is interrupted
@property BOOL interrupted;
@property BOOL inBackground;

// for connecting store callback
@property CFTimeInterval startConnectTime;
@property uint dotNumber;

- (void)stopMetronomeAnimation;
- (void)scheduleResetAnimation;
- (void)breakIntoInterruption;
- (void)resumeFromInterruption;
- (void)clearDisplayLink;
@end
