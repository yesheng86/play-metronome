//
//  XYSPartView.m
//  Play Metronome
//
//  Created by Xu Yesheng on 5/25/14.
//  Copyright (c) 2014 yesheng. All rights reserved.
//

#import "XYSPartView.h"
#import "XYSArmView.h"
@interface XYSPartView ()

- (uint)countOfFaces;

- (CGPoint)originalPoint;

- (void)setFacePathWithIndex:(NSUInteger)index;

@end

@implementation XYSPartView


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Sub view need override this default value
        self.layer.opaque = NO;
        
        self.layer.frame = frame;
        _darkFactor = 1;
        _fillHue = 0.5;
        _strokeHue = 0.5;
        _saturation = 0.3;
        _brightnessDelta = 0.3;
        [self initFaces];
        _viewMode = COLORMODE;
    }
    return self;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGPoint originalPoint = [self originalPoint];
 
    CGContextSaveGState(context);
    CGContextTranslateCTM(context, originalPoint.x, originalPoint.y);

    for (int i = 0; i < [self countOfFaces]; i++) {
        UIBezierPath *path = _faces[i];
        switch (_viewMode) {
            case COLORMODE:
                [[UIColor colorWithHue:_fillHue saturation:_saturation brightness:[self brightnessWithIndex:i] * _darkFactor alpha:1] setFill];
                [path fill];
                if ([self needStrokeWithIndex:i]) {
                    [[UIColor colorWithHue:_strokeHue saturation:_saturation brightness:([self brightnessWithIndex:i] + _brightnessDelta) * _darkFactor alpha:1] setStroke];
                } else {
                    [[UIColor colorWithHue:_fillHue saturation:_saturation brightness:[self brightnessWithIndex:i] * _darkFactor alpha:1] setStroke];
                }
                [path stroke];
                break;
            case DRAFTMODE:
                [[UIColor colorWithWhite:([self brightnessWithIndex:i] + 0.2)* _darkFactor alpha:_fillHue] setFill];
                [path fill];
                [[UIColor colorWithWhite:0.5 alpha:_strokeHue] setStroke];
                [path stroke];
                break;
            case GREYMODE:
                [[UIColor colorWithWhite:(1- _fillHue) * [self brightnessWithIndex:i] * _darkFactor alpha:1] setFill];
                [path fill];
                if ([self needStrokeWithIndex:i]) {
                    [[UIColor colorWithWhite:((1- _fillHue) * [self brightnessWithIndex:i] + _brightnessDelta) * _darkFactor alpha:1] setStroke];
                } else {
                    [[UIColor colorWithWhite:(1- _fillHue) * [self brightnessWithIndex:i] * _darkFactor alpha:1] setStroke];
                }
                [path stroke];
                break;
            default:
                break;
        }
    }
    CGContextRestoreGState(context);
}

-(void) initFaces
{
    NSMutableArray *faces = [[NSMutableArray alloc] init];
    int facesCount = [self countOfFaces];
    for (int i = 0; i < facesCount; i++)
    {
        UIBezierPath *path = [[UIBezierPath alloc] init];
        [faces addObject:path];
    }
    _faces = [[NSArray alloc ] initWithArray:faces];
    for (int i = 0; i < facesCount; i++)
    {
        [self setFacePathWithIndex:i];
    }
}

- (void)setFacePathWithIndex:(NSUInteger)index
{
    NSAssert(NO, @"Subclass need to override this method...");
}

- (CGFloat)brightnessWithIndex:(NSUInteger)index
{
    NSAssert(NO, @"Subclass need to override this method...");
    return 0;
}

- (BOOL)needStrokeWithIndex:(NSUInteger)index
{
    return YES;
}

- (CGPoint)originalPoint
{
    NSAssert(NO, @"Subclass need to override this method...");
    return CGPointMake(0, 0);
}

-(uint) countOfFaces
{
    NSAssert(NO, @"Subclass need to override this method...");
    return 0;
}

@end
