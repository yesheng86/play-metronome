//
//  XYSSmallMetronomeView.h
//  Play Metronome
//
//  Created by Xu Yesheng on 7/27/14.
//  Copyright (c) 2014 yesheng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XYSSmallCasingView.h"
#import "XYSSmallBoardView.h"
#import "XYSSmallWeightView.h"

@interface XYSSmallMetronomeView : UIView

@property XYSSmallCasingView *casingView;
@property XYSSmallBoardView *boardView;
@property XYSSmallWeightView *weightView;

@property UIColor *casingColor;
@property UIColor *boardColor;
@property UIColor *weightColor;
@property ViewMode viewMode;
@property UIBezierPath *focusPath;

@property BOOL focus;

- (void)setCasingHue:(CGFloat)hue;
- (void)setBoardHue:(CGFloat)hue;
- (void)setWeightHue:(CGFloat)hue;

- (void)switchMode:(ViewMode)mode;

@end
