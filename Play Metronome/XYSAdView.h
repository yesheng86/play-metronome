//
//  XYSAdView.h
//  Play Metronome
//
//  Created by Xu Yesheng on 9/12/14.
//  Copyright (c) 2014 yesheng. All rights reserved.
//
#import <iAd/iAd.h>
#import "XYSTranslatableView.h"


@interface XYSAdView : XYSTranslatableView
@property ADBannerView *adBannerView;
@property BOOL visible;
@property float height;
@end
