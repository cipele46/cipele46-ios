//
//  C46Entity.h
//  Cipele46
//
//  Created by Mijo Kaliger on 13/11/13.
//  Copyright (c) 2013 cipele46.org. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface C46Entity : NSObject

@property (nonatomic, readonly) NSString *identifier;
@property (nonatomic, readonly) NSString *name;
@property (nonatomic, readonly) NSDate *dateCreated;
@property (nonatomic, readonly) NSDate *dateUpdated;

- (id)initWithIdentifier:(NSString *)identifier name:(NSString *)name;
- (id)initWithJSONDictionary:(NSDictionary *)dictionary;

+ (C46Entity *)defaultRepresentation;

@end
