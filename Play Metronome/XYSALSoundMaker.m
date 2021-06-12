//
//  XYSALSoundMaker.m
//  Play Metronome
//
//  Created by Xu Yesheng on 9/24/14.
//  Copyright (c) 2014 yesheng. All rights reserved.
//

#import "XYSALSoundMaker.h"
#import <AudioToolbox/AudioFile.h>
#import <AVFoundation/AVFoundation.h>

@implementation XYSALSoundMaker

+ (XYSALSoundMaker *)sharedInstance
{
    static XYSALSoundMaker *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[XYSALSoundMaker alloc] init];
        
    });
    return sharedInstance;
}

- (id)init
{
    _dataKeeper = [XYSDataKeeper sharedInstance];
    // AL open device
    _alDevice = alcOpenDevice(NULL);
    if (_alDevice) {
        _alContext = alcCreateContext(_alDevice, NULL);
        alcMakeContextCurrent(_alContext);
    }

    // AL buffers
    // init weight sound
    _weightSound = [[XYSWavObject alloc] initWithFileName:@"weight"];
    
    // init blot sound
    _blotSound = [[XYSWavObject alloc] initWithFileName:@"blot"];
    
    // AL tempo sound
    XYSWavObject *t1Sound = [[XYSWavObject alloc] initWithFileName:@"t1"];
    XYSWavObject *t2Sound = [[XYSWavObject alloc] initWithFileName:@"t2"];
    XYSWavObject *t3Sound = [[XYSWavObject alloc] initWithFileName:@"t3"];
    
    // AL beat sound
    XYSWavObject *b1Sound = [[XYSWavObject alloc] initWithFileName:@"b1"];
    XYSWavObject *b2Sound = [[XYSWavObject alloc] initWithFileName:@"b2"];
    XYSWavObject *b3Sound = [[XYSWavObject alloc] initWithFileName:@"b3"];

    _tempoSounds = [[NSMutableArray alloc] initWithObjects:t1Sound, t2Sound, t3Sound, nil];
    _beatSounds = [[NSMutableArray alloc] initWithObjects:b1Sound, b2Sound, b3Sound, nil];
    
    // AL generate source
    alGenSources(1, &_weightSrcId);
    alGenSources(1, &_blotSrcId);
    alGenSources(1, &_clickSrcId);
    alSourcei(_weightSrcId, AL_BUFFER, [_weightSound bufId]);
    alSourcei(_blotSrcId, AL_BUFFER, [_blotSound bufId]);
    alSourcei(_clickSrcId, AL_LOOPING, AL_TRUE);
    
    _queuedSilentBuf = [[NSMutableArray alloc] init];
    _initialized = YES;
    _clickInterval = 0;
    _beat = 0;
    
    // allocate zero buffer for maxinum buffer copy
    unsigned int zeroBufSz = 264600; //60 * 44100 * 4 / 40
    _zeroBuf = malloc(zeroBufSz);
    memset(_zeroBuf, 0, zeroBufSz);
    
    return self;
}

- (void)playWeightSound
{
    if (!_initialized) {
        return;
    }
    alSourcePlay(_weightSrcId);
}

- (void)playBlotSound
{
    if (!_initialized) {
        return;
    }
    alSourcePlay(_blotSrcId);
}

