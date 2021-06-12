//
//  XYSButtonView.m
//  Play Metronome
//
//  Created by Xu Yesheng on 10/5/14.
//  Copyright (c) 2014 yesheng. All rights reserved.
//

#import "XYSButtonView.h"

@implementation XYSButtonView
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _fillColor = [UIColor colorWithWhite:0.2 alpha:1];
    }
    return self;
}

- (void)highLight:(BOOL)highlight
{
    if (highlight) {
        _fillColor = [UIColor colorWithWhite:0.4 alpha:1];
    }
    else {
        _fillColor = [UIColor colorWithWhite:0.2 alpha:1];
    }
}
@end
