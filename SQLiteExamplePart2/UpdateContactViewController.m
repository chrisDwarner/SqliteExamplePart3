//
//  UpdateConactViewController.m
//  SQLiteExamplePart2
//
//  Created by chris warner on 3/21/14.
//  Copyright (c) 2014 conedogers. All rights reserved.
//

#import "UpdateContactViewController.h"

@interface UpdateContactViewController ()

@end

@implementation UpdateContactViewController
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
        self.photo.image = _person.photo;
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

-(void) viewWillAppear:(BOOL)animated
{
    [self.firstName becomeFirstResponder];
}
#pragma mark - Table view data source

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuseIdentifier" forIndexPath:indexPath];
    
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

- (IBAction)save:(id)sender
{
    // collect the updated information
    if (_person) {
        _person.first = self.firstName.text;
        _person.last = self.lastName.text;
        _person.phone = self.phoneNumber.text;
        _person.photo = self.photo.image;
    }

    // tell the delegate that we have a record to update.
    [self.delegate updateContactViewControllerDidUpdate:self withPerson:_person];
}

- (IBAction)cancel:(id)sender
{
    [self.delegate updateContactViewControllerDidCancel:self];
}

-(void)takePhoto
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
        [self presentViewController:photoPicker animated:YES completion:nil];
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
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:nil];
}




@end
