//
//  XYSTimbreWaveView.m
//  Play Metronome
//
//  Created by Xu Yesheng on 8/10/14.
//  Copyright (c) 2014 yesheng. All rights reserved.
//

#import "XYSTimbreWaveView.h"

@implementation XYSTimbreWaveView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setBounds:CGRectMake(0, 0, 80, 30)];
        [self setOpaque:NO];
        _animationDuration = 3; // 60/40*2
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGFloat delay = 30;
    uint rangeNum = 5;
    CGFloat middle = 15, timeline = 0;
    CGFloat range[] = {4, 10, 5, 3, 2};
    UIBezierPath *timbrePath = [[UIBezierPath alloc] init];
    [timbrePath moveToPoint:CGPointMake(timess
    timeline += delay;
    [timbrePath addLineToPoint:CGPointMake(timeline, middle)];
    for (int i = 0; i < rangeNum; i++) {
        timeline += 4;
        [timbrePath moveToPoint:CGPointMake(timeline, middle - range[i])];
        [timbrePath addLineToPoint:CGPointMake(timeline, middle + range[i])];
    }
    timeline += 4;
    [timbrePath moveToPoint:CGPointMake(timeline, middle)];
    [timbrePath addLineToPoint:CGPointMake(80, middle)];
    
    CGContextSaveGState(context);
    [[UIColor whiteColor] setStroke];
    [timbrePath stroke];
    CGContextRestoreGState(context);
}

- (void)startTranslateWithDx:(CGFloat)dx Dy:(CGFloat)dy
{
    [self stopTranslate];
    CABasicAnimation *translateAnimation = [CABasicAnimation animationWithKeyPath:@"transform"];
    translateAnimation.duration = _animationDuration;
    translateAnimation.fromValue = [NSValue valueWithCATransform3D:CATransform3DTranslate([[self layer] transform], 0, 0, 0)];
    translateAnimation.toValue = [NSValue valueWithCATransform3D:CATransform3DTranslate([[self layer] transform], dx, dy, 0)];
    translateAnimation.repeatCount = _animationRepeatCount;
    [[self layer] addAnimation:translateAnimation forKey:@"transform"];
}

- (void)stopTranslate
{
    [[self layer] removeAllAnimations];
}
@end
