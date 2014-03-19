//
//  SQLiteManager.h
//  SQLiteExample
//
//  Created by chris warner on 3/14/14.
//  Copyright (c) 2014 conedogers. All rights reserved.
//

#import <Foundation/Foundation.h>
#include "sqlite3.h"


@interface SQLiteManager : NSObject

+(void) initializeDatabase;
+(NSString *) databasePath;
+(sqlite3 *) newConnection;
+(sqlite3 *) newConnectionFromFilename:(NSString *)databaseFilePath;
+(void) closeConnection:(sqlite3 *)database;
@end
