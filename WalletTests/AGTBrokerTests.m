//
//  AGTBrokerTests.m
//  Wallet
//
//  Created by CLAG on 18/7/16.
//  Copyright © 2016 Clag. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <UIKit/UIKit.h>
#import "AGTMoney.h"
#import "AGTBroker.h"

@interface AGTBrokerTests : XCTestCase

@property (strong, nonatomic) AGTBroker *emptyBroker;
@property (strong, nonatomic) AGTMoney *oneDollar;

@end

@implementation AGTBrokerTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    self.emptyBroker = [AGTBroker new];
    self.oneDollar   = [AGTMoney dollarWithAmount:1];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
    // self.emptyBroker = nil;
    // self.oneDollar = nil;
}

-(void) testSimpleReduction {
    
    
    AGTMoney *sum = [[AGTMoney dollarWithAmount:5] plus:[AGTMoney dollarWithAmount:5]];
    
    AGTMoney *reduced = [self.emptyBroker reduce:sum toCurrency: @"USD"];
    
    XCTAssertEqualObjects(sum, reduced, @"Conversion to same currency should be a NOP");
}

// 10$ == 5€ 2:1

-(void) testReduction {
    
    [self.emptyBroker addRate:2 fromCurrency:@"EUR" toCurrency:@"USD"];
    
    AGTMoney *dollars = [AGTMoney dollarWithAmount:10];
    AGTMoney *euros = [AGTMoney euroWitAmount:5];
    
    AGTMoney *converted = [self.emptyBroker reduce:dollars toCurrency:@"EUR"];
    
    XCTAssertEqualObjects(converted, euros, @"$10 == €5 2:1");
    
}

-(void) testThatNoRateRaisesException {
    
    XCTAssertThrows([self.emptyBroker reduce:self.oneDollar toCurrency:@"EUR"], @"No rates should case exception");
    
}

-(void) testThatNilConversionDoesNotChangeMoney {
    
    
    XCTAssertEqualObjects(self.oneDollar, [self.emptyBroker reduce:self.oneDollar
                                                        toCurrency:@"USD"], @"A nil conversion should have not effect");
}

@end

