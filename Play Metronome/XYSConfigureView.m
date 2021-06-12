//
//  XYSConfigureView.m
//  Play Metronome
//
//  Created by Xu Yesheng on 7/9/14.
//  Copyright (c) 2014 yesheng. All rights reserved.
//

#import "XYSConfigureView.h"
#import "XYSSliderView.h"
#import "XYSALSoundMaker.h"

@implementation XYSConfigureView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //[self setBackgroundColor:[UIColor lightGrayColor]];
        [self setAlpha:0.9];
        [self setOpaque:NO];
        [self setBounds:CGRectMake(0, 0, 220, 400)];
        
        // data keeper
        _dataKeeper = [XYSDataKeeper sharedInstance];
        
        // store agent
        _storeAgent = [XYSStoreAgent sharedInstance];
        
        // metronome
        _metronomeView = [[XYSSmallMetronomeView alloc] initWithFrame:CGRectMake(20, 80, 30, 45)];

        
        // color sliders
        _casingSliderView = [[XYSSliderView alloc] initWithFrame:CGRectMake(80, 30, 10, 140)];
        [_casingSliderView setColorful:YES];
        _boardSliderView = [[XYSSliderView alloc] initWithFrame:CGRectMake(130, 30, 10, 140)];
        [_boardSliderView setColorful:YES];
        _weightSliderView = [[XYSSliderView alloc] initWithFrame:CGRectMake(180, 30, 10, 140)];
        [_weightSliderView setColorful:YES];
        
        // speaker
        _speakerWaveView = [[XYSSpeakerView alloc] initWithFrame:CGRectMake(60, 230, 30, 30)];
        _speakerOnlyView = [[XYSSpeakerView alloc] initWithFrame:CGRectMake(60, 340, 30, 30)];
        [_speakerOnlyView setWithWave:NO];
        
        // volume slider view
        _volumeSliderView = [[XYSSliderView alloc] initWithFrame:CGRectMake(60, 270, 26, 65)];
        [[_volumeSliderView thumbView] translateWithDy:5];
        
        // bulb
        _bulbRayView = [[XYSBulbView alloc] initWithFrame:CGRectMake(108, 230 - 2, 30, 30)];
        _bulbOnlyView = [[XYSBulbView alloc] initWithFrame:CGRectMake(108, 340 - 2, 30, 30)];
        [_bulbOnlyView setWithRay:NO];
        
        // brightness slider
        _brightnessSliderView = [[XYSSliderView alloc] initWithFrame:CGRectMake(110, 270, 26, 65)];
        [[_brightnessSliderView thumbView] translateWithDy:5];
        
        // default is not purchased
        /* add small metronome icons */
        XYSSmallMetronomeView *metroView0 = [[XYSSmallMetronomeView alloc] initWithFrame:CGRectMake(20, 180, 30, 45)];
        [metroView0 setTransform:CGAffineTransformScale(CGAffineTransformIdentity, 0.7, 0.7)];
        XYSSmallMetronomeView *metroView1 = [[XYSSmallMetronomeView alloc] initWithFrame:CGRectMake(60, 180, 30, 45)];
        [metroView1 setTransform:CGAffineTransformScale(CGAffineTransformIdentity, 0.7, 0.7)];
        XYSSmallMetronomeView *metroView2 = [[XYSSmallMetronomeView alloc] initWithFrame:CGRectMake(100, 180, 30, 45)];
        [metroView2 setTransform:CGAffineTransformScale(CGAffineTransformIdentity, 0.7, 0.7)];
        XYSSmallMetronomeView *metroView3 = [[XYSSmallMetronomeView alloc] initWithFrame:CGRectMake(140, 180, 30, 45)];
        [metroView3 setTransform:CGAffineTransformScale(CGAffineTransformIdentity, 0.7, 0.7)];
        XYSSmallMetronomeView *metroView4 = [[XYSSmallMetronomeView alloc] initWithFrame:CGRectMake(180, 180, 30, 45)];
        [metroView4 setTransform:CGAffineTransformScale(CGAffineTransformIdentity, 0.7, 0.7)];
        [metroView0 setHidden:YES];
        [metroView1 setHidden:YES];
        [metroView2 setHidden:YES];
        [metroView3 setHidden:YES];
        [metroView4 setHidden:YES];
        _metronomeIcons = [[NSArray alloc] initWithObjects:metroView0, metroView1, metroView2, metroView3, metroView4, nil];
        
        // timber button
        _timbreView = [[XYSTimbreView alloc] initWithFrame:CGRectMake(160, 225, 40, 30)];
        
        // switch button
        _switchButtonView = [[XYSSwitchButtonView alloc] initWithFrame:CGRectMake(160, 255, 40, 40)];
        
        // manual button
        _manButtonView = [[XYSManButtonView alloc] initWithFrame:CGRectMake(160, 295, 40, 40)];
        
        _purchaseButtonView = [[XYSPurchaseButtonView alloc] initWithFrame:CGRectMake(160, 335, 40, 40)];
        
        // tempo light view
        _tempoLightView = [[XYSTempoLightView alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
        
        // man view
        _manView = [[XYSManView alloc] initWithFrame:CGRectMake(220, 20, 220, 360)];
        
        // purchase view
        _purchaseView = [[XYSPurchaseView alloc] initWithFrame:CGRectMake(220, 20, 220, 360)];
        
        
        [self addSubview:_metronomeView];
        [self addSubview:_casingSliderView];
        [self addSubview:_boardSliderView];
        [self addSubview:_weightSliderView];
        [self addSubview:_bulbRayView];
        [self addSubview:_bulbOnlyView];
        [self addSubview:_speakerWaveView];
        [self addSubview:_speakerOnlyView];
        [self addSubview:_brightnessSliderView];
        [self addSubview:_volumeSliderView];
        [self addSubview:_timbreView];
        [self addSubview:_switchButtonView];
        [self addSubview:_manButtonView];
        [self addSubview:_tempoLightView];
        [self addSubview:metroView0];
        [self addSubview:metroView1];
        [self addSubview:metroView2];
        [self addSubview:metroView3];
        [self addSubview:metroView4];
        [self addSubview:_purchaseButtonView];
        [self addSubview:_manView];
        [self addSubview:_purchaseView];
        
        _slideState = NOTSLIDING;
        _manOn = NO;
        _purchaseOn = NO;
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    UIBezierPath *deskPath = [[UIBezierPath alloc] init];
    [deskPath appendPath:[UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, 220, 400) byRoundingCorners:UIRectCornerTopLeft | UIRectCornerBottomLeft cornerRadii:CGSizeMake(10, 20)]];
    
    UIBezierPath *splitterPaths = [[UIBezierPath alloc] init];
    
    [splitterPaths moveToPoint:CGPointMake(0, 20)];
    [splitterPaths addLineToPoint:CGPointMake(220, 20)];
    
    [splitterPaths moveToPoint:CGPointMake(0, 180)];
    [splitterPaths addLineToPoint:CGPointMake(220, 180)];
    
    [splitterPaths moveToPoint:CGPointMake(0, 220)];
    [splitterPaths addLineToPoint:CGPointMake(220, 220)];
    
    [splitterPaths moveToPoint:CGPointMake(0, 380)];
    [splitterPaths addLineToPoint:CGPointMake(220, 380)];
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    [[UIColor darkGrayColor] setFill];
    [deskPath fill];
    [[UIColor whiteColor] setStroke];
    [splitterPaths stroke];
    CGContextRestoreGState(context);
}

