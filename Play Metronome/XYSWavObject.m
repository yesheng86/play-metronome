//
//  XYSWavObject.m
//  Play Metronome
//
//  Created by Xu Yesheng on 9/27/14.
//  Copyright (c) 2014 yesheng. All rights reserved.
//

#import "XYSWavObject.h"
#include "OPENAL/al.h"
#include "OPENAL/alc.h"
#import "AudioToolbox/AudioFile.h"

@implementation XYSWavObject

- (id)initWithFileName:(NSString *)fileName
{
    self = [super init];
    if (self) {
        int err;
        AudioFileID audioId = [self openWavFile:fileName];
        _bufSize = [self audioFileSize:audioId];
        //NSLog(@"%@.wav size: %d", fileName, (unsigned int)_bufSize);
        
        unsigned char *buf = malloc(_bufSize);
        OSStatus status = noErr;
        status = AudioFileReadBytes(audioId, true, 0, &_bufSize, buf);
        AudioFileClose(audioId);
        
        if (status != 0) {
            if (buf) {
                free(buf);
                buf = NULL;
            }
            NSAssert(NO, @"failed to load %@.wav", fileName);
            //return NULL;
        }
        
        alGenBuffers(1, &_bufId);
        if ((err = alGetError()) != AL_NO_ERROR) {
            if (buf) {
                free(buf);
                buf = NULL;
            }
            alDeleteBuffers(1, &_bufId);
            NSAssert(NO, @"error generate buffer %d", err);
            //return NULL;
        }
        alBufferData(_bufId, AL_FORMAT_STEREO16, buf, _bufSize, 44100);
        if ((err = alGetError()) != AL_NO_ERROR) {
            if (buf) {
                free(buf);
                buf = NULL;
            }
            alDeleteBuffers(1, &_bufId);
            NSAssert(NO, @"error buffer data %d", err);
            //return NULL;
        }
        
        if (buf) {
            free(buf);
            buf = NULL;
        }
        
    }
    return self;
}

- (AudioFileID)openWavFile:(NSString *)fileName
{
    AudioFileID afid;
    NSURL *afUrl = [[NSBundle mainBundle] URLForResource:fileName withExtension:@"wav"];
    OSStatus status = AudioFileOpenURL((__bridge CFURLRef)afUrl, kAudioFileReadPermission, 0, &afid);
    if (status != 0) {
        NSAssert(NO, @"failed to open wav file: %@", fileName);
    }
    return afid;
}

- (UInt32)audioFileSize:(AudioFileID)afid
{
    UInt64 dataSize = 0;
    UInt32 propSize = sizeof(UInt64);
    OSStatus status = AudioFileGetProperty(afid, kAudioFilePropertyAudioDataByteCount, &propSize, &dataSize);
    if (status != 0) {
        NSAssert(NO, @"failed to get file size");
    }
    return (UInt32)dataSize;
}

- (void)dealloc
{
    if (self) {
        alDeleteBuffers(1, &_bufId);
    }
}
@end
