//
//  XYSBlotView.m
//  Play Metronome
//
//  Created by Xu Yesheng on 5/31/14.
//  Copyright (c) 2014 yesheng. All rights reserved.
//

#import "XYSBlotView.h"

@implementation XYSBlotView

uint beatNumber[5] = {0, 2, 3, 4, 6};
uint step = 7;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //self.layer.backgroundColor = [UIColor greenColor].CGColor;
        _originX = frame.origin.x + 50;
        [self setSaturation:0.3];
    }
    return self;
}

- (NSUInteger)countOfFaces
{
    return 4;
}

- (CGPoint)originalPoint
{
    return CGPointMake(5, 13);
}

- (void)setFacePathWithIndex:(NSUInteger)index
{
    UIBezierPath *face = self.faces[index];
    switch (index) {
        case 0:
            [face appendPath:[UIBezierPath bezierPathWithRect:CGRectMake(0, 6, 40, 2)]];
            /*
             CGContextTranslateCTM(context, 50.0, 280.0);
             CGContextMoveToPoint(context, 0.0, 6.0);
             CGContextAddLineToPoint(context, 0.0, 8.0);
             CGContextAddLineToPoint(context, 40.0, 8.0);
             CGContextAddLineToPoint(context, 40.0, 6.0);
             CGContextAddLineToPoint(context, 0.0, 6.0);
             
             CGContextMoveToPoint(context, 40.0, 6.0);
             CGContextAddLineToPoint(context, 46.0, 0.0);
             CGContextAddLineToPoint(context, 46.0, 14.0);
             CGContextAddLineToPoint(context, 40.0, 8.0);
             
             CGContextMoveToPoint(context, 46.0, 0.0);
             CGContextAddLineToPoint(context, 53.0, 0.0);
             CGContextAddArcToPoint(context, 60.0, 0.0, 60.0, 7.0, 7.0);
             CGContextAddArcToPoint(context, 60.0, 14.0, 53.0, 14.0, 7.0);
             CGContextAddLineToPoint(context, 46.0, 14.0);
             
             CGContextMoveToPoint(context, 46.0, 10.0);
             CGContextAddLineToPoint(context, 53.0, 10.0);
             CGContextAddCurveToPoint(context, 57.0, 10.0, 57.0, 10.0, 60.0, 7.0);
             
             */
            break;
        case 1:
            [face moveToPoint:CGPointMake(40, 6)];
            [face addLineToPoint:CGPointMake(46, 1)];
            [face addLineToPoint:CGPointMake(46, 13)];
            [face addLineToPoint:CGPointMake(40, 8)];
            [face addLineToPoint:CGPointMake(40, 6)];
            break;
        case 2:
            [face moveToPoint:CGPointMake(46, 0)];
            [face addLineToPoint:CGPointMake(53, 0)];
            [face addArcWithCenter:CGPointMake(53, 7) radius:7 startAngle:1.5 * M_PI endAngle:0 clockwise:YES];
            [face addCurveToPoint:CGPointMake(53, 10) controlPoint1:CGPointMake(57, 10) controlPoint2:CGPointMake(57, 10)];
            [face addLineToPoint:CGPointMake(46, 10)];
            [face addLineToPoint:CGPointMake(46, 0)];
            break;
        case 3:
            [face moveToPoint:CGPointMake(46, 14)];
            [face addLineToPoint:CGPointMake(53, 14)];
            [face addArcWithCenter:CGPointMake(53, 7) radius:7 startAngle:0.5 * M_PI endAngle:0 clockwise:NO];
            [face addCurveToPoint:CGPointMake(53, 10) controlPoint1:CGPointMake(57, 10) controlPoint2:CGPointMake(57, 10)];
            [face addLineToPoint:CGPointMake(46, 10)];
            [face addLineToPoint:CGPointMake(46, 14)];
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
            brightness = 0.7;
            break;
        case 2:
            brightness = 0.9;
            break;
        case 3:
            brightness = 0.8;
            break;
        default:
            break;
    }
    return brightness;
}

- (uint)beatNumberFromLocationX:(float)locationX
{
    uint index;
    float deltaX = locationX - _originX;
    if (deltaX < 0) {
        index = 0;
    }
    else if (deltaX > step * 4) {
        index = 4;
    }
    else {
        for (uint i = 0; i <= 3; i++) {
            if (deltaX >= i * step && deltaX <= (i + 1) * step) {
                if ((deltaX - i * step) < ((i + 1) * step - deltaX))
                    index = i;
                else
                    index = i + 1;
                break;
            }
        }
    }
    return beatNumber[index];
}

- (void)translateWithBeatNumber:(uint)beat
{
    uint index = 5;
    float deltaX;
    for (uint i = 0; i < 5; i++) {
        if (beatNumber[i] == beat) {
            index = i;
            break;
        }
    }
    if (index == 5) {
        NSAssert(NO, @"unsupported beat number");
    }
    deltaX = index * step;
    [self setTransform:CGAffineTransformTranslate(CGAffineTransformIdentity, deltaX, 0)];
}
/*
- (Boolean)beatIndexUpdatedWithLocationX:(float)locationX
{
    NSUInteger index, beatIndex = _beatIndex;
    float deltaX = locationX - _originX;
    if (deltaX < 0)
        deltaX = 0;
    if (deltaX > step * 4)
        deltaX = step * 4;
    for (index = 0; index <= 3; index++) {
        if (deltaX >= index * step && deltaX <= (index + 1) * step) {
            if (deltaX - index * step < (index + 1) * step - deltaX)
                _beatIndex = index;
            else
                _beatIndex = index + 1;
        }
    }
    return beatIndex == _beatIndex;
}

- (CGFloat)currentIndexDeltaX
{
    return step * _beatIndex;
}

- (uint)currentBeatNumber
{
    return beatNumber[_beatIndex];
}
 */
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/


@end
