//
//  C46UserManager.h
//  Cipele46
//
//  Created by Drago Ruzman on 7/6/13.
//  Copyright (c) 2013 Miran Brajsa. All rights reserved.
//

#import <Foundation/Foundation.h>


@class C46UserInfo;


@interface C46UserManager : NSObject

+(id) sharedInstance;

-(void) loginViaFacebookWithCompletionHandler:(void(^)(NSError* error)) completed;

-(void) loginWithEmail:(NSString*) email
           andPassword:(NSString*) password
     completionHandler:(void(^)(NSError* error)) completed;

-(void) logout;

-(void) createUserWithName:(NSString*) name
                     email:(NSString*) email
                     phone:(NSString*) phone
                  password:(NSString*) password
         completionHandler:(void(^)(NSError* error)) completed;

@property(nonatomic, readonly, getter=isLoggedIn) BOOL loggedIn;
@property(nonatomic, readonly) C46UserInfo* userInfo;

@end


NSString* const C46UserManagerLoggedInNotification;
NSString* const C46UserManagerLoginFailedNotification;