//
//  XYSScaleView.m
//  Play Metronome
//
//  Created by Xu Yesheng on 8/2/14.
//  Copyright (c) 2014 yesheng. All rights reserved.
//

#import "XYSScaleView.h"

@implementation XYSScaleView

float scale[39] = {0, 1.6, 3.2, 4.8, 6.4, 8.0, 9.6, 11.2, 13.6, 16.0, 18.4, 20.8, 23.2, 27.2, 30.4, 34.4, 38.4, 43.2, 47.2, 51.2, 55.2, 59.2, 63.2, 67.2, 71.2, 75.2, 80.0, 85.6, 91.2, 96.8, 103.2, 110.4, 118.4, 126.4, 134.4, 142.4, 151.2, 160.0, 168.0};

uint bpm[39] =
{40, 42, 44, 46, 48, 50, 52, 54, 56, 58, 60, 63, 66, 69, 72, 76, 80, 84, 88, 92, 96, 100, 104, 108, 112, 116, 120, 126, 132, 138, 144, 152, 160, 168, 176, 184, 192, 200, 208};
uint bpm2tempo[39] =
{0,  1,  1,  2,  2,  3,  3,  3,  4,  4,  4,  4,  5,  5,  6,  6,  6,  7,  7,  8,  8,   8,   9,   9,   9,  10,  11,  12,   12,  13, 13,  14,  14,  15,  15,  16, 16,  16,  17};
NSString *tempo[18] = {@"Grave", @"Lento", @"Largo", @"Larghetto", @"Adagio", @"Adagietto", @"Andantino", @"Andante", @"Andante Moderato", @"Moderato", @"Allegro Moderato", @"Allegretto", @"Allegro", @"Vivance", @"Vivacissimo", @"Allegrissimo", @"Presto", @"Prestissimo"};


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setSaturation:0.1];
    }
    return self;
}

- (NSUInteger)countOfFaces
{
    return 6;
}

- (CGPoint)originalPoint
{
    return CGPointMake(40, 0);
}


- (void)setFacePathWithIndex:(NSUInteger)index
{
    UIBezierPath *face = self.faces[index];
    switch (index) {
        case 0:
            [face moveToPoint:CGPointMake(10, 0)];
            [face addLineToPoint:CGPointMake(10, 168)];
            
            CGFloat scaleLeft[20] = {0, 3.2, 6.4, 9.6, 13.6, 18.4, 23.2, 30.4, 38.4, 47.2, 55.2, 63.2, 71.2, 80.0, 91.2, 103.2, 118.4, 134.4, 151.2, 168.0};
            for (int i = 0; i < 20; i++)
            {
                [face moveToPoint:CGPointMake(0, scaleLeft[i])];
                [face addLineToPoint:CGPointMake(10, scaleLeft[i])];
            }
            [face applyTransform:CGAffineTransformTranslate(CGAffineTransformIdentity, -20, 51)];
            break;
        case 1:
            [face moveToPoint:CGPointMake(0, 1)];
            [face addLineToPoint:CGPointMake(0, 168)];
            
            CGFloat scaleRight[20] = {1.6, 4.8, 8.0, 11.2, 16.0, 20.8, 27.2, 34.4, 43.2, 51.2, 59.2, 67.2, 75.2, 85.6, 96.8, 110.4, 126.4, 142.4, 160.0, 168.0};
            for (int i = 0; i < 20; i++)
            {
                [face moveToPoint:CGPointMake(0, scaleRight[i])];
                [face addLineToPoint:CGPointMake(10, scaleRight[i])];
            }
            [face applyTransform:CGAffineTransformTranslate(CGAffineTransformIdentity, 10, 51)];
            break;
        case 2:
            [face appendPath:[UIBezierPath bezierPathWithOvalInRect:CGRectMake(-31, 34, 4, 4)]];
            break;
        case 3:
            [face appendPath:[UIBezierPath bezierPathWithOvalInRect:CGRectMake(27, 34, 4, 4)]];
            break;
        case 4:
            [face appendPath:[UIBezierPath bezierPathWithOvalInRect:CGRectMake(-31, 232, 4, 4)]];
            break;
        case 5:
            [face appendPath:[UIBezierPath bezierPathWithOvalInRect:CGRectMake(27, 232, 4, 4)]];
            break;
        default:
            break;
    }
}

- (CGFloat) brightnessWithIndex:(NSUInteger)index
{
    CGFloat brightness = 0;
    // setting fill brightness, stroke brightness is fill brightness + 1
    switch (index) {
        case 0:
            brightness = 0.8;
            break;
        case 1:
            brightness = 0.8;
            break;
        case 2:
            brightness = 0.5;
            break;
        case 3:
            brightness = 0.5;
            break;
        case 4:
            brightness = 0.5;
            break;
        case 5:
            brightness = 0.5;
            break;
        default:
            break;
    }
    return brightness;
}



- (uint) tempoWithPointFromTop:(float)pointFromTop
{
    uint index = 0;
    for (uint i = 0; i < 39; i++)
    {
        if (pointFromTop >= scale[i] && pointFromTop <= scale[i+1])
        {
            if ((pointFromTop - scale[i]) < (scale[i+1] - pointFromTop))
                index = i;
            else
                index = i + 1;
            break;
        }
    }
    return bpm[index];
}

- (float) pointFromTopWithTempo:(uint)tempo
{
    uint index = 39;
    for (uint i = 0; i < 39; i++) {
        if (bpm[i] == tempo) {
            index = i;
            break;
        }
    }
    if (index == 39) {
        NSAssert(NO, @"unsupported tempo number");
    }
    return scale[index];
}

/*
- (CGFloat)nearestScale:(CGFloat)pointFromTop
{
    CGFloat nearest = 0;
    for (int i = 0; i < 39; i++)
    {
        if (pointFromTop >= scale[i] && pointFromTop <= scale[i+1])
        {
            if ((pointFromTop - scale[i]) < (scale[i+1] - pointFromTop))
                nearest = scale[i];
            else
                nearest = scale[i+1];
            break;
        }
    }
    return nearest;
}
- (NSString *)tempoStringWithIndex:(uint)index
{
    return [NSString stringWithFormat:@"%d", bpm[index]];
}

- (uint)bpmWithIndex:(uint)index
{
    return bpm[index];
}

- (uint)tempoIndexWithPointFromTop:(CGFloat)pointFromTop
{
    uint index = 0;
    for (uint i = 0; i < 39; i++)
    {
        if (pointFromTop >= scale[i] && pointFromTop <= scale[i+1])
        {
            if ((pointFromTop - scale[i]) < (scale[i+1] - pointFromTop))
                index = i;
            else
                index = i + 1;
            break;
        }
    }
    return index;
}
*/

@end
