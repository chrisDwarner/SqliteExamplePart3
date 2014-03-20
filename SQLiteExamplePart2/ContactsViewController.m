//
//  ContactsViewController.m
//  SQLiteExamplePart2
//
//  Created by chris warner on 3/19/14.
//  Copyright (c) 2014 conedogers. All rights reserved.
//

#import "ContactsViewController.h"
#import "AddContactViewController.h"
#import "Person+DeletePerson.h"


@interface ContactsViewController ()

@end

@implementation ContactsViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if (self.contactList) {
        _contactList = self.contactList;
    }
    else {
        _contactList = [[NSMutableArray alloc] init];
    }
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [_contactList count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ContactCell" forIndexPath:indexPath];
    
    // Configure the cell...
    Person *person = _contactList[indexPath.row];
    if (person) {
        cell.textLabel.text = [NSString stringWithFormat:@"%@, %@", person.first, person.last];
        cell.detailTextLabel.text = person.phone;
    }
    
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSString *identifier = segue.identifier;
    
    if ([identifier isEqualToString:@"AddContact"]) {
        UINavigationController *navigationController = segue.destinationViewController;
        AddContactViewController *addContactViewController = [navigationController viewControllers][0];
        addContactViewController.delegate = self;
        addContactViewController.database = self.database;
    }
    if ([identifier isEqualToString:@"ViewContact"]) {
        UINavigationController *navigationController = segue.destinationViewController;
        ViewContactViewController *viewContactViewController = [navigationController viewControllers][0];
        viewContactViewController.delegate = self;
        
        // first we need to get the indexPath from the sender (the UITableViewCell)
        NSObject *obj = (NSObject *)sender;
        // validate the object type
        if ([obj isKindOfClass:[UITableViewCell class]]) {
            
            // get the index path
            UITableViewCell *cell = (UITableViewCell *)sender;
            NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
            
            int index = (int)indexPath.row;
            // get the person
            viewContactViewController.person = (Person *)[_contactList objectAtIndex:index];
        }
    }
}

#pragma mark - AddContactViewControllerDelegate methods
-(void)addContactViewControllerDidCancel:(AddContactViewController *)controller
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)addContactViewControllerDidAddContact:(AddContactViewController *)controller didAddContact:(Person *)contact
{
    [_contactList addObject:contact];
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:([_contactList count]-1) inSection:0];
    [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

#pragma mark - ViewContactViewcontrollerDelegate methods

-(void) viewContactViewControllerDidCancel:(ViewContactViewController *)controller
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void) viewContactViewControllerDidDelete:(ViewContactViewController *)controller Contact:(Person *)person
{
    [Person deletePersonWithIndex:person.primaryKey fromDatabase:person.database];
    [_contactList removeObject:person];
    [self.tableView reloadData];
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
