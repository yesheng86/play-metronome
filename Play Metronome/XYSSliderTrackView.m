//
//  XYSSliderTrackView.m
//  Play Metronome
//
//  Created by Xu Yesheng on 7/22/14.
//  Copyright (c) 2014 yesheng. All rights reserved.
//

#import "XYSSliderTrackView.h"

@implementation XYSSliderTrackView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _width = frame.size.width;
        _height = frame.size.height;
        [self setBounds:CGRectMake(0, 0, _width, _height)];
        NSMutableArray *degreePaths = [[NSMutableArray alloc] init];
        CGFloat block = (_height - 4) / DEGREES;
        for (int i = 0; i < DEGREES; i++)
        {
            UIBezierPath *blockPath = [[UIBezierPath alloc] init];
            if (i == 0)
                [blockPath appendPath:[UIBezierPath bezierPathWithRoundedRect:CGRectMake(2, 2, _width - 4, block) byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:CGSizeMake((_width - 4) / 2, (_width - 4) / 2)]];
            else if (i == DEGREES -1)
                [blockPath appendPath:[UIBezierPath bezierPathWithRoundedRect:CGRectMake(2, (DEGREES - 1) * block + 2, _width - 4, block) byRoundingCorners:UIRectCornerBottomLeft | UIRectCornerBottomRight cornerRadii:CGSizeMake((_width - 4) / 2, (_width - 4) / 2)]];
            else
                [blockPath appendPath:[UIBezierPath bezierPathWithRect:CGRectMake(2, i * block + 2, _width - 4, block)]];
            [degreePaths addObject:blockPath];
        }
        UIBezierPath *roundPath = [[UIBezierPath alloc] init];
        [roundPath appendPath:[UIBezierPath bezierPathWithRoundedRect:CGRectMake(2, 2, _width - 4, _height - 4) byRoundingCorners:UIRectCornerAllCorners cornerRadii:CGSizeMake(_width / 2, _width / 2)]];
        [degreePaths addObject:roundPath];
        _degreePaths = [[NSArray alloc ] initWithArray:degreePaths];
        [self.layer setOpaque:NO];
        _colorful = NO;
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    for (int i = 0; i < DEGREES; i++) {
        if (_colorful)
            [[UIColor colorWithHue:(CGFloat)i / DEGREES saturation:0.8 brightness:0.8 alpha:1] setFill];
        else
            [[UIColor colorWithWhite: 1 - (CGFloat)i / DEGREES alpha:1] setFill];
        [_degreePaths[i] fill];
    }
    [[UIColor whiteColor] setStroke];
    [_degreePaths[DEGREES] stroke];
    CGContextRestoreGState(context);
}


@end
