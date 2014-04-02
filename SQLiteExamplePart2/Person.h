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
@property (nonatomic, copy) UIImage  *photo;

// we need to overload the sysnthesized methods so we can
// pick up when the data changes.
-(void) setFirst:(NSString *)value;
-(void) setLast:(NSString *)value;
-(void) setPhone:(NSString *)value;
-(void) setPhoto:(UIImage *)value;

@end
