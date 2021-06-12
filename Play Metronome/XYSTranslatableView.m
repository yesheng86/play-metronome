//
//  XYSTranslatableView.m
//  Play Metronome
//
//  Created by Xu Yesheng on 9/12/14.
//  Copyright (c) 2014 yesheng. All rights reserved.
//

#import "XYSTranslatableView.h"

@implementation XYSTranslatableView

- (void)startTranslateWithDx:(CGFloat)dx Dy:(CGFloat)dy
{
    [self stopTranslate];
    CABasicAnimation *translateAnimation = [CABasicAnimation animationWithKeyPath:@"transform"];
    translateAnimation.duration = 0.5;
    translateAnimation.fromValue = [NSValue valueWithCATransform3D:CATransform3DTranslate([[self layer] transform], 0, 0, 0)];
    translateAnimation.toValue = [NSValue valueWithCATransform3D:CATransform3DTranslate([[self layer] transform], dx, dy, 0)];
    translateAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [[self layer] addAnimation:translateAnimation forKey:@"transform"];
    [[self layer] setTransform:CATransform3DTranslate([[self layer] transform], dx, dy, 0)];
}

- (void)stopTranslate
{
    [[self layer] removeAllAnimations];
}

@end
