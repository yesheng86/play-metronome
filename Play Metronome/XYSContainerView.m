//
//  XYSContainerView.m
//  Play Metronome
//
//  Created by Xu Yesheng on 7/26/14.
//  Copyright (c) 2014 yesheng. All rights reserved.
//

#import "XYSContainerView.h"
#import "XYSDataKeeper.h"

@implementation XYSContainerView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setBounds:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        
        // sometimes we get app frame size smaller than screen size even we disable status bar
        float statusBarHeight = [[UIScreen mainScreen] bounds].size.height - [[UIScreen mainScreen] applicationFrame].size.height;
        if ((uint)statusBarHeight != 0 && (uint)statusBarHeight != 20) {
            NSLog(@"Oops, status bar height is unexpected! %f", statusBarHeight);
        }
        uint screenHeight = (uint)[[UIScreen mainScreen] bounds].size.height;
        
        switch (screenHeight) {
            case 480: // 320 * 480
                _screenSize = SZ480;
                
                _tempoTextFrame = CGRectMake(40, 10 - statusBarHeight, 60, 50);
                _beatTextFrame = CGRectMake(220, 10 - statusBarHeight, 60, 50);
                _metronomeFrame = CGRectMake(17.5, 30 - statusBarHeight, 285, 380);
                _configureFrame = CGRectMake(320, 30 - statusBarHeight, 209, 380);
                _gearIconFrame = CGRectMake(140, 420 - statusBarHeight, 40, 40);
                _tempoDy = 5;
                _beatDy = 5;
                _metronomeDy = 20;
                _configureDy = 20;
                _gearDy = 32;
                _scaleFactor = 0.95;
                break;
            case 568: // 320 * 568
                _screenSize = SZ568;
                
                _tempoTextFrame = CGRectMake(90, 20 - statusBarHeight, 60, 50);
                _beatTextFrame = CGRectMake(170, 20 - statusBarHeight, 60, 50);
                _metronomeFrame = CGRectMake(10, 80 - statusBarHeight, 300, 400);
                _configureFrame = CGRectMake(320, 80 - statusBarHeight, 220, 400);
                _gearIconFrame = CGRectMake(140, 490 - statusBarHeight, 40, 40);
                _tempoDy = 5;
                _beatDy = 5;
                _metronomeDy = 10;
                _configureDy = 10;
                _gearDy = 17;
                _scaleFactor = 1.0;
                break;
            case 667: // 375 * 667
                _screenSize = SZ667;
                
                _tempoTextFrame = CGRectMake(103, 30 - statusBarHeight, 72, 60);
                _beatTextFrame = CGRectMake(200, 30 - statusBarHeight, 72, 60);
                _metronomeFrame = CGRectMake(7.5, 105 - statusBarHeight, 360, 480);
                _configureFrame = CGRectMake(375, 105 - statusBarHeight, 264, 480);
                _gearIconFrame = CGRectMake(163.5, 600 - statusBarHeight, 48, 48);
                _tempoDy = 10;
                _beatDy = 10;
                _metronomeDy = 20;
                _configureDy = 20;
                _gearDy = 30;
                _scaleFactor = 1.2;
                break;
            case 736: // 414 * 736
                _screenSize = SZ736;
                
                _tempoTextFrame = CGRectMake(116, 35 - statusBarHeight, 78, 65);
                _beatTextFrame = CGRectMake(220, 35 - statusBarHeight, 78, 65);
                _metronomeFrame = CGRectMake(12, 130 - statusBarHeight, 390, 520);
                _configureFrame = CGRectMake(414, 130 - statusBarHeight, 286, 520);
                _gearIconFrame = CGRectMake(181, 670 - statusBarHeight, 52, 52);
                _tempoDy = 10;
                _beatDy = 10;
                _metronomeDy = 20;
                _configureDy = 20;
                _gearDy = 32;
                _scaleFactor = 1.3;
                break;
            case 1024: // 768 * 1024
                _screenSize = SZ1024;
                
                _tempoTextFrame = CGRectMake(260, 50 - statusBarHeight, 108, 90);
                _beatTextFrame = CGRectMake(400, 50 - statusBarHeight, 108, 90);
                _metronomeFrame = CGRectMake(114, 160 - statusBarHeight, 540, 720);
                _configureFrame = CGRectMake(768, 160 - statusBarHeight, 396, 720);
                _gearIconFrame = CGRectMake(348, 900 - statusBarHeight, 72, 72);
                _tempoDy = 5;
                _beatDy = 5;
                _metronomeDy = 10;
                _configureDy = 10;
                _gearDy = 15;
                _scaleFactor = 1.8;
                break;
            default:
                _screenSize = SZUNKNOWN;
                NSAssert(NO, @"Unknown screen resolution with height %d...", screenHeight);
                break;
        }
        
        
        // tempo text view
        _tempoTextView = [[XYSTextView alloc] initWithFrame:_tempoTextFrame];
        [_tempoTextView setLabel:@"TEMPO"];
        [_tempoTextView setText:@"40"];
        [_tempoTextView setAlignment:kCAAlignmentRight];
        [_tempoTextView lowlight];
        [_tempoTextView setTransform:CGAffineTransformScale([_tempoTextView transform], _scaleFactor, _scaleFactor)];
        
        // beat text view
        _beatTextView = [[XYSTextView alloc] initWithFrame:_beatTextFrame];
        [_beatTextView setLabel:@"BEAT"];
        [_beatTextView setText:@"0"];
        [_beatTextView setAlignment:NSTextAlignmentLeft];
        [_beatTextView lowlight];
        [_beatTextView setTransform:CGAffineTransformScale([_beatTextView transform], _scaleFactor, _scaleFactor)];
        
        // metronome view
        _metronomeView = [[XYSMetronomeView alloc] initWithFrame:_metronomeFrame];
        [_metronomeView setTransform:CGAffineTransformScale([_metronomeView transform], _scaleFactor, _scaleFactor)];
        
        // configure view
        _configureView = [[XYSConfigureView alloc] initWithFrame:_configureFrame];
        [_configureView setTransform:CGAffineTransformScale([_configureView transform], _scaleFactor, _scaleFactor)];
        
        // gear icon view
        _gearIconView = [[XYSGearIconView alloc] initWithFrame:_gearIconFrame];
        [_gearIconView setTransform:CGAffineTransformScale([_gearIconView transform], _scaleFactor, _scaleFactor)];
        
        
        _adView = [[XYSAdView alloc] init];
        if (_screenSize == SZ1024) {
            //ipad banner height is 66
            [_adView setHeight:66];
        }
        else {
            // iphone banner height is 50
            [_adView setHeight:50];
        }
        [_adView setFrame:CGRectMake(0, screenHeight, self.bounds.size.width, [_adView height])];
        
        // add subviews
        [self addSubview:_tempoTextView];
        [self addSubview:_beatTextView];
        [self addSubview:_metronomeView];
        [self addSubview:_gearIconView];
        [self addSubview:_configureView];
        [self addSubview:_adView];
        [self addSubview:_tempoLightView];
        [_metronomeView setBeatTextView:_beatTextView];
        [_metronomeView setTempoTextView:_tempoTextView];
        
        // set opaque
        [[self layer] setOpaque:NO];
        
    }
    return self;
}

