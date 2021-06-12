//
//  XYSTranslatableView.h
//  Play Metronome
//
//  Created by Xu Yesheng on 9/12/14.
//  Copyright (c) 2014 yesheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XYSTranslatableView : UIView

- (void)startTranslateWithDx:(CGFloat)dx Dy:(CGFloat)dy;
- (void)stopTranslate;

@end
