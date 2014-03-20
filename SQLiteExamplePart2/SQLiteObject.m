//
//  SqliteObj.m
//  sqlite-Sample
//
//  Created by chris warner on 12/3/12.
//  Copyright (c) 2012 chris warner. All rights reserved.
//
#import "SQLiteObject.h"

@implementation SQLiteObject

@synthesize primaryKey = _primaryKey;
@synthesize database = _database;
@synthesize dirty = _dirty;



-(id) init
{
    if( self = [super init] )
    {
        _primaryKey = 0;
        _database = NULL;
    }
    return self;
}

-(id) initWithPrimaryKey:(NSInteger)pk AndDatabase:(sqlite3 *)db
{
    if( self = [super init] )
    {
        _primaryKey = pk;
        _database = db;
    }
    return self;
}

-(BOOL) isConnected
{
    return (_primaryKey != 0 && _database != NULL);
}

@end