- (void)hitGearIconView
{
    if (_configOn == NO) {
        _configOn = YES;
        [_gearIconView startSpin:-M_PI_2];
        [_metronomeView startTranslateWithDx:-120 Dy:0];
        [_configureView startTranslateWithDx:-(_configureView.bounds.size.width) Dy:0];
        if (_screenSize == SZ480)
        {
            [_tempoTextView startTranslateWithDx:50 Dy:0];
            [_beatTextView startTranslateWithDx:-50 Dy:0];
        }
    }
    else
    {
        _configOn = NO;
        [_gearIconView startSpin:M_PI_2];
        [_metronomeView startTranslateWithDx:120 Dy:0];
        [_configureView startTranslateWithDx:_configureView.bounds.size.width Dy:0];
        if (_screenSize == SZ480)
        {
            [_tempoTextView startTranslateWithDx:-50 Dy:0];
            [_beatTextView startTranslateWithDx:50 Dy:0];
        }
        if ([_configureView manOn]) {
            [_configureView.manView hide];
            [_configureView setManOn:NO];
        }
        if ([_configureView purchaseOn]) {
            [_configureView.purchaseView hide];
            [[XYSStoreAgent sharedInstance] setPurchaseState:PURCHASE_IDLE];
            [_configureView setPurchaseOn:NO];
        }
    }
}

