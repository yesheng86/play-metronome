//
//  XYSSwitchButtonView.h
//  Play Metronome
//
//  Created by Xu Yesheng on 8/10/14.
//  Copyright (c) 2014 yesheng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XYSButtonView.h"

@interface XYSSwitchButtonView : XYSButtonView
@property CATextLayer *textLayer;
- (void)updateText:(uint)num;
@end
