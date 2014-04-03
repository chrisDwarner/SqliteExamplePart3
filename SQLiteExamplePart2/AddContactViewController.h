//
//  AddContactViewController.h
//  SQLiteExamplePart2
//
//  Created by chris warner on 3/19/14.
//  Copyright (c) 2014 conedogers. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Person.h"

@class AddContactViewController;

@protocol AddContactViewControllerDelegate <NSObject>
-(void)addContactViewControllerDidCancel:(AddContactViewController *)controller;
-(void)addContactViewControllerDidAddContact:(AddContactViewController *)controller didAddContact:(Person *)contact;

@end
@interface AddContactViewController : UITableViewController <UIImagePickerControllerDelegate, UIActionSheetDelegate, UINavigationControllerDelegate>
@property (weak, nonatomic) IBOutlet UITextField *firstName;
@property (weak, nonatomic) IBOutlet UITextField *lastName;
@property (weak, nonatomic) IBOutlet UITextField *phone;
@property (weak, nonatomic) IBOutlet UIImageView *photo;

@property (nonatomic, assign) sqlite3 *database;

@property (nonatomic, weak) id<AddContactViewControllerDelegate> delegate;

-(IBAction)cancel:(id)sender;
-(IBAction)done:(id)sender;
-(void)takePhoto;

@end
