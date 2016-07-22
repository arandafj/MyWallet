//
//  AGTBroker.m
//  Wallet
//
//  Created by CLAG on 18/7/16.
//  Copyright © 2016 Clag. All rights reserved.
//

#import "AGTBroker.h"
#import "AGTMoney.h"

@implementation AGTBroker

-(id)init {
    
    if (self = [super init]) {
        
        _rates = [@{}mutableCopy];
    }
    
    return self;
}

-(id<AGTMoney>)reduce:(id<AGTMoney>)money toCurrency:(NSString *)currency {
    
    //Double dispatch
    
    return [money reduceToCurrency:currency
                        withBroker:self];
    
}

-(void)addRate:(NSInteger)rate
  fromCurrency:(NSString *)fromCurrency
    toCurrency:(NSString *)toCurrency {
    
    [self.rates setObject:@(rate) forKey:[self keyFromCurrency:fromCurrency toCurrency:toCurrency]];
    
    [self.rates setObject:@(1.0/rate) forKey:[self keyFromCurrency:toCurrency
                                                        toCurrency:fromCurrency]];
}

-(NSString *) keyFromCurrency: (NSString *) fromCurrency toCurrency: (NSString *) toCurrency {
    
    return [NSString stringWithFormat:@"%@-%@", fromCurrency, toCurrency];
    
}

@end