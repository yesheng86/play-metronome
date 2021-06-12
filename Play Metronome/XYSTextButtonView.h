//
//  XYSTextButtonView.h
//  Play Metronome
//
//  Created by Xu Yesheng on 10/5/14.
//  Copyright (c) 2014 yesheng. All rights reserved.
//

#import "XYSButtonView.h"

@interface XYSTextButtonView : XYSButtonView
@property UILabel *labelString;
- (void)setText:(NSString *)text;
@end
