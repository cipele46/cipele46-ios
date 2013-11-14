//
//  C46Entity.m
//  Cipele46
//
//  Created by Mijo Kaliger on 13/11/13.
//  Copyright (c) 2013 cipele46.org. All rights reserved.
//

#import "C46Entity.h"

@implementation C46Entity

- (id)initWithIdentifier:(NSString *)identifier name:(NSString *)name
{
    self = [super init];
    if (self) {
        _identifier = identifier;
        _name = name;
    }
    return self;
}

- (id)initWithJSONDictionary:(NSDictionary *)dictionary
{
    if (self = [super init]) {

        _identifier = [dictionary[@"id"] stringValue];
        _name = dictionary[@"name"];

        NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
        [dateFormat setDateFormat:@"yyyy-MM-dd'T'HH:mm:ssZ"];

        _dateCreated = [dateFormat dateFromString:[dictionary objectForKey:@"created_at"]];
        _dateUpdated = [dateFormat dateFromString:[dictionary objectForKey:@"updated_at"]];
    }

    return self;
}

+ (C46Entity*)defaultRepresentation
{
    return nil;
}

@end
