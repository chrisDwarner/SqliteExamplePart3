//
//  SQLiteManager.m
//  SQLiteExample
//
//  Created by chris warner on 3/14/14.
//  Copyright (c) 2014 conedogers. All rights reserved.
//
#import "SQLiteManager.h"

#define DATABASE_NAME @"main.rdb"


@implementation SQLiteManager

+(void) initializeDatabase
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *path = [self databasePath];
    
    // if the path does not exist, then we need to initialize the database.
    if ([fileManager fileExistsAtPath:path] == NO)
    {
        sqlite3 *database = [self newConnection];
        // the database file does not exist, so we need to create one.
        if (database)
        {
            // now we have initialized the database, but we have no database defined yet.
            // From here we drop into SQL and we can create the table that will hold
            // the data that will be displayed in the table view.
            NSString *filePath = [[NSBundle mainBundle] pathForResource:@"database" ofType:@"sql"];

            if ([fileManager fileExistsAtPath:filePath]) {
                
                // load the SQL commands that will create the database
                NSString *sqlCommands = [NSString stringWithContentsOfFile:filePath
                                                                  encoding:NSASCIIStringEncoding
                                                                     error:NULL];
                // any error message that sent back from sqlite when creating the database will go here.
                char *szErrorMessage = NULL;
                
                // execute the sql commands
                int error = sqlite3_exec(database, [sqlCommands UTF8String], NULL, NULL, &szErrorMessage);
                
                if (error == SQLITE_OK)
                {
                    NSLog(@"successfully created database");
                    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"FirstRun"];
                }
                else {
                    NSLog(@"Failed with error %s", sqlite3_errmsg(database));
                }
            }

            [self closeConnection:database];
        }
    }
    else {
        // check to see if we have attempted to upgrade the database before.
        // we only want to run the ALTER command once after an upgrade.
        if ( [[NSUserDefaults standardUserDefaults] boolForKey:@"FirstRun"] == NO) {
            // the file exists, so all we need to do is alter the existing table.
            sqlite3 *database = [self newConnection];
            // the database file does not exist, so we need to create one.
            if (database)
            {
                // load the SQL commands that will create the database
                NSString *sqlCommands = @"ALTER TABLE Contacts ADD photo BLOB DEFAULT NULL;";
                
                // any error message that sent back from sqlite when creating the database will go here.
                char *szErrorMessage = NULL;
                
                // execute the sql commands
                int error = sqlite3_exec(database, [sqlCommands UTF8String], NULL, NULL, &szErrorMessage);
                
                if (error == SQLITE_OK)
                {
                    NSLog(@"successfully created database");
                    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"FirstRun"];
                }
                else {
                    NSLog(@"Failed with error %s", sqlite3_errmsg(database));
                }
                
                [self closeConnection:database];
            }
        }
    }
}

+(NSString *) databasePath
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex: 0];
    NSString *path = [documentsDirectory stringByAppendingPathComponent:DATABASE_NAME];
    
    return path;
}

+(sqlite3 *) newConnection
{
    sqlite3 *database = NULL;
    NSString *path = [self databasePath];
    
    // the database file does not exist, so we need to create one.
    if ( sqlite3_open_v2([path UTF8String], &database, SQLITE_OPEN_READWRITE | SQLITE_OPEN_CREATE, NULL) != SQLITE_OK)
    {
        NSLog(@"Failed to open the database with error %s", sqlite3_errmsg(database));
        sqlite3_close(database);
        database = NULL;
    }

    // warning, the caller is expected to free this pointer.
    return database;
}

+(sqlite3 *) newConnectionFromFilename:(NSString *)databaseFilePath
{
    sqlite3 *database = NULL;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *path = [self databasePath];
    
    if ([fileManager fileExistsAtPath:path])
    {
        // the database file does not exist, so we need to create one.
        if ( sqlite3_open_v2([path UTF8String], &database, SQLITE_OPEN_READWRITE | SQLITE_OPEN_CREATE, NULL) != SQLITE_OK)
        {
            NSLog(@"Failed to open the database with error %s", sqlite3_errmsg(database));
            sqlite3_close(database);
            database = NULL;
        }
    }
    
    // warning, the caller is expected to free this pointer.
    return database;
}

+(void) closeConnection:(sqlite3 *)database
{
    if(database)
    {
        if (sqlite3_close(database) != SQLITE_OK )
        {
            NSLog(@"Failed to close the database with error %s", sqlite3_errmsg(database));
        }
        database = NULL;
    }
}

@end
