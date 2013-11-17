//
//  C46Entity.m
//  Cipele46
//
//  Created by Mijo Kaliger on 13/11/13.
//  Copyright (c) 2013 cipele46.org. All rights reserved.
//

#import "C46Entity.h"

@interface C46Entity ()

@property (nonatomic, copy) NSString *identifier;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSDate *dateCreated;
@property (nonatomic, copy) NSDate *dateUpdated;

@end

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


#pragma mark - Keyed Archiving

- (void)encodeWithCoder:(NSCoder *)encoder
{
    [encoder encodeObject:self.identifier forKey:@"identifier"];
    [encoder encodeObject:self.name forKey:@"name"];
    [encoder encodeObject:self.dateCreated forKey:@"dateCreated"];
    [encoder encodeObject:self.dateUpdated forKey:@"dateUpdated"];
}

- (id)initWithCoder:(NSCoder *)decoder
{
    self = [super init];
    if (self) {
        self.identifier = [decoder decodeObjectForKey:@"identifier"];
        self.name = [decoder decodeObjectForKey:@"name"];
        self.dateCreated = [decoder decodeObjectForKey:@"dateCreated"];
        self.dateUpdated = [decoder decodeObjectForKey:@"dateUpdated"];
    }
    return self;
}

- (id)copyWithZone:(NSZone *)zone
{
    id theCopy = [[[self class] allocWithZone:zone] init];  // use designated initializer

    [theCopy setIdentifier:[self.identifier copy]];
    [theCopy setName:[self.name copy]];
    [theCopy setDateCreated:[self.dateCreated copy]];
    [theCopy setDateUpdated:[self.dateUpdated copy]];

    return theCopy;
}

@end
