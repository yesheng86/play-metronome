//
//  XYSArmView.h
//  Play Metronome
//
//  Created by Xu Yesheng on 5/31/14.
//  Copyright (c) 2014 yesheng. All rights reserved.
//

#import "XYSPartView.h"

@interface XYSArmView : XYSPartView

@property CGPoint armRotateAxis;

//@property CFTimeInterval timePerRotate;
- (BOOL)willRotateWithAngle:(CGFloat)alpha;
- (void)startRotateWithAngle:(CGFloat)alpha Duration:(CFTimeInterval)duration;
- (void)stopRotate;

@end
