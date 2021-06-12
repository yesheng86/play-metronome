//
//  XYSTextButtonView.m
//  Play Metronome
//
//  Created by Xu Yesheng on 10/5/14.
//  Copyright (c) 2014 yesheng. All rights reserved.
//

#import "XYSTextButtonView.h"

@implementation XYSTextButtonView
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setBounds:CGRectMake(0, 0, 140, 30)];
        [self setBackgroundColor:[UIColor darkGrayColor]];
        
        _labelString = [[UILabel alloc] initWithFrame:CGRectMake(2, 2, 136, 26)];
        [_labelString setTextColor:[UIColor whiteColor]];
        [_labelString setFont:[UIFont fontWithName:@"AppleGothic" size:12]];
        [_labelString setTextAlignment:NSTextAlignmentCenter];
        [_labelString setBackgroundColor:[UIColor clearColor]];
        [self addSubview:_labelString];
    }
    return self;
}

- (void)setText:(NSString *)text
{
    [_labelString setText:text];
}

- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    UIBezierPath *roundRectPath = [[UIBezierPath alloc] init];
    [roundRectPath appendPath:[UIBezierPath bezierPathWithRoundedRect:CGRectMake(2, 2, 136, 26) cornerRadius:4]];
    
    CGContextSaveGState(context);
    [[UIColor whiteColor] setStroke];
    [[super fillColor] setFill];
    [roundRectPath stroke];
    [roundRectPath fill];
    CGContextRestoreGState(context);
}
@end
