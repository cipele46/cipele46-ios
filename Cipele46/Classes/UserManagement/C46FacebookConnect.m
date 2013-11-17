//
//  C46FacebookConnect.m
//  Cipele46
//
//  Created by Drago Ruzman on 7/6/13.
//  Copyright (c) 2013 Miran Brajsa. All rights reserved.
//

#import "C46FacebookConnect.h"
#import "NSString+URLEncoding.h"
#import <FacebookSDK/FacebookSDK.h>
#import "C46User.h"

@implementation C46FacebookConnect

+(id)sharedInstance
{
    static C46FacebookConnect* instance = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^()
    {
        instance = [[self alloc] init];
    });
    
    return instance;
}

-(void)connectWithCompletionHandler:(void (^)(NSError* error, C46User* userInfo))completionHandler
{
    NSAssert(NULL != completionHandler, @"completion handler is required!");
    
    [self loginToFacebookWithPermissions:[[self class] loginPermissions]
                       completionHandler:^(NSError *error)
    {
        dispatch_async(dispatch_get_main_queue(), ^()
        {
            if (nil != error)
            {
                completionHandler(error, nil);
            }
            else
            {
                [self fetchUserInfoWithCompletionHandler:^(NSError *error, C46User *userInfo)
                {
                    completionHandler(error, userInfo);
                }];
            }
            
        });
    }];
}

-(void)disconnect
{
    [[FBSession activeSession] closeAndClearTokenInformation];
    [FBSession setActiveSession:nil];
}

-(BOOL)handleOpenURL:(NSURL *)url
{
    return [[FBSession activeSession] handleOpenURL:url];
}

-(void)handleDidBecomeActive
{
    return [[FBSession activeSession] handleDidBecomeActive];
}

-(NSString *)accessToken
{
    return [[[FBSession activeSession] accessTokenData] accessToken];
}

#pragma mark - private

+(NSArray*) loginPermissions
{
    return @[@"email", @"user_about_me"];
}

-(void) loginToFacebookWithPermissions:(NSArray*)permissions
                     completionHandler:(void(^)(NSError* error)) completionHandler
{
    NSAssert(NULL != completionHandler, @"completion handler is required!");
    
    FBSession* session = [[FBSession alloc] initWithAppID:nil
                                              permissions:permissions
                                          urlSchemeSuffix:nil
                                       tokenCacheStrategy:nil];
    
    __block void(^completionHandlerCopy)(NSError* error) = [completionHandler copy];
    
    [FBSession setActiveSession:session];
    [session openWithBehavior:FBSessionLoginBehaviorUseSystemAccountIfPresent
            completionHandler:^(FBSession *session, FBSessionState status, NSError *error)
    {
        void (^callCompletionHandler)(NSError* error) = ^(NSError* error)
        {
            if (NULL != completionHandlerCopy)
            {
                completionHandlerCopy(error);
                completionHandlerCopy = NULL;
            }
        };
        
        if ([[FBSession activeSession] isOpen])
        {
            callCompletionHandler(nil);
        }
        else if (status == FBSessionStateClosedLoginFailed)
        {
            callCompletionHandler(error);
        }
    }];
}

-(void) fetchUserInfoWithCompletionHandler:(void(^)(NSError* error, C46User* userInfo)) completionHandler
{
    NSAssert(NULL != completionHandler, @"completion handler is required!");
    
    NSString* path = [self graphPathForFQLQuery:[self userDataQueryForUser:@"me()"]];
    
    FBRequestConnection* connection = [[FBRequestConnection alloc] init];
    FBSession* activeSession = [FBSession activeSession];
    
    FBRequest* request = [[FBRequest alloc] initWithSession:activeSession
                                                  graphPath:path];
    
    [connection addRequest:request
         completionHandler: ^(FBRequestConnection *requestConnection, id result, NSError *error)
    {
        if (nil != error)
        {
            completionHandler(error, nil);
        }
        else
        {
            C46User* userInfo = [self userInfoWithFBResponse:result];
            completionHandler(nil, userInfo);
        }
    }];
    
    [connection start];
}

-(NSString*) userDataQueryForUser:(NSString*) userID
{
    NSString* query = [NSString stringWithFormat:
                       @"SELECT uid, first_name, last_name, name, email, pic_square "
                       "FROM user "
                       "WHERE uid=%@", userID];
    
    return query;
}

-(NSString*) graphPathForFQLQuery:(NSString*) query
{
    NSString* path = [NSString stringWithFormat:
                      @"fql?q=%@",
                      [query URLEncodedString]
                      ];
    
    return path;
}

-(C46User*) userInfoWithFBResponse:(FBGraphObject*) response
{
    FBGraphObject* data = [[response objectForKey:@"data"] firstObject];
    
    NSString* firstName = [data objectForKey:@"first_name"];
    NSString* lastName = [data objectForKey:@"last_name"];
    NSString* userName = [data objectForKey:@"name"];
    NSString* email = [data objectForKey:@"email"];
    
    NSString* accessToken = [[[FBSession activeSession] accessTokenData] accessToken];
    
    C46User* userInfo = [[C46User alloc] initWithUserName:userName
                                                            email:email
                                                        firstName:firstName
                                                         lastName:lastName
                                                         password:accessToken];
    
    return userInfo;
}

@end
