//
//  XYSALSoundMaker.h
//  Play Metronome
//
//  Created by Xu Yesheng on 9/24/14.
//  Copyright (c) 2014 yesheng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OPENAL/al.h"
#import "OPENAL/alc.h"
#import "XYSWavObject.h"
#import "XYSDataKeeper.h"

@interface XYSALSoundMaker : NSObject
+ (XYSALSoundMaker *)sharedInstance;

@property XYSDataKeeper *dataKeeper;
@property ALCcontext *alContext;
@property ALCdevice *alDevice;
@property uint weightSrcId;
@property uint blotSrcId;
@property uint clickSrcId;

@property XYSWavObject *weightSound;
@property XYSWavObject *blotSound;

//@property uint currentSoundIndex;
@property NSMutableArray *beatSounds;
@property NSMutableArray *tempoSounds;

@property unsigned char *zeroBuf;
//@property unsigned int tempoSilentBufId;
//@property unsigned int beatSilentBufId;
@property NSMutableArray *queuedSilentBuf;

@property uint beat;
@property BOOL initialized;

@property CFTimeInterval startClickTime;
@property CFTimeInterval clickInterval;

- (void)playWeightSound;
- (void)playBlotSound;
- (void)addExtraSounds;
- (void)playClickSoundWithBpm:(float)bpm;
- (void)playClickSoundOnce;
- (void)stopClickSound;
- (uint)nextClickSoundId;
- (void)switchClickSound:(uint)soundId;
- (void)adjustVolume:(float)volume;
- (void)setNullContext;
- (void)restoreContext;
@end
