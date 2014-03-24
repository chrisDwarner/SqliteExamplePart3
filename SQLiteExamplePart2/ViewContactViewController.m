//
//  ViewContactViewController.m
//  SQLiteExamplePart2
//
//  Created by chris warner on 3/19/14.
//  Copyright (c) 2014 conedogers. All rights reserved.
//

#import "ViewContactViewController.h"
#import "UpdateContactViewController.h"
#import "Person+WritePerson.h"

@interface ViewContactViewController ()

@end

@implementation ViewContactViewController
{
    Person *_person;
}

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
    
    _person = self.person;
    if (_person) {
        self.firstName.text = _person.first;
        self.lastName.text = _person.last;
        self.phoneNumber.text = _person.phone;
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


/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

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
    
    if ([identifier isEqualToString:@"UpdateContact"]) {
        UINavigationController *navigationController = segue.destinationViewController;
        UpdateContactViewController *updateContactViewController = [navigationController viewControllers][0];
        updateContactViewController.delegate = self;
        updateContactViewController.person = _person;
    }
}

-(IBAction)cancel:(id)sender
{
    [self.delegate viewContactViewControllerDidCancel:self];
}

-(void) updateContactViewControllerDidCancel:(UpdateContactViewController *)controller
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void) updateContactViewControllerDidUpdate:(UpdateContactViewController *)controller withPerson:(Person *)person
{
    // update the record in the database.
    [person updateTheDatabase];
    
    // update the view.
    self.firstName.text = person.first;
    self.lastName.text = person.last;
    self.phoneNumber.text = person.phone;
    
    // close the update view.
    [self dismissViewControllerAnimated:NO completion:nil];
    
    // now tell the contacts view that we have an update 
    [self.delegate viewContactViewControllerDidUpdate:self withPerson:person];
}

@end
