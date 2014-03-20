//
//  ViewContactViewController.h
//  SQLiteExamplePart2
//
//  Created by chris warner on 3/19/14.
//  Copyright (c) 2014 conedogers. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Person.h"

@class ViewContactViewController;

@protocol ViewContactViewControllerDelegate <NSObject>

-(void) viewContactViewControllerDidCancel:(ViewContactViewController *)controller;
-(void) viewContactViewControllerDidDelete:(ViewContactViewController *)controller Contact:(Person *)person;

@end

@interface ViewContactViewController : UITableViewController
@property (weak, nonatomic) IBOutlet UITextField *firstName;
@property (weak, nonatomic) IBOutlet UITextField *lastName;
@property (weak, nonatomic) IBOutlet UITextField *phoneNumber;

@property( nonatomic, strong) Person *person;

@property (nonatomic, weak) id<ViewContactViewControllerDelegate> delegate;

-(IBAction)cancel:(id)sender;
-(IBAction)deleteContact:(id)sender;
@end
