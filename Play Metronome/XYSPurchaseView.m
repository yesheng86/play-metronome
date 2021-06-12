//
//  XYSPurchaseView.m
//  Play Metronome
//
//  Created by Xu Yesheng on 10/5/14.
//  Copyright (c) 2014 yesheng. All rights reserved.
//

#import "XYSPurchaseView.h"

@implementation XYSPurchaseView
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setBounds:CGRectMake(0, 0, 220, 360)];
        [self setBackgroundColor:[UIColor darkGrayColor]];

        _titleView = [[UILabel alloc] initWithFrame:CGRectMake(20, 20, 180, 20)];
        [_titleView setTextColor:[UIColor whiteColor]];
        [_titleView setFont:[UIFont fontWithName:@"AppleGothic" size:12]];
        [_titleView setTextAlignment:NSTextAlignmentCenter];
        [_titleView setBackgroundColor:[UIColor clearColor]];
        [_titleView setText:NSLocalizedString(@"BuyFullVersionToUnlock:", @"Buy Full Version to Unlock:")];
        
        _descriptionView = [[UILabel alloc] initWithFrame:CGRectMake(70, 50, 140, 140)];
        [_descriptionView setTextColor:[UIColor whiteColor]];
        [_descriptionView setFont:[UIFont fontWithName:@"AppleGothic" size:12]];
        [_descriptionView setTextAlignment:NSTextAlignmentLeft];
        [_descriptionView setBackgroundColor:[UIColor clearColor]];
        [_descriptionView setNumberOfLines:9];
        
        _colorMetro = [[XYSSmallMetronomeView alloc] initWithFrame:CGRectMake(30, 40, 30, 45)];
        [_colorMetro setTransform:CGAffineTransformScale(CGAffineTransformIdentity, 0.7, 0.7)];
        [_colorMetro setCasingHue:0.0];
        [_colorMetro setBoardHue:0.6];
        [_colorMetro setWeightHue:0.2];
        
        _greyMetro = [[XYSSmallMetronomeView alloc] initWithFrame:CGRectMake(30, 70, 30, 45)];
        [_greyMetro setTransform:CGAffineTransformScale(CGAffineTransformIdentity, 0.7, 0.7)];
        [_greyMetro setCasingHue:0.6];
        [_greyMetro setBoardHue:0.1];
        [_greyMetro setWeightHue:0.8];
        [_greyMetro switchMode:GREYMODE];
        
        _draftMetro = [[XYSSmallMetronomeView alloc] initWithFrame:CGRectMake(30, 100, 30, 45)];
        [_draftMetro setTransform:CGAffineTransformScale(CGAffineTransformIdentity, 0.7, 0.7)];
        [_draftMetro setCasingHue:0.8];
        [_draftMetro setBoardHue:0.8];
        [_draftMetro setWeightHue:0.8];
        [_draftMetro switchMode:DRAFTMODE];
        
        _switchTextLayer = [CATextLayer layer];
        [_switchTextLayer setFrame:CGRectMake(42, 144, 8, 16)];
        [_switchTextLayer setForegroundColor:[UIColor whiteColor].CGColor];
        [_switchTextLayer setFontSize:10];
        [_switchTextLayer setContentsScale:2];
        [_switchTextLayer setString:[NSString stringWithFormat:@"9"]];
        
        _adTextLayer = [CATextLayer layer];
        [_adTextLayer setFrame:CGRectMake(38, 172, 32, 32)];
        [_adTextLayer setForegroundColor:[UIColor whiteColor].CGColor];
        [_adTextLayer setFontSize:10];
        [_adTextLayer setContentsScale:2];
        [_adTextLayer setString:[NSString stringWithFormat:@"AD"]];
        
        _buyButton = [[XYSTextButtonView alloc] initWithFrame:CGRectMake(40, 220, 140, 30)];
        [_buyButton setText:NSLocalizedString(@"BuyFor", @"Buy for ...")];
        
        _restoreButton = [[XYSTextButtonView alloc] initWithFrame:CGRectMake(40, 260, 140, 30)];
        [_restoreButton setText:NSLocalizedString(@"RestoreOldPurchase", @"Restore Old Purchase")];
        
        _cancelButton = [[XYSTextButtonView alloc] initWithFrame:CGRectMake(40, 300, 140, 30)];
        [_cancelButton setText:NSLocalizedString(@"Cancel", @"Cancel")];
        
        [self addSubview:_titleView];
        [self addSubview:_descriptionView];
        [self addSubview:_colorMetro];
        [self addSubview:_greyMetro];
        [self addSubview:_draftMetro];
        [self addSubview:_buyButton];
        [self addSubview:_restoreButton];
        [self addSubview:_cancelButton];
        [[self layer] addSublayer:_switchTextLayer];
        [[self layer] addSublayer:_adTextLayer];
        
        _purchaseUI = YES;
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    if (!_purchaseUI) {
        return;
    }
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGFloat radius = 9;
    CGPoint start = CGPointMake(25, 130);
    UIBezierPath *switchPath = [[UIBezierPath alloc] init];
    [switchPath appendPath:[UIBezierPath bezierPathWithArcCenter:CGPointMake(20 + start.x, 20 + start.y) radius:radius startAngle:-M_PI_2 endAngle:M_PI_4 clockwise:YES]];
    [switchPath appendPath:[UIBezierPath bezierPathWithArcCenter:CGPointMake(20 + start.x, 20 + start.y) radius:radius startAngle:M_PI_2 endAngle:5 * M_PI_4 clockwise:YES]];
    
    [switchPath moveToPoint:CGPointMake(20 + start.x - radius / sqrtf(2), 20 + start.y - radius / sqrtf(2))];
    [switchPath addLineToPoint:CGPointMake(20 + start.x - (radius + 6) / sqrtf(2), 23 + start.y - radius / sqrtf(2))];
    [switchPath moveToPoint:CGPointMake(20 + start.x - radius / sqrtf(2), 20 + start.y - radius / sqrtf(2))];
    [switchPath addLineToPoint:CGPointMake(20 + start.x - radius / sqrtf(2), 25 + start.y - radius / sqrtf(2))];
    
    
    [switchPath moveToPoint:CGPointMake(20 + start.x + radius / sqrtf(2), 20 + start.y + radius / sqrtf(2))];
    [switchPath addLineToPoint:CGPointMake(20 + start.x + (radius + 6) / sqrtf(2), 17 + start.y + radius / sqrtf(2))];
    [switchPath moveToPoint:CGPointMake(20 + start.x + radius / sqrtf(2), 20 + start.y + radius / sqrtf(2))];
    [switchPath addLineToPoint:CGPointMake(20 + start.x + radius / sqrtf(2), 15 + start.y + radius / sqrtf(2))];
    
    UIBezierPath *circlePath = [[UIBezierPath alloc] init];
    [circlePath appendPath:[UIBezierPath bezierPathWithOvalInRect:CGRectMake(35, 168, 20, 20)]];
    
    UIBezierPath *crossPath = [[UIBezierPath alloc] init];
    [crossPath moveToPoint:CGPointMake(35, 179)];
    [crossPath addLineToPoint:CGPointMake(55, 179)];
    
    CGContextSaveGState(context);
    [[UIColor whiteColor] setStroke];
    [switchPath stroke];
    [circlePath stroke];
    [[UIColor redColor] setStroke];
    [crossPath stroke];
    CGContextRestoreGState(context);
}

