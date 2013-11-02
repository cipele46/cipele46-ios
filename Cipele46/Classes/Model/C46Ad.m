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
        
        _type =  [dictionary[@"ad_type"] integerValue];
        
        NSDictionary *categoryDictionary =  dictionary[@"category"];
        _category = [[C46AdCategory alloc] initWithJSONDictionary:categoryDictionary];
        _categoryID =  [dictionary[@"categoryID"] integerValue];
        
        NSDictionary *cityDictionary =  dictionary[@"city"];
        _city = [[C46City alloc] initWithJSONDictionary:cityDictionary];
        _cityID =  [dictionary[@"cityID"] integerValue];
        
        // TODO: create date object from string
        //        NSString *dateCreatedString = [dictionary objectForKey:@"created_at"]; // 2013-07-06T10:01:53Z
        _dateCreated = [NSDate date];
        //        NSString *dateUpdatedString = [dictionary objectForKey:@"updated_at"]; // 2013-07-06T10:01:53Z
        _dateUpdated = [NSDate date];
        
        
        _description =  dictionary[@"description"];
        _email =  dictionary[@"email"];
        _identifier = [dictionary[@"id"] integerValue];
        
        NSDictionary *imageInfoDIctionary = dictionary[@"image"];
        _imageInfo = [[C46AdImageInfo alloc] initWithJSONDictionary:imageInfoDIctionary];
        
        _phone =  dictionary[@"phone"];
        
        NSDictionary *regionDictionary = dictionary[@"region"];
        _region = [[C46Region alloc] initWithJSONDictionary:regionDictionary];
        _status =  [dictionary[@"status"] integerValue];
        _title =  dictionary[@"title"];
        
        _userId = dictionary[@"user_id"];
    }
    
    return self;
}

@end

NSString * ADTypeDescription(AdType type)
{
    switch (type) {
        case AdTypeSupply: return @"Supply";
        case AdTypeDemand: return @"Demand";
        default: return @"Unknown";
    }
}

