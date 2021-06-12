//
//  XYSSliderThumbView.m
//  Play Metronome
//
//  Created by Xu Yesheng on 7/22/14.
//  Copyright (c) 2014 yesheng. All rights reserved.
//

#import "XYSSliderThumbView.h"

@implementation XYSSliderThumbView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _width = frame.size.width;
        _height = frame.size.height;
        [self setBounds:CGRectMake(0, 0, _width, _height)];
        _thumbPath = [[UIBezierPath alloc] init];
        [_thumbPath appendPath:[UIBezierPath bezierPathWithOvalInRect:CGRectMake(9, 9, _width - 18, _height - 18)]];
        _thumbCore = [[UIBezierPath alloc] init];
        [_thumbCore appendPath:[UIBezierPath bezierPathWithOvalInRect:CGRectMake((_width - 6) / 2, (_height - 6) / 2, 6, 6)]];
        _percentage = 0;
        _colorful = NO;
        [self.layer setOpaque:NO];

    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    CGFloat hue = _percentage;
    CGFloat brightness = 1 - _percentage;
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    if (_colorful)
        [[UIColor colorWithHue:hue saturation:1 brightness:1 alpha:0.6] setFill];
    else
        [[UIColor colorWithWhite:brightness alpha:0.6] setFill];
    [[UIColor whiteColor] setStroke];
    [_thumbPath fill];
    [_thumbPath stroke];
    if (_colorful)
        [[UIColor colorWithHue:hue saturation:1 brightness:1 alpha:1] setFill];
    else
        [[UIColor colorWithWhite:brightness alpha:1] setFill];
    [_thumbCore fill];
    [_thumbCore stroke];
    CGContextRestoreGState(context);
}

- (void)translateWithDy:(CGFloat)dy
{
    [self setTransform:CGAffineTransformTranslate(CGAffineTransformIdentity, 0, dy)];
}

@end
