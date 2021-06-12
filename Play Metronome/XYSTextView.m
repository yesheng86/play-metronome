//
//  XYSTextView.m
//  Play Metronome
//
//  Created by Xu Yesheng on 6/29/14.
//  Copyright (c) 2014 yesheng. All rights reserved.
//

#import "XYSTextView.h"

@implementation XYSTextView

/*
+ (Class)layerClass
{
    return [CATextLayer class];
}
*/
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setBounds:CGRectMake(0, 0, 60, 50)];
        
        _highlightOn = NO;
        _lowlightColor = [UIColor colorWithWhite:0.5 alpha:1];
        _highlightColor = [UIColor blackColor];
        
        _labelLayer = [CATextLayer layer];
        [_labelLayer setFrame:CGRectMake(0, 0, 60, 10)];
        [_labelLayer setBackgroundColor:[UIColor whiteColor].CGColor];
        [_labelLayer setForegroundColor:_lowlightColor.CGColor];
        [_labelLayer setFontSize:10];
        [_labelLayer setContentsScale:2];
        [[self layer] addSublayer:_labelLayer];
        
        _textLayer = [CATextLayer layer];
        [_textLayer setFrame:CGRectMake(0, 10, 60, 40)];
        [_textLayer setBackgroundColor:[UIColor whiteColor].CGColor];
        [_textLayer setForegroundColor:_lowlightColor.CGColor];
        [_textLayer setFontSize:36];
        [_textLayer setContentsScale:2];
        [[self layer] addSublayer:_textLayer];
        
    }
    return self;
}

- (void)setLabel:(NSString *)label
{
    [_labelLayer setString:label];
}

- (void)setText:(NSString *)text
{
    [_textLayer setString:text];
}

- (void)highlight
{
    if (!_highlightOn)
    {
        _highlightOn = YES;
        [_labelLayer setForegroundColor:_highlightColor.CGColor];
        [_textLayer setForegroundColor:_highlightColor.CGColor];
    }
}

- (void)lowlight
{
    if (_highlightOn)
    {
        _highlightOn = NO;
        [_labelLayer setForegroundColor:_lowlightColor.CGColor];
        [_textLayer setForegroundColor:_lowlightColor.CGColor];
    }
}

- (void)setAlignment:(NSString *)alignment
{
    [_labelLayer setAlignmentMode:alignment];
    [_textLayer setAlignmentMode:alignment];
}


@end
