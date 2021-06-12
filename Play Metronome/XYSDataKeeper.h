//
//  XYSDataKeeper.h
//  Play Metronome
//
//  Created by Xu Yesheng on 8/30/14.
//  Copyright (c) 2014 yesheng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XYSDataKeeper : NSObject
+ (XYSDataKeeper *)sharedInstance;

// following are set by metronome view
@property BOOL beating;
@property float rotateAngle;

// followings are set by configure view
@property float casingHue;
@property float boardHue;
@property float weightHue;
@property float volume;
@property float brightness;

/* following values are to be stored
 * to persistance area
 * start - store to disk
 */
// if purchased
@property float ch0;
@property float bh0;
@property float wh0;

@property float ch1;
@property float bh1;
@property float wh1;

@property float ch2;
@property float bh2;
@property float wh2;

@property float ch3;
@property float bh3;
@property float wh3;

@property float ch4;
@property float bh4;
@property float wh4;

@property uint focusIndex;
@property uint soundIndex;
@property uint tempo;
@property uint beat;
@property BOOL purchased;
/* end - store to disk */

- (void)loadData;
- (void)storeData;
- (void)storePurchased;
@end
