//
//  XYSMetronomeView.m
//  Play Metronome
//
//  Created by Xu Yesheng on 7/13/14.
//  Copyright (c) 2014 yesheng. All rights reserved.
//

#import "XYSMetronomeView.h"

@implementation XYSMetronomeView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setBounds:CGRectMake(0, 0, 300, 400)];
        // upper casing
        _upperCasingView = [[XYSUpperCasingView alloc] initWithFrame:CGRectMake(0, 0, 300, 280)];
        
        // lower casing
        _lowerCasingView = [[XYSLowerCasingView alloc] initWithFrame:CGRectMake(0, 260, 300, 140)];
        
        // board
        _boardView = [[XYSBoardView alloc] initWithFrame:CGRectMake(110, 0, 80, 245)];
        
        // scale
        _scaleView = [[XYSScaleView alloc] initWithFrame:CGRectMake(0, 0, 80, 245)];
        
        // arm
        CGRect armViewFrame = CGRectMake(142, 35, 16, 310);
        _armView = [[XYSArmView alloc] initWithFrame:armViewFrame];
        
        // weight subview of arm
        CGRect weightFrameAbsolute = CGRectMake(130, 46, 40, 43);
        CGRect weightFrameRelated = CGRectMake(weightFrameAbsolute.origin.x - armViewFrame.origin.x, weightFrameAbsolute.origin.y - armViewFrame.origin.y, weightFrameAbsolute.size.width, weightFrameAbsolute.size.height);
        _weightView = [[XYSWeightView alloc] initWithFrame:weightFrameRelated];
        
        // blot
        _blotView = [[XYSBlotView alloc] initWithFrame:CGRectMake(210 - 10, 280 - 13, 60 + 10, 14 + 26)];
        
        // hint lines
        _hintLineView = [[XYSHintLineView alloc] initWithFrame:CGRectMake(0, 0, 300, 400)];
        
        [self addSubview:_hintLineView];
        [self addSubview:_upperCasingView];
        [self addSubview:_boardView];
        [_boardView addSubview:_scaleView];
        [self addSubview:_armView];
        [_armView addSubview:_weightView];
        [self addSubview:_blotView];
        [self addSubview:_lowerCasingView];
        
        // set weight center and rotation axis
        _weightCenter = [_weightView convertPoint:_weightView.centerPosition toView:self];
        _rotationAxis = [_armView convertPoint:_armView.armRotateAxis toView:self];
        
        // hit view set rotation axis
        [_hintLineView setRotationAxis:[self convertPoint:_rotationAxis toView:_hintLineView]];
        
        _currentWeightLocation = fabsf(_rotationAxis.y - _weightCenter.y);
        _currentBlotLocation = 0;
        
        // reset hold state
        _holdState = NOTHOLDING;
        
        // data keeper
        _dataKeeper = [XYSDataKeeper sharedInstance];
        
    }
    return self;
}

- (CGFloat)calculateAlphaWithLocation:(CGPoint) location
{
    CGFloat alpha = 0;
    if (_holdState >= HOLDARM)
        alpha = atan((double)(location.x - _rotationAxis.x) / (double)(_rotationAxis.y - location.y));
    else
        NSAssert(NO, @"holdState < WEIGHTVIEWHIT!");
    return alpha;
}

- (CGFloat)holdAlphaConstrain:(CGFloat)alpha
{
    if (alpha < - M_PI / 4)
        alpha = - M_PI / 4;
    if (alpha > M_PI / 4)
        alpha = M_PI / 4;
    return alpha;
}

- (CGFloat)locationToAxisConstrain:(CGFloat)locationToAxis
{
    CGFloat top = 215.5, buttom = 47.5;
    if (locationToAxis > top)
        locationToAxis = top;
    if (locationToAxis < buttom)
        locationToAxis = buttom;
    return locationToAxis;
}

