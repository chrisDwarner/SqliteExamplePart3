//
//  Person+WritePerson.m
//  SQLiteExamplePart2
//
//  Created by chris warner on 3/19/14.
//  Copyright (c) 2014 conedogers. All rights reserved.
//

#import "Person+WritePerson.h"

@implementation Person (WritePerson)

-(int)updateTheDatabase
{
    int error = SQLITE_OK;
    
    if ([self isConnected] && _dirty) {
        sqlite3_stmt *statement = NULL;
        const char *query = "UPDATE Contacts SET firstname = ?, lastname = ?, phone = ? WHERE idx = ?";
        error = sqlite3_prepare_v2(_database, query, -1, &statement, NULL);
        if (error != SQLITE_OK) {
            NSLog(@"Error failed to prepare sql with err %s", sqlite3_errmsg(_database));
        }
        else{
            // bind the data to the query.  We need to make sure that we label the string
            // data as SQLITE_TRANSIENT so that SQLite knows how to handle the memeory.
            // the order of the binding is the order of the values on the update query string.
            sqlite3_bind_text(statement, 1, [self.first UTF8String], -1, SQLITE_TRANSIENT);
            sqlite3_bind_text(statement, 2, [self.last UTF8String], -1, SQLITE_TRANSIENT);
            sqlite3_bind_text(statement, 3, [self.phone UTF8String], -1, SQLITE_TRANSIENT);
            sqlite3_bind_int(statement, 4, self.primaryKey);
            
            // execute the query
            error = sqlite3_step(statement);
            if (error != SQLITE_DONE) {
                NSLog(@"Error failed to save with err %s", sqlite3_errmsg(_database));
            } else _dirty = NO;  // succes, reset dirty flag.
        }
        sqlite3_finalize(statement);
    }
    return error;
}

@end
