//
//  C46Ad.m
//  Cipele46
//
//  Created by Dino Bartosak on 7/6/13.
//  Copyright (c) 2013 Miran Brajsa. All rights reserved.
//

#import "C46Ad.h"

@implementation C46Ad

- (id)initWithHTTPReponseDictionary:(NSDictionary *)dictionary
{
    if (self = [super init]) {
        
        _status =  [dictionary valueForKey:@"id"];
        _description =  [dictionary valueForKey:@"description"];
        _districtID =  [dictionary valueForKey:@"districtID"];
        _phone =  [dictionary valueForKey:@"phone"];
        _categoryID =  [dictionary valueForKey:@"categoryID"];
        _adID =  [dictionary valueForKey:@"id"];
        _cityID =  [dictionary valueForKey:@"cityID"];
        _type =  [dictionary valueForKey:@"ad_type"];
        _email =  [dictionary valueForKey:@"email"];
        _title =  [dictionary valueForKey:@"title"];
        
        NSDictionary *category =  [dictionary valueForKey:@"category"];
        NSDictionary *city =  [dictionary valueForKey:@"city"];
        NSDictionary *district =  [dictionary valueForKey:@"district"];
        
        _category = [category valueForKey:@"name"];
        _city = [city valueForKey:@"name"];
        _district = [district valueForKey:@"name"];
        _imageURL = [NSURL URLWithString:@"http://www.lynnwittenburg.com/wp-content/uploads/2013/03/Ball.jpg"];
    }
    
    return self;
}

@end
