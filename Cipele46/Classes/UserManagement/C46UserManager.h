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

-(void) loginViaFacebook;
-(void) loginWithUserName:(NSString*) userName andPassword:(NSString*) password;

-(void) logout;

@property(nonatomic, readonly, getter=isLoggedIn) BOOL loggedIn;
@property(nonatomic, readonly) C46UserInfo* userInfo;

@end


NSString* const C46UserManagerLoggedInNotification;
NSString* const C46UserManagerLoginFailedNotification;