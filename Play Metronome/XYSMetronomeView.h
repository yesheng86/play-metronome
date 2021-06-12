//
//  XYSMetronomeView.h
//  Play Metronome
//
//  Created by Xu Yesheng on 7/13/14.
//  Copyright (c) 2014 yesheng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XYSUpperCasingView.h"
#import "XYSLowerCasingView.h"
#import "XYSBoardView.h"
#import "XYSScaleView.h"
#import "XYSArmView.h"
#import "XYSWeightView.h"
#import "XYSBlotView.h"
#import "XYSTextView.h"
#import "XYSConfigureView.h"
#import "XYSGearIconView.h"
#import "XYSTextView.h"
#import "XYSHintLineView.h"
#import "XYSDataKeeper.h"
#import "XYSTranslatableView.h"

typedef enum __HoldState
{
    NOTHOLDING = 0,
    HOLDING,
    HOLDBLOT,
    HOLDARM,
    HOLDWEIGHT
} HoldState;

@interface XYSMetronomeView : XYSTranslatableView

// subviews
@property XYSUpperCasingView *upperCasingView;
@property XYSLowerCasingView *lowerCasingView;
@property XYSBoardView *boardView;
@property XYSScaleView *scaleView;
@property XYSArmView *armView;
@property XYSWeightView *weightView;
@property XYSBlotView *blotView;
@property XYSHintLineView *hintLineView;

// reference view, set by super view
@property XYSTextView *beatTextView;
@property XYSTextView *tempoTextView;
//@property XYSTimbreView *timbreView;


@property CGPoint weightCenter;
@property CGPoint rotationAxis;
//@property CGFloat holdAlpha;
@property CGFloat originBlotLocationX;
@property CGFloat currentWeightLocation;
@property CGFloat currentBlotLocation;

@property HoldState holdState;

// KVO value
//@property uint bpm;

// arm is rotating need make sound and animate
//@property BOOL beating;

//@property BOOL holdSustainTransformComplete;

// data keeper
@property XYSDataKeeper *dataKeeper;
@property ViewMode viewMode;

- (void)transformWeightWithTempo:(uint)tempo;
- (void)rotateArmWithAngle:(float)angle;

- (void)holdingBegan:(CGPoint)location;
- (void)holdingSustain:(CGPoint)location;
- (void)holdingChanged:(CGPoint)location;
- (void)holdingEnded:(CGPoint)location;

- (void)setCasingHue:(CGFloat)hue;
- (void)setBoardHue:(CGFloat)hue;
- (void)setWeightHue:(CGFloat)hue;
- (void)darkCasing:(CGFloat)darkFactor;
- (void)darkBoard:(CGFloat)darkFactor;
- (void)brightenWeight:(CGFloat)dimFactor;

- (void)switchMode:(ViewMode)mode;
@end
