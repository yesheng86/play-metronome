//
//  XYSPurchaseButtonView.m
//  Play Metronome
//
//  Created by Xu Yesheng on 8/10/14.
//  Copyright (c) 2014 yesheng. All rights reserved.
//

#import "XYSPurchaseButtonView.h"

@implementation XYSPurchaseButtonView
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
    
    UIBezierPath *cartPath = [[UIBezierPath alloc] init];
    [cartPath appendPath:[UIBezierPath bezierPathWithRoundedRect:CGRectMake(16, 15, 12, 8) byRoundingCorners:UIRectCornerBottomRight cornerRadii:CGSizeMake(2, 2)]];
    
    // cart body
    [cartPath moveToPoint:CGPointMake(16, 19)];
    [cartPath addLineToPoint:CGPointMake(28, 19)];
    [cartPath moveToPoint:CGPointMake(20, 15)];
    [cartPath addLineToPoint:CGPointMake(20, 23)];
    [cartPath moveToPoint:CGPointMake(24, 15)];
    [cartPath addLineToPoint:CGPointMake(24, 23)];
    // cart handle
    [cartPath moveToPoint:CGPointMake(16, 15)];
    [cartPath addLineToPoint:CGPointMake(16, 12)];
    [cartPath addLineToPoint:CGPointMake(11, 12)];
    // cart wheels
    [cartPath appendPath:[UIBezierPath bezierPathWithOvalInRect:CGRectMake(14.5, 27.5, 3, 3)]];
    [cartPath appendPath:[UIBezierPath bezierPathWithOvalInRect:CGRectMake(22.5, 27.5, 3, 3)]];
    [cartPath moveToPoint:CGPointMake(16, 22)];
    [cartPath addLineToPoint:CGPointMake(16, 27.5)];
    [cartPath moveToPoint:CGPointMake(17.5, 29)];
    [cartPath addLineToPoint:CGPointMake(22.5, 29)];
    
    
    CGContextSaveGState(context);
    [[UIColor whiteColor] setStroke];
    [[super fillColor] setFill];
    [circlePath stroke];
    [circlePath fill];
    [cartPath stroke];
    CGContextRestoreGState(context);
}
@end
