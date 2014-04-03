//
//  Person.m
//  SQLiteExamplePart2
//
//  Created by chris warner on 3/19/14.
//  Copyright (c) 2014 conedogers. All rights reserved.
//

#import "Person.h"

@implementation Person

@synthesize first;
@synthesize last;
@synthesize phone;
@synthesize photo;

// let the database connection know that something has changed
// by overloading the setters that are created by the @systhesize.
// now we can update the database anytime values change in the object.

-(void) setFirst:(NSString *)value
{
    if (first == nil) {
        first = value;
    }
    else if ([first compare:value] != NSOrderedSame)
    {
        first = value;
        self.dirty = YES;
    }
}

-(void) setLast:(NSString *)value
{
    if (last == nil) {
        last = value;
    }
    else if ([last compare:value] != NSOrderedSame)
    {
        last = value;
        self.dirty = YES;
    }
}

-(void) setPhone:(NSString *)value
{
    if (phone == nil) {
        phone = value;
    }
    else if ([phone compare:value] != NSOrderedSame)
    {
        phone = value;
        self.dirty = YES;
    }
}

-(void) setPhoto:(UIImage *)value
{
    if (photo == nil) {
        photo = value;
    }
    else {
        photo = value;
        self.dirty = YES;
    }
}

@end
