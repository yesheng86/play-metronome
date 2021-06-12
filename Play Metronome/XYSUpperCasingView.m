//
//  XYSUpperCasingView.m
//  Play Metronome
//
//  Created by Xu Yesheng on 5/25/14.
//  Copyright (c) 2014 yesheng. All rights reserved.
//

#import "XYSUpperCasingView.h"

@implementation XYSUpperCasingView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setSaturation:0.4];
    }
    return self;
}

- (NSUInteger)countOfFaces
{
    return 8;
}

- (CGPoint)originalPoint
{
    return CGPointMake(150, 0);
}

- (void)setFacePathWithIndex:(NSUInteger)index
{
    UIBezierPath *face = self.faces[index];
    switch (index) {
        case 0:
            [face moveToPoint:CGPointMake(-40, 20)];
            [face addCurveToPoint:CGPointMake(40, 20) controlPoint1:CGPointMake(-20, 10) controlPoint2:CGPointMake(20, 10)];
            [face addCurveToPoint:CGPointMake(50, 40) controlPoint1:CGPointMake(44, 22) controlPoint2:CGPointMake(48, 24)];
            [face addCurveToPoint:CGPointMake(70, 240) controlPoint1:CGPointMake(60, 120) controlPoint2:CGPointMake(60, 140)];
            [face addCurveToPoint:CGPointMake(80, 261) controlPoint1:CGPointMake(71, 250) controlPoint2:CGPointMake(75, 255)];
            [face addLineToPoint:CGPointMake(55, 261)];
            [face addCurveToPoint:CGPointMake(50, 250) controlPoint1:CGPointMake(53, 258) controlPoint2:CGPointMake(51, 255)];
            [face addLineToPoint:CGPointMake(-50, 250)];
            [face addCurveToPoint:CGPointMake(-55, 261) controlPoint1:CGPointMake(-51, 255) controlPoint2:CGPointMake(-53, 258)];
            [face addLineToPoint:CGPointMake(-80, 261)];
            [face addCurveToPoint:CGPointMake(-70, 240) controlPoint1:CGPointMake(-75, 255) controlPoint2:CGPointMake(-71, 250)];
            [face addCurveToPoint:CGPointMake(-50, 40) controlPoint1:CGPointMake(-60, 140) controlPoint2:CGPointMake(-60, 120)];
            [face addCurveToPoint:CGPointMake(-40, 20) controlPoint1:CGPointMake(-48, 24) controlPoint2:CGPointMake(-44, 22)];
            break;
        case 1:
            [face moveToPoint:CGPointMake(-50, 40)];
            [face addCurveToPoint:CGPointMake(-30, 10) controlPoint1:CGPointMake(-48, 24) controlPoint2:CGPointMake(-40, 15)];
            [face addLineToPoint:CGPointMake(-40, 20)];
            [face addCurveToPoint:CGPointMake(-50, 40) controlPoint1:CGPointMake(-44, 22) controlPoint2:CGPointMake(-48, 24)];
            break;
        case 2:
            [face moveToPoint:CGPointMake(50, 40)];
            [face addCurveToPoint:CGPointMake(30, 10) controlPoint1:CGPointMake(48, 24) controlPoint2:CGPointMake(40, 15)];
            [face addLineToPoint:CGPointMake(40, 20)];
            [face addCurveToPoint:CGPointMake(50, 40) controlPoint1:CGPointMake(44, 22) controlPoint2:CGPointMake(48, 24)];
            break;
        case 3:
            [face moveToPoint:CGPointMake(-40, 20)];
            [face addLineToPoint:CGPointMake(-30, 10)];
            [face addCurveToPoint:CGPointMake(30, 10) controlPoint1:CGPointMake(-20, 5) controlPoint2:CGPointMake(20, 5)];
            [face addLineToPoint:CGPointMake(40, 20)];
            [face addCurveToPoint:CGPointMake(-40, 20) controlPoint1:CGPointMake(20, 10) controlPoint2:CGPointMake(-20, 10)];
            break;
        case 4:
            [face moveToPoint:CGPointMake(55, 260)];
            [face addCurveToPoint:CGPointMake(50, 250) controlPoint1:CGPointMake(53, 258) controlPoint2:CGPointMake(51, 255)];
            [face addLineToPoint:CGPointMake(-50, 250)];
            [face addCurveToPoint:CGPointMake(-55, 260) controlPoint1:CGPointMake(-51, 255) controlPoint2:CGPointMake(-53, 258)];
            [face addCurveToPoint:CGPointMake(55, 260) controlPoint1:CGPointMake(-35, 270) controlPoint2:CGPointMake(35, 270)];
            break;
        case 5:
            [face moveToPoint:CGPointMake(-50, 250)];
            [face addLineToPoint:CGPointMake(-50, 260)];
            [face addLineToPoint:CGPointMake(50, 260)];
            [face addLineToPoint:CGPointMake(50, 250)];
            [face addLineToPoint:CGPointMake(-50, 250)];
            break;
        case 6:
            [face moveToPoint:CGPointMake(-50, 250)];
            [face addLineToPoint:CGPointMake(-50, 260)];
            [face addCurveToPoint:CGPointMake(-55, 270) controlPoint1:CGPointMake(-51, 265) controlPoint2:CGPointMake(-53, 268)];
            [face addLineToPoint:CGPointMake(-55, 260)];
            [face addCurveToPoint:CGPointMake(-50, 250) controlPoint1:CGPointMake(-53, 258) controlPoint2:CGPointMake(-51, 255)];
            break;
        case 7:
            [face moveToPoint:CGPointMake(50, 250)];
            [face addLineToPoint:CGPointMake(50, 260)];
            [face addCurveToPoint:CGPointMake(55, 270) controlPoint1:CGPointMake(51, 265) controlPoint2:CGPointMake(53, 268)];
            [face addLineToPoint:CGPointMake(55, 260)];
            [face addCurveToPoint:CGPointMake(50, 250) controlPoint1:CGPointMake(53, 258) controlPoint2:CGPointMake(51, 255)];
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
            brightness = 0.75;
            break;
        case 1:
            brightness = 0.9;
            break;
        case 2:
            brightness = 0.9;
            break;
        case 3:
            brightness = 0.8;
            break;
        case 4:
            brightness = 0.3;
            break;
        case 5:
            brightness = 0.4;
            break;
        case 6:
            brightness = 0.5;
            break;
        case 7:
            brightness = 0.5;
            break;
        default:
            break;
    }
    return brightness;
}

@end
