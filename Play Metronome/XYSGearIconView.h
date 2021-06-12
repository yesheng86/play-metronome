//
//  XYSGearIconView.h
//  Play Metronome
//
//  Created by Xu Yesheng on 7/11/14.
//  Copyright (c) 2014 yesheng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XYSTranslatableView.h"

@interface XYSGearIconView : XYSTranslatableView

@property NSUInteger toothNum;
@property CGFloat outerToothRadius;
@property CGFloat innerToothRadius;
@property CGFloat outerAxisRadius;
@property CGFloat innerAxisRadius;
@property CGPoint gearCenter;
@property CGFloat hue;
@property BOOL colorful;

- (void)startSpin:(CGFloat)aps;
- (void)stopSpin;
- (void)setGearHue:(CGFloat)hue;
@end
