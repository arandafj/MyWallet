//
//  AGTWallet.m
//  Wallet
//
//  Created by CLAG on 18/7/16.
//  Copyright © 2016 Clag. All rights reserved.
//

#import "AGTWallet.h"
#import "AGTMoney.h"


@interface AGTWallet ()


@property (strong, nonatomic) NSMutableArray *euros;
@property (strong, nonatomic) NSMutableArray *dollars;

@end

@implementation AGTWallet


#pragma mark - Init

-(id)initWithAmount:(NSInteger)amount currency:(NSString *)currency {
    
    if (self = [super init]) {
        
        AGTMoney *money = [[AGTMoney alloc] initWithAmount:amount currency:currency];
        
        _euros = [@[]mutableCopy];
        _dollars = [@[]mutableCopy];
        
        if ([self isEuro:money]) {
            [self.euros addObject:money];
            
        } else if ([self isDollar:money]) {
            [self.dollars addObject:money];
        }
    }
    
    return self;
}

-(NSUInteger) eurosCount {
    
    return self.euros.count;
}

-(NSUInteger)dollarCount {
    
    return self.dollars.count;
}

-(NSUInteger)currenciesCount {
    
    return 2;
}

#pragma mark - Operations

-(id<AGTMoney>)plus:(AGTMoney *)money {
    
    [self addMoneyToWallet:money];
    
    return self;
}

-(id<AGTMoney>)times:(NSInteger)multiplier {
    
    NSMutableArray *newEuros = [NSMutableArray arrayWithCapacity:self.euros.count];
    NSMutableArray *newDollars = [NSMutableArray arrayWithCapacity:self.dollars.count];
    
    
    
    for (AGTMoney *euro in self.euros) {
        AGTMoney *newMoney = [euro times:multiplier];
        
        [newEuros addObject:newMoney];
    }
    
    for (AGTMoney *dollar in self.dollars) {
        AGTMoney *newMoney = [dollar times:multiplier];
        
        [newDollars addObject:newMoney];
    }
    
    
    self.euros = newEuros;
    self.dollars = newDollars;
    
    return self;
}

-(id<AGTMoney>)reduceToCurrency:(NSString *)currency withBroker:(AGTBroker *)broker {
    
    AGTMoney *result = [[AGTMoney alloc] initWithAmount:0 currency:currency];
    
    for (AGTMoney *euro in self.euros) {
        
        result = [result plus: [euro reduceToCurrency:currency withBroker:broker]];
    }
    
    for (AGTMoney *dollar in self.dollars) {
        
        result = [result plus: [dollar reduceToCurrency:currency withBroker:broker]];
    }
    
    return result;
}

#pragma mark - Datasource

-(AGTMoney *)euroAtIndex:(NSUInteger)index {
    
    return self.euros[index];
}

-(AGTMoney *)dollarAtIndex:(NSUInteger)index {
    
    return self.dollars[index];
}

-(NSUInteger)totalEurosValue {
    
    AGTMoney *total = [AGTMoney euroWitAmount:0];;
    
    for (AGTMoney *euro in self.euros) {
        total = [total plus:euro];
    }
    
    return [total.amount integerValue];
}

-(NSUInteger)totalDollarsValue {
    
    AGTMoney *total = [AGTMoney dollarWithAmount:0];;
    
    for (AGTMoney *dollar in self.dollars) {
        total = [total plus:dollar];
    }
    
    return [total.amount integerValue];
}

#pragma mark - Private

-(void) addMoneyToWallet: (AGTMoney *) money {
    
    if ([self isEuro:money]) {
        [self.euros addObject:money];
        
    } else if ([self isDollar:money]) {
        [self.dollars addObject:money];
    }
    
}

-(BOOL) isEuro: (AGTMoney *) money {
    
    return [money.currency isEqual:@"EUR"];
}

-(BOOL) isDollar: (AGTMoney *) money {
    
    return [money.currency isEqual:@"USD"];
}

@end
