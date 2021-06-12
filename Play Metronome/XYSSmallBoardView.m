//
//  XYSSmallBoardView.m
//  Play Metronome
//
//  Created by Xu Yesheng on 7/21/14.
//  Copyright (c) 2014 yesheng. All rights reserved.
//

#import "XYSSmallBoardView.h"

@implementation XYSSmallBoardView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setBounds:CGRectMake(0, 0, 16, 20)];
        //[self setBackgroundColor:[UIColor yellowColor]];
    }
    return self;
}

- (NSUInteger)countOfFaces
{
    return 1;
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
            [face appendPath:[UIBezierPath bezierPathWithRoundedRect:CGRectMake(-6, 2, 12, 16) cornerRadius:1]];
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
        default:
            break;
    }
    return brightness;
}
@end
