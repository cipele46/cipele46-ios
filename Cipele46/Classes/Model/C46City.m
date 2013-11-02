//
//  C46City.m
//  Cipele46
//
//  Created by Dino Bartošak on 7/16/13.
//  Copyright (c) 2013 Miran Brajsa. All rights reserved.
//

#import "C46City.h"

@implementation C46City

- (id)initWithJSONDictionary:(NSDictionary *)dictionary
{
    if (self = [super init]) {
        
        _identifier = dictionary[@"id"];
        _name = dictionary[@"name"];
        
        // TODO: create date objects from strings
        //        NSString *dateCreatedString = [dictionary objectForKey:@"created_at"]; // 2013-07-06T10:01:53Z
        _dateCreated = [NSDate date];
        //        NSString *dateUpdatedString = [dictionary objectForKey:@"updated_at"];
        _dateUpdated = [NSDate date];
        
        _regionID = [dictionary[@"region_id"] integerValue];
    }
    
    return self;
}

@end
