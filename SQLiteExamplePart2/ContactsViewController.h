//
//  ContactsViewController.h
//  SQLiteExamplePart2
//
//  Created by chris warner on 3/19/14.
//  Copyright (c) 2014 conedogers. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddContactViewController.h"

@interface ContactsViewController : UITableViewController <AddContactViewControllerDelegate>

@property (nonatomic, strong) NSMutableArray *contactList;

@end
