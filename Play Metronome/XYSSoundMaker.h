//
//  XYSSoundMaker.h
//  Play Metronome
//
//  Created by Xu Yesheng on 8/16/14.
//  Copyright (c) 2014 yesheng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

@interface XYSSoundMaker : NSObject <AVAudioPlayerDelegate>
+ (XYSSoundMaker *)sharedInstance;

@property AVAudioPlayer *weightClickPlayer;
@property AVAudioPlayer *blotClickPlayer;

@property uint currentPlayerIndex;
@property AVAudioPlayer *currentBeatPlayer;
@property AVAudioPlayer *currentTempoPlayer;

@property NSArray *beatPlayers;
@property NSArray *tempoPlayers;

@property uint beat;

@property CFTimeInterval startClickTime;
@property CFTimeInterval clickInterval;
@property uint clickCount;
@property BOOL clicking;
@property BOOL playSoundOnce;

@property BOOL initialized;

- (void)playWeightSound;
- (void)playBlotSound;
- (void)playClickSoundWithBpm:(float)bpm;
- (void)playClickSoundOnce;
- (void)stopClickSound;
- (uint)switchBeatSound;

- (void)adjustVolume:(float)volume;
@end
