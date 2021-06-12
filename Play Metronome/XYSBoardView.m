//
//  XYSBoardView.m
//  Play Metronome
//
//  Created by Xu Yesheng on 5/29/14.
//  Copyright (c) 2014 yesheng. All rights reserved.
//

#import "XYSBoardView.h"

@implementation XYSBoardView

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
    return 2;
}

- (CGPoint)originalPoint
{
    return CGPointMake(40, 0);
}

- (void)setFacePathWithIndex:(NSUInteger)index
{
    UIBezierPath *face = self.faces[index];
    switch (index) {
        case 0:
            [face appendPath:[UIBezierPath bezierPathWithRoundedRect:CGRectMake(-35, 30, 70, 210) cornerRadius:4]];
            break;
        case 1:
            [face moveToPoint:CGPointMake(-35, 34)];
            [face addCurveToPoint:CGPointMake(-29, 28) controlPoint1:CGPointMake(-35, 30) controlPoint2:CGPointMake(-32, 28)];
            [face addLineToPoint:CGPointMake(29, 28)];
            [face addCurveToPoint:CGPointMake(35, 34) controlPoint1:CGPointMake(31, 28) controlPoint2:CGPointMake(35, 30)];
            [face addArcWithCenter:CGPointMake(31, 34) radius:4 startAngle:0 endAngle:1.5 * M_PI clockwise:NO];
            [face addLineToPoint:CGPointMake(-31, 30)];
            [face addArcWithCenter:CGPointMake(-31, 34) radius:4 startAngle:1.5 * M_PI endAngle:M_PI clockwise:NO];
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
            brightness = 0.6;
            break;
        case 1:
            brightness = 0.8;
            break;
        default:
            break;
    }
    return brightness;
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
