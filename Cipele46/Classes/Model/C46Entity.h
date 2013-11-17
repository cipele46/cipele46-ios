//
//  C46Entity.h
//  Cipele46
//
//  Created by Mijo Kaliger on 13/11/13.
//  Copyright (c) 2013 cipele46.org. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface C46Entity : NSObject <NSCoding>

@property (nonatomic, readonly, copy) NSString *identifier;
@property (nonatomic, readonly, copy) NSString *name;
@property (nonatomic, readonly, copy) NSDate *dateCreated;
@property (nonatomic, readonly, copy) NSDate *dateUpdated;

- (id)initWithIdentifier:(NSString *)identifier name:(NSString *)name;
- (id)initWithJSONDictionary:(NSDictionary *)dictionary;

+ (C46Entity *)defaultRepresentation;

@end
