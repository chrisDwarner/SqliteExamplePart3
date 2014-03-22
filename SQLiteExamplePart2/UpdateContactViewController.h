//
//  UpdateContactViewController.h
//  SQLiteExamplePart2
//
//  Created by chris warner on 3/21/14.
//  Copyright (c) 2014 conedogers. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Person.h"

@class UpdateContactViewController;

@protocol UpdateContactViewControllerDelegate <NSObject>

-(void) updateContactViewControllerDidCancel:(UpdateContactViewController *)controller;
-(void) updateContactViewControllerDidUpdate:(UpdateContactViewController *)controller withPerson:(Person *)person;

@end

@interface UpdateContactViewController : UITableViewController
@property (weak, nonatomic) IBOutlet UITextField *firstName;
@property (weak, nonatomic) IBOutlet UITextField *lastName;
@property (weak, nonatomic) IBOutlet UITextField *phoneNumber;

@property (nonatomic, strong) Person *person;
@property (nonatomic, weak) id<UpdateContactViewControllerDelegate> delegate;

- (IBAction)save:(id)sender;
- (IBAction)cancel:(id)sender;
@end
