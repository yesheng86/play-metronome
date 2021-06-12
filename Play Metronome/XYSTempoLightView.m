//
//  XYSTempoLightView.m
//  Play Metronome
//
//  Created by Xu Yesheng on 8/26/14.
//  Copyright (c) 2014 yesheng. All rights reserved.
//

#import "XYSTempoLightView.h"

@implementation XYSTempoLightView
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setBounds:CGRectMake(0, 0, 20, 20)];
        [self setOpaque:NO];
        //UIView *shadowView = [[UIView alloc] initWithFrame:[self bounds]];
        _lightRadius = 2;
        _shadowRadius = 4;
        
        [self.layer setOpacity:0];
        [self.layer setShadowColor:[UIColor redColor].CGColor];
        [self.layer setShadowOffset:CGSizeMake(0, 0)];
        [self.layer setShadowRadius:2];
        [self.layer setShadowOpacity:0.8];
        [self.layer setShadowPath:[UIBezierPath bezierPathWithOvalInRect:CGRectMake(10 - _shadowRadius, 10 - _shadowRadius, _shadowRadius * 2, _shadowRadius * 2)].CGPath];
        //[self addSubview:shadowView];
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    UIBezierPath *light = [[UIBezierPath alloc] init];
    [light appendPath:[UIBezierPath bezierPathWithOvalInRect:CGRectMake(10 - _lightRadius, 10 - _lightRadius, _lightRadius * 2, _lightRadius * 2)]];
    
    CGContextSaveGState(context);
    [[UIColor colorWithHue:1 saturation:0.8 brightness:1 alpha:1] setFill];
    [light fill];
    CGContextRestoreGState(context);
}

- (void)startLightingWithDuration:(CGFloat)duration
{
    [self stopLighting];
    CABasicAnimation *lightingAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    lightingAnimation.duration = duration;
    lightingAnimation.fromValue = [NSNumber numberWithFloat:1];
    lightingAnimation.toValue = [NSNumber numberWithFloat:0];
    lightingAnimation.repeatCount = HUGE_VALF;
    [[self layer] addAnimation:lightingAnimation forKey:@"transform"];
}

- (void)startLightingOnceWithDuration:(CGFloat)duration
{
    [self stopLighting];
    CABasicAnimation *lightingAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    lightingAnimation.duration = duration;
    lightingAnimation.fromValue = [NSNumber numberWithFloat:1];
    lightingAnimation.toValue = [NSNumber numberWithFloat:0];
    lightingAnimation.repeatCount = 4;
    [[self layer] addAnimation:lightingAnimation forKey:@"transform"];
}

- (void)stopLighting
{
    [[self layer] removeAllAnimations];
}
@end
