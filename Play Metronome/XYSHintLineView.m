//
//  XYSHintLineView.m
//  Play Metronome
//
//  Created by Xu Yesheng on 8/13/14.
//  Copyright (c) 2014 yesheng. All rights reserved.
//

#import "XYSHintLineView.h"

@implementation XYSHintLineView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setOpaque:NO];
        [self setHidden:YES];
        [self setBounds:CGRectMake(0, 0, 300, 400)];
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    UIBezierPath *hintLine = [[UIBezierPath alloc] init];
    CGFloat dashArray[] = {2, 3};
    CGFloat deltaY = 120 / tanf(M_PI / 5);


    [hintLine moveToPoint:CGPointMake(_rotationAxis.x - 120, _rotationAxis.y - deltaY)];
    [hintLine addLineToPoint:_rotationAxis];
    [hintLine moveToPoint:CGPointMake(_rotationAxis.x + 120, _rotationAxis.y - deltaY)];
    [hintLine addLineToPoint:_rotationAxis];
    [hintLine setLineDash:dashArray count:2 phase:0];
    
    CGContextSaveGState(context);
    [[UIColor redColor] setStroke];
    [hintLine stroke];
    CGContextRestoreGState(context);
}

- (void)appear
{
    [self.layer setHidden:NO];
}

- (void)disappear
{
    [self.layer setHidden:YES];
}
@end
