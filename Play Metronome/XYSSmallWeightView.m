//
//  XYSSmallWeightView.m
//  Play Metronome
//
//  Created by Xu Yesheng on 7/21/14.
//  Copyright (c) 2014 yesheng. All rights reserved.
//

#import "XYSSmallWeightView.h"

@implementation XYSSmallWeightView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setBounds:CGRectMake(0, 0, 10, 20)];
    }
    return self;
}

- (NSUInteger)countOfFaces
{
    return 2;
}

- (CGPoint)originalPoint
{
    return CGPointMake(5, 0);
}

- (void)setFacePathWithIndex:(NSUInteger)index
{
    UIBezierPath *face = self.faces[index];
    switch (index) {
        case 0:
            [face moveToPoint:CGPointMake(0, 0)];
            [face addLineToPoint:CGPointMake(0, 20)];
            break;
        case 1:
            [face appendPath:[UIBezierPath bezierPathWithRect:CGRectMake(-3, 3, 6, 6)]];
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
            brightness = 0.5;
            break;
        case 1:
            brightness = 0.7;
            break;
        default:
            break;
    }
    return brightness;
}
@end
