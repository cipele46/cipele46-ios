//
//  C46UserInfo.h
//  Cipele46
//
//  Created by Drago Ruzman on 7/6/13.
//  Copyright (c) 2013 Miran Brajsa. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface C46UserInfo : NSObject

@property(nonatomic,readonly) NSString* userName;
@property(nonatomic,readonly) NSString* email;
@property(nonatomic,readonly) NSString* firstName;
@property(nonatomic,readonly) NSString* lastName;

@end
