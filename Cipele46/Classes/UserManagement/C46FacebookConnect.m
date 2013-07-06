//
//  C46FacebookConnect.m
//  Cipele46
//
//  Created by Drago Ruzman on 7/6/13.
//  Copyright (c) 2013 Miran Brajsa. All rights reserved.
//

#import "C46FacebookConnect.h"
#import <FacebookSDK/FacebookSDK.h>

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

-(void)connectWithCompletionHandler:(void (^)(NSError* error, C46UserInfo* userInfo))completionHandler
{
    NSAssert(NULL != completionHandler, @"completion handler is required!");
    
    [self loginToFacebookWithPermissions:[[self class] loginPermissions]
                       completionHandler:^(NSError *error)
    {
        if (nil != error)
        {
            completionHandler(error, nil);
        }
        else
        {
            [self fetchUserInfoWithCompletionHandler:^(NSError *error, C46UserInfo *userInfo)
            {
                completionHandler(error, userInfo);
            }];
        }
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

#pragma mark - private

+(NSArray*) loginPermissions
{
    return @[@"email"];
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
                completionHandlerCopy(nil);
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

-(void) fetchUserInfoWithCompletionHandler:(void(^)(NSError* error, C46UserInfo* userInfo)) completionHandler
{
    NSAssert(NULL != completionHandler, @"completion handler is required!");
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

@end
