//
//  XYSWeightView.m
//  Play Metronome
//
//  Created by Xu Yesheng on 5/31/14.
//  Copyright (c) 2014 yesheng. All rights reserved.
//

#import "XYSWeightView.h"

@implementation XYSWeightView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.layer.anchorPoint = CGPointMake(0.5, 0.5);
        // frame will change along with anchor point... so set it back
        self.layer.frame = frame;
        self.centerPosition = CGPointMake(frame.size.width / 2, frame.size.height / 2);
        [self setSaturation:0.3];
        [self setBrightnessDelta:0.4];
    }
     return self;
}

/*
- (void)updateAnchorPointY:(CGFloat)y
{
    CGRect frame = self.layer.frame;
    self.layer.anchorPoint = CGPointMake(0.5, (y - self.layer.frame.origin.y) / self.frame.size.height);
    self.layer.frame = frame;
    NSLog(@"Weight anchor point(%f, %f) position(%f, %f)", self.layer.anchorPoint.x, self.layer.anchorPoint.y, self.layer.position.x, self.layer.position.y);
}


- (void)translateAnchorPointY:(CGFloat)y
{
    NSLog(@"frame (%f, %f)", self.frame.origin.x, self.frame.origin.y);
    NSLog(@"AnchorPoint from (%f, %f)", self.layer.anchorPoint.x, self.layer.anchorPoint.y);
    self.layer.position = CGPointMake(self.layer.anchorPoint.x, self.layer.anchorPoint.y + y);
    NSLog(@"translatePosition to (%f, %f)", self.layer.anchorPoint.x, self.layer.anchorPoint.y);
}
*/

- (NSUInteger)countOfFaces
{
    return 2;
}

- (CGPoint)originalPoint
{
    return CGPointMake(20, 5);
}

- (void)setFacePathWithIndex:(NSUInteger)index
{
    UIBezierPath *face = self.faces[index];
    switch (index) {
        case 0:
            [face moveToPoint:CGPointMake(-15, 3)];
            [face addLineToPoint:CGPointMake(15, 3)];
            [face addLineToPoint:CGPointMake(15, 28)];
            [face addArcWithCenter:CGPointMake(10, 28) radius:5 startAngle:0 endAngle:0.5 * M_PI clockwise:YES];
            [face addLineToPoint:CGPointMake(-10, 33)];
            [face addArcWithCenter:CGPointMake(-10, 28) radius:5 startAngle:0.5 * M_PI endAngle:M_PI clockwise:YES];
            [face addLineToPoint:CGPointMake(-15, 3)];
            break;
        case 1:
            [face moveToPoint:CGPointMake(-15, 3)];
            [face addLineToPoint:CGPointMake(-12, 0)];
            [face addLineToPoint:CGPointMake(12, 0)];
            [face addLineToPoint:CGPointMake(15, 3)];
            [face addLineToPoint:CGPointMake(-15, 3)];
            
            break;
        default:
            break;
    }
}

- (CGFloat) brightnessWithIndex:(NSUInteger)index
{
    CGFloat brightness = 0;
    switch (index) {
        case 0:
            brightness = 0.8;
            break;
        case 1:
            brightness = 0.9;
            break;
        default:
            break;
    }
    return brightness;
}

-(BOOL) shapeIsHitByPoint:(CGPoint)point afterTransform:(CATransform3D)transform
{
    return NO;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
