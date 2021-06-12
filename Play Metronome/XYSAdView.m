//
//  XYSAdView.m
//  Play Metronome
//
//  Created by Xu Yesheng on 9/12/14.
//  Copyright (c) 2014 yesheng. All rights reserved.
//

#import "XYSAdView.h"
#import <iAd/iAd.h>

@implementation XYSAdView

- (id)init
{
    self = [super init];
    if (self) {
        _adBannerView = [[ADBannerView alloc] initWithAdType:ADAdTypeBanner];
        [self addSubview:_adBannerView];
        _visible = NO;
    }
    return self;
}

@end
