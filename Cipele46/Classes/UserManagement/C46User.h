//
//  C46UserInfo.h
//  Cipele46
//
//  Created by Drago Ruzman on 7/6/13.
//  Copyright (c) 2013 Miran Brajsa. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "C46Entity.h"

@interface C46User : C46Entity

- (id)initWithFacebookJSONDictionary:(NSDictionary *)dictionary facebookAccessToken:(NSString *)token;

@property (nonatomic, readonly) NSString *username;
@property (nonatomic, readonly) NSString *email;
@property (nonatomic, readonly) NSString *facebookUID;
@property (nonatomic, readonly) NSString *firstName;
@property (nonatomic, readonly) NSString *lastName;
@property (nonatomic, readonly) NSString *phone;

@end
