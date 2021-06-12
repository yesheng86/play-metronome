//
//  XYSLowerCasingView.m
//  Play Metronome
//
//  Created by Xu Yesheng on 5/29/14.
//  Copyright (c) 2014 yesheng. All rights reserved.
//

#import "XYSLowerCasingView.h"

@implementation XYSLowerCasingView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setSaturation:0.4];
    }
    return self;
}
-(NSUInteger) countOfFaces
{
    return 3;
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
            [face moveToPoint:CGPointMake(-80, 0)];
            [face addLineToPoint:CGPointMake(-55, 0)];
            [face addCurveToPoint:CGPointMake(55, 0) controlPoint1:CGPointMake(-35, 10) controlPoint2:CGPointMake(35, 10)];
            [face addLineToPoint:CGPointMake(80, 0)];
            [face addCurveToPoint:CGPointMake(-80, 0) controlPoint1:CGPointMake(40, 20) controlPoint2:CGPointMake(-40, 20)];
            break;
        case 1:
            [face moveToPoint:CGPointMake(-80, 0)];
            [face addCurveToPoint:CGPointMake(-95, 110) controlPoint1:CGPointMake(-85, 20) controlPoint2:CGPointMake(-95, 70)];
            [face addCurveToPoint:CGPointMake(95, 110) controlPoint1:CGPointMake(-35, 140) controlPoint2:CGPointMake(35, 140)];
            [face addCurveToPoint:CGPointMake(80, 0) controlPoint1:CGPointMake(95, 70) controlPoint2:CGPointMake(85, 20)];
            [face addCurveToPoint:CGPointMake(-80, 0) controlPoint1:CGPointMake(40, 20) controlPoint2:CGPointMake(-40, 20)];
            break;
        case 2:
            [face moveToPoint:CGPointMake(-93, 110)];
            [face addLineToPoint:CGPointMake(-90, 115)];
            [face addCurveToPoint:CGPointMake(90, 115) controlPoint1:CGPointMake(-36, 142) controlPoint2:CGPointMake(36, 142)];
            [face addLineToPoint:CGPointMake(93, 110)];
            [face addCurveToPoint:CGPointMake(-93, 110) controlPoint1:CGPointMake(35, 140) controlPoint2:CGPointMake(-35, 140)];
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
            brightness = 0.6;
            break;
        case 2:
            brightness = 0.3;
            break;
        default:
            break;
    }
    return brightness;
}

- (BOOL)needStrokeWithIndex:(NSUInteger)index
{
    BOOL needStroke = YES;
    switch (index) {
        case 0:
            needStroke = NO;
            break;
        default:
            break;
    }
    return needStroke;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    // Drawing code
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    CGContextTranslateCTM(context, 150, 0);
    UIBezierPath *path1 = [[UIBezierPath alloc] init];
    UIBezierPath *path2 = [[UIBezierPath alloc] init];
    [path1 moveToPoint:CGPointMake(-80, 0)];
    [path1 addLineToPoint:CGPointMake(-55, 0)];
    [path2 moveToPoint:CGPointMake(55, 0)];
    [path2 addLineToPoint:CGPointMake(80, 0)];
    [[UIColor whiteColor] setStroke];
    [path1 stroke];
    [path2 stroke];
    
    CGContextRestoreGState(context);
}
*/

@end
