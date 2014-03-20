//
//  Person+AddNewPerson.h
//  SQLiteExamplePart2
//
//  Created by chris warner on 3/19/14.
//  Copyright (c) 2014 conedogers. All rights reserved.
//

#import "Person.h"

@interface Person (AddNewPerson)

+(id)addNewPersonWithFirstName:(NSString *)firstName LastName:(NSString *)lastName andPhone:(NSString *)phoneNumber intoDatbase:(sqlite3 *)database;

@end
