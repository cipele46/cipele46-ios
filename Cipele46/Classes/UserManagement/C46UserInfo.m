//
//  C46UserInfo.m
//  Cipele46
//
//  Created by Drago Ruzman on 7/6/13.
//  Copyright (c) 2013 Miran Brajsa. All rights reserved.
//

#import "C46UserInfo.h"

@implementation C46UserInfo

-(id) initWithUserName:(NSString*) userName
                 email:(NSString*) email
             firstName:(NSString*) firstName
              lastName:(NSString*) lastName
{
    if (self = [super init])
    {
        _userName = [userName copy];
        _email = [email copy];
        _firstName = [firstName copy];
        _lastName = [lastName copy];
    }
    
    return self;
}

@end
