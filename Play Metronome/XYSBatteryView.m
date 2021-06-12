//
//  XYSBatteryView.m
//  Play Metronome
//
//  Created by Xu Yesheng on 8/25/14.
//  Copyright (c) 2014 yesheng. All rights reserved.
//

#import "XYSBatteryView.h"

@implementation XYSBatteryView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setBounds:CGRectMake(0, 0, 30, 30)];
        [self setOpaque:NO];
        _withLighting = YES;
        //[self setBackgroundColor:[UIColor blackColor]];
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    // battery
    UIBezierPath *batteryPath = [[UIBezierPath alloc] init];
    [batteryPath appendPath:[UIBezierPath bezierPathWithRoundedRect:CGRectMake(11, 7, 8, 16) cornerRadius:1]];
    [batteryPath appendPath:[UIBezierPath bezierPathWithRect:CGRectMake(14, 5, 2, 2)]];
    
    [batteryPath moveToPoint:CGPointMake(13, 15)];
    [batteryPath addLineToPoint:CGPointMake(17, 15)];
    [batteryPath moveToPoint:CGPointMake(13, 18)];
    [batteryPath addLineToPoint:CGPointMake(17, 18)];
    [batteryPath moveToPoint:CGPointMake(13, 21)];
    [batteryPath addLineToPoint:CGPointMake(17, 21)];
    if (!_withLighting) {
        [batteryPath moveToPoint:CGPointMake(13, 12)];
        [batteryPath addLineToPoint:CGPointMake(17, 12)];
        [batteryPath moveToPoint:CGPointMake(13, 9)];
        [batteryPath addLineToPoint:CGPointMake(17, 9)];
    }
    
    // light ray
    UIBezierPath *lightingPath;
    
    if (_withLighting)
    {
#if 0
        lightingPath = [[UIBezierPath alloc] init];
        [lightingPath moveToPoint:CGPointMake(7, 9)];
        [lightingPath addLineToPoint:CGPointMake(5, 15)];
        [lightingPath addLineToPoint:CGPointMake(9, 15)];
        [lightingPath addLineToPoint:CGPointMake(7, 21)];
        
        [lightingPath moveToPoint:CGPointMake(23, 9)];
        [lightingPath addLineToPoint:CGPointMake(21, 15)];
        [lightingPath addLineToPoint:CGPointMake(25, 15)];
        [lightingPath addLineToPoint:CGPointMake(23, 21)];
#else
        lightingPath = [[UIBezierPath alloc] init];
        [lightingPath moveToPoint:CGPointMake(23, 9)];
        [lightingPath addLineToPoint: CGPointMake(23, 21)];
        [lightingPath moveToPoint:CGPointMake(21, 18)];
        [lightingPath addLineToPoint:CGPointMake(23, 21)];
        [lightingPath addLineToPoint:CGPointMake(25, 18)];
#endif
    }
    
    CGContextSaveGState(context);
    [[UIColor whiteColor] setStroke];
    [batteryPath stroke];
    if (_withLighting) {
        [lightingPath stroke];
    }
    CGContextRestoreGState(context);
}

@end
