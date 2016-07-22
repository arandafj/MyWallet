//
//  AGTMoney.m
//  Wallet
//
//  Created by CLAG on 18/7/16.
//  Copyright © 2016 Clag. All rights reserved.
//

#import "AGTMoney.h"
#import "NSObject+GNUStep.h"
#import "AGTBroker.h"

@interface AGTMoney ()

@property (strong, nonatomic) NSNumber *amount;

@end

@implementation AGTMoney

#pragma mark - Init

-(id) initWithAmount:(NSInteger) amount currency:(NSString *)currency {
    
    if (self = [super init]) {
        self.amount = @(amount);
        _currency = currency;
    }
    
    return self;
    
}

+(instancetype) dollarWithAmount: (NSInteger) amount {
    
    AGTMoney *dollar = [[AGTMoney alloc] initWithAmount:amount currency:@"USD"];
    
    return dollar;
    
}

+(instancetype) euroWitAmount: (NSInteger) amount {
    
    AGTMoney *euro = [[AGTMoney alloc] initWithAmount:amount currency:@"EUR"];
    
    return euro;
    
}

#pragma mark - Operations

-(id<AGTMoney>) times: (NSInteger) multiplier {
    
    return [[AGTMoney alloc] initWithAmount:[self.amount integerValue] * multiplier currency:self.currency];
}

-(id<AGTMoney>) plus: (AGTMoney *) other {
    
    NSUInteger totalAmount = [self.amount integerValue] + [other.amount integerValue];
    
    AGTMoney *total = [[AGTMoney alloc] initWithAmount:totalAmount
                                              currency:self.currency];
    
    return total;
}

-(id<AGTMoney>)reduceToCurrency:(NSString *)currency withBroker:(AGTBroker *)broker {
    
    // Comprabamos que divisa de origen y destino son las mismas
    AGTMoney *result;
    
    double rate = [[broker.rates objectForKey:[broker keyFromCurrency:self.currency
                                                           toCurrency:currency]] doubleValue];
    
    if ([self.currency isEqual:currency]) {
        result = self;
        
    } else if (rate == 0) {
        // No hay tasa de conversión, excepción al canto
        
        [NSException raise:@"NoConversionRateException"
                    format:@"Must have a conversion from %@ to %@", self.currency, currency];
    } else {
        // Tenemos conversión
        
        double newAmount = [self.amount integerValue] * rate;
        
        result = [[AGTMoney alloc] initWithAmount:newAmount
                                         currency:currency];
    }
    
    return result;
    
}


#pragma mark - Overwritten

-(NSString *)description {
    
    return [NSString stringWithFormat:@"<%@: %@ %@>", [self class], self.currency, self.amount];
    
}

#pragma mark -Equality

-(BOOL) isEqual:(id)object {
    
    return ([self amount] == [object amount])
    && ([self.currency isEqual:[object currency]]);
    
}

-(NSUInteger) hash {
    
    return [self.amount integerValue];
}

@end