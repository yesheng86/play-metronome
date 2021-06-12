//
//  XYSManView.m
//  Play Metronome
//
//  Created by Xu Yesheng on 9/10/14.
//  Copyright (c) 2014 yesheng. All rights reserved.
//

#import "XYSManView.h"

@implementation XYSManView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setBounds:CGRectMake(0, 0, 220, 360)];
        [self setBackgroundColor:[UIColor lightGrayColor]];
        
        // 430 * 150
        NSString *startImgPath = [[NSBundle mainBundle] pathForResource:@"man-start" ofType:@"png"];
        
        // 470 * 150
        NSString *stopImgPath = [[NSBundle mainBundle] pathForResource:@"man-stop" ofType:@"png"];
        
        // 322 * 220
        NSString *tempoImgPath = [[NSBundle mainBundle] pathForResource:@"man-tempo" ofType:@"png"];
        
        // 365 * 220
        NSString *beatImgPath = [[NSBundle mainBundle] pathForResource:@"man-beat" ofType:@"png"];
        
        _startManImg = [[UIImage alloc] initWithContentsOfFile:startImgPath];
        _stopManImg = [[UIImage alloc] initWithContentsOfFile:stopImgPath];
        _tempoManImg = [[UIImage alloc] initWithContentsOfFile:tempoImgPath];
        _beatManImg = [[UIImage alloc] initWithContentsOfFile:beatImgPath];
        
        uint fontSize = 8;
        
        UILabel *startText = [[UILabel alloc] initWithFrame:CGRectMake(10, 75, 100, 15)];
        [startText setText:NSLocalizedString(@"Start", @"START")];
        [startText setTextColor:[UIColor darkGrayColor]];
        [startText setBackgroundColor:[UIColor clearColor]];
        [startText setFont:[UIFont systemFontOfSize:fontSize]];
        
        UILabel *stopText = [[UILabel alloc] initWithFrame:CGRectMake(10, 165, 100, 15)];
        [stopText setText:NSLocalizedString(@"Stop", @"STOP")];
        [stopText setTextColor:[UIColor darkGrayColor]];
        [stopText setBackgroundColor:[UIColor clearColor]];
        [stopText setFont:[UIFont systemFontOfSize:fontSize]];
        
        UILabel *tempoText = [[UILabel alloc] initWithFrame:CGRectMake(10, 255, 100, 15)];
        [tempoText setText:NSLocalizedString(@"SetTempo", @"SET TEMPO")];
        [tempoText setTextColor:[UIColor darkGrayColor]];
        [tempoText setBackgroundColor:[UIColor clearColor]];
        [tempoText setFont:[UIFont systemFontOfSize:fontSize]];
        
        UILabel *beatText = [[UILabel alloc] initWithFrame:CGRectMake(10, 345, 100, 15)];
        [beatText setText:NSLocalizedString(@"SetBeat", @"SET BEAT")];
        [beatText setTextColor:[UIColor darkGrayColor]];
        [beatText setBackgroundColor:[UIColor clearColor]];
        [beatText setFont:[UIFont systemFontOfSize:fontSize]];
        
        [self addSubview:startText];
        [self addSubview:stopText];
        [self addSubview:tempoText];
        [self addSubview:beatText];
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    UIBezierPath *rectPath = [[UIBezierPath alloc] init];
    [rectPath appendPath:[UIBezierPath bezierPathWithRect:CGRectMake(5, 0, 215, 360)]];
    
    UIBezierPath *bgPath = [[UIBezierPath alloc] init];
    [bgPath moveToPoint:CGPointMake(0, 90)];
    [bgPath addLineToPoint:CGPointMake(220, 90)];
    [bgPath moveToPoint:CGPointMake(0, 180)];
    [bgPath addLineToPoint:CGPointMake(220, 180)];
    [bgPath moveToPoint:CGPointMake(0, 270)];
    [bgPath addLineToPoint:CGPointMake(220, 270)];
    
    
    CGContextSaveGState(context);
    [[UIColor whiteColor] setFill];
    [rectPath fill];
    [[UIColor lightGrayColor] setStroke];
    [bgPath stroke];
    CGContextRestoreGState(context);
    
    float scaleFactor = 0.4;
    [_startManImg drawInRect:CGRectMake((220 - 430 * scaleFactor) / 2, 15, 430 * scaleFactor, 150 * scaleFactor)];
    [_stopManImg drawInRect:CGRectMake((220 - 470 * scaleFactor) / 2, 105, 470 * scaleFactor, 150 * scaleFactor)];
    [_tempoManImg drawInRect:CGRectMake((220 - 322 * scaleFactor) / 2 + 10, 180, 322 * scaleFactor, 220 * scaleFactor)];
    [_beatManImg drawInRect:CGRectMake((220 - 365 * scaleFactor) / 2 + 22, 270, 365 * scaleFactor, 220 * scaleFactor)];
    
}

- (void)appear
{
    [self startTranslateWithDx:-self.bounds.size.width Dy:0];
}

- (void)hide
{
    [self startTranslateWithDx:self.bounds.size.width Dy:0];
}
@end
