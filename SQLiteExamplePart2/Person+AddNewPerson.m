//
//  Person+AddNewPerson.m
//  SQLiteExamplePart2
//
//  Created by chris warner on 3/19/14.
//  Copyright (c) 2014 conedogers. All rights reserved.
//

#import "Person+AddNewPerson.h"

@implementation Person (AddNewPerson)

+(id)addNewPersonWithFirstName:(NSString *)firstName LastName:(NSString *)lastName andPhone:(NSString *)phoneNumber intoDatbase:(sqlite3 *)database
{
    Person *contact = nil;
    
    // here we build a string for the complete SQL query and values to insert.
    NSString *query = [NSString stringWithFormat:@"INSERT INTO Contacts (firstname, lastname, phone) VALUES ('%@','%@','%@')", firstName, lastName, phoneNumber ];
    int success = -1;
    sqlite3_stmt *statement = nil;
    
    int error = sqlite3_prepare_v2(database, [query UTF8String], -1, &statement, NULL);
    if ( error != SQLITE_OK)
    {
        // error
        NSLog(@"Error failed to prepare sql with err %s", sqlite3_errmsg(database));
    }
    else
    {
        // execute the query
        success = sqlite3_step( statement );
        if ( success == SQLITE_DONE )
        {
            // successful insertion into the database, now create the person object.
            success = (int)sqlite3_last_insert_rowid(database);
            contact = [[Person alloc] initWithPrimaryKey:success AndDatabase:database];
            contact.first = firstName;
            contact.last = lastName;
            contact.phone = phoneNumber;
        }
    }
    
    // cleanup
    sqlite3_finalize(statement);
    statement = NULL;
    
    return contact;
}

+(id)addNewPersonWithFirstName:(NSString *)firstName LastName:(NSString *)lastName phoneNumber:(NSString *)phoneNumber andPhoto:(UIImage *)photo intoDatbase:(sqlite3 *)database
{
    Person *contact = nil;
    
    // here we build a string for the complete SQL query and values to insert.
    NSString *query = @"INSERT INTO Contacts (firstname, lastname, phone, photo) VALUES ('?','?','?', ?)";
    int success = -1;
    sqlite3_stmt *statement = nil;
    
    int error = sqlite3_prepare_v2(database, [query UTF8String], -1, &statement, NULL);
    if ( error != SQLITE_OK)
    {
        // error
        NSLog(@"Error failed to prepare sql with err %s", sqlite3_errmsg(database));
    }
    else
    {
        // Now bind the variable to the prepared statement
        sqlite3_bind_text(statement, 1, [firstName UTF8String], -1, SQLITE_TRANSIENT);
        sqlite3_bind_text(statement, 2, [lastName UTF8String], -1, SQLITE_TRANSIENT);
        sqlite3_bind_text(statement, 3, [phoneNumber UTF8String], -1, SQLITE_TRANSIENT);

        // now we store the image into the database as a PNG for better compression.
        sqlite3_bind_blob(statement, 4, [UIImagePNGRepresentation(photo) bytes], [UIImagePNGRepresentation(photo) length], SQLITE_TRANSIENT);

        // execute the query
        success = sqlite3_step( statement );
        if ( success == SQLITE_DONE )
        {
            // successful insertion into the database, now create the person object.
            success = (int)sqlite3_last_insert_rowid(database);
            contact = [[Person alloc] initWithPrimaryKey:success AndDatabase:database];
            contact.first = firstName;
            contact.last = lastName;
            contact.phone = phoneNumber;
            contact.photo = photo;
        }
    }
    
    // cleanup
    sqlite3_finalize(statement);
    statement = NULL;
    
    return contact;
}
@end
