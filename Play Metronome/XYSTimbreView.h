//
//  XYSTimbreView.h
//  Play Metronome
//
//  Created by Xu Yesheng on 8/9/14.
//  Copyright (c) 2014 yesheng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XYSTimbreWaveView.h"

@interface XYSTimbreView : UIView

@property XYSTimbreWaveView *waveView;

@property BOOL animateOn;

- (void)startWaveAnimateWithDuration:(CFTimeInterval)duration;
- (void)startWaveAnimateForeverWithDuration:(CFTimeInterval)duration;
- (void)stopWaveAnimate;

@end
