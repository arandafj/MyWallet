//
//  AGTMoneyTests.m
//  Wallet
//
//  Created by CLAG on 18/7/16.
//  Copyright © 2016 Clag. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <UIKit/UIKit.h>
#import "AGTMoney.h"

@interface AGTMoneyTests : XCTestCase

@end

@implementation AGTMoneyTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

-(void) testThatInitNotRaisesException {
    
    XCTAssertNoThrow([[AGTMoney alloc] initWithAmount:3 currency:@"EUR"]);
    
}

-(void) testHash {
    
    AGTMoney *a = [[AGTMoney alloc] initWithAmount:2 currency:@"EUR"];
    AGTMoney *b = [[AGTMoney alloc] initWithAmount:2 currency:@"EUR"];
    
    XCTAssertEqual([a hash], [b hash], @"Equal objects must have same hash");
    
}

-(void) testEquality {
    
    AGTMoney *fiveEuros = [[AGTMoney alloc] initWithAmount:5 currency:@"EUR"];
    AGTMoney *otherFiveEuros = [[AGTMoney alloc] initWithAmount:5 currency:@"EUR"];
    
    XCTAssertEqualObjects(fiveEuros, otherFiveEuros);
    
    AGTMoney *sevenEuros = [[AGTMoney alloc] initWithAmount:7 currency:@"EUR"];
    
    XCTAssertNotEqualObjects(fiveEuros, sevenEuros);
    
    AGTMoney *fiveDollars = [[AGTMoney alloc] initWithAmount:5 currency:@"USD"];
    AGTMoney *otherFiveDollars = [[AGTMoney alloc] initWithAmount:5 currency:@"USD"];
    
    XCTAssertEqualObjects(fiveDollars, otherFiveDollars);
    
    AGTMoney *sevenDollars = [[AGTMoney alloc] initWithAmount:7 currency:@"EUR"];
    
    XCTAssertNotEqualObjects(fiveDollars, sevenDollars);
    
    
}

-(void) testDifferentCurrencies {
    
    AGTMoney *euro = [[AGTMoney alloc] initWithAmount:1 currency:@"EUR"];
    AGTMoney *dollar = [[AGTMoney alloc] initWithAmount:1 currency:@"USD"];
    
    XCTAssertNotEqualObjects(euro, dollar, @"Different currencies should not be equal!");
    
}

-(void) testCurrency {
    
    AGTMoney *dollars = [AGTMoney dollarWithAmount:1];
    
    XCTAssertEqualObjects(@"USD", [dollars currency]);
    
    AGTMoney *euros = [AGTMoney euroWitAmount:1];
    
    XCTAssertEqualObjects(@"EUR", [euros currency]);
    
}

-(void) testThatHashIsAmount {
    
    AGTMoney *one = [AGTMoney dollarWithAmount:1];
    
    XCTAssertEqual([one hash], 1, @"The hash must be the ssame as the amount");
    
}

-(void) testDescription {
    
    AGTMoney *one = [AGTMoney dollarWithAmount:1];
    NSString *desc = @"<AGTMoney: USD 1>";
    
    XCTAssertEqualObjects([one description], desc);
    
}

#pragma mark - Operations

-(void) testSimpleAddition {
    
    XCTAssertEqualObjects([[AGTMoney dollarWithAmount:5] plus:
                           [AGTMoney dollarWithAmount:5]],
                          [AGTMoney dollarWithAmount:10], @"$5 + $5 = $10");
}

-(void) testMultiplication {
    
    AGTMoney *fiveEuro = [[AGTMoney alloc] initWithAmount:5 currency:@"EUR"];
    AGTMoney *productEuro = [fiveEuro times:2];
    XCTAssertEqualObjects([[AGTMoney alloc] initWithAmount:10 currency:@"EUR"], productEuro);
    
    AGTMoney *fiveDollars = [[AGTMoney alloc] initWithAmount:5 currency:@"USD"];
    AGTMoney *productDollars = [fiveDollars times:2];
    
    XCTAssertEqualObjects(productDollars, [[AGTMoney alloc] initWithAmount:10 currency:@"USD"]);
    
    
}

@end
