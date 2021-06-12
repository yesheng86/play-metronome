//
//  XYSSliderThumbView.h
//  Play Metronome
//
//  Created by Xu Yesheng on 7/22/14.
//  Copyright (c) 2014 yesheng. All rights reserved.
//

#import "XYSPartView.h"

@interface XYSSliderThumbView : UIView

@property UIBezierPath *thumbPath;
@property UIBezierPath *thumbCore;
@property CGFloat width;
@property CGFloat height;

/* percentage is a 0-1 float value to represent:
 * hue if colorful == YES
 * brightness if colorful == NO
 */
@property CGFloat percentage;
@property BOOL colorful;
- (void)translateWithDy:(CGFloat)dy;
@end
