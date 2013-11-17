//
//  C46UserInfo.m
//  Cipele46
//
//  Created by Drago Ruzman on 7/6/13.
//  Copyright (c) 2013 Miran Brajsa. All rights reserved.
//

#import "C46User.h"

@implementation C46User

- (id)initWithJSONDictionary:(NSDictionary *)dictionary
{
    if (self = [super initWithJSONDictionary:dictionary]) {

        _email = dictionary[@"email"];
        _facebookUID = dictionary[@"facebook_uid"];
        _firstName = dictionary[@"first_name"];
        _lastName = dictionary[@"last_name"];
        _phone = dictionary[@"phone"];
    }
    
    return self;
}


- (id)initWithFacebookJSONDictionary:(NSDictionary *)dictionary facebookAccessToken:(NSString *)token
{
    if (self = [super init]) {
        _firstName = [dictionary objectForKey:@"first_name"];
        _lastName = [dictionary objectForKey:@"last_name"];
        _email = [dictionary objectForKey:@"email"];
        _username = [dictionary objectForKey:@"name"];
    }
    
    return self;
}


@end
