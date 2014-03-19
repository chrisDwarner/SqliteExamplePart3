//
//  Person.h
//  SQLiteExamplePart2
//
//  Created by chris warner on 3/19/14.
//  Copyright (c) 2014 conedogers. All rights reserved.
//

#import <Foundation/Foundation.h>
#include "sqlite3.h"
#import "SQLiteObject.h"

@interface Person : SQLiteObject

@property (nonatomic, copy) NSString *first;
@property (nonatomic, copy) NSString *last;
@property (nonatomic, copy) NSString *phone;

+(NSMutableArray *)getAllPersonsFromDatabase:(sqlite3 *)database;
@end
