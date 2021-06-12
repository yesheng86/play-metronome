//
//  XYSSliderView.m
//  Play Metronome
//
//  Created by Xu Yesheng on 7/22/14.
//  Copyright (c) 2014 yesheng. All rights reserved.
//

#import "XYSSliderView.h"

@implementation XYSSliderView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _height = frame.size.height;
        _width = frame.size.width;
        _holdThumbView = NO;
        
        [self setBounds:CGRectMake(0, 0, 26, _height)];
        _trackView = [[XYSSliderTrackView alloc] initWithFrame:CGRectMake(8, 0, 10, _height)];
        [self addSubview:_trackView];
        _thumbView = [[XYSSliderThumbView alloc] initWithFrame:CGRectMake(-7, -20, 40, 40)];
        [self addSubview:_thumbView];
        [_thumbView translateWithDy: _height / 2];
        [_thumbView setPercentage:0];
    }
    return self;
}

- (void)setColorful:(BOOL)colorful
{
    [_trackView setColorful:colorful];
    [_trackView setNeedsDisplay];
    [_thumbView setColorful:colorful];
    [_trackView setNeedsDisplay];
}

/*
- (void)holdingBegan:(CGPoint)location
{
    // hit thumb view
    if ([_thumbView.layer hitTest:location] != nil)
        _holdThumbView = YES;
}

- (void)holdingChanged:(CGPoint)location
{
    if (_holdThumbView == YES)
    {
        [self transformToHoldLocation:location];
        
    }
}

- (void)holdingEnded:(CGPoint)location
{
    _holdThumbView = NO;
}
 */

- (float)getPercentageValueFromLocation:(CGPoint)location
{
    CGFloat deltaY = location.y;
    CGFloat margin = 5; // 2 + (10 - 4) / 2
    if (deltaY <= margin)
        deltaY = margin;
    if (deltaY >= _height - margin)
        deltaY = _height -  margin;
    return (deltaY - margin) / (_height - 2 * margin);
}

- (void)updateViewByPercentageValue:(CGFloat)pct
{
    CGFloat margin = 5;
    CGFloat deltaY = pct * (_height - 2 * margin) + margin;
    [_thumbView setTransform:CGAffineTransformTranslate(CGAffineTransformIdentity, 0, deltaY)];
    [_thumbView setPercentage:pct];
    [_thumbView setNeedsDisplay];
}

/*
- (void)transformToHoldLocation:(CGPoint)location
{

    [_thumbView setTransform:CGAffineTransformTranslate(CGAffineTransformIdentity, 0, deltaY)];
    
    [_thumbView setBrightness:(deltaY - margin) / (_height - 2 * margin)];
    [_thumbView setNeedsDisplay];
}
*/

@end
