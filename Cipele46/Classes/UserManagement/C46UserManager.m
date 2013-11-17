//
//  C46UserManager.m
//  Cipele46
//
//  Created by Drago Ruzman on 7/6/13.
//  Copyright (c) 2013 Miran Brajsa. All rights reserved.
//

#import "C46UserManager.h"
#import "C46User.h"
#import "C46FacebookConnect.h"
#import "C46Cipele46APINetworkClient.h"
#import "C46Cipele46APIUtils.h"

@interface C46UserManager()
{
@private
    
    BOOL _isFBLogin;
}

@end


@implementation C46UserManager

+(id)sharedInstance
{
    static id instance = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^()
                  {
                      instance = [[self alloc] init];
                  });
    
    return instance;
}

-(id)init
{
    if (self = [super init])
    {
    }
    
    return self;
}

-(void)loginViaFacebookWithCompletionHandler:(void (^)(NSError *))completed
{
    [[C46FacebookConnect sharedInstance] connectWithCompletionHandler:^(NSError *error, C46User *fbUserInfo)
     {
         if (error)
         {
             [self broadcastNotification:C46UserManagerLoginFailedNotification];
         }
         else
         {
             //            [_server loginWithEmail:fbUserInfo.email
             //                facebookAccessToken:[[C46FacebookConnect sharedInstance] accessToken]
             //                  completionHandler:^(NSError *error, NSDictionary *userInfo)
             //            {
             //                if (error)
             //                {
             //                    [self broadcastNotification:C46UserManagerLoginFailedNotification];
             //                }
             //                else
             //                {
             //                    _isFBLogin = YES;
             //                    _userInfo = fbUserInfo;
             //                    [self broadcastNotification:C46UserManagerLoggedInNotification];
             //                }
             //            }];
         }
     }];
}

-(void)loginWithEmail:(NSString *)email
          andPassword:(NSString *)password
    completionHandler:(void (^)(NSError *))completed
{
    //    [_server loginWithUserName:userName
    //                      password:password
    //             completionHandler:^(NSError *error, NSDictionary *userInfo)
    //    {
    //        if (error)
    //        {
    //            [self broadcastNotification:C46UserManagerLoginFailedNotification];
    //        }
    //        else
    //        {
    //            _isFBLogin = NO;
    //            _userInfo = [self userInfoWithServerDict:userInfo
    //                                            password:password];
    //            [self broadcastNotification:C46UserManagerLoggedInNotification];
    //        }
    //    }];
}

- (id<WMRequestProxyProtocol>)createUserWithName:(NSString *)name
                                        lastName:(NSString *)lastName
                                           email:(NSString *)email
                                           phone:(NSString *)phone
                                        password:(NSString *)password
                            passwordConfirmation:(NSString *)passwordConfirmation
                                         success:(void (^)(C46User *))success
                                         failure:(void (^)(C46Error *))failure
{
    NSString *path = @"users.json";
    
    NSDictionary *bodyParamaters = @{ @"user":
                                          @{
                                              @"first_name" : name,
                                              @"last_name" : lastName,
                                              @"email" : email,
                                              @"phone" : phone,
                                              @"password" : password,
                                              @"password_confirmation" : passwordConfirmation
                                            }
                                      };
    
    return [WMAFHTTPClientRequest postRequestWithPath:path
                                       bodyParameters:bodyParamaters
                                        networkClient:[C46Cipele46APINetworkClient sharedClient]
                                              success:^(id responseInfo, id responseObject) {
                                                  
                                                  DDLogInfo(@"Create user success");
                                                  DDLogVerbose(@"\t\tResponse: %@", responseObject);
                                                  DDLogVerbose(@"\t\tResponse info: %@", responseInfo);
                                                  
                                                  C46User *user = [[C46User alloc] initWithJSONDictionary:responseObject];
                                                  
                                                  DDLogVerbose(@"\t\tUser created: %@", user);
                                                  
                                                  success(user);
                                                  
                                              } failure:^(id responseInfo, id responseObject) {
                                                  
                                                  DDLogError(@"Create user error");
                                                  DDLogVerbose(@"\t\tResponse: %@", responseObject);
                                                  DDLogVerbose(@"\t\tResponse info: %@", responseInfo);
                                                  
                                                  failure([C46Cipele46APIUtils errorFromHTTPResponse:responseObject
                                                                                        responseInfo:responseInfo]);
                                              }];
    
}

-(void)logout
{
    if (_isFBLogin)
    {
        [[C46FacebookConnect sharedInstance] logout];
    }
    
    _user = nil;
    _isFBLogin = NO;
}

-(BOOL)isLoggedIn
{
    return nil != _user;
}

#pragma mark - private

-(void) broadcastNotification:(NSString*) notification
{
    dispatch_async(dispatch_get_main_queue(), ^()
                   {
                       [[NSNotificationCenter defaultCenter] postNotificationName:notification object:self];
                   });
}

@end


NSString* const C46UserManagerLoggedInNotification = @"C46UserManagerLoggedInNotification";
NSString* const C46UserManagerLoginFailedNotification = @"C46UserManagerLoginFailedNotification";