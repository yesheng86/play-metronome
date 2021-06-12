//
//  XYSSoundMaker.m
//  Play Metronome
//
//  Created by Xu Yesheng on 8/16/14.
//  Copyright (c) 2014 yesheng. All rights reserved.
//

#import "XYSSoundMaker.h"
#import <CoreFoundation/CFDate.h>

@interface XYSSoundMaker()

@end

@implementation XYSSoundMaker

+ (XYSSoundMaker *)sharedInstance
{
    static XYSSoundMaker *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[XYSSoundMaker alloc] init];

    });
    return sharedInstance;
}

- (id)init
{
    self = [super init];
    if (self) {
        _initialized = NO;
        
        // set in XYSViewController
        //[[UIApplication sharedApplication] beginReceivingRemoteControlEvents];
        
                                        
  
        // init wave.wav
        NSURL *weightSoundURL = [[NSBundle mainBundle] URLForResource:@"weight" withExtension:@"wav"];
        if (!weightSoundURL) {
            return self;
        }
        _weightClickPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:weightSoundURL error:nil];
        [_weightClickPlayer prepareToPlay];

        // init blot.wav
        NSURL *blotSoundURL = [[NSBundle mainBundle] URLForResource:@"blot" withExtension:@"wav"];
        if (!blotSoundURL) {
            return self;
        }
        _blotClickPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:blotSoundURL error:nil];
        [_blotClickPlayer prepareToPlay];
                    
        // tempo 1
        NSURL *t1URL = [[NSBundle mainBundle] URLForResource:@"x" withExtension:@"wav"];
        if (!t1URL) {
            return self;
        }
        AVAudioPlayer *t1Player = [[AVAudioPlayer alloc] initWithContentsOfURL:t1URL error:nil];
        [t1Player setDelegate:self];
        [t1Player prepareToPlay];
        
        // tempo 2
        NSURL *t2URL = [[NSBundle mainBundle] URLForResource:@"y" withExtension:@"wav"];
        if (!t2URL) {
            return self;
        }
        AVAudioPlayer *t2Player = [[AVAudioPlayer alloc] initWithContentsOfURL:t2URL error:nil];
        [t2Player setDelegate:self];
        [t2Player prepareToPlay];
        
        // tempo 3
        NSURL *t3URL = [[NSBundle mainBundle] URLForResource:@"z" withExtension:@"wav"];
        if (!t3URL) {
            return self;
        }
        AVAudioPlayer *t3Player = [[AVAudioPlayer alloc] initWithContentsOfURL:t3URL error:nil];
        [t3Player setDelegate:self];
        [t3Player prepareToPlay];
        
        // beat 1
        NSURL *b1URL = [[NSBundle mainBundle] URLForResource:@"a" withExtension:@"wav"];
        if (!b1URL) {
            return self;
        }
        AVAudioPlayer *b1Player = [[AVAudioPlayer alloc] initWithContentsOfURL:b1URL error:nil];
        [b1Player prepareToPlay];
        
        // beat 2
        NSURL *b2URL = [[NSBundle mainBundle] URLForResource:@"b" withExtension:@"wav"];
        if (!b2URL) {
            return self;
        }
        AVAudioPlayer *b2Player = [[AVAudioPlayer alloc] initWithContentsOfURL:b2URL error:nil];
        [b2Player prepareToPlay];
        
        // beat 3
        NSURL *b3URL = [[NSBundle mainBundle] URLForResource:@"d" withExtension:@"wav"];
        if (!b3URL) {
            return self;
        }
        AVAudioPlayer *b3Player = [[AVAudioPlayer alloc] initWithContentsOfURL:b3URL error:nil];
        [b3Player prepareToPlay];
        
        _tempoPlayers = [[NSArray alloc] initWithObjects:t1Player, t2Player, t3Player, nil];
        _beatPlayers = [[NSArray alloc] initWithObjects:b1Player, b2Player, b3Player, nil];
        
        
        _currentPlayerIndex = 0;
        _currentTempoPlayer = t1Player;
        _currentBeatPlayer = b1Player;

        _initialized = YES;
        _clicking = NO;
        _clickInterval = 0;
        _beat = 0;
        _playSoundOnce = NO;
    }
    return self;
}

