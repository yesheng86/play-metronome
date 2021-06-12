//
//  XYSTimbreView.m
//  Play Metronome
//
//  Created by Xu Yesheng on 8/9/14.
//  Copyright (c) 2014 yesheng. All rights reserved.
//

#import "XYSTimbreView.h"

@implementation XYSTimbreView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setBounds:CGRectMake(0, 0, 40, 30)];
        [self setOpaque:NO];
        UIView *screenView = [[UIView alloc] initWithFrame:CGRectMake(5, 0, 30, 30)];
        [self addSubview:screenView];
        _waveView = [[XYSTimbreWaveView alloc] initWithFrame:CGRectMake(0, 0, 80, 30)];
        [screenView addSubview:_waveView];
        [screenView setClipsToBounds:YES];
        _animateOn = NO;
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    /*
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSaveGState(context);
    CGContextRestoreGState(context);
     */
}

- (void)startWaveAnimate
{
    [_waveView startTranslateWithDx:-50 Dy:0];
}

- (void)startWaveAnimateWithDuration:(CFTimeInterval)duration
{
    _animateOn = NO;
    [_waveView setAnimationDuration:duration];
    [_waveView setAnimationRepeatCount:4];
    [self startWaveAnimate];
}

- (void)startWaveAnimateForeverWithDuration:(CFTimeInterval)duration
{
    _animateOn = YES;
    [_waveView setAnimationDuration:duration];
    [_waveView setAnimationRepeatCount:HUGE_VALF];
    [self startWaveAnimate];
}

- (void)stopWaveAnimate
{
    if (_animateOn) {
        [_waveView stopTranslate];
        _animateOn = NO;
    }
}

@end
