//
//  AppDelegate.m
//  SQLiteExamplePart2
//
//  Created by chris warner on 3/18/14.
//  Copyright (c) 2014 conedogers. All rights reserved.
//
#import "AppDelegate.h"
#include "sqlite3.h"
#import "SQLiteObject.h"
#import "SQLiteManager.h"
#import "ContactsViewController.h"
#import "Person+ReadPersons.h"
#import "Person+WritePerson.h"

@implementation AppDelegate
{
    NSMutableArray *_contacts;
    
    sqlite3 *_database; // the pointer to the open database connection.
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // initialize database on first run.
    [SQLiteManager initializeDatabase];
    
    _database = [SQLiteManager newConnection];  //open the database
    _contacts = [Person getAllPersonsFromDatabase:_database];
    
    UINavigationController *navigationController = (UINavigationController *)self.window.rootViewController;
    ContactsViewController *contactsViewController = [navigationController viewControllers][0];
    contactsViewController.contactList = _contacts;
    contactsViewController.database = _database;
    
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // save out any updates in the contacts array.  Any person object marked as dirty, will be updated to the database.
    [_contacts makeObjectsPerformSelector:@selector(updateTheDatabase)];
    
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // save out any updates in the contacts array.  Any person object marked as dirty, will be updated to the database.
    [_contacts makeObjectsPerformSelector:@selector(updateTheDatabase)];

    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    [SQLiteManager closeConnection:_database];
    _database = NULL;
}

@end
