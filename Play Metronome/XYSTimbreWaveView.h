//
//  XYSTimbreWaveView.h
//  Play Metronome
//
//  Created by Xu Yesheng on 8/10/14.
//  Copyright (c) 2014 yesheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XYSTimbreWaveView : UIView

- (void)startTranslateWithDx:(CGFloat)dx Dy:(CGFloat)dy;
- (void)stopTranslate;

@property CFTimeInterval animationDuration;
@property float animationRepeatCount;

@end
