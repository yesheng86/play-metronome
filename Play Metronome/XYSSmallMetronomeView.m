//
//  XYSSmallMetronomeView.m
//  Play Metronome
//
//  Created by Xu Yesheng on 7/27/14.
//  Copyright (c) 2014 yesheng. All rights reserved.
//

#import "XYSSmallMetronomeView.h"

@implementation XYSSmallMetronomeView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setBounds:CGRectMake(0, 0, 30, 45)];
        [self setOpaque:NO];
        
        //small
        _casingView = [[XYSSmallCasingView alloc] initWithFrame:CGRectMake(0, 0, 30, 40)];
        
        //small board
        _boardView = [[XYSSmallBoardView alloc] initWithFrame:CGRectMake(7, 5, 16, 20)];
        
        //small weight
        _weightView = [[XYSSmallWeightView alloc] initWithFrame:CGRectMake(3, 2, 10, 20)];
        
        [self addSubview:_casingView];
        [_casingView addSubview:_boardView];
        [_boardView addSubview:_weightView];
        
        _viewMode = COLORMODE;
        _focus = NO;
        _focusPath = [UIBezierPath bezierPathWithRect:CGRectMake(13, 42, 4, 2)];
    }
    return self;
}


- (void)drawRect:(CGRect)rect
{
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    if (_focus) {
        [[UIColor whiteColor] setFill];
        [_focusPath fill];
    }
    CGContextRestoreGState(context);
}

- (void)setCasingHue:(CGFloat)hue
{
    [_casingView setFillHue:hue];
    [_casingView setStrokeHue:hue];
    [_casingView setNeedsDisplay];
}

- (void)setBoardHue:(CGFloat)hue
{
    [_boardView setFillHue:hue];
    [_boardView setStrokeHue:hue];
    [_boardView setNeedsDisplay];
}

- (void)setWeightHue:(CGFloat)hue
{
    [_weightView setFillHue:hue];
    [_weightView setStrokeHue:hue];
    [_weightView setNeedsDisplay];
}

- (void)switchMode:(ViewMode)mode
{
    [_casingView setViewMode:mode];
    [_casingView setNeedsDisplay];
    [_boardView setViewMode:mode];
    [_boardView setNeedsDisplay];
    [_weightView setViewMode:mode];
    [_weightView setNeedsDisplay];
}

@end
