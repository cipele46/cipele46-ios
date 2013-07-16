//
//  C46Ad.m
//  Cipele46
//
//  Created by Dino Bartosak on 7/6/13.
//  Copyright (c) 2013 Miran Brajsa. All rights reserved.
//

#import "C46Ad.h"

@implementation C46Ad

- (id)initWithJSONDictionary:(NSDictionary *)dictionary
{
    if (self = [super init]) {
        
        _type =  [[dictionary objectForKey:@"ad_type"] integerValue];
        
        NSDictionary *categoryDictionary =  [dictionary objectForKey:@"category"];
        _category = [[C46AdCategory alloc] initWithJSONDictionary:categoryDictionary];
        _categoryID =  [[dictionary objectForKey:@"categoryID"] integerValue];

        NSDictionary *cityDictionary =  [dictionary objectForKey:@"city"];
        _city = [[C46City alloc] initWithJSONDictionary:cityDictionary];
        _cityID =  [[dictionary objectForKey:@"cityID"] integerValue];

        // TODO: create date object from string
//        NSString *dateCreatedString = [dictionary objectForKey:@"created_at"]; // 2013-07-06T10:01:53Z
        _dateCreated = [NSDate date];
//        NSString *dateUpdatedString = [dictionary objectForKey:@"updated_at"]; // 2013-07-06T10:01:53Z
        _dateUpdated = [NSDate date];
        
        
        _description =  [dictionary objectForKey:@"description"];
        _email =  [dictionary objectForKey:@"email"];
        _identifier = [[dictionary objectForKey:@"id"] integerValue];
        
        NSDictionary *imageInfoDIctionary = [dictionary objectForKey:@"image"];
        _imageInfo = [[C46AdImageInfo alloc] initWithJSONDictionary:imageInfoDIctionary];

        _phone =  [dictionary objectForKey:@"phone"];
        
        NSDictionary *regionDictionary = [dictionary objectForKey:@"region"];
        _region = [[C46Region alloc] initWithJSONDictionary:regionDictionary];
        _status =  [[dictionary objectForKey:@"status"] integerValue];
        _title =  [dictionary objectForKey:@"title"];
        
        _userId = [dictionary objectForKey:@"user_id"];
    }
    
    return self;
}

@end