- (void)holdingBegan:(CGPoint)location
{
    // hit manual view
    if ([_manView.layer hitTest:location] != nil) {
        if (_manOn) {
            [_manView startTranslateWithDx:220 Dy:0];
            _manOn = NO;
        }
    }
    // hit purchase view
    else if ([_purchaseView.layer hitTest:location] != nil) {
        if (_purchaseOn) {
            CGPoint purchaseLocation = [self convertPoint:location toView:_purchaseView];
            // hit buy
            if ([_purchaseView.buyButton.layer hitTest:purchaseLocation] != nil)
            {
                [_purchaseView.buyButton highLight:YES];
                [_purchaseView.buyButton setNeedsDisplay];
                [_switchButtonView setNeedsDisplay];
                _slideState = HITBUY;
            }
            // hit restore
            else if ([_purchaseView.restoreButton.layer hitTest:purchaseLocation] != nil)
            {
                [_purchaseView.restoreButton highLight:YES];
                [_purchaseView.restoreButton setNeedsDisplay];
                _slideState = HITRESTORE;
            }
            // hit cancel
            else if ([_purchaseView.cancelButton.layer hitTest:purchaseLocation] != nil)
            {
                [_purchaseView.cancelButton highLight:YES];
                [_purchaseView.cancelButton setNeedsDisplay];
                _slideState = HITCANCEL;
            }
            
        }
    }
    // hit casing slider
    else if ([_casingSliderView.layer hitTest:location] != nil)
    {
        _slideState = SLIDECASING;
    }
    // hit board slider
    else if ([_boardSliderView.layer hitTest:location] != nil)
    {
        _slideState = SLIDEBOARD;
    }
    // hit weight slider
    else if ([_weightSliderView.layer hitTest:location] != nil)
    {
        _slideState = SLIDEWEIGHT;
    }
    // hit brightness slider
    else if ([_brightnessSliderView.layer hitTest:location] != nil)
    {
        _slideState = SLIDEBRIGHTNESS;
    }
    // hit volume slider
    else if ([_volumeSliderView.layer hitTest:location] != nil)
    {
        _slideState = SLIDEVOLUME;
    }
    // hit swicth button
    else if ([_switchButtonView.layer hitTest:location] != nil)
    {
        [_switchButtonView highLight:YES];
        [_switchButtonView setNeedsDisplay];
        _slideState = HITSWITCH;
    }
    // hit purchase button
    else if ([_purchaseButtonView.layer hitTest:location] != nil)
    {
        [_purchaseButtonView highLight:YES];
        [_purchaseButtonView setNeedsDisplay];
        _slideState = HITPURCHASE;
    }
    // hit man button
    else if ([_manButtonView.layer hitTest:location] != nil)
    {
        [_manButtonView highLight:YES];
        [_manButtonView setNeedsDisplay];
        _slideState = HITMAN;
    }
    else if ([_dataKeeper purchased]) {
        // list of small metronomes icons
        for (int i = 0; i < [_metronomeIcons count]; i++) {
            XYSSmallMetronomeView *metroView = _metronomeIcons[i];
            if ([metroView.layer hitTest:location] != nil) {
                [_dataKeeper setFocusIndex:i];
                NSLog(@"foucusIndex = %d", [_dataKeeper focusIndex]);
            }
        }
    }
    
}

