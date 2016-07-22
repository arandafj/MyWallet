//
//  AGTControllerTests.m
//  Wallet
//
//  Created by CLAG on 18/7/16.
//  Copyright © 2016 Clag. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <UIKit/UIKit.h>
#import "AGTSimpleViewController.h"
#import "AGTWalletTableViewController.h"
#import "AGTWallet.h"

@interface AGTControllerTests : XCTestCase

@property (strong, nonatomic) AGTSimpleViewController *vc;
@property (strong, nonatomic) UIButton *button;
@property (strong, nonatomic) UILabel *label;

@property (strong, nonatomic) AGTWalletTableViewController *walletVC;
@property (strong, nonatomic) AGTWallet *wallet;
@end

@implementation AGTControllerTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    self.vc = [[AGTSimpleViewController alloc] initWithNibName:nil bundle:nil];
    self.button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [self.button setTitle:@"Hola" forState:UIControlStateNormal];
    self.label = [[UILabel alloc] initWithFrame:CGRectZero];
    self.vc.displayLabel = self.label;
    
    self.wallet = [[AGTWallet alloc] initWithAmount:1 currency:@"USD"];
    [self.wallet plus:[AGTMoney euroWitAmount:1]];
    self.walletVC = [[AGTWalletTableViewController alloc] initWithModel:self.wallet broker:nil];
    
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
    self.vc = nil;
    self.button = nil;
    self.label = nil;
}

#pragma mark - ViewController

-(void) testThatLabelIsEqualToTextOnButton {
    
    // mandamos el mensaje
    [self.vc displayText:self.button];
    
    // comprobamos que etiqueta y botón tienen el mismo texto
    XCTAssertEqualObjects(self.button.titleLabel.text, self.label.text, @"Button and label should have the same text");
}

#pragma mark - TableController

-(void) testThatNumberOfSectionsIsNumberOfCurrenciesPlusOne {
    
    NSInteger sections = [self.walletVC numberOfSectionsInTableView:nil];
    
    XCTAssertEqual(sections, [self.wallet currenciesCount] + 1, @"Number of sections is the number of moneys plus 1");
}

-(void) testThatNumberOfCellsIsNumberOfMoneysPlusOne {
    
    XCTAssertEqual(self.wallet.eurosCount + 1, [self.walletVC tableView:nil
                                                  numberOfRowsInSection:0],
                   @"Number of cells is the number of moneys plus 1 (the total");
    
    XCTAssertEqual(self.wallet.dollarCount + 1, [self.walletVC tableView:nil
                                                   numberOfRowsInSection:1],
                                                   @"Number of cells is the number of moneys plus 1 (the total");
}

@end 