- (void)addExtraSounds
{
    // AL tempo sound
    XYSWavObject *t4Sound = [[XYSWavObject alloc] initWithFileName:@"t4"];
    XYSWavObject *t5Sound = [[XYSWavObject alloc] initWithFileName:@"t5"];
    XYSWavObject *t6Sound = [[XYSWavObject alloc] initWithFileName:@"t6"];
    XYSWavObject *t7Sound = [[XYSWavObject alloc] initWithFileName:@"t7"];
    XYSWavObject *t8Sound = [[XYSWavObject alloc] initWithFileName:@"t8"];
    XYSWavObject *t9Sound = [[XYSWavObject alloc] initWithFileName:@"t9"];
    
    // AL beat sound
    XYSWavObject *b4Sound = [[XYSWavObject alloc] initWithFileName:@"b4"];
    XYSWavObject *b5Sound = [[XYSWavObject alloc] initWithFileName:@"b5"];
    XYSWavObject *b6Sound = [[XYSWavObject alloc] initWithFileName:@"b6"];
    XYSWavObject *b7Sound = [[XYSWavObject alloc] initWithFileName:@"b7"];
    XYSWavObject *b8Sound = [[XYSWavObject alloc] initWithFileName:@"b8"];
    XYSWavObject *b9Sound = [[XYSWavObject alloc] initWithFileName:@"b9"];
    
    [_tempoSounds addObjectsFromArray:[[NSArray alloc] initWithObjects:t4Sound, t5Sound, t6Sound, t7Sound, t8Sound, t9Sound, nil]];
    [_beatSounds addObjectsFromArray:[[NSArray alloc] initWithObjects:b4Sound, b5Sound, b6Sound, b7Sound, b8Sound, b9Sound, nil]];
}

- (void)srcQueBufWithBeat:(uint)beat Bpm:(float)bpm
{
    XYSWavObject *currentTempoSound = _tempoSounds[[_dataKeeper soundIndex]];
    _startClickTime = CFAbsoluteTimeGetCurrent();
    _clickInterval = (CFTimeInterval)((unsigned int)(10584000 / bpm)) / 176400;
    // 10584000 = 60 * 44100 * 4
    unsigned int tempoSilentBufSz = (unsigned int)(10584000 / bpm) - [currentTempoSound bufSize];
    unsigned int tempoSilentBufId = [self genSilentBuf:tempoSilentBufSz];
    unsigned int tempoSoundBufId = [currentTempoSound bufId];
    
    if (beat == 0) {
        alSourceQueueBuffers(_clickSrcId, 1, &tempoSilentBufId);
        alSourceQueueBuffers(_clickSrcId, 1, &tempoSoundBufId);
    } else {
        if (beat != 2 && beat != 3 && beat != 4 && beat != 6) {
            //NSAssert(NO, @"wrong beat number");
            NSLog(@"wrong beat number");
            return;
        }
        XYSWavObject *currentBeatSound = _beatSounds[[_dataKeeper soundIndex]];
        unsigned int beatSilentBufSz = (unsigned int)(10584000 / bpm) - [currentBeatSound bufSize];
        unsigned beatSilentBufId = [self genSilentBuf:beatSilentBufSz];
        unsigned int beatSoundBufId = [currentBeatSound bufId];
        alSourceQueueBuffers(_clickSrcId, 1, &beatSilentBufId);
        alSourceQueueBuffers(_clickSrcId, 1, &beatSoundBufId);
        for (int i = 0; i < beat - 1; i++) {
            alSourceQueueBuffers(_clickSrcId, 1, &tempoSilentBufId);
            alSourceQueueBuffers(_clickSrcId, 1, &tempoSoundBufId);
        }
    }
}

- (void)playClickSoundWithBpm:(float)bpm
{
    if (!_initialized) {
        return;
    }
    [self stopClickSound];
    int state;
    alGetSourcei(_clickSrcId, AL_SOURCE_STATE, &state);
    if (state == AL_INITIAL || state == AL_STOPPED) {
        [self srcQueBufWithBeat:_beat Bpm:bpm];
    }
    alSourcei(_clickSrcId, AL_LOOPING, AL_TRUE);
    alSourcePlay(_clickSrcId);
}

- (void)playClickSoundOnce
{
    if (!_initialized) {
        return;
    }
    [self stopClickSound];
    int state;
    alGetSourcei(_clickSrcId, AL_SOURCE_STATE, &state);
    if (state == AL_INITIAL || state == AL_STOPPED) {
        [self srcQueBufWithBeat:4 Bpm:120];
    }
    alSourcei(_clickSrcId, AL_LOOPING, AL_FALSE);
    alSourcePlay(_clickSrcId);
}