- (void)holdingChanged:(CGPoint)location
{
    float percentage = 0;
    CGPoint subviewLocation;
    switch (_slideState) {
        case SLIDECASING:
            subviewLocation = [self convertPoint:location toView:_casingSliderView];
            percentage = [_casingSliderView getPercentageValueFromLocation:subviewLocation];
            [_dataKeeper setCasingHue:percentage];
            break;
        case SLIDEBOARD:
            subviewLocation = [self convertPoint:location toView:_boardSliderView];
            percentage = [_boardSliderView getPercentageValueFromLocation:subviewLocation];
            [_dataKeeper setBoardHue:percentage];
            break;
        case SLIDEWEIGHT:
            subviewLocation = [self convertPoint:location toView:_weightSliderView];
            percentage = [_weightSliderView getPercentageValueFromLocation:subviewLocation];
            [_dataKeeper setWeightHue:percentage];
            break;
        case SLIDEBRIGHTNESS:
            subviewLocation = [self convertPoint:location toView:_brightnessSliderView];
            percentage = [_brightnessSliderView getPercentageValueFromLocation:subviewLocation];
            [_dataKeeper setBrightness:(1 - percentage)];
            break;
        case SLIDEVOLUME:
            subviewLocation = [self convertPoint:location toView:_volumeSliderView];
            percentage = [_volumeSliderView getPercentageValueFromLocation:subviewLocation];
            [_dataKeeper setVolume:(1 - percentage)];
            break;
        default:
            break;
    }
}

- (void)holdingEnded:(CGPoint)location
{
    XYSALSoundMaker *alSoundMaker = [XYSALSoundMaker sharedInstance];
    switch (_slideState) {
        case SLIDECASING:
        case SLIDEBOARD:
        case SLIDEWEIGHT:
        case SLIDEBRIGHTNESS:
        case SLIDEVOLUME:
            break;
        case HITSWITCH:
            [_switchButtonView highLight:NO];
            [_switchButtonView setNeedsDisplay];
            uint soundIndex = [alSoundMaker nextClickSoundId];
            [_dataKeeper setSoundIndex:soundIndex];
            break;
        case HITPURCHASE:
            [_purchaseButtonView highLight:NO];
            [_purchaseButtonView setNeedsDisplay];
            //[_dataKeeper setPurchased:YES];
            if (!_purchaseOn) {
                _purchaseOn = YES;
                if ([_storeAgent purchaseState] == PURCHASE_IDLE) {
                    [_storeAgent changeState:PROD_REQUESTING];
                }
                [_purchaseView appear];
            } else {
                _purchaseOn = NO;
                [_purchaseView hide];
            }
            break;
        case HITMAN:
            [_manButtonView highLight:NO];
            [_manButtonView setNeedsDisplay];
            if (!_manOn) {
                [_manView appear];
                _manOn = YES;
            } else {
                [_manView hide];
                [_manView startTranslateWithDx:220 Dy:0];
                _manOn = NO;
            }
            break;
        case HITBUY:
            if ([_storeAgent purchaseState] == PROD_REQUESTED) {
                [_storeAgent changeState:PAY_REQUESTING];
            }
            [_purchaseView.buyButton highLight:NO];
            [_purchaseView.buyButton setNeedsDisplay];
            break;
        case HITRESTORE:
            if ([_storeAgent purchaseState] == PROD_REQUESTED) {
                [_storeAgent changeState:RESTORE_REQUESTING];
            }
            [_purchaseView.restoreButton highLight:NO];
            [_purchaseView.restoreButton setNeedsDisplay];
            break;
        case HITCANCEL:
            [_storeAgent changeState:PURCHASE_IDLE];
            [_purchaseView.cancelButton highLight:NO];
            [_purchaseView.cancelButton setNeedsDisplay];
            [_purchaseView startTranslateWithDx:220 Dy:0];
            _purchaseOn = NO;
            break;
        default:
            break;
    }
    _slideState = NOTSLIDING;
}

@end
