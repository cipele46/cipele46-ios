//
//  C46UserManager.m
//  Cipele46
//
//  Created by Drago Ruzman on 7/6/13.
//  Copyright (c) 2013 Miran Brajsa. All rights reserved.
//

#import "C46UserManager.h"
#import "C46ServerCommunicationManager.h"
#import "C46UserInfo.h"
#import "C46FacebookConnect.h"

@interface C46UserManager()
{
    @private
    
    C46ServerCommunicationManager* _server;
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
        _server = [[C46ServerCommunicationManager alloc] init];
    }
    
    return self;
}

-(void)loginViaFacebook
{
    [[C46FacebookConnect sharedInstance] connectWithCompletionHandler:^(NSError *error, C46UserInfo *fbUserInfo)
    {
        if (error)
        {
            [self broadcastNotification:C46UserManagerLoginFailedNotification];
        }
        else
        {   
            [_server loginWithEmail:fbUserInfo.email
                facebookAccessToken:[[C46FacebookConnect sharedInstance] accessToken]
                  completionHandler:^(NSError *error, NSDictionary *userInfo)
            {
                if (error)
                {
                    [self broadcastNotification:C46UserManagerLoginFailedNotification];
                }
                else
                {
                    _isFBLogin = YES;
                    _userInfo = fbUserInfo;
                    [self broadcastNotification:C46UserManagerLoggedInNotification];
                }
            }];
        }
    }];
}

-(void)loginWithUserName:(NSString *)userName andPassword:(NSString *)password
{
    [_server loginWithUserName:userName
                      password:password
             completionHandler:^(NSError *error, NSDictionary *userInfo) 
    {
        if (error)
        {
            [self broadcastNotification:C46UserManagerLoginFailedNotification];
        }
        else
        {
            _isFBLogin = NO;
            _userInfo = [self userInfoWithServerDict:userInfo];
            [self broadcastNotification:C46UserManagerLoggedInNotification];
        }
    }];
}

-(void)logout
{
    if (_isFBLogin)
    {
        [[C46FacebookConnect sharedInstance] logout];
    }
    
    _userInfo = nil;
    _isFBLogin = NO;
}

-(BOOL)isLoggedIn
{
    return nil != _userInfo;
}

#pragma mark - private

-(C46UserInfo*) userInfoWithServerDict:(NSDictionary*) dict
{
    NSString* firstName = [dict objectForKey:@"first_name"];
    NSString* lastName = [dict objectForKey:@"last_name"];
    NSString* userName = [dict objectForKey:@"name"];
    NSString* email = [dict objectForKey:@"email"];
    
    C46UserInfo* userInfo = [[C46UserInfo alloc] initWithUserName:userName
                                                            email:email
                                                        firstName:firstName
                                                         lastName:lastName];
    
    return userInfo;
}

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