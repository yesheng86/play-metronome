//
//  XYSContainerView.h
//  Play Metronome
//
//  Created by Xu Yesheng on 7/26/14.
//  Copyright (c) 2014 yesheng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XYSMetronomeView.h"
#import "XYSTextView.h"
#import "XYSConfigureView.h"
#import "XYSGearIconView.h"
#import "XYSTempoLightView.h"
#import "XYSAdView.h"


typedef enum __ScreenSize
{
    SZ480 = 0,      // iphone 4s and older
    SZ568,          // iphone 5s and 5
    SZ667,          // iphone 6
    SZ736,          // iphone 6 plus
    SZ1024,         // ipad
    SZUNKNOWN
} ScreenSize;

@interface XYSContainerView : UIView

@property XYSMetronomeView *metronomeView;
@property XYSTextView *tempoTextView;
@property XYSTextView *beatTextView;
@property XYSConfigureView *configureView;
@property XYSGearIconView *gearIconView;
@property XYSTempoLightView *tempoLightView;
@property XYSAdView *adView;

@property ScreenSize screenSize;
@property float scaleFactor;
@property CGRect tempoTextFrame;
@property CGRect beatTextFrame;
@property CGRect metronomeFrame;
@property CGRect configureFrame;
@property CGRect gearIconFrame;

// Dy values are delta of y values when Ads in/out
@property float tempoDy;
@property float beatDy;
@property float metronomeDy;
@property float configureDy;
@property float gearDy;

@property BOOL configOn;

- (void)holdingBegan:(CGPoint)location;
- (void)holdingSustain:(CGPoint)location;
- (void)holdingChanged:(CGPoint)location;
- (void)holdingEnded:(CGPoint)location;
- (void)holdingCancelled:(CGPoint)location;

- (void) layoutAnimateAdIn;
- (void) layoutAnimateAdOut;

@end
