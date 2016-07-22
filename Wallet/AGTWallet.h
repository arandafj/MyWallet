//
//  AGTWallet.h
//  Wallet
//
//  Created by CLAG on 18/7/16.
//  Copyright © 2016 Clag. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AGTMoney.h"

@interface AGTWallet : NSObject<AGTMoney>

@property (nonatomic, readonly) NSUInteger eurosCount;
@property (nonatomic, readonly) NSUInteger dollarCount;
@property (nonatomic, readonly) NSUInteger currenciesCount;

-(AGTMoney *) euroAtIndex: (NSUInteger) index;

-(AGTMoney *) dollarAtIndex: (NSUInteger) index;

-(NSUInteger) totalEurosValue;

-(NSUInteger) totalDollarsValue;

@end

