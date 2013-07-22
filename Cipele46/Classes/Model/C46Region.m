//
//  C46Region.m
//  Cipele46
//
//  Created by Dino Bartošak on 7/16/13.
//  Copyright (c) 2013 Miran Brajsa. All rights reserved.
//

#import "C46Region.h"

@implementation C46Region

- (id)initWithJSONDictionary:(NSDictionary *)dictionary
{
    if (self = [super init]) {
        
        _identifier = [[dictionary objectForKey:@"id"] stringValue];
        _name = [dictionary objectForKey:@"name"];
        
        // TODO: create date objects from strings
        //        NSString *dateCreatedString = [dictionary objectForKey:@"created_at"]; // 2013-07-06T10:01:53Z
        _dateCreated = [NSDate date];
        //        NSString *dateUpdatedString = [dictionary objectForKey:@"updated_at"];
        _dateUpdated = [NSDate date];
    }
    
    return self;
}

@end
