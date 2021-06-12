//
//  XYSManButtonView.m
//  Play Metronome
//
//  Created by Xu Yesheng on 9/10/14.
//  Copyright (c) 2014 yesheng. All rights reserved.
//

#import "XYSManButtonView.h"

@implementation XYSManButtonView
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setBounds:CGRectMake(0, 0, 40, 40)];
        [self setOpaque:NO];
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    UIBezierPath *circlePath = [[UIBezierPath alloc] init];
    [circlePath appendPath:[UIBezierPath bezierPathWithOvalInRect:CGRectMake(5, 5, 30, 30)]];
    
    UIBezierPath *questionMarkPath = [[UIBezierPath alloc] init];
    [questionMarkPath appendPath:[UIBezierPath bezierPathWithArcCenter:CGPointMake(20, 18) radius:4 startAngle:0 endAngle:M_PI clockwise:NO]];
    [questionMarkPath appendPath:[UIBezierPath bezierPathWithArcCenter:CGPointMake(22, 18) radius:2 startAngle:0 endAngle:M_PI_2 clockwise:YES]];
    [questionMarkPath appendPath:[UIBezierPath bezierPathWithArcCenter:CGPointMake(22, 22) radius:2 startAngle:M_PI_2 * 3 endAngle:M_PI clockwise:NO]];
    [questionMarkPath moveToPoint:CGPointMake(20, 22)];
    [questionMarkPath addLineToPoint:CGPointMake(20, 24)];
    
    //[questionMarkPath appendPath:[UIBezierPath bezierPathWithOvalInRect:CGRectMake(19, 26, 2, 2)]];
    [questionMarkPath moveToPoint:CGPointMake(20, 27)];
    [questionMarkPath addLineToPoint:CGPointMake(20, 28)];
    
    CGContextSaveGState(context);
    [[UIColor whiteColor] setStroke];
    [[super fillColor] setFill];
    [circlePath stroke];
    [circlePath fill];
    [questionMarkPath stroke];
    CGContextRestoreGState(context);
}
@end
