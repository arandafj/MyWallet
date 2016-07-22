//
//  AGTWalletTableViewController.m
//  MyWallet
//
//  Created by CLAG on 21/7/16.
//  Copyright © 2016 Clag. All rights reserved.
//

#import "AGTWalletTableViewController.h"
#import "AGTWallet.h"
#import "AGTBroker.h"

NSUInteger const EUROS = 0;
NSUInteger const DOLLARS = 1;


@interface AGTWalletTableViewController ()

@property (strong, nonatomic) AGTWallet *wallet;
@property (strong, nonatomic) AGTBroker *broker;

@end

@implementation AGTWalletTableViewController

-(id)initWithModel:(AGTWallet *)wallet broker:(AGTBroker *)broker {
    
    if (self = [super initWithStyle:UITableViewStylePlain] ) {
        _wallet = wallet;
        _broker = broker;
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return [self.wallet currenciesCount] + 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    
    if (section == EUROS) {
        return self.wallet.eurosCount + 1;
    } else if (section == DOLLARS) {
        return self.wallet.dollarCount + 1;
    }
    
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellIdentifier = @"moneyCell";
    
    // Crear la celda
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle
                                      reuseIdentifier:cellIdentifier];
    }
    
    // Configure the cell...
    
    [self configureCell:cell indexPath:indexPath];
    
    return cell;
}

-(NSString *) tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    
    if (section == EUROS) {
        return @"Euros";
        
    } else if ([self isLastSection:section]) {
        return @"Total euros";
    }
    
    return @"Dollars";
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
}


#pragma mark - Private

-(BOOL) isLastSection: (NSUInteger) section {
    
    return [self.wallet currenciesCount] == section;
}

-(BOOL) isLastRowInSection: (NSUInteger) row section: (NSUInteger) section {
    
    if (section == EUROS) {
        return [self.wallet eurosCount] == row;
        
    } else {
        return [self.wallet dollarCount] == row;
    }
}

-(void) configureCell: (UITableViewCell *)cell indexPath: (NSIndexPath  *) indexPath {
    
    NSString *cellValue;
    NSString *cellTitle;
    
    AGTMoney *money;
    
    if ([self isLastRowInSection:indexPath.row section:indexPath.section]) {
        
        if (indexPath.section == EUROS) {
            
            cellValue = [NSString stringWithFormat:@"%ld€",[self.wallet totalEurosValue]];
            cellTitle = @"Subtotal euros";
            
        } else {
            
            cellValue = [NSString stringWithFormat:@"%ld$",[self.wallet totalDollarsValue]];
            cellTitle = @"Subtotal dollars";
            
        }
        
    } else if ([self isLastSection:indexPath.section]) {
        
        money = [self.broker reduce:self.wallet toCurrency:@"EUR"];
        cellValue = [NSString stringWithFormat:@"%ld€",[money.amount integerValue]];
        cellTitle = @"Total euros";
        
    } else if (indexPath.section == EUROS) {
        
        money = [self.wallet euroAtIndex:indexPath.row];
        cellValue = [NSString stringWithFormat:@"%ld€",[money.amount integerValue]];
        
    } else {
        
        money = [self.wallet dollarAtIndex:indexPath.row];
        cellValue = [NSString stringWithFormat:@"%ld$",[money.amount integerValue]];
    }
    
    cell.textLabel.text = cellValue;
    cell.detailTextLabel.text = cellTitle;
}


@end

