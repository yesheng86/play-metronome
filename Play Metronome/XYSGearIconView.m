//
//  XYSGearIconView.m
//  Play Metronome
//
//  Created by Xu Yesheng on 7/11/14.
//  Copyright (c) 2014 yesheng. All rights reserved.
//

#import "XYSGearIconView.h"

@implementation XYSGearIconView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setBounds:CGRectMake(0, 0, 40, 40)];
        [self setOpaque:NO];
        _toothNum = 20;
        _outerToothRadius = self.bounds.size.width / 5 * 2;
        _innerToothRadius = self.bounds.size.width / 3;
        _outerAxisRadius = self.bounds.size.width / 10;
        _innerAxisRadius = _outerAxisRadius - 2;
        _gearCenter = CGPointMake(self.bounds.size.width / 2, self.bounds.size.width / 2);
        _hue = 0.5;
        _colorful = YES;
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    UIBezierPath *toothPath = [[UIBezierPath alloc] init];
    CGFloat sliceAngle = M_PI * 2 / _toothNum;
    for (int i = 0; i < _toothNum; i++) {
        
        [toothPath addArcWithCenter:_gearCenter radius:_outerToothRadius startAngle:sliceAngle * i endAngle:sliceAngle * i + sliceAngle / 5 clockwise:YES];
        [toothPath addArcWithCenter:_gearCenter radius:_innerToothRadius startAngle:sliceAngle * i + sliceAngle / 5 * 2 endAngle:sliceAngle * i + sliceAngle /5 * 4 clockwise:YES];
    }
    [toothPath closePath];
    UIBezierPath *outerAxisPath = [[UIBezierPath alloc] init];
    [outerAxisPath appendPath:[UIBezierPath bezierPathWithOvalInRect:CGRectMake(_gearCenter.x - _outerAxisRadius, _gearCenter.y - _outerAxisRadius, _outerAxisRadius * 2, _outerAxisRadius * 2)]];

    UIBezierPath *innerAxisPath = [[UIBezierPath alloc] init];
    [innerAxisPath appendPath:[UIBezierPath bezierPathWithOvalInRect:CGRectMake(_gearCenter.x - _innerAxisRadius, _gearCenter.y - _innerAxisRadius, _innerAxisRadius * 2, _innerAxisRadius * 2)]];
    
    CGContextSaveGState(context);
    if (_colorful) {
        [[UIColor colorWithHue:_hue saturation:0.1 brightness:0.7 alpha:1] setFill];
        [[UIColor colorWithHue:_hue saturation:0.1 brightness:0.6 alpha:1] setStroke];
        [toothPath fill];
        [toothPath stroke];
        [[UIColor colorWithHue:_hue saturation:0.1 brightness:0.6 alpha:1] setFill];
        [[UIColor whiteColor] setStroke];
        [outerAxisPath fill];
        [outerAxisPath stroke];
        [[UIColor colorWithHue:_hue saturation:0.1 brightness:0.7 alpha:1] setFill];
        [innerAxisPath fill];
    }
    else {
        [[UIColor colorWithWhite:0.7 alpha:1] setFill];
        [[UIColor colorWithWhite:0.6 alpha:1] setStroke];
        [toothPath fill];
        [toothPath stroke];
        [[UIColor colorWithWhite:0.6 alpha:1] setFill];
        [[UIColor whiteColor] setStroke];
        [outerAxisPath fill];
        [outerAxisPath stroke];
        [[UIColor colorWithWhite:0.7 alpha:1] setFill];
        [innerAxisPath fill];
    }
    CGContextRestoreGState(context);
}

- (void)startSpin:(CGFloat)aps
{
    [self stopSpin];
    CABasicAnimation *spinAnimation = [CABasicAnimation animationWithKeyPath:@"transform"];
    spinAnimation.duration = 0.5;
    //spinAnimation.repeatCount = HUGE_VALF;
    spinAnimation.fromValue = [NSValue valueWithCATransform3D:CATransform3DRotate([[self layer] transform], 0, 0, 0, 1)];
    spinAnimation.toValue = [NSValue valueWithCATransform3D:CATransform3DRotate([[self layer] transform], aps, 0, 0, 1)];
    [[self layer] addAnimation:spinAnimation forKey:@"transform"];
}

- (void)stopSpin
{
    [[self layer] removeAllAnimations];
}

- (void)setGearHue:(CGFloat)hue
{
    [self setHue:hue];
    [self setNeedsDisplay];
}

@end
