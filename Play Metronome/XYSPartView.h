//
//  XYSPartView.h
//  Play Metronome
//
//  Created by Xu Yesheng on 5/25/14.
//  Copyright (c) 2014 yesheng. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum __ViewMode
{
    COLORMODE = 0,
    DRAFTMODE,
    GREYMODE
} ViewMode;

@interface XYSPartView : UIView
@property CGFloat fillHue;
@property CGFloat strokeHue;
@property CGFloat saturation;
@property CGFloat brightnessDelta;
@property CGFloat darkFactor;
@property NSArray *faces;

@property ViewMode viewMode;
@end
