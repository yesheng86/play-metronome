//
//  XYSBulbView.m
//  Play Metronome
//
//  Created by Xu Yesheng on 8/5/14.
//  Copyright (c) 2014 yesheng. All rights reserved.
//

#import "XYSBulbView.h"

@implementation XYSBulbView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setBounds:CGRectMake(0, 0, 30, 30)];
        [self setOpaque:NO];
        _brightness = 1;
        _withRay = YES;
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();

    // bulb
    UIBezierPath *bulbPath = [[UIBezierPath alloc] init];
    CGFloat bulbRadius = 6;
    [bulbPath appendPath:[UIBezierPath bezierPathWithArcCenter:CGPointMake(15, 15) radius:bulbRadius startAngle:M_PI_4 endAngle:M_PI_4 * 3 clockwise:NO]];
    [bulbPath appendPath:[UIBezierPath bezierPathWithRoundedRect:CGRectMake(15 - bulbRadius / sqrtf(2), 15 + bulbRadius / sqrtf(2), bulbRadius * sqrtf(2), 6) byRoundingCorners:UIRectCornerBottomLeft | UIRectCornerBottomRight cornerRadii:CGSizeMake(2, 2)]];
    [bulbPath appendPath:[UIBezierPath bezierPathWithRect:CGRectMake(15 - bulbRadius / sqrtf(2) / 2, 15, bulbRadius / sqrtf(2), bulbRadius / sqrtf(2))]];
    [bulbPath moveToPoint:CGPointMake(15 - bulbRadius / sqrtf(2), 18 + bulbRadius / sqrtf(2))];
    [bulbPath addLineToPoint:CGPointMake(15 + bulbRadius / sqrtf(2), 18 + bulbRadius / sqrtf(2))];
    
    // light ray
    UIBezierPath *rayPath;
    if (_withRay)
    {
        rayPath = [[UIBezierPath alloc] init];
        CGFloat rayRadius = 9;
        [rayPath moveToPoint:CGPointMake(15, 15 - rayRadius)];
        [rayPath addLineToPoint:CGPointMake(15, 13 - rayRadius)];
        [rayPath moveToPoint:CGPointMake(15 - rayRadius, 15)];
        [rayPath addLineToPoint:CGPointMake(13 - rayRadius, 15)];
        [rayPath moveToPoint:CGPointMake(15 + rayRadius, 15)];
        [rayPath addLineToPoint:CGPointMake(17 + rayRadius, 15)];
        [rayPath moveToPoint:CGPointMake(15 - rayRadius / sqrtf(2), 15 - rayRadius / sqrtf(2))];
        [rayPath addLineToPoint:CGPointMake(15 - (rayRadius + 2) / sqrtf(2), 15 - (rayRadius + 2) / sqrtf(2))];
        [rayPath moveToPoint:CGPointMake(15 + rayRadius / sqrtf(2), 15 - rayRadius / sqrtf(2))];
        [rayPath addLineToPoint:CGPointMake(15 + (rayRadius + 2) / sqrtf(2), 15 - (rayRadius + 2) / sqrtf(2))];
    }
    CGContextSaveGState(context);
    [[UIColor colorWithWhite:_brightness alpha:1] setStroke];
    [bulbPath stroke];
    if (_withRay)
        [rayPath stroke];
    CGContextRestoreGState(context);
}

@end
