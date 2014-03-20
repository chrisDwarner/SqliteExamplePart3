//
//  Person+DeletePerson.h
//  SQLiteExamplePart2
//
//  Created by chris warner on 3/19/14.
//  Copyright (c) 2014 conedogers. All rights reserved.
//

#import "Person.h"

@interface Person (DeletePerson)

+(void)deletePersonWithIndex:(NSInteger)index fromDatabase:(sqlite3 *)database;

@end
