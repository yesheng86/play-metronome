//
//  XYSDataKeeper.m
//  Play Metronome
//
//  Created by Xu Yesheng on 8/30/14.
//  Copyright (c) 2014 yesheng. All rights reserved.
//

#import "XYSDataKeeper.h"

@implementation XYSDataKeeper
+ (XYSDataKeeper *)sharedInstance
{
    static XYSDataKeeper *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[XYSDataKeeper alloc] init];
        
    });
    return sharedInstance;
}

- (id)init
{
    static const uint N_ENTRIES = 20;
    NSDictionary *dataDictionary;
    NSString *keyArray[N_ENTRIES];
    NSNumber *valueArray[N_ENTRIES];
    [self s];
    
    keyArray[0] = [NSString stringWithFormat:@"XYS_CH0"];
    valueArray[0] = [NSNumber numberWithFloat:_ch0];
    keyArray[1] = [NSString stringWithFormat:@"XYS_BH0"];
    valueArray[1] = [NSNumber numberWithFloat:_bh0];
    keyArray[2] = [NSString stringWithFormat:@"XYS_WH0"];
    valueArray[2] = [NSNumber numberWithFloat:_wh0];
    keyArray[3] = [NSString stringWithFormat:@"XYS_CH1"];
    valueArray[3] = [NSNumber numberWithFloat:_ch1];
    keyArray[4] = [NSString stringWithFormat:@"XYS_BH1"];
    valueArray[4] = [NSNumber numberWithFloat:_bh1];
    keyArray[5] = [NSString stringWithFormat:@"XYS_WH1"];
    valueArray[5] = [NSNumber numberWithFloat:_wh1];
    keyArray[6] = [NSString stringWithFormat:@"XYS_CH2"];
    valueArray[6] = [NSNumber numberWithFloat:_ch2];
    keyArray[7] = [NSString stringWithFormat:@"XYS_BH2"];
    valueArray[7] = [NSNumber numberWithFloat:_bh2];
    keyArray[8] = [NSString stringWithFormat:@"XYS_WH2"];
    valueArray[8] = [NSNumber numberWithFloat:_wh2];
    keyArray[9] = [NSString stringWithFormat:@"XYS_CH3"];
    valueArray[9] = [NSNumber numberWithFloat:_ch3];
    keyArray[10] = [NSString stringWithFormat:@"XYS_BH3"];
    valueArray[10] = [NSNumber numberWithFloat:_bh3];
    keyArray[11] = [NSString stringWithFormat:@"XYS_WH3"];
    valueArray[11] = [NSNumber numberWithFloat:_wh3];
    keyArray[12] = [NSString stringWithFormat:@"XYS_CH4"];
    valueArray[12] = [NSNumber numberWithFloat:_ch4];
    keyArray[13] = [NSString stringWithFormat:@"XYS_BH4"];
    valueArray[13] = [NSNumber numberWithFloat:_bh4];
    keyArray[14] = [NSString stringWithFormat:@"XYS_WH4"];
    valueArray[14] = [NSNumber numberWithFloat:_wh4];
    
    keyArray[15] = [NSString stringWithFormat:@"XYS_FOCUS"];
    valueArray[15] = [NSNumber numberWithInt:_focusIndex];
    keyArray[16] = [NSString stringWithFormat:@"XYS_SOUND"];
    valueArray[16] = [NSNumber numberWithInt:_soundIndex];
    keyArray[17] = [NSString stringWithFormat:@"XYS_TEMPO"];
    valueArray[17] = [NSNumber numberWithInt:_tempo];
    keyArray[18] = [NSString stringWithFormat:@"XYS_BEAT"];
    valueArray[18] = [NSNumber numberWithInt:_beat];
    keyArray[19] = [NSString stringWithFormat:@"XYS_PURCHASED"];
    valueArray[19] = [NSNumber numberWithBool:_purchased];
    

    dataDictionary = [NSDictionary dictionaryWithObjects:valueArray forKeys:keyArray count:N_ENTRIES];
    [[NSUserDefaults standardUserDefaults] registerDefaults:dataDictionary];
    return self;
}


- (void)setDefault
{
    _ch0 = 0.6;
    _bh0 = 0.2;
    _wh0 = 0.2;
    _ch1 = 0.2;
    _bh1 = 0.4;
    _wh1 = 0.5;
    _ch2 = 1.0;
    _bh2 = 0.5;
    _wh2 = 0.5;
    _ch3 = 0.6;
    _bh3 = 0.1;
    _wh3 = 1.0;
    _ch4 = 0.5;
    _bh4 = 0.8;
    _wh4 = 0.5;
    
    _focusIndex = 0;
    _soundIndex = 0;
    _tempo = 80;
    _beat = 2;
    _purchased = NO;
    
    _beating = NO;
    _rotateAngle = 0;
    _casingHue = _ch0;
    _boardHue = _bh0;
    _weightHue = _wh0;
    _volume = 1.0;
    _brightness = 1.0;
}

