//
//  XYSStoreAgent.m
//  Play Metronome
//
//  Created by Xu Yesheng on 10/6/14.
//  Copyright (c) 2014 yesheng. All rights reserved.
//

#import "XYSStoreAgent.h"

@implementation XYSStoreAgent

+ (XYSStoreAgent *)sharedInstance
{
    static XYSStoreAgent *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[XYSStoreAgent alloc] init];
        
    });
    return sharedInstance;
}

- (id)init
{
    [[SKPaymentQueue defaultQueue] addTransactionObserver:self];
    _purchaseState = PURCHASE_IDLE;
    _delegate = NULL;
    return self;
}

- (void)requestFullVersionProduct
{
    if (_purchaseState == PROD_REQUESTING) {
        NSURL *pidUrl = [[NSBundle mainBundle] URLForResource:@"Product Id" withExtension:@"plist"];
        NSArray *productIds = [NSArray arrayWithContentsOfURL:pidUrl];
        if (productIds.count != 1) {
            NSLog(@"product id array count is supposed to be 1 but is %lu", (unsigned long)productIds.count);
            return;
        }
        SKProductsRequest *productReq = [[SKProductsRequest alloc] initWithProductIdentifiers:[NSSet setWithArray:productIds]];
        productReq.delegate = self;
        [productReq start];
    }
}

// Sent immediately before -requestDidFinish:
- (void)productsRequest:(SKProductsRequest *)request didReceiveResponse:(SKProductsResponse *)response
{
    NSArray *products = response.products;
    if (products.count != 1) {
        NSLog(@"product sould be 1 but is %lu", (unsigned long)products.count);
        [self setPurchaseState:PROD_INVALID];
        return;
    }
    _product = (SKProduct *)products[0];
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    [numberFormatter setFormatterBehavior:NSNumberFormatterBehavior10_4];
    [numberFormatter setNumberStyle:NSNumberFormatterCurrencyStyle];
    [numberFormatter setLocale:_product.priceLocale];
    _formattedPrice = [numberFormatter stringFromNumber:_product.price];
    //[self setPurchaseState:PROD_REQUESTED];
    [self changeState:PROD_REQUESTED];
}


- (void)requestPayment
{
    if (_purchaseState == PAY_REQUESTING) {
        SKPayment *payment = [SKPayment paymentWithProduct:_product];
        [[SKPaymentQueue defaultQueue] addPayment:payment];
    }
}

- (void)requestRestore
{
    if (_purchaseState == RESTORE_REQUESTING) {
        [[SKPaymentQueue defaultQueue] restoreCompletedTransactions];
    }
}

// Sent when the transaction array has changed (additions or state changes).  Client should check state of transactions and finish as appropriate.
- (void)paymentQueue:(SKPaymentQueue *)queue updatedTransactions:(NSArray *)transactions
{
    for (SKPaymentTransaction *transaction in transactions) {
        //NSLog(@"paymentQueueUpdatedTransaction with state %ld", transaction.transactionState);
        switch (transaction.transactionState) {
            case SKPaymentTransactionStatePurchasing:
                //[self changeState:PAY_REQUESTING withTransation:transaction];
                break;
            case SKPaymentTransactionStatePurchased:
                [self changeState:PAY_SUCCEED withObject:transaction];
                break;
            case SKPaymentTransactionStateFailed:
                //NSLog(@"SKPaymentTransactionStateFailed with code: %ld", (long)transaction.error.code);
                [self changeState:PAY_FAILED withObject:transaction];
                break;
            case SKPaymentTransactionStateRestored:
                [self changeState:RESTORE_SUCCEED withObject:transaction];
                break;
            default:
                break;
        }
        
    }
    
}

- (void)changeState:(PurchaseState)state
{
    [self changeState:state withObject:NULL];
}

- (void)changeState:(PurchaseState)state withObject:(id)object
{
    _purchaseState = state;
    if (_delegate == NULL) {
        NSLog(@"Store agent delegate is NULL");
        return;
    }
    if ([_delegate respondsToSelector:@selector(storeAgentDidChangeState:withObject:)]) {
        [_delegate storeAgentDidChangeState:state withObject:object];
    }
}

- (void)finishTransaction:(SKPaymentTransaction *)transaction
{
    if (transaction != NULL) {
        [[SKPaymentQueue defaultQueue] finishTransaction:transaction];
    }
}

// Sent when transactions are removed from the queue (via finishTransaction:).
- (void)paymentQueue:(SKPaymentQueue *)queue removedTransactions:(NSArray *)transactions
{
    NSLog(@"paymentQueueRemovedTransactions");
}

// Sent when an error is encountered while adding transactions from the user's purchase history back to the queue.
- (void)paymentQueue:(SKPaymentQueue *)queue restoreCompletedTransactionsFailedWithError:(NSError *)error
{
    NSLog(@"paymentQueueRestoreCompletedTransactionsFailedWithError %@", error);
    [self changeState:RESTORE_FAILED withObject:error];
}

// Sent when all transactions from the user's purchase history have successfully been added back to the queue.
- (void)paymentQueueRestoreCompletedTransactionsFinished:(SKPaymentQueue *)queue
{
    NSLog(@"paymentQueueRestoreCompletedTransactionsFinished queue count = %lu", (unsigned long)queue.transactions.count);
    if (queue.transactions.count == 0) {
        [self changeState:RESTORE_FAILED];
    }
}

// Sent when the download state has changed.
-(void)paymentQueue:(SKPaymentQueue *)queue updatedDownloads:(NSArray *)downloads
{
    NSLog(@"paymentQueueUpdatedDownloads");
}
@end
