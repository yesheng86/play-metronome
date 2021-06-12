//
//  XYSBlotView.h
//  Play Metronome
//
//  Created by Xu Yesheng on 5/31/14.
//  Copyright (c) 2014 yesheng. All rights reserved.
//

#import "XYSPartView.h"

@interface XYSBlotView : XYSPartView

//@property NSUInteger beatIndex;
@property CGFloat originX;

/*
- (Boolean)beatIndexUpdatedWithLocationX:(float)locationX;
- (CGFloat)currentIndexDeltaX;
- (uint)currentBeatNumber;
 */
- (uint)beatNumberFromLocationX:(float)locationX;
- (void)translateWithBeatNumber:(uint)beat;
@end
