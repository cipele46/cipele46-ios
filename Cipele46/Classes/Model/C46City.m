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
    if (self = [super initWithJSONDictionary:dictionary]) {
        _regionID = [dictionary[@"region_id"] integerValue];
    }
    
    return self;
}

@end
