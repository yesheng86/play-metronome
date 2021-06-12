//
//  XYSArmView.m
//  Play Metronome
//
//  Created by Xu Yesheng on 5/31/14.
//  Copyright (c) 2014 yesheng. All rights reserved.
//

#import "XYSArmView.h"

@implementation XYSArmView

- (id)initWithFrame:(CGRect)frame
{
    CGFloat anchorY = 0.8;
    self = [super initWithFrame:frame];
    if (self) {
        self.layer.anchorPoint = CGPointMake(0.5, anchorY);
        //frame will change along with anchor point... so set it back
        self.layer.frame = frame;
        _armRotateAxis = CGPointMake(frame.size.width * 0.5, frame.size.height * anchorY);
        [self setSaturation:0.3];
//        [self setTimePerRotate:3];
    }
    return self;
}

- (NSUInteger)countOfFaces
{
    return 2;
}

- (CGPoint)originalPoint
{
    return CGPointMake(8, 0);
}

- (void)setFacePathWithIndex:(NSUInteger)index
{
    UIBezierPath *face = self.faces[index];
    switch (index) {
        case 0:
            [face appendPath:[UIBezierPath bezierPathWithRoundedRect:CGRectMake(-3, 5, 6, 300) cornerRadius:3]];
            break;
        case 1:
            [face appendPath:[UIBezierPath bezierPathWithOvalInRect:CGRectMake(-1, 8, 2, 2)]];
            break;
        default:
            break;
    }
}

- (CGFloat) brightnessWithIndex:(NSUInteger)index
{
    CGFloat brightness = 0;
    switch (index) {
        case 0:
            brightness = 0.7;
            break;
        case 1:
            brightness = 0.8;
            break;
        default:
            break;
    }
    return brightness;
}

- (BOOL)willRotateWithAngle:(CGFloat)alpha
{
    BOOL rotate = NO;
    if (fabsf(alpha) > (M_PI / 5))
        rotate = YES;
    else if (fabsf(alpha) > (M_PI/64))
        rotate = NO;
    return rotate;
}

- (void)startRotateWithAngle:(CGFloat)alpha Duration:(CFTimeInterval)duration
{
    CAKeyframeAnimation *rotateAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    if (fabsf(alpha) > (M_PI / 5))
    {
        rotateAnimation.values = @[[NSValue valueWithCATransform3D:CATransform3DMakeRotation(alpha, 0, 0, 1)],
                                   [NSValue valueWithCATransform3D:CATransform3DMakeRotation(0, 0, 0, 1)],
                                   [NSValue valueWithCATransform3D:CATransform3DMakeRotation(- alpha, 0, 0, 1)],
                                   [NSValue valueWithCATransform3D:CATransform3DMakeRotation(0, 0, 0, 1)],
                                   [NSValue valueWithCATransform3D:CATransform3DMakeRotation(alpha, 0, 0, 1)]];
        rotateAnimation.timingFunctions = @[[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn],
                                            [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut],
                                            [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn],
                                            [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut]];
        rotateAnimation.repeatCount = HUGE_VALF;
        rotateAnimation.duration = duration;
    }
    else if (fabsf(alpha) > (M_PI/64))
    {
        NSMutableArray *values = [[NSMutableArray alloc] init];
        NSMutableArray *timingFunctions = [[NSMutableArray alloc] init];
        NSUInteger index = 0;
        while (1) {
            if (index == 0)
            {
                [values insertObject:[NSValue valueWithCATransform3D:CATransform3DMakeRotation(alpha, 0, 0, 1)] atIndex:0];
                [values insertObject:[NSValue valueWithCATransform3D:CATransform3DMakeRotation(0, 0, 0, 1)] atIndex:1];
                [timingFunctions insertObject:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn] atIndex:0];
                index = 1;
            }
            else
            {
                if (index % 2 == 0)
                {
                    alpha = - alpha / powf(1.1, index);
                    [values insertObject:[NSValue valueWithCATransform3D:CATransform3DMakeRotation(alpha, 0, 0, 1)] atIndex:index];
                    [timingFunctions insertObject:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut] atIndex:(index - 1)];
                }
                else
                {
                    if (fabsf(alpha) < M_PI/64)
                    {
                        alpha = 0;
                        [values insertObject:[NSValue valueWithCATransform3D:CATransform3DMakeRotation(alpha, 0, 0, 1)] atIndex:index];
                        [timingFunctions insertObject:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn] atIndex:(index - 1)];
                        break;
                    }
                    [values insertObject:[NSValue valueWithCATransform3D:CATransform3DMakeRotation(0, 0, 0, 1)] atIndex:index];
                    [timingFunctions insertObject:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn] atIndex:(index - 1)];
                }
            }
            index++;
        }
        rotateAnimation.values = values;
        rotateAnimation.timingFunctions = timingFunctions;
        rotateAnimation.duration = duration / 4 * (index - 1);
    }
    
    [self setTransform:CGAffineTransformRotate(CGAffineTransformIdentity, alpha)];
    [self.layer addAnimation:rotateAnimation forKey:@"transform"];
}

- (void)stopRotate
{
    [self.layer removeAllAnimations];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
