//
//  XYSScaleView.h
//  Play Metronome
//
//  Created by Xu Yesheng on 8/2/14.
//  Copyright (c) 2014 yesheng. All rights reserved.
//

#import "XYSPartView.h"

@interface XYSScaleView : XYSPartView
- (uint) tempoWithPointFromTop:(float)pointFromTop;
- (float) pointFromTopWithTempo:(uint)tempo;
/*
- (CGFloat)nearestScale:(CGFloat)pointFromTop;
- (NSString *)tempoStringWithIndex:(uint)index;
- (uint)bpmWithIndex:(uint)index;
- (uint)tempoIndexWithPointFromTop:(CGFloat)pointFromTop;
 */
@end
