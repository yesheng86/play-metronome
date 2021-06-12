//
//  XYSViewController.m
//  Play Metronome
//
//  Created by Xu Yesheng on 5/24/14.
//  Copyright (c) 2014 yesheng. All rights reserved.
//

#import "XYSViewController.h"
#import <Foundation/NSNotification.h>
#import <AVFoundation/AVFoundation.h>

@implementation ProcessingParameter

+ (ProcessingParameter *)processParameterWithState:(PurchaseState)state Info:(NSString *)info Error:(NSString *)error Timeout:(NSTimeInterval)timeout
{
    ProcessingParameter *processParameter = [[ProcessingParameter alloc] init];
    [processParameter setPurchaseState:state];
    [processParameter setInfoMessage:info];
    [processParameter setErrorMessage:error];
    [processParameter setTimeout:timeout];
    return processParameter;
}

@end

@implementation XYSViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSLog(@"viewDidLoad");
    // hide status bar
    [[UIApplication sharedApplication] setStatusBarHidden:YES];

    // init audio session
    [self initAudioSession];
    
    // disable auto lock
    //[[UIApplication sharedApplication] setIdleTimerDisabled:YES];
    
    // attach background view exclude status bar
    _containerView = [[XYSContainerView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    [self.view addSubview:_containerView];
    _metronomeView = [_containerView metronomeView];
    
    // add AD subview
    //_containerView.adView = [[XYSAdView alloc] initWithFrame:CGRectMake(0, _containerView.bounds.size.height, 320, 20)];
    //[_containerView addSubview:_containerView.adView];
    //_containerView.adView.adBannerView.delegate = self;
    
    [_containerView.adView.adBannerView setDelegate:self];
    
    // get sound maker
    _alSoundMaker = [XYSALSoundMaker sharedInstance];
    
    // get data keeper
    _dataKeeper = [XYSDataKeeper sharedInstance];
    
    // get store agent
    _storeAgent = [XYSStoreAgent sharedInstance];
    [_storeAgent setDelegate:self];
    
    // setup color KVO
    [self setupKVO];
    
    // load data after view setup
    [_dataKeeper loadData];
    
    // update switch button number
    [_containerView.configureView.switchButtonView updateText:[_dataKeeper soundIndex]];
    
    _interrupted = NO;
    _inBackground = NO;
}

- (BOOL)prefersStatusBarHidden
{
    return YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    /*
     [[UIApplication sharedApplication] beginReceivingRemoteControlEvents];
     [self becomeFirstResponder];
     */
}

- (void)switchViewMode:(ViewMode)mode
{
    switch (mode) {
        case COLORMODE:
            [_containerView.configureView.metronomeView switchMode:COLORMODE];
            [_containerView.metronomeView switchMode:COLORMODE];
            [_containerView.gearIconView setColorful:YES];
            [_containerView.gearIconView setNeedsDisplay];
            [_containerView.configureView.casingSliderView setColorful:YES];
            [_containerView.configureView.boardSliderView setColorful:YES];
            [_containerView.configureView.weightSliderView setColorful:YES];
            break;
        case GREYMODE:
            [_containerView.configureView.metronomeView switchMode:GREYMODE];
            [_containerView.metronomeView switchMode:GREYMODE];
            [_containerView.gearIconView setColorful:NO];
            [_containerView.gearIconView setNeedsDisplay];
            [_containerView.configureView.casingSliderView setColorful:NO];
            [_containerView.configureView.boardSliderView setColorful:NO];
            [_containerView.configureView.weightSliderView setColorful:NO];
            break;
        case DRAFTMODE:
            [_containerView.configureView.metronomeView switchMode:DRAFTMODE];
            [_containerView.metronomeView switchMode:DRAFTMODE];
            [_containerView.gearIconView setColorful:NO];
            [_containerView.gearIconView setNeedsDisplay];
            [_containerView.configureView.casingSliderView setColorful:NO];
            [_containerView.configureView.boardSliderView setColorful:NO];
            [_containerView.configureView.weightSliderView setColorful:NO];
            break;
        default:
            break;
    }
}

/* touch events routing */

- (void)displayLinkCallback
{
    [_containerView holdingSustain:_holdLocation];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    _holdLocation = [touch locationInView:_containerView];
    [_containerView holdingBegan:_holdLocation];
    // create display link
    _displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(displayLinkCallback)];
    [_displayLink setFrameInterval:1];
    [_displayLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
    _displayLinkWorking = YES;
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    _holdLocation = [touch locationInView:_containerView];
    [_containerView holdingChanged:_holdLocation];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    _holdLocation = [touch locationInView:_containerView];
    [_containerView holdingEnded:_holdLocation];
    if (_displayLinkWorking && _displayLink != nil) {
        [_displayLink removeFromRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
        _displayLinkWorking = NO;
    }
}

- (void)clearDisplayLink
{
    if (_displayLinkWorking && _displayLink != nil) {
        [_displayLink removeFromRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
        _displayLinkWorking = NO;
    }
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self touchesEnded:touches withEvent:event];
}


/* KVO handling */
- (void)setupKVO
{
    // color change
    [self addObserver:self forKeyPath:@"dataKeeper.casingHue" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:NULL];
    [self addObserver:self forKeyPath:@"dataKeeper.boardHue" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:NULL];
    [self addObserver:self forKeyPath:@"dataKeeper.weightHue" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:NULL];
    
    // brightness change
    [self addObserver:self forKeyPath:@"dataKeeper.brightness" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:NULL];
    
    // volume change
    [self addObserver:self forKeyPath:@"dataKeeper.volume" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:NULL];
    
    // metronome beating
    [self addObserver:self forKeyPath:@"dataKeeper.beating" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:NULL];
    
    // beat number
    [self addObserver:self forKeyPath:@"dataKeeper.beat" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:NULL];
    
    // tempo number
    [self addObserver:self forKeyPath:@"dataKeeper.tempo" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:NULL];
    
    // rotate angle
    [self addObserver:self forKeyPath:@"dataKeeper.rotateAngle" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:NULL];
    
    // rotate angle
    [self addObserver:self forKeyPath:@"dataKeeper.soundIndex" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:NULL];
    
    // metronome item focus index
    [self addObserver:self forKeyPath:@"dataKeeper.focusIndex" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:NULL];
    
    // purchased
    [self addObserver:self forKeyPath:@"dataKeeper.purchased" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:NULL];
}

- (void)redrawMetronomeIcons
{
    // redraw metronome icon views
    NSArray *metronomeIcons = [_containerView.configureView metronomeIcons];
    float ch, bh, wh;
    for (int i = 0; i < [metronomeIcons count]; i++) {
        ch = [[_dataKeeper valueForKey:[NSString stringWithFormat:@"ch%d", i]] floatValue];
        bh = [[_dataKeeper valueForKey:[NSString stringWithFormat:@"bh%d", i]] floatValue];
        wh = [[_dataKeeper valueForKey:[NSString stringWithFormat:@"wh%d", i]] floatValue];
        XYSSmallMetronomeView *mv = [metronomeIcons objectAtIndex:i];
        [mv setCasingHue:ch];
        [mv setBoardHue:bh];
        [mv setWeightHue:wh];
        
        if (i == [_dataKeeper focusIndex]) {
            [_containerView.configureView.metronomeView setCasingHue:ch];
            [_containerView.configureView.metronomeView setBoardHue:bh];
            [_containerView.configureView.metronomeView setWeightHue:wh];
            [mv setFocus:YES];
            [mv setNeedsDisplay];
            [_containerView.metronomeView setCasingHue:ch];
            [_containerView.metronomeView setBoardHue:bh];
            [_containerView.metronomeView setWeightHue:wh];
        }
        
        // grey mode view
        if (i == 3) {
            [mv switchMode:GREYMODE];
            if (3 == [_dataKeeper focusIndex]) {
                [self switchViewMode:GREYMODE];
            }
        }
        // draft mode view
        else if (i == 4) {
            [mv switchMode:DRAFTMODE];
            if (4 == [_dataKeeper focusIndex]) {
                [self switchViewMode:DRAFTMODE];
            }
        }
    }
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    
    if ([keyPath isEqual:@"dataKeeper.beating"]) {
        BOOL beating;
        BOOL oldBeating;
        beating = [[change objectForKey:NSKeyValueChangeNewKey] boolValue];
        oldBeating = [[change objectForKey:NSKeyValueChangeOldKey] boolValue];
        if (oldBeating != beating) {
            if (beating == YES) {
                [_alSoundMaker playClickSoundWithBpm:[_dataKeeper tempo]];
                [self startMetronomeAnimationWithDuration:[_alSoundMaker clickInterval]];
            }
            else {
                [_alSoundMaker stopClickSound];
                [self stopMetronomeAnimation];
            }
        }
    }
    if ([keyPath isEqual:@"dataKeeper.casingHue"]) {
        float hue;
        float oldHue;
        hue = [[change objectForKey:NSKeyValueChangeNewKey] floatValue];
        oldHue = [[change objectForKey:NSKeyValueChangeOldKey] floatValue];
        if (oldHue != hue) {
            [_containerView.metronomeView setCasingHue:hue];
            [_containerView.configureView.metronomeView setCasingHue:hue];
            [_containerView.configureView.casingSliderView updateViewByPercentageValue:hue];
            XYSSmallMetronomeView *mv = [_containerView.configureView.metronomeIcons objectAtIndex:[_dataKeeper focusIndex]];
            [mv setCasingHue:hue];
            [_dataKeeper setValue:[NSNumber numberWithFloat:hue] forKey:[NSString stringWithFormat:@"ch%d", [_dataKeeper focusIndex]]];
        }
    }
    else if ([keyPath isEqual:@"dataKeeper.boardHue"]) {
        float hue;
        float oldHue;
        hue = [[change objectForKey:NSKeyValueChangeNewKey] floatValue];
        oldHue = [[change objectForKey:NSKeyValueChangeOldKey] floatValue];
        if (oldHue != hue) {
            [_containerView.metronomeView setBoardHue:hue];
            [_containerView.configureView.metronomeView setBoardHue:hue];
            [_containerView.configureView.boardSliderView updateViewByPercentageValue:hue];
            XYSSmallMetronomeView *mv = [_containerView.configureView.metronomeIcons objectAtIndex:[_dataKeeper focusIndex]];
            [mv setBoardHue:hue];
            [_dataKeeper setValue:[NSNumber numberWithFloat:hue] forKey:[NSString stringWithFormat:@"bh%d", [_dataKeeper focusIndex]]];
        }
    }
    else if ([keyPath isEqual:@"dataKeeper.weightHue"]) {
        float hue;
        float oldHue;
        hue = [[change objectForKey:NSKeyValueChangeNewKey] floatValue];
        oldHue = [[change objectForKey:NSKeyValueChangeOldKey] floatValue];
        if (oldHue != hue) {
            [_containerView.metronomeView setWeightHue:hue];
            [_containerView.configureView.metronomeView setWeightHue:hue];
            [_containerView.gearIconView setGearHue:hue];
            [_containerView.configureView.weightSliderView updateViewByPercentageValue:hue];
            XYSSmallMetronomeView *mv = [_containerView.configureView.metronomeIcons objectAtIndex:[_dataKeeper focusIndex]];
            [mv setWeightHue:hue];
            [_dataKeeper setValue:[NSNumber numberWithFloat:hue] forKey:[NSString stringWithFormat:@"wh%d", [_dataKeeper focusIndex]]];
        }
    }
    else if ([keyPath isEqual:@"dataKeeper.brightness"]) {
        float brightness;
        float oldBrightness;
        brightness = [[change objectForKey:NSKeyValueChangeNewKey] floatValue];
        oldBrightness = [[change objectForKey:NSKeyValueChangeOldKey] floatValue];
        if (oldBrightness != brightness) {
            // dark metronome
            [_metronomeView darkCasing:brightness];
            [_metronomeView darkBoard:brightness];
            [_metronomeView brightenWeight:brightness];
            // dark text
            if (brightness < 0.5)
            {
                if ([[_containerView beatTextView] highlightColor] == [UIColor blackColor])
                {
                    [[_containerView beatTextView] setHighlightColor:[UIColor whiteColor]];
                    [[_containerView tempoTextView] setHighlightColor:[UIColor whiteColor]];
                    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
                }
                
            } else
            {
                if ([[_containerView beatTextView] highlightColor] == [UIColor whiteColor])
                {
                    [[_containerView beatTextView] setHighlightColor:[UIColor blackColor]];
                    [[_containerView tempoTextView] setHighlightColor:[UIColor blackColor]];
                }
            }
            // dark background
            [CATransaction begin];
            [CATransaction setValue:(id)kCFBooleanTrue forKey:kCATransactionDisableActions];
            [_containerView.layer setBackgroundColor:[UIColor colorWithWhite:brightness alpha:1].CGColor];
            [[[_containerView beatTextView] textLayer] setBackgroundColor:[UIColor colorWithWhite:brightness alpha:1].CGColor];
            [[[_containerView beatTextView] labelLayer] setBackgroundColor:[UIColor colorWithWhite:brightness alpha:1].CGColor];
            [[[_containerView tempoTextView] textLayer] setBackgroundColor:[UIColor colorWithWhite:brightness alpha:1].CGColor];
            [[[_containerView tempoTextView] labelLayer] setBackgroundColor:[UIColor colorWithWhite:brightness alpha:1].CGColor];
            [CATransaction commit];
            // update brightness slider
            [_containerView.configureView.brightnessSliderView updateViewByPercentageValue:(1 - brightness)];
        }
    }
    else if ([keyPath isEqual:@"dataKeeper.volume"]) {
        float volume;
        float oldVolume;
        volume = [[change objectForKey:NSKeyValueChangeNewKey] floatValue];
        oldVolume = [[change objectForKey:NSKeyValueChangeOldKey] floatValue];
        if (oldVolume != volume) {
            [_containerView.configureView.volumeSliderView updateViewByPercentageValue:(1 - volume)];
            [_alSoundMaker adjustVolume:volume];
        }
    }
    else if ([keyPath isEqual:@"dataKeeper.beat"]) {
        uint beat;
        uint oldBeat;
        beat = [[change objectForKey:NSKeyValueChangeNewKey] intValue];
        oldBeat = [[change objectForKey:NSKeyValueChangeOldKey] intValue];
        if (oldBeat != beat) {
            [_containerView.metronomeView.blotView translateWithBeatNumber:beat];
            [_containerView.beatTextView setText:[NSString stringWithFormat:@"%d", beat]];
            [_alSoundMaker playBlotSound];
            [_alSoundMaker setBeat:beat];
            if ([_dataKeeper beating]) {
                [self scheduleChangeSounds];
            }
            
        }
    }
    else if ([keyPath isEqual:@"dataKeeper.tempo"]) {
        uint tempo;
        uint oldTempo;
        tempo = [[change objectForKey:NSKeyValueChangeNewKey] intValue];
        oldTempo = [[change objectForKey:NSKeyValueChangeOldKey] intValue];
        if (oldTempo != tempo) {
            [_containerView.tempoTextView setText:[NSString stringWithFormat:@"%d", tempo]];
            [_containerView.metronomeView transformWeightWithTempo:tempo];
            //[_soundMaker playWeightSound];
            [_alSoundMaker playWeightSound];
        }
    }
    else if ([keyPath isEqual:@"dataKeeper.rotateAngle"]) {
        float angle;
        float oldAngle;
        angle = [[change objectForKey:NSKeyValueChangeNewKey] floatValue];
        oldAngle = [[change objectForKey:NSKeyValueChangeOldKey] floatValue];
        if (oldAngle != angle) {
            [_containerView.metronomeView rotateArmWithAngle:angle];
        }
    }
    else if([keyPath isEqual:@"dataKeeper.soundIndex"]) {
        uint sound;
        uint oldSound;
        sound = [[change objectForKey:NSKeyValueChangeNewKey] intValue];
        oldSound = [[change objectForKey:NSKeyValueChangeOldKey] intValue];
        if (oldSound != sound) {
            [_containerView.configureView.switchButtonView updateText:sound];
            if ([_dataKeeper beating]) {
                [self scheduleChangeSounds];
            }
            else {
                [_alSoundMaker playClickSoundOnce];
                [_containerView.configureView.timbreView stopWaveAnimate];
                [_containerView.configureView.timbreView startWaveAnimateWithDuration:0.5];
                [_containerView.configureView.tempoLightView stopLighting];
                [_containerView.configureView.tempoLightView startLightingOnceWithDuration:0.5];
            }
        }
    }
    else if([_dataKeeper purchased] && [keyPath isEqual:@"dataKeeper.focusIndex"]) {
        uint focusIndex;
        uint oldFocusIndex;
        focusIndex = [[change objectForKey:NSKeyValueChangeNewKey] intValue];
        oldFocusIndex = [[change objectForKey:NSKeyValueChangeOldKey] intValue];
        if (oldFocusIndex != focusIndex) {
            float ch, bh, wh;
            ch = [[_dataKeeper valueForKey:[NSString stringWithFormat:@"ch%d", focusIndex]] floatValue];
            bh = [[_dataKeeper valueForKey:[NSString stringWithFormat:@"bh%d", focusIndex]] floatValue];
            wh = [[_dataKeeper valueForKey:[NSString stringWithFormat:@"wh%d", focusIndex]] floatValue];
            //NSLog(@"%@(%f), bh(%f), wh(%f)", [NSString stringWithFormat:@"ch%d", focusIndex], ch, bh, wh);
            // update casing
            [_containerView.metronomeView setCasingHue:ch];
            [_containerView.configureView.metronomeView setCasingHue:ch];
            [_containerView.configureView.casingSliderView updateViewByPercentageValue:ch];
            // update board
            [_containerView.metronomeView setBoardHue:bh];
            [_containerView.configureView.metronomeView setBoardHue:bh];
            [_containerView.configureView.boardSliderView updateViewByPercentageValue:bh];
            // update weight
            [_containerView.metronomeView setWeightHue:wh];
            [_containerView.configureView.metronomeView setWeightHue:wh];
            [_containerView.gearIconView setGearHue:wh];
            [_containerView.configureView.weightSliderView updateViewByPercentageValue:wh];
            
            XYSSmallMetronomeView *oldMetronomeIcon = [_containerView.configureView.metronomeIcons objectAtIndex:oldFocusIndex];
            XYSSmallMetronomeView *newMetronomeIcon = [_containerView.configureView.metronomeIcons objectAtIndex:focusIndex];
            [oldMetronomeIcon setFocus:NO];
            [oldMetronomeIcon setNeedsDisplay];
            [newMetronomeIcon setFocus:YES];
            [newMetronomeIcon setNeedsDisplay];
            
            // need switch mode
            if (oldFocusIndex == 3 || oldFocusIndex == 4 || focusIndex == 3 || focusIndex == 4) {
                if (focusIndex == 3) {
                    [self switchViewMode:GREYMODE];
                }
                else if (focusIndex == 4) {
                    [self switchViewMode:DRAFTMODE];
                }
                else {
                    [self switchViewMode:COLORMODE];
                }
                
            }
        }
    }
    else if([keyPath isEqual:@"dataKeeper.purchased"]) {
        uint purchased;
        uint oldPurchased;
        purchased = [[change objectForKey:NSKeyValueChangeNewKey] intValue];
        oldPurchased = [[change objectForKey:NSKeyValueChangeOldKey] intValue];
        if (oldPurchased == NO && purchased == YES) {
            // store the value to presist
            [_dataKeeper storePurchased];
            // show list of metronome icons
            NSArray *metronomeIcons = [_containerView.configureView metronomeIcons];
            for (int i = 0; i < [metronomeIcons count]; i++) {
                XYSSmallMetronomeView *mv = [metronomeIcons objectAtIndex:i];
                [mv setHidden:NO];
            }
            [self redrawMetronomeIcons];
            // translate switch sound button and manual button
            [_containerView.configureView.timbreView setTransform: CGAffineTransformTranslate([_containerView.configureView.timbreView transform], 0, 5)];
            [_containerView.configureView.switchButtonView setTransform:CGAffineTransformTranslate([_containerView.configureView.switchButtonView transform], 0, 15)];
            [_containerView.configureView.manButtonView setTransform:CGAffineTransformTranslate([_containerView.configureView.manButtonView transform], 0, 25)];
            // add more sound
            [_alSoundMaker addExtraSounds];
            
            // hide ad
            [self layoutAnimateAdOut];
            [_containerView.adView setHidden:YES];
            _containerView.adView.adBannerView.delegate = nil;
            
            // remove purchase button
            [_containerView.configureView.purchaseButtonView setHidden:YES];
            
            // remove purchase view
            if (_containerView.configureView.purchaseView != NULL) {
                [_containerView.configureView.purchaseView removeFromSuperview];
                _containerView.configureView.purchaseView = NULL;
            }
            
        }
    }
}


/* APIs */

- (void)startMetronomeAnimationWithDuration:(CFTimeInterval)duration
{
    [_containerView.metronomeView.armView startRotateWithAngle:[_dataKeeper rotateAngle] Duration:duration * 2];
    [_containerView.configureView.timbreView startWaveAnimateForeverWithDuration:duration];
    [_containerView.configureView.tempoLightView startLightingWithDuration:duration];
}

- (void)stopMetronomeAnimation
{
    [_containerView.metronomeView.armView stopRotate];
    [_containerView.configureView.timbreView stopWaveAnimate];
    [_containerView.configureView.tempoLightView stopLighting];
}

- (CFTimeInterval) getTillNextClick
{
    CFTimeInterval currentTime = CFAbsoluteTimeGetCurrent();
    CFTimeInterval interval = [_alSoundMaker clickInterval];
    CFTimeInterval elapsedTime = currentTime - [_alSoundMaker startClickTime];
    uint clickCount = (unsigned int)(elapsedTime / interval);
    CFTimeInterval waitTime = (clickCount + 1) * interval - elapsedTime;
    return waitTime;
}

- (void)changeSounds
{
    [_alSoundMaker stopClickSound];
    [_alSoundMaker playClickSoundWithBpm:[_dataKeeper tempo]];
}

- (void)scheduleChangeSounds
{
    CFTimeInterval waitTime = [self getTillNextClick];
    //NSLog(@"wait %f(s)", waitTime);
    [self performSelector:@selector(changeSounds) withObject:self afterDelay:waitTime];
}

- (void)resetAnimation
{
    [self stopMetronomeAnimation];
    [self startMetronomeAnimationWithDuration:[_alSoundMaker clickInterval]];
}

- (void)scheduleResetAnimation
{
    CFTimeInterval waitTime = [self getTillNextClick];
    [self performSelector:@selector(resetAnimation) withObject:self afterDelay:waitTime];
}

- (void)breakIntoInterruption
{
    if (!_interrupted && [_dataKeeper beating]) {
        [_alSoundMaker stopClickSound];
        [self stopMetronomeAnimation];
    }
    _interrupted = YES;
}

- (void)resumeFromInterruption
{
    if (_interrupted && [_dataKeeper beating]) {
        [_alSoundMaker playClickSoundWithBpm:[_dataKeeper tempo]];
        [self startMetronomeAnimationWithDuration:[_alSoundMaker clickInterval]];
    }
    _interrupted = NO;
}

/* ad callbacks */

- (void) layoutAnimateAdIn
{
    if (![_containerView.adView visible]) {
        [_containerView.adView setVisible:YES];
        [_containerView layoutAnimateAdIn];
    }
}

- (void) layoutAnimateAdOut
{
    if ([_containerView.adView visible]) {
        [_containerView.adView setVisible:NO];
        [_containerView layoutAnimateAdOut];
    }
}

- (void)bannerViewDidLoadAd:(ADBannerView *)banner
{
    if (![_dataKeeper purchased]) {
        NSLog(@"bannerViewDidLoadAd");
        [self layoutAnimateAdIn];
    }
}

- (void)bannerView:(ADBannerView *)banner didFailToReceiveAdWithError:(NSError *)error
{
    if (![_dataKeeper purchased]) {
        NSLog(@"bannerView");
        [self layoutAnimateAdOut];
    }
}

- (BOOL)bannerViewActionShouldBegin:(ADBannerView *)banner willLeaveApplication:(BOOL)willLeave
{
    if (![_dataKeeper purchased]) {
        NSLog(@"bannerViewActionSouldBegin, willLeave %d", willLeave);
        if (!willLeave) {
            [_dataKeeper storeData];
            [self breakIntoInterruption];
        }
        return YES;
    }
    return NO;
}

- (void)bannerViewActionDidFinish:(ADBannerView *)banner
{
    if (![_dataKeeper purchased]) {
        NSLog(@"bannerViewActionDidFinish");
        [self resumeFromInterruption];
    }
    
}

/* audio session handling */

- (void)initAudioSession
{
    
    AVAudioSession *session = [AVAudioSession sharedInstance];
    
    // Specify that this object is the delegate of the audio session, so that
    //    this object's endInterruption method will be invoked when needed.
    //[session setDelegate: self];
    
    NSError *audioSessionError = nil;
    [session setCategory: AVAudioSessionCategoryPlayback
                   error: &audioSessionError];
    if (audioSessionError != nil) {
        NSLog (@"Error setting audio session category.");
        return;
    }
    
    /*
    NSTimeInterval bufferDuration = 0.005;
    [session setPreferredIOBufferDuration:bufferDuration error:&audioSessionError];
    if (audioSessionError != nil) {
        NSLog (@"Error setting buffer duration.");
        return;
    }
    */
    
    double sampleRate = 44100.0;
    [session setPreferredSampleRate:sampleRate error:&audioSessionError];
    if (audioSessionError != nil) {
        NSLog (@"Error setting sample rate.");
        return;
    }
    
    [session setActive: YES
                 error: &audioSessionError];
    
    if (audioSessionError != nil) {
        
        NSLog (@"Error activating audio session during initial setup.");
        return;
    }
    
    // add session notification
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(audioSessionInterrupt:) name:AVAudioSessionInterruptionNotification object:nil];
}

- (void) audioSessionInterrupt:(NSNotification*)notification
{
    NSDictionary *intDict = notification.userInfo;
    
    uint intType = [[intDict valueForKey:AVAudioSessionInterruptionTypeKey] intValue];
    NSLog(@"session interrupt %d", intType);
    switch (intType) {
        case AVAudioSessionInterruptionTypeBegan:
            [_alSoundMaker setNullContext];
            break;
        case AVAudioSessionInterruptionTypeEnded:
            if (!_inBackground) {
                [_alSoundMaker restoreContext];
            }
            break;
            
        default:
            break;
    }
}

- (void)processingCallback:(ProcessingParameter *)processingParameter
{
    if ([_storeAgent purchaseState] != [processingParameter purchaseState]) {
        return;
    }
    _dotNumber++;
    if (_dotNumber == 5) {
        _dotNumber = 0;
    }
    switch (_dotNumber) {
        case 0:
            [_containerView.configureView.purchaseView displayMessageUI:[NSString stringWithFormat:@"%@\n\n.", [processingParameter infoMessage]]];
            break;
        case 1:
            [_containerView.configureView.purchaseView displayMessageUI:[NSString stringWithFormat:@"%@\n\n. .", [processingParameter infoMessage]]];
            break;
        case 2:
            [_containerView.configureView.purchaseView displayMessageUI:[NSString stringWithFormat:@"%@\n\n. . .", [processingParameter infoMessage]]];
            break;
        case 3:
            [_containerView.configureView.purchaseView displayMessageUI:[NSString stringWithFormat:@"%@\n\n. . . .", [processingParameter infoMessage]]];
            break;
        case 4:
            [_containerView.configureView.purchaseView displayMessageUI:[NSString stringWithFormat:@"%@\n\n. . . . .", [processingParameter infoMessage]]];
            break;
        default:
            break;
    }
    if ((CFAbsoluteTimeGetCurrent() - _startConnectTime) > [processingParameter timeout]) {
        [_containerView.configureView.purchaseView displayMessageUI:[processingParameter errorMessage]];
    } else {
        [self performSelector:@selector(processingCallback:) withObject:processingParameter afterDelay:0.5];
    }
}

- (void)storeAgentDidChangeState:(PurchaseState)state withObject:(id)object
{
    //NSLog(@"storeAgentDidChangeState %d", state);
    SKPaymentTransaction *transaction = NULL;
    NSError *err = NULL;
    ProcessingParameter *processingParameter = NULL;
    switch (state) {
        case PURCHASE_IDLE:
            break;
        case PROD_REQUESTING:
            [_containerView.configureView.purchaseView displayMessageUI:NSLocalizedString(@"ConnectingToAppStore\n\n.", @"Connecting to App Store\n\n.")];
            _startConnectTime = CFAbsoluteTimeGetCurrent();
            _dotNumber = 0;
            processingParameter = [ProcessingParameter processParameterWithState:PROD_REQUESTING
                                                                            Info:NSLocalizedString(@"ConnectingToAppStore", @"Connecting to App Store")
                                                                           Error:NSLocalizedString(@"CannotConnectingToAppStore", @"Oops!\nCannot connect to App Store, please check your network connection and system configuration")
                                                                         Timeout:20];
            [self performSelector:@selector(processingCallback:) withObject:processingParameter afterDelay:0.5];
            [_storeAgent requestFullVersionProduct];
            break;
        case PROD_REQUESTED:
            if ([_storeAgent formattedPrice] == NULL) {
                NSLog(@"Price is NULL");
                [_containerView.configureView.purchaseView displayMessageUI:NSLocalizedString(@"InvalidPriceInfo", @"Invalid price info")];
                break;
            }
            [_containerView.configureView.purchaseView.buyButton setText:[NSString stringWithFormat:NSLocalizedString(@"BuyFor%@", @"Buy for %@"), [_storeAgent formattedPrice]]];
            [_containerView.configureView.purchaseView displayPurchaseUI];
            break;
        case PROD_INVALID:
            [_containerView.configureView.purchaseView displayMessageUI:NSLocalizedString(@"CannotGetProduct", @"Oops!\nCannot get product")];
            break;
        case PAY_REQUESTING:
            [_storeAgent requestPayment];
            [_containerView.configureView.purchaseView displayMessageUI:NSLocalizedString(@"Purchasing\n\n.", @"Purchasing\n\n.")];
            processingParameter = [ProcessingParameter processParameterWithState:PAY_REQUESTING
                                                                            Info:NSLocalizedString(@"Purchasing", @"Purchasing")
                                                                           Error:NSLocalizedString(@"PurchaseTakesTooLong", @"Oops!\nPurchase takes too long")
                                                                         Timeout:300];
            [self performSelector:@selector(processingCallback:) withObject:processingParameter afterDelay:0.5];
            break;
        case PAY_SUCCEED:
            [_dataKeeper setPurchased:YES];
            transaction = (SKPaymentTransaction *)object;
            if (transaction != NULL) {
                [_storeAgent finishTransaction:transaction];
            }
            break;
        case PAY_FAILED:
            transaction = (SKPaymentTransaction *)object;
            if (transaction != NULL) {
                NSString *errMsg;
                switch (transaction.error.code) {
                    case SKErrorUnknown:
                        errMsg = NSLocalizedString(@"PurchaseTryAgainLater", @"Purchase failed\nTry again later");
                        break;
                    case SKErrorClientInvalid:
                        errMsg = NSLocalizedString(@"InvalidClient", @"Oops!\nInvalid client");
                        break;
                    case SKErrorPaymentCancelled:
                        errMsg = NSLocalizedString(@"PurchaseCancelled", @"Purchase cancelled");
                        break;
                    case SKErrorPaymentInvalid:
                        errMsg = NSLocalizedString(@"PaymentInvalid", @"Oops!\nPayment invalid");
                        break;
                    case SKErrorPaymentNotAllowed:
                        errMsg = NSLocalizedString(@"PaymentNotAllowed", @"Oops!\nPayment not allowed");
                        break;
                    case SKErrorStoreProductNotAvailable:
                        errMsg = NSLocalizedString(@"InvalidProduct", @"Oops!\nInvalid product");
                        break;
                    default:
                        break;
                }
                [_containerView.configureView.purchaseView displayMessageUI:errMsg];
                [_storeAgent finishTransaction:transaction];
            }
            break;
        case RESTORE_REQUESTING:
            [_storeAgent requestRestore];
            [_containerView.configureView.purchaseView displayMessageUI:NSLocalizedString(@"Restoring\n\n.", @"Restoring\n\n.")];
            processingParameter = [ProcessingParameter processParameterWithState:RESTORE_REQUESTING
                                                                            Info:NSLocalizedString(@"Restoring", @"Restoring")
                                                                           Error:NSLocalizedString(@"RestoringTakesTooLong", @"Oops!\nRestoring takes too long")
                                                                         Timeout:300];
            [self performSelector:@selector(processingCallback:) withObject:processingParameter afterDelay:0.5];
            break;
        case RESTORE_SUCCEED:
            [_dataKeeper setPurchased:YES];
            transaction = (SKPaymentTransaction *)object;
            if (transaction != NULL) {
                [_storeAgent finishTransaction:transaction];
            }
            break;
        case RESTORE_FAILED:
            err = (NSError *)object;
            if (err != NULL) {
                NSString *errMsg;
                switch (err.code) {
                    case SKErrorUnknown:
                        errMsg = NSLocalizedString(@"RestoreTryAgainLater", @"Restore failed\nTry again later");
                        break;
                    case SKErrorClientInvalid:
                        errMsg = NSLocalizedString(@"InvalidClient", @"Oops!\nInvalid client");
                        break;
                    case SKErrorPaymentCancelled:
                        errMsg = NSLocalizedString(@"RestoreCancelled", @"Restore cancelled");
                        break;
                    case SKErrorPaymentInvalid:
                        errMsg = NSLocalizedString(@"PaymentInvalid", @"Oops!\nPayment invalid");
                        break;
                    case SKErrorPaymentNotAllowed:
                        errMsg = NSLocalizedString(@"PaymentNotAllowed", @"Oops!\nPayment not allowed");
                        break;
                    case SKErrorStoreProductNotAvailable:
                        errMsg = NSLocalizedString(@"InvalidProduct", @"Oops!\nInvalid product");
                        break;
                    default:
                        break;
                }
                [_containerView.configureView.purchaseView displayMessageUI:errMsg];
            }
            else {
                [_containerView.configureView.purchaseView displayMessageUI:NSLocalizedString(@"NoRestoreItem", @"No restore item")];
            }
            break;
        default:
            break;
    }
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver: self name: AVAudioSessionInterruptionNotification object: nil];
}


@end
