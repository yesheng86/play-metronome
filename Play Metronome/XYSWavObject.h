//
//  XYSWavObject.h
//  Play Metronome
//
//  Created by Xu Yesheng on 9/27/14.
//  Copyright (c) 2014 yesheng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XYSWavObject : NSObject
@property UInt32 bufSize;
@property unsigned int bufId;

- (id)initWithFileName:(NSString *)fileName;
@end
