//
//  XYSPurchaseView.h
//  Play Metronome
//
//  Created by Xu Yesheng on 10/5/14.
//  Copyright (c) 2014 yesheng. All rights reserved.
//

#import "XYSTranslatableView.h"
#import "XYSTextButtonView.h"
#import "XYSSmallMetronomeView.h"
#import "XYSSwitchButtonView.h"

@interface XYSPurchaseView : XYSTranslatableView
@property UILabel *titleView;
@property UILabel *descriptionView;
@property XYSTextButtonView *buyButton;
@property XYSTextButtonView *restoreButton;
@property XYSTextButtonView *cancelButton;
@property XYSSmallMetronomeView *colorMetro;
@property XYSSmallMetronomeView *greyMetro;
@property XYSSmallMetronomeView *draftMetro;
@property XYSSwitchButtonView *switchIcon;
@property CATextLayer *switchTextLayer;
@property CATextLayer *adTextLayer;
@property BOOL purchaseUI;
- (void)displayMessageUI:(NSString *)message;
- (void)displayPurchaseUI;
- (void)appear;
- (void)hide;
@end
