//
//  XYSSliderView.h
//  Play Metronome
//
//  Created by Xu Yesheng on 7/22/14.
//  Copyright (c) 2014 yesheng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XYSSliderTrackView.h"
#import "XYSSliderThumbView.h"

@interface XYSSliderView : UIView

@property XYSSliderTrackView *trackView;
@property XYSSliderThumbView *thumbView;
@property CGFloat height;
@property CGFloat width;
@property CGFloat margin;
@property BOOL holdThumbView;

- (void)setColorful:(BOOL)colorful;
- (float)getPercentageValueFromLocation:(CGPoint)location;
- (void)updateViewByPercentageValue:(CGFloat)pct;

@end
