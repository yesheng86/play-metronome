//
//  XYSSmallCasingView.m
//  Play Metronome
//
//  Created by Xu Yesheng on 7/20/14.
//  Copyright (c) 2014 yesheng. All rights reserved.
//

#import "XYSSmallCasingView.h"

@implementation XYSSmallCasingView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setBounds:CGRectMake(0, 0, 30, 40)];
        [self setSaturation:0.4];
    }
    return self;
}

- (NSUInteger)countOfFaces
{
    return 2;
}

- (CGPoint)originalPoint
{
    return CGPointMake(15, 0);
}

- (void)setFacePathWithIndex:(NSUInteger)index
{
    UIBezierPath *face = self.faces[index];
    switch (index) {
        case 0:
            [face moveToPoint:CGPointMake(-8, 5)];
            [face addLineToPoint:CGPointMake(-10, 25)];
            [face addCurveToPoint:CGPointMake(10, 25) controlPoint1:CGPointMake(-4, 27) controlPoint2:CGPointMake(4, 27)];
            [face addLineToPoint:CGPointMake(8, 5)];
            [face addCurveToPoint:CGPointMake(-8, 5) controlPoint1:CGPointMake(4, 3) controlPoint2:CGPointMake(-4, 3)];
            break;
        case 1:
            [face moveToPoint:CGPointMake(-10, 25)];
            [face addLineToPoint:CGPointMake(-11, 35)];
            [face addCurveToPoint:CGPointMake(11, 35) controlPoint1:CGPointMake(-4, 37) controlPoint2:CGPointMake(4, 37)];
            [face addLineToPoint:CGPointMake(10, 25)];
            [face addCurveToPoint:CGPointMake(-10, 25) controlPoint1:CGPointMake(4, 27) controlPoint2:CGPointMake(-4, 27)];
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
            brightness = 0.6;
            break;
        default:
            break;
    }
    return brightness;
}


@end
