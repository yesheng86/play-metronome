//
//  XYSTempoLightView.h
//  Play Metronome
//
//  Created by Xu Yesheng on 8/26/14.
//  Copyright (c) 2014 yesheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XYSTempoLightView : UIView
@property float lightRadius;
@property float shadowRadius;
- (void)startLightingWithDuration:(CGFloat)duration;
- (void)startLightingOnceWithDuration:(CGFloat)duration;
- (void)stopLighting;
@end
