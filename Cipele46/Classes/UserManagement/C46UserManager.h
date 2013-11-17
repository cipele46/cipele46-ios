//
//  C46UserManager.h
//  Cipele46
//
//  Created by Drago Ruzman on 7/6/13.
//  Copyright (c) 2013 Miran Brajsa. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WMAFHTTPClientRequest.h"

@class C46User;


@interface C46UserManager : NSObject

+(id) sharedInstance;

-(void) loginViaFacebookWithCompletionHandler:(void(^)(NSError* error)) completed;

-(void) loginWithEmail:(NSString*) email
           andPassword:(NSString*) password
     completionHandler:(void(^)(NSError* error)) completed;

-(void) logout;

- (id <WMRequestProxyProtocol>)createUserWithName:(NSString *)name
                                         lastName:(NSString *)lastName
                                            email:(NSString *)email
                                            phone:(NSString *)phone
                                         password:(NSString *)password
                             passwordConfirmation:(NSString *)passwordConfirmation
                                          success:(void(^)(C46User *user))success
                                          failure:(void(^)(C46Error *error))failure;

- (id<WMRequestProxyProtocol>)loginUserWithEmail:(NSString *)email
                                        password:(NSString *)password
                                         success:(void (^)(C46User *))success
                                         failure:(void (^)(C46Error *))failure;

@property(nonatomic, readonly, getter=isLoggedIn) BOOL loggedIn;
@property(nonatomic, readonly) C46User* user;

@end


NSString* const C46UserManagerLoggedInNotification;
NSString* const C46UserManagerLoginFailedNotification;