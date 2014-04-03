//
//  AddContactViewController.m
//  SQLiteExamplePart2
//
//  Created by chris warner on 3/19/14.
//  Copyright (c) 2014 conedogers. All rights reserved.
//

#import "AddContactViewController.h"
#import "Person+AddNewPerson.h"

@interface AddContactViewController ()

@end

@implementation AddContactViewController

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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - button selectors
-(IBAction)cancel:(id)sender
{
    [self.delegate addContactViewControllerDidCancel:self];
}

-(IBAction)done:(id)sender
{
    // Create a new Person object and insert it into the database
    Person *person = [Person addNewPersonWithFirstName:self.firstName.text
                                              LastName:self.lastName.text
                                           phoneNumber:self.phone.text
                                              andPhoto:self.photo.image
                                           intoDatbase:self.database];
    
    // cause the calling tableView controller to reubild it's data.
    [self.delegate addContactViewControllerDidAddContact:self didAddContact:person];
    
}

-(IBAction)takePhoto:(id)sender
{
    UIActionSheet *dialog = nil;
    
    // present the action sheet that offers the user the choices for photos.
    // open a dialog with an OK and cancel button
    dialog = [[UIActionSheet alloc] initWithTitle:@""
                                         delegate:self
                                cancelButtonTitle:@"Cancel"
                           destructiveButtonTitle:nil
                                otherButtonTitles:@"Take Photo", @"Choose Existing Photo", @"Edit Photo", nil];
    
    dialog.actionSheetStyle = UIActionSheetStyleBlackTranslucent;

    // show the action dialog on top of the photo.  
    [dialog showFromRect:self.photo.frame inView:self.view animated:YES];

}

#pragma mark - UIActionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    BOOL bCancel = NO;
    UIImagePickerController *photoPicker = [[UIImagePickerController alloc] init];
    photoPicker.delegate = self;
    photoPicker.allowsEditing = YES;

    // we are processing a photo
    switch (buttonIndex)
    {
        case 0: // take photo
        {
            if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
                photoPicker.sourceType = UIImagePickerControllerSourceTypeCamera;
            }
            break;
        }
        case 1: // choose existing photo
        {
            if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
                photoPicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            }
            break;
        }
        case 2: // edit photo
        {
            if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeSavedPhotosAlbum]) {
                photoPicker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
            }
            break;
        }
        default:
            // cancel
            bCancel = YES;
            break;
    }
    if ( !bCancel )
    {
        // present the view controller.
        [self presentModalViewController:photoPicker animated:YES];
    }
}

#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *selectedImage = (UIImage *)[info valueForKey:UIImagePickerControllerEditedImage];
    if ( selectedImage != nil )
    {
        self.photo.image = selectedImage;
        
    }
    [self dismissModalViewControllerAnimated:YES];
}


- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissModalViewControllerAnimated:YES];
}



@end
