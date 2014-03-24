//
//  Person+DeletePerson.m
//  SQLiteExamplePart2
//
//  Created by chris warner on 3/19/14.
//  Copyright (c) 2014 conedogers. All rights reserved.
//

#import "Person+DeletePerson.h"

@implementation Person (DeletePerson)

+(void)deletePersonWithIndex:(NSInteger)index fromDatabase:(sqlite3 *)database
{
    const char *query = "DELETE FROM Contacts WHERE idx=?";
    sqlite3_stmt *statement = NULL;
    int error = sqlite3_prepare_v2(database, query, -1, &statement, NULL);
    if ( error != SQLITE_OK){
        // error
        NSLog(@"Error failed to prepare sql with err %s", sqlite3_errmsg(database));
    }
    
    // bind the primary index to the statement
    sqlite3_bind_int(statement, 1, index);
    // execute the statement
    sqlite3_step( statement );
    // clean up
    sqlite3_finalize(statement);
    statement = NULL;
}

@end
