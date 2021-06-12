//
//  XYSManView.h
//  Play Metronome
//
//  Created by Xu Yesheng on 9/10/14.
//  Copyright (c) 2014 yesheng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XYSTranslatableView.h"

@interface XYSManView : XYSTranslatableView
@property UIImage *startManImg;
@property UIImage *stopManImg;
@property UIImage *tempoManImg;
@property UIImage *beatManImg;

- (void)appear;
- (void)hide;
@end
