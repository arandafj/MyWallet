//
//  AGTWalletTableViewController.h
//  MyWallet
//
//  Created by CLAG on 21/7/16.
//  Copyright © 2016 Clag. All rights reserved.
//

#import <UIKit/UIKit.h>
@class AGTWallet;
@class AGTBroker;

@interface AGTWalletTableViewController : UITableViewController

-(id) initWithModel: (AGTWallet *) wallet broker: (AGTBroker *) broker;

@end