- (void)holdingBegan:(CGPoint)location
{
    // configure view began
    if ([_configureView.layer.presentationLayer hitTest:location] != nil
        && _configOn == YES)
    {
        CGPoint configureLocation = [self convertPoint:location toView:_configureView];
        [_configureView holdingBegan:configureLocation];
    }
    
    // configure metronome began
    else if ([_metronomeView.layer.presentationLayer hitTest:location] != nil)
    {
        CGPoint metronomeLocation = [self convertPoint:location toView:_metronomeView];
        [_metronomeView holdingBegan:metronomeLocation];
        if (_configOn == YES) {
            [self hitGearIconView];
        }
    }
    
    // turn on/off configure view
    else if (([_gearIconView.layer.presentationLayer hitTest:location] != nil
             && _configOn == NO) || (_configOn == YES))
    {
        [self hitGearIconView];
    }
}

-(void)holdingSustain:(CGPoint)location
{
    // metronome view sustain holding
    if ([_metronomeView.layer.presentationLayer hitTest:location] != nil
        && _configOn == NO)
    {
        CGPoint metronomeLocation = [self convertPoint:location toView:_metronomeView];
        [_metronomeView holdingSustain:metronomeLocation];
    }
}

-(void)holdingChanged:(CGPoint)location
{
    // metronome view changed
    if ([_metronomeView.layer.presentationLayer hitTest:location] != nil
        && _configOn == NO)
    {
        CGPoint metronomeLocation = [self convertPoint:location toView:_metronomeView];
        [_metronomeView holdingChanged:metronomeLocation];
    }
    
    // configure view began
    else if ([_configureView.layer.presentationLayer hitTest:location] != nil
        && _configOn == YES)
    {
        CGPoint configureLocation = [self convertPoint:location toView:_configureView];
        [_configureView holdingChanged:configureLocation];
    }
}

-(void)holdingEnded:(CGPoint)location
{
    // metronome view ended
    if (_configOn == NO)
    {
        CGPoint metronomeLocation = [self convertPoint:location toView:_metronomeView];
        [_metronomeView holdingEnded:metronomeLocation];
    }
    
    // configure view end
    else if ([_configureView.layer.presentationLayer hitTest:location] != nil
        && _configOn == YES)
    {
        CGPoint configureLocation = [self convertPoint:location toView:_configureView];
        [_configureView holdingEnded:configureLocation];
    }
}

-(void)holdingCancelled:(CGPoint)location
{
    // metronome view cancelled treated as ended
    if ([_metronomeView.layer.presentationLayer hitTest:location] != nil
        && _configOn == NO)
    {
        CGPoint metronomeLocation = [self convertPoint:location toView:_metronomeView];
        [_metronomeView holdingEnded:metronomeLocation];
        return;
    }
    
    // configure view began
    else if ([_configureView.layer.presentationLayer hitTest:location] != nil
        && _configOn == YES)
    {
        CGPoint configureLocation = [self convertPoint:location toView:_configureView];
        [_configureView holdingEnded:configureLocation];
    }
}

- (void) layoutAnimateAdIn
{
    [_adView startTranslateWithDx:0 Dy:-[_adView height]];
    [_tempoTextView startTranslateWithDx:0 Dy:-_tempoDy];
    [_beatTextView startTranslateWithDx:0 Dy:-_beatDy];
    [_metronomeView startTranslateWithDx:0 Dy:-_metronomeDy];
    [_configureView startTranslateWithDx:0 Dy:-_configureDy];
    [_gearIconView startTranslateWithDx:0 Dy:-_gearDy];
    [self setNeedsLayout];
    [self.adView setNeedsLayout];
}

- (void) layoutAnimateAdOut
{
    [_adView startTranslateWithDx:0 Dy:[_adView height]];
    [_tempoTextView startTranslateWithDx:0 Dy:_tempoDy];
    [_beatTextView startTranslateWithDx:0 Dy:_beatDy];
    [_metronomeView startTranslateWithDx:0 Dy:_metronomeDy];
    [_configureView startTranslateWithDx:0 Dy:_configureDy];
    [_gearIconView startTranslateWithDx:0 Dy:_gearDy];
    [self setNeedsLayout];
    [self.adView setNeedsLayout];
}
@end
