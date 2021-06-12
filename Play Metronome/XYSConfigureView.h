//
//  XYSConfigureView.h
//  Play Metronome
//
//  Created by Xu Yesheng on 7/9/14.
//  Copyright (c) 2014 yesheng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XYSSmallMetronomeView.h"
#import "XYSSliderView.h"
#import "XYSBulbView.h"
#import "XYSTimbreView.h"
#import "XYSSwitchButtonView.h"
#import "XYSPurchaseButtonView.h"
#import "XYSManButtonView.h"
#import "XYSSpeakerView.h"
#import "XYSTempoLightView.h"
#import "XYSDataKeeper.h"
#import "XYSManView.h"
#import "XYSPurchaseView.h"
#import "XYSTranslatableView.h"
#import "XYSStoreAgent.h"

typedef enum __SlideState
{
    NOTSLIDING = 0,
    SLIDECASING,
    SLIDEBOARD,
    SLIDEWEIGHT,
    SLIDEBRIGHTNESS,
    SLIDEVOLUME,
    HITSWITCH,
    HITPURCHASE,
    HITMAN,
    HITBUY,
    HITRESTORE,
    HITCANCEL
} SlideState;

@interface XYSConfigureView : XYSTranslatableView

@property XYSDataKeeper *dataKeeper;
@property XYSStoreAgent *storeAgent;

@property XYSSmallMetronomeView *metronomeView;
//@property NSArray *sliderViews;
@property XYSSliderView *casingSliderView;
@property XYSSliderView *boardSliderView;
@property XYSSliderView *weightSliderView;
@property XYSSliderView *brightnessSliderView;
@property XYSSliderView *volumeSliderView;
@property XYSTimbreView *timbreView;
@property XYSSwitchButtonView *switchButtonView;
@property XYSPurchaseButtonView *purchaseButtonView;
@property XYSManButtonView *manButtonView;
@property XYSBulbView *bulbRayView;
@property XYSBulbView *bulbOnlyView;
@property XYSSpeakerView *speakerWaveView;
@property XYSSpeakerView *speakerOnlyView;
@property XYSTempoLightView *tempoLightView;
@property XYSManView *manView;
@property XYSPurchaseView *purchaseView;

// if purchased
@property NSArray *metronomeIcons;
/*
@property XYSSmallMetronomeView *metroView0;
@property XYSSmallMetronomeView *metroView1;
@property XYSSmallMetronomeView *metroView2;
@property XYSSmallMetronomeView *metroView3;
@property XYSSmallMetronomeView *metroView4;
*/
@property BOOL manOn;
@property BOOL purchaseOn;

@property SlideState slideState;

- (void)holdingBegan:(CGPoint)location;
- (void)holdingChanged:(CGPoint)location;
- (void)holdingEnded:(CGPoint)location;

@end