- (void)stopClickSound
{
    if (!_initialized) {
        return;
    }
    
    int state;
    alGetSourcei(_clickSrcId, AL_SOURCE_STATE, &state);
    if (state == AL_PLAYING || state == AL_PAUSED) {
        alSourceStop(_clickSrcId);
    }
    alGetSourcei(_clickSrcId, AL_SOURCE_STATE, &state);
    if (state == AL_INITIAL || state == AL_STOPPED) {
        // remove buffers from queue
        ALenum err = AL_NO_ERROR;
        alSourcei(_clickSrcId, AL_BUFFER, AL_NONE);
        if ((err = alGetError()) != AL_NO_ERROR) {
            NSLog(@"error %d", err);
        }
        
        [self clearSilentBufferQueue];
        
        if ((err = alGetError()) != AL_NO_ERROR) {
            NSLog(@"error deleting %d", err);
        }
    }

}

- (uint)nextClickSoundId
{
    uint nextClickSound = [_dataKeeper soundIndex] + 1;
    if (nextClickSound == _tempoSounds.count) {
        nextClickSound = 0;
    }
    return nextClickSound;
}

- (void)switchClickSound:(uint)soundId
{
    if (soundId >= _tempoSounds.count) {
        NSLog(@"invalid soundIndex %d", soundId);
        return;
    }
    [_dataKeeper setSoundIndex:soundId];
}

- (void)adjustVolume:(float)volume
{
    alSourcef(_weightSrcId, AL_GAIN, volume);
    alSourcef(_blotSrcId, AL_GAIN, volume);
    alSourcef(_clickSrcId, AL_GAIN, volume);
}

- (uint)genSilentBuf:(UInt32)bufSz
{
    int err;
    uint bufId;
    alGenBuffers(1, &bufId);
    if ((err = alGetError()) != AL_NO_ERROR) {
        NSLog(@"error generate buffer %d", err);
        alDeleteBuffers(1, &bufId);
        return INT_MAX;
    }
    alBufferData(bufId, AL_FORMAT_STEREO16, _zeroBuf, bufSz, 44100);
    if ((err = alGetError()) != AL_NO_ERROR) {
        NSLog(@"error buffer data %d", err);
        alDeleteBuffers(1, &bufId);
        return INT_MAX;
    }
    [_queuedSilentBuf addObject:[NSNumber numberWithInt:bufId]];
    //NSLog(@"generate buf :%d size: %d", bufId, (unsigned int)bufSz);
    return bufId;
}

- (void)clearSilentBufferQueue
{
    NSUInteger count = [_queuedSilentBuf count];
    if (count > 2) {
        //NSAssert(NO, @"silent buffer is larger than 2");
        NSLog(@"silent buffer is larger than 2");
        return;
    }
    for (int i = 0; i < count; i++) {
        uint bufId = [(NSNumber *)_queuedSilentBuf[i] intValue];
        //NSLog(@"delete buf %d", bufId);
        alDeleteBuffers(1, &bufId);
    }
    [_queuedSilentBuf removeAllObjects];
}

- (void)setNullContext
{
    alcMakeContextCurrent(NULL);
}

- (void)restoreContext
{
    if (_alContext == 0) {
        NSLog(@"Error, _alContext is null");
        return;
    }
    ALCcontext *context = alcGetCurrentContext();
    //NSLog(@"current context = %p, alContext = %p", context, _alContext);
    if (context == NULL) {
        alcMakeContextCurrent(_alContext);
        alcProcessContext(_alContext);
    }
    
}

- (void)dealloc
{
    //NSLog(@"XYSALSoundMaker dealloc");
    alcMakeContextCurrent(NULL);
    alcDestroyContext(_alContext);
    alcCloseDevice(_alDevice);
    
    if (_zeroBuf) {
        free(_zeroBuf);
        _zeroBuf = NULL;
    }
    //TBD, sources, buffers
    alDeleteSources(1, &_weightSrcId);
    alDeleteSources(1, &_blotSrcId);
    alDeleteSources(1, &_clickSrcId);
    [self clearSilentBufferQueue];
}
@end
