//
//  XYSStoreAgent.h
//  Play Metronome
//
//  Created by Xu Yesheng on 10/6/14.
//  Copyright (c) 2014 yesheng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <StoreKit/StoreKit.h>

typedef enum __PurchaseState
{
    PURCHASE_IDLE = 0,
    PROD_REQUESTING,
    PROD_REQUESTED,
    PROD_INVALID,
    PAY_REQUESTING,
    PAY_SUCCEED,
    PAY_FAILED,
    RESTORE_REQUESTING,
    RESTORE_SUCCEED,
    RESTORE_FAILED
}PurchaseState;

@protocol XYSStoreAgentDelegate <NSObject>
@required
- (void)storeAgentDidChangeState:(PurchaseState)state withObject:(id)object;
@end

@interface XYSStoreAgent : NSObject <SKProductsRequestDelegate, SKPaymentTransactionObserver>
@property PurchaseState purchaseState;
@property NSString *formattedPrice;
@property SKProduct *product;
@property id<XYSStoreAgentDelegate> delegate;

+ (XYSStoreAgent *)sharedInstance;
- (void)requestFullVersionProduct;
- (void)requestPayment;
- (void)requestRestore;
- (void)changeState:(PurchaseState)state;
- (void)finishTransaction:(SKPaymentTransaction *)transaction;
@end



