//
//  AGTBroker.h
//  Wallet
//
//  Created by CLAG on 18/7/16.
//  Copyright © 2016 Clag. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AGTMoney.h"

@interface AGTBroker : NSObject

@property (strong, nonatomic) NSMutableDictionary *rates;

-(id<AGTMoney>) reduce: (id<AGTMoney>) money toCurrency: (NSString *) currency;

-(void) addRate: (NSInteger) rate
   fromCurrency: (NSString *) fromCurrency
     toCurrency: (NSString *) toCurrency;

-(NSString *) keyFromCurrency: (NSString *) fromCurrency toCurrency: (NSString *) toCurrency;

@end
