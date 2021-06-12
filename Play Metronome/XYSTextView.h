//
//  XYSTextView.h
//  Play Metronome
//
//  Created by Xu Yesheng on 6/29/14.
//  Copyright (c) 2014 yesheng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XYSTranslatableView.h"

@interface XYSTextView : XYSTranslatableView
//@property UILabel *labelView;
//@property UILabel *textView;
@property CATextLayer *labelLayer;
@property CATextLayer *textLayer;
@property UIColor *lowlightColor;
@property UIColor *highlightColor;
@property BOOL highlightOn;

- (void)setLabel:(NSString *)label;
- (void)setText:(NSString *)text;
- (void)highlight;
- (void)lowlight;
- (void)setAlignment:(NSString *)alignment;


@end