- (void)playWeightSound
{
    if (!_initialized) {
        return;
    }
    [_weightClickPlayer play];
}

- (void)playBlotSound
{
    if (!_initialized) {
        return;
    }
    [_blotClickPlayer play];
}




- (void)playClickSoundWithBpm:(float)bpm
{
    if (!_initialized) {
        return;
    }

    _clicking = YES;
    if (_clicking) {
        _clickInterval = (double)60 / bpm;
        _clickCount = 0;
        _startClickTime = [_currentTempoPlayer deviceCurrentTime];
        [_currentTempoPlayer playAtTime:_startClickTime + _clickInterval];
        if (_beat != 0) {
            [_currentBeatPlayer playAtTime:_startClickTime + _clickInterval];
        }
    }
}

- (void)playClickSoundOnce
{
    if (!_initialized) {
        return;
    }
    _playSoundOnce = YES;
    _clicking = YES;
    if (_clicking) {
        _clickInterval = 0.5;
        _clickCount = 0;
        _startClickTime = [_currentTempoPlayer deviceCurrentTime];
        [_currentTempoPlayer play];
        [_currentBeatPlayer play];
    }
}

- (void)stopClickSound
{
    if (!_initialized) {
        return;
    }
    _clicking = NO;
    if ([_currentTempoPlayer isPlaying]) {
        [_currentTempoPlayer pause];
    }
    if ([_currentBeatPlayer isPlaying]) {
        [_currentBeatPlayer pause];
    }
}


- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag
{
    if (_clicking) {
        _clickCount++;
        if (_playSoundOnce) {
            if (_clickCount == 4) {
                _playSoundOnce = NO;
                return;
            }
            else {
                CFTimeInterval nextClickTime = _startClickTime + _clickInterval * _clickCount;
                [_currentTempoPlayer playAtTime:nextClickTime];
            }
        }
        else {
            CFTimeInterval nextClickTime = _startClickTime + _clickInterval * (_clickCount + 1);

            if (_beat != 0 && _clickCount % _beat == 0) {
                [_currentBeatPlayer playAtTime:nextClickTime];
            }
            [_currentTempoPlayer playAtTime:nextClickTime];

        }
    }
    
}

- (void)audioPlayerBeginInterruption:(AVAudioPlayer *)player
{
    NSLog(@"interruption");
}

- (uint)switchBeatSound
{
    if ([_currentTempoPlayer isPlaying]) {
        [_currentTempoPlayer pause];
        _currentPlayerIndex++;
        if (_currentPlayerIndex == _tempoPlayers.count) {
            _currentPlayerIndex = 0;
        }
        _currentTempoPlayer = _tempoPlayers[_currentPlayerIndex];
        _currentBeatPlayer = _beatPlayers[_currentPlayerIndex];
        
        CFTimeInterval nextClickTime = _startClickTime + _clickInterval * (_clickCount + 1);
        [_currentTempoPlayer playAtTime:nextClickTime];
        if (_clickCount % _beat == 0) {
            [_currentBeatPlayer playAtTime:nextClickTime];
        }
    }
    else {
        _currentPlayerIndex++;
        if (_currentPlayerIndex == _tempoPlayers.count) {
            _currentPlayerIndex = 0;
        }
        _currentTempoPlayer = _tempoPlayers[_currentPlayerIndex];
        _currentBeatPlayer = _beatPlayers[_currentPlayerIndex];
    }
    return _currentPlayerIndex;
}

- (void)adjustVolume:(float)volume
{
    if (volume < 0) {
        volume = 0;
    } else if (volume > 1) {
        volume = 1;
    }
    [_weightClickPlayer setVolume:volume];
    [_blotClickPlayer setVolume:volume];
    for (int i = 0; i < _tempoPlayers.count; i++) {
        [(AVAudioPlayer *)_tempoPlayers[i] setVolume:volume];
    }
    for (int i = 0; i < _beatPlayers.count; i++) {
        [(AVAudioPlayer *)_beatPlayers[i] setVolume:volume];
    }
}


- (void) dealloc
{
    NSError *error = NULL;
    [[AVAudioSession sharedInstance] setActive:NO error:&error];
}
@end
