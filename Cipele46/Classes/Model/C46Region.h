//
//  C46Region.h
//  Cipele46
//
//  Created by Dino Bartošak on 7/16/13.
//  Copyright (c) 2013 Miran Brajsa. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface C46Region : NSObject

@property (nonatomic, readonly) NSString *identifier;
@property (nonatomic, readonly) NSString *name;
@property (nonatomic, readonly) NSDate *dateCreated;
@property (nonatomic, readonly) NSDate *dateUpdated;

- (id)initWithJSONDictionary:(NSDictionary *)dictionary;

@end
