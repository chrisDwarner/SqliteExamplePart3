//
//  Person+ReadPersons.m
//  SQLiteExamplePart2
//
//  Created by chris warner on 3/19/14.
//  Copyright (c) 2014 conedogers. All rights reserved.
//

#import "Person+ReadPersons.h"

@implementation Person (ReadPersons)

+(NSMutableArray *)getAllPersonsFromDatabase:(sqlite3 *)database
{
    NSMutableArray *results = nil;
    if (database) {
        // now we have opened the database, retrieve some records.
        sqlite3_stmt *statement = NULL;
        
        // execute the Sql statement
        int error = sqlite3_prepare_v2(database, "SELECT idx, firstname, lastname, phone, photo FROM Contacts", -1, &statement, NULL);
        
        if (error == SQLITE_OK)
        {
            // got some results, now parse the records returned.
            results = [[NSMutableArray alloc] init];
            
            // loop through the results until you reach the end.
            while (sqlite3_step(statement) == SQLITE_ROW) {
                // get the primary key
                int primaryKey = sqlite3_column_int(statement, 0);
                
                // get the data
                NSString *firstName = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 1)];
                NSString *lastName = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 2)];
                NSString *phone = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 3)];
                UIImage *photo = nil;
                
                // We need two parameters to get the BLOB data.  the actual blob and the length in bytes.
                NSData *imageData = [NSData dataWithBytes:sqlite3_column_blob(statement, 4) length:sqlite3_column_bytes(statement, 4)];
                if (imageData) {
                    
                    // got it, stuff it into a UIImage
                    photo = [UIImage imageWithData:imageData];
                }
                
                // insert into an object
                Person *contact = [[Person alloc] initWithPrimaryKey:primaryKey AndDatabase:database];
                if (contact) {
                    contact.first = firstName;
                    contact.last = lastName;
                    contact.phone = phone;
                    contact.photo = photo;
                    
                    [results addObject:contact];
                }
            }
        }
        // clean up the SQL statement when your done.
        sqlite3_finalize(statement);
        statement = NULL;
    }
    
    return results;
}

@end