- (void)displayMessageUI:(NSString *)message
{
    [_descriptionView setText:message];
    if (!_purchaseUI) {
        [self setNeedsDisplay];
        return;
    }
    _purchaseUI = NO;
    [_descriptionView setTextAlignment:NSTextAlignmentCenter];
    [_descriptionView setTransform:CGAffineTransformTranslate([_descriptionView transform], -30, 40)];
    [_titleView setHidden:YES];
    [_buyButton setHidden:YES];
    [_restoreButton setHidden:YES];
    [_colorMetro setHidden:YES];
    [_greyMetro setHidden:YES];
    [_draftMetro setHidden:YES];
    [_switchIcon setHidden:YES];
    [_switchTextLayer setHidden:YES];
    [_adTextLayer setHidden:YES];
    [self setNeedsDisplay];
}

- (void)displayPurchaseUI
{
    if (_purchaseUI) {
        [self setNeedsDisplay];
        return;
    }
    _purchaseUI = YES;
    [_titleView setHidden:NO];
    [_descriptionView setText:[NSString stringWithFormat:
                                                         @"%@\n\n%@\n\n%@\n\n%@\n\n%@",
                                                         NSLocalizedString(@"3SlotsToSaveColors", @"3 slots to save colors"),
                                                         NSLocalizedString(@"GreyMode",@"Grey mode"),
                                                         NSLocalizedString(@"TransparentMode", @"Transparent mode"),
                                                         NSLocalizedString(@"6MoreSounds", @"6 more sounds"),
                                                         NSLocalizedString(@"RemoveAds", @"Remove Ads")]];
    [_descriptionView setTextAlignment:NSTextAlignmentLeft];
    [_descriptionView setTransform:CGAffineTransformTranslate([_descriptionView transform], 30, -40)];
    [_buyButton setHidden:NO];
    [_restoreButton setHidden:NO];
    [_colorMetro setHidden:NO];
    [_greyMetro setHidden:NO];
    [_draftMetro setHidden:NO];
    [_switchIcon setHidden:NO];
    [_switchTextLayer setHidden:NO];
    [_adTextLayer setHidden:NO];
    [self setNeedsDisplay];
}

- (void)appear
{
    [self startTranslateWithDx:-self.bounds.size.width Dy:0];
}

- (void)hide
{
    [self startTranslateWithDx:self.bounds.size.width Dy:0];
}
@end