- (void)loadData
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    _casingHue = 2.0;
    _boardHue = 2.0;
    _weightHue = 2.0;
    _brightness = 1.0;
    _volume = 1.0;
    _tempo = 40;
    _beat = 0;
    _soundIndex = 0;
    _focusIndex = 0;
    _purchased = NO;
    
    _ch0 = [userDefaults floatForKey:@"XYS_CH0"];
    _bh0 = [userDefaults floatForKey:@"XYS_BH0"];
    _wh0 = [userDefaults floatForKey:@"XYS_WH0"];
    _ch1 = [userDefaults floatForKey:@"XYS_CH1"];
    _bh1 = [userDefaults floatForKey:@"XYS_BH1"];
    _wh1 = [userDefaults floatForKey:@"XYS_WH1"];
    _ch2 = [userDefaults floatForKey:@"XYS_CH2"];
    _bh2 = [userDefaults floatForKey:@"XYS_BH2"];
    _wh2 = [userDefaults floatForKey:@"XYS_WH2"];
    _ch3 = [userDefaults floatForKey:@"XYS_CH3"];
    _bh3 = [userDefaults floatForKey:@"XYS_BH3"];
    _wh3 = [userDefaults floatForKey:@"XYS_WH3"];
    _ch4 = [userDefaults floatForKey:@"XYS_CH4"];
    _bh4 = [userDefaults floatForKey:@"XYS_BH4"];
    _wh4 = [userDefaults floatForKey:@"XYS_WH4"];
    
    _focusIndex = (uint)[userDefaults integerForKey:@"XYS_FOCUS"];
    _soundIndex = (uint)[userDefaults integerForKey:@"XYS_SOUND"];
    [self setTempo:(uint)[userDefaults integerForKey:@"XYS_TEMPO"]];
    [self setBeat:(uint)[userDefaults integerForKey:@"XYS_BEAT"]];
    [self setPurchased:[userDefaults boolForKey:@"XYS_PURCHASED"]];
    
    if (_purchased == NO) {
        _focusIndex = 0;
        if (_soundIndex >= 3) {
            _soundIndex = 0;
        }
    }
    //[self setPurchased:YES];

    switch (_focusIndex) {
        case 0:
            [self setCasingHue:_ch0];
            [self setBoardHue:_bh0];
            [self setWeightHue:_wh0];
            break;
        case 1:
            [self setCasingHue:_ch1];
            [self setBoardHue:_bh1];
            [self setWeightHue:_wh1];
            break;
        case 2:
            [self setCasingHue:_ch2];
            [self setBoardHue:_bh2];
            [self setWeightHue:_wh2];
            break;
        case 3:
            [self setCasingHue:_ch3];
            [self setBoardHue:_bh3];
            [self setWeightHue:_wh3];
            break;
        case 4:
            [self setCasingHue:_ch4];
            [self setBoardHue:_bh4];
            [self setWeightHue:_wh4];
            break;
        default:
            break;
    }

    [self setBrightness:_brightness];
    [self setVolume:_volume];
}

- (void)storeData
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];

    [userDefaults setFloat:_ch0 forKey:@"XYS_CH0"];
    [userDefaults setFloat:_bh0 forKey:@"XYS_BH0"];
    [userDefaults setFloat:_wh0 forKey:@"XYS_WH0"];
    [userDefaults setFloat:_ch1 forKey:@"XYS_CH1"];
    [userDefaults setFloat:_bh1 forKey:@"XYS_BH1"];
    [userDefaults setFloat:_wh1 forKey:@"XYS_WH1"];
    [userDefaults setFloat:_ch2 forKey:@"XYS_CH2"];
    [userDefaults setFloat:_bh2 forKey:@"XYS_BH2"];
    [userDefaults setFloat:_wh2 forKey:@"XYS_WH2"];
    [userDefaults setFloat:_ch3 forKey:@"XYS_CH3"];
    [userDefaults setFloat:_bh3 forKey:@"XYS_BH3"];
    [userDefaults setFloat:_wh3 forKey:@"XYS_WH3"];
    [userDefaults setFloat:_ch4 forKey:@"XYS_CH4"];
    [userDefaults setFloat:_bh4 forKey:@"XYS_BH4"];
    [userDefaults setFloat:_wh4 forKey:@"XYS_WH4"];
    [userDefaults setInteger:_focusIndex forKey:@"XYS_FOCUS"];
    [userDefaults setInteger:_soundIndex forKey:@"XYS_SOUND"];
    [userDefaults setInteger:_tempo forKey:@"XYS_TEMPO"];
    [userDefaults setInteger:_beat forKey:@"XYS_BEAT"];
    
    [self storePurchased];
    [userDefaults synchronize];
}

- (void)storePurchased
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    BOOL purchased = [userDefaults boolForKey:@"XYS_PURCHASED"];
    if (purchased == NO && _purchased == YES) {
        [userDefaults setInteger:YES forKey:@"XYS_PURCHASED"];
    }
}
@end
