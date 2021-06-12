//
//  XYSSwitchButtonView.m
//  Play Metronome
//
//  Created by Xu Yesheng on 8/10/14.
//  Copyright (c) 2014 yesheng. All rights reserved.
//

#import "XYSSwitchButtonView.h"

@implementation XYSSwitchButtonView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setBounds:CGRectMake(0, 0, 40, 40)];
        [self setOpaque:NO];
        
        _textLayer = [CATextLayer layer];
        [_textLayer setFrame:CGRectMake(17, 14, 8, 16)];
        [_textLayer setForegroundColor:[UIColor whiteColor].CGColor];
        [_textLayer setFontSize:10];
        [_textLayer setContentsScale:2];
        [[self layer] addSublayer:_textLayer];
        
        [_textLayer setString:[NSString stringWithFormat:@"%c", '1']];
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    UIBezierPath *circlePath = [[UIBezierPath alloc] init];
    [circlePath appendPath:[UIBezierPath bezierPathWithOvalInRect:CGRectMake(5, 5, 30, 30)]];
    
    CGFloat radius = 9;
    UIBezierPath *switchPath = [[UIBezierPath alloc] init];
    [switchPath appendPath:[UIBezierPath bezierPathWithArcCenter:CGPointMake(20, 20) radius:radius startAngle:-M_PI_2 endAngle:M_PI_4 clockwise:YES]];
    [switchPath appendPath:[UIBezierPath bezierPathWithArcCenter:CGPointMake(20, 20) radius:radius startAngle:M_PI_2 endAngle:5 * M_PI_4 clockwise:YES]];

    [switchPath moveToPoint:CGPointMake(20 - radius / sqrtf(2), 20 - radius / sqrtf(2))];
    [switchPath addLineToPoint:CGPointMake(20 - (radius + 6) / sqrtf(2), 23 - radius / sqrtf(2))];
    [switchPath moveToPoint:CGPointMake(20 - radius / sqrtf(2), 20 - radius / sqrtf(2))];
    [switchPath addLineToPoint:CGPointMake(20 - radius / sqrtf(2), 25 - radius / sqrtf(2))];
    
    
    [switchPath moveToPoint:CGPointMake(20 + radius / sqrtf(2), 20 + radius / sqrtf(2))];
    [switchPath addLineToPoint:CGPointMake(20 + (radius + 6) / sqrtf(2), 17 + radius / sqrtf(2))];
    [switchPath moveToPoint:CGPointMake(20 + radius / sqrtf(2), 20 + radius / sqrtf(2))];
    [switchPath addLineToPoint:CGPointMake(20 + radius / sqrtf(2), 15 + radius / sqrtf(2))];
    
    CGContextSaveGState(context);
    [[UIColor whiteColor] setStroke];
    [[super fillColor] setFill];
    [circlePath stroke];
    [circlePath fill];
    [switchPath stroke];
    CGContextRestoreGState(context);
}

- (void)updateText:(uint)num
{
    [_textLayer setString:[NSString stringWithFormat:@"%c", '1' + num]];
}
@end