- (void)transformWeightWithTempo:(uint)tempo
{
    float pointFromTop = [_scaleView pointFromTopWithTempo:tempo];
    float locationToAxis = 215.5 - pointFromTop;
    float weightCenterToAxis = fabsf(_rotationAxis.y - _weightCenter.y);
    float holdToWeightCenter = weightCenterToAxis - locationToAxis;
    [_weightView setTransform:CGAffineTransformTranslate(CGAffineTransformIdentity, 0, holdToWeightCenter)];
}

- (void)rotateArmWithAngle:(float)angle
{
    [_armView setTransform:CGAffineTransformRotate(CGAffineTransformIdentity, angle)];
}

/* if begin/sustain then unHold is NO
 * if end then unHold is YES
 */
- (void)holdingStateMachineWithUnHold:(BOOL)unHold location:(CGPoint)location
{
    HoldState preHoldState = _holdState;
    CGPoint armLocation;

    switch (preHoldState) {
        case NOTHOLDING:
            NSLog(@"Pre-state is NOTHOLDING");
            break;
        case HOLDING:
            // S: HOLDING -> NOTHOLDING
            if (unHold) {
                _holdState = NOTHOLDING;
                break;
            }
            // S: HOLDING -> HOLDBLOT
            if ([_blotView.layer.presentationLayer hitTest:location] != nil) {
                _holdState = HOLDBLOT;
                [_beatTextView highlight];
                break;
            }
            // S: HOLDING -> HOLDARM
            if ([_armView.layer.presentationLayer hitTest:location] != nil) {
                _holdState = HOLDARM;
            }
            // S: HOLDING -> HOLDWEIGHT
            armLocation = [self convertPoint:location toView:_armView];
            if ([_weightView.layer.presentationLayer hitTest:armLocation] != nil) {
                _holdState = HOLDWEIGHT;
                [_tempoTextView highlight];
            }
            
            // handling HOLDARM or HOLDWEIGHT
            if (_holdState >= HOLDARM) {
                if ([_dataKeeper beating]) {
                    [_dataKeeper setBeating:NO];
                }
                [_armView stopRotate];
                [_hintLineView appear];
            }
            break;
        case HOLDBLOT:
            // S: HOLDBLOT -> NOTHOLDING
            if (unHold) {
                _holdState = NOTHOLDING;
                [_beatTextView lowlight];
                break;
            }
            // S: HOLDBLOT
            uint beatNumber = [_blotView beatNumberFromLocationX:location.x];
            [_dataKeeper setBeat:beatNumber];
            break;
        case HOLDARM:
        case HOLDWEIGHT:
            // S: HOLDARM -> NOTHOLDING or
            // S: HOLDWEIGHT -> NOTHOLDING
            if (unHold) {
                if ([_armView willRotateWithAngle:[_dataKeeper rotateAngle]]) {
                    [_dataKeeper setBeating:YES];
                } else {
                    // just animate rotate to stable
                    [_armView startRotateWithAngle:[_dataKeeper rotateAngle] Duration:(CFTimeInterval)60 / [_dataKeeper tempo]];
                }
                if (preHoldState == HOLDWEIGHT) {
                    [_tempoTextView lowlight];
                }
                [_hintLineView disappear];
                _holdState = NOTHOLDING;
                break;
            }
            if (_rotationAxis.y <= location.y)
                break;
            // S: HOLDARM -> HOLDWEIGHT
            if (preHoldState == HOLDARM) {
                armLocation = [self convertPoint:location toView:_armView];
                if ([_weightView.layer.presentationLayer hitTest:armLocation] != nil) {
                    _holdState = HOLDWEIGHT;
                    [_tempoTextView highlight];
                }
            }
            // handling HOLDARM or HOLDWEIGHT
            if (_holdState == HOLDWEIGHT) {
                float locationToAxis = hypot(location.x - _rotationAxis.x, location.y - _rotationAxis.y);
                locationToAxis = [self locationToAxisConstrain:locationToAxis];
                
                float tempo = [_scaleView tempoWithPointFromTop:(215.5 - locationToAxis)];
                [_dataKeeper setTempo:tempo];
            }
            float holdAlpha = [self calculateAlphaWithLocation:location];
            holdAlpha = [self holdAlphaConstrain:holdAlpha];
            [_dataKeeper setRotateAngle:holdAlpha];
            break;
        default:
            NSAssert(NO, @"No such state...");
            break;
    }
}

