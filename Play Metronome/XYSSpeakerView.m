//
//  XYSSpeakerView.m
//  Play Metronome
//
//  Created by Xu Yesheng on 8/11/14.
//  Copyright (c) 2014 yesheng. All rights reserved.
//

#import "XYSSpeakerView.h"

@implementation XYSSpeakerView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setBounds:CGRectMake(0, 0, 30, 30)];
        [self setOpaque:NO];
        _withWave = YES;
        //[self setBackgroundColor:[UIColor blackColor]];
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    // speaker
    UIBezierPath *speakerPath = [[UIBezierPath alloc] init];
    [speakerPath appendPath:[UIBezierPath bezierPathWithRoundedRect:CGRectMake(7, 12, 4, 6) byRoundingCorners:UIRectCornerTopLeft | UIRectCornerBottomLeft cornerRadii:CGSizeMake(4, 4)]];
    [speakerPath moveToPoint:CGPointMake(11, 12)];
    [speakerPath addLineToPoint:CGPointMake(15, 8)];
    [speakerPath addLineToPoint:CGPointMake(17, 8)];
    [speakerPath addLineToPoint:CGPointMake(17, 22)];
    [speakerPath addLineToPoint:CGPointMake(15, 22)];
    [speakerPath addLineToPoint:CGPointMake(11, 18)];
    
    // sound wave
    UIBezierPath *wavePath;
    
    if (_withWave)
    {
        /*
        wavePath = [[UIBezierPath alloc] init];
        [wavePath moveToPoint:CGPointMake(20, 8)];
        [wavePath addLineToPoint:CGPointMake(22, 7)];
        [wavePath moveToPoint:CGPointMake(20.5, 13)];
        [wavePath addLineToPoint:CGPointMake(22.5, 12.5)];
        [wavePath moveToPoint:CGPointMake(20.5, 17)];
        [wavePath addLineToPoint:CGPointMake(22.5, 17.5)];
        [wavePath moveToPoint:CGPointMake(20, 22)];
        [wavePath addLineToPoint:CGPointMake(22, 23)];
         */
        wavePath = [[UIBezierPath alloc] init];
        [wavePath appendPath:[UIBezierPath bezierPathWithArcCenter:CGPointMake(15, 15) radius:6 startAngle:- M_PI_4 endAngle:M_PI_4 clockwise:YES]];
        [wavePath appendPath:[UIBezierPath bezierPathWithArcCenter:CGPointMake(15, 15) radius:8 startAngle:- M_PI_4 endAngle:M_PI_4 clockwise:YES]];
        [wavePath appendPath:[UIBezierPath bezierPathWithArcCenter:CGPointMake(15, 15) radius:10 startAngle:- M_PI_4 endAngle:M_PI_4 clockwise:YES]];
    }
    
    CGContextSaveGState(context);
    [[UIColor whiteColor] setStroke];
    [speakerPath stroke];
    if (_withWave)
        [wavePath stroke];
    CGContextRestoreGState(context);
}

@end