- (void)holdingBegan:(CGPoint)location
{
    _holdState = HOLDING;
    [self holdingStateMachineWithUnHold:NO location:location];
}

- (void)holdingSustain:(CGPoint)location
{
    [self holdingStateMachineWithUnHold:NO location:location];
}

- (void)holdingChanged:(CGPoint)location
{
    [self holdingStateMachineWithUnHold:NO location:location];
}

- (void)holdingEnded:(CGPoint)location
{
    [self holdingStateMachineWithUnHold:YES location:location];
}


- (void)setCasingHue:(CGFloat)hue
{
    [_upperCasingView setFillHue:hue];
    [_upperCasingView setStrokeHue:hue];
    [_upperCasingView setNeedsDisplay];
    [_lowerCasingView setFillHue:hue];
    [_lowerCasingView setStrokeHue:hue];
    [_lowerCasingView setNeedsDisplay];
}

- (void)setBoardHue:(CGFloat)hue
{
    [_boardView setFillHue:hue];
    [_boardView setStrokeHue:hue];
    [_boardView setNeedsDisplay];
}

- (void)setWeightHue:(CGFloat)hue
{
    [_scaleView setFillHue:hue];
    [_scaleView setStrokeHue:hue];
    [_scaleView setNeedsDisplay];
    [_armView setFillHue:hue];
    [_armView setStrokeHue:hue];
    [_armView setNeedsDisplay];
    [_weightView setFillHue:hue];
    [_weightView setStrokeHue:hue];
    [_weightView setNeedsDisplay];
    [_blotView setFillHue:hue];
    [_blotView setStrokeHue:hue];
    [_blotView setNeedsDisplay];
}

- (void)darkCasing:(CGFloat)darkFactor
{
    [_upperCasingView setDarkFactor:darkFactor];
    [_upperCasingView setNeedsDisplay];
    [_lowerCasingView setDarkFactor:darkFactor];
    [_lowerCasingView setNeedsDisplay];
}

- (void)darkBoard:(CGFloat)darkFactor
{
    [_boardView setDarkFactor:darkFactor];
    [_boardView setNeedsDisplay];
}

- (void)brightenWeight:(CGFloat)darkFactor
{
    CGFloat brightenFactor = (0.2 * (1 - darkFactor)) + 1;
    [_scaleView setDarkFactor:brightenFactor];
    [_scaleView setNeedsDisplay];
    [_armView setDarkFactor:brightenFactor];
    [_armView setNeedsDisplay];
    [_weightView setDarkFactor:brightenFactor];
    [_weightView setNeedsDisplay];
    [_blotView setDarkFactor:brightenFactor];
    [_blotView setNeedsDisplay];
}

- (void)switchMode:(ViewMode)mode
{
    [_upperCasingView setViewMode:mode];
    [_upperCasingView setNeedsDisplay];
    [_lowerCasingView setViewMode:mode];
    [_lowerCasingView setNeedsDisplay];
    [_boardView setViewMode:mode];
    [_boardView setNeedsDisplay];
    [_scaleView setViewMode:mode];
    [_scaleView setNeedsDisplay];
    [_armView setViewMode:mode];
    [_armView setNeedsDisplay];
    [_weightView setViewMode:mode];
    [_weightView setNeedsDisplay];
    [_blotView setViewMode:mode];
    [_blotView setNeedsDisplay];
}
@end
