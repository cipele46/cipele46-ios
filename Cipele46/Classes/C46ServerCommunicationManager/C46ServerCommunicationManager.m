//
//  C46ServerCommunicationManager.m
//  Cipele46
//
//  Created by Miran Brajsa on 7/6/13.
//  Copyright (c) 2013 Miran Brajsa. All rights reserved.
//

#import "C46ServerCommunicationManager.h"

#import "AFNetworking.h"
#import "JSONKit.h"

#define mockupURL @"http://dev.fiveminutes.eu/cipele/api/"
#define cipele46URL @"http://cipele46.org/"

@interface C46ServerCommunicationManager ()
typedef void (^DelegateCallerBlock)(id, NSError *);
- (void)serverCommunicationGetPathWorker:(NSString *)path withBlock:(DelegateCallerBlock)delegateCallerBlock parameters:(NSDictionary *)parameters andBaseURL:(NSString *)baseUrl;
@end

@implementation C46ServerCommunicationManager

- (void)serverCommunicationGetPathWorker:(NSString *)path withBlock:(DelegateCallerBlock)delegateCallerBlock parameters:(NSDictionary *)parameters andBaseURL:(NSString *)baseUrl {
    AFHTTPClient *client = [[AFHTTPClient alloc] initWithBaseURL:[NSURL URLWithString:baseUrl]];
    if ([parameters objectForKey:@"username"])
        [client setAuthorizationHeaderWithUsername:[parameters objectForKey:@"username"] password:[parameters objectForKey:@"password"]];
    [client getPath:path parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSString *json_string = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        id response = [json_string objectFromJSONString];
        delegateCallerBlock(response, nil);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Getting '%@' failed: %@", path, [error localizedDescription]);
        delegateCallerBlock(nil, error);
    }];
}

- (void)ads {
    [self serverCommunicationGetPathWorker:@"ads" withBlock:^(id response, NSError *error){
        [self.delegate didReceiveAds:response withError:error];
    } parameters:nil andBaseURL:cipele46URL];
}

- (void)categories {
    [self serverCommunicationGetPathWorker:@"categories.json" withBlock:^(id response, NSError *error){
        [self.delegate didReceiveCategories:response withError:error];
    } parameters:nil andBaseURL:cipele46URL];
}

- (void)districts {
    [self serverCommunicationGetPathWorker:@"regions.json" withBlock:^(id response, NSError *error){
        [self.delegate didReceiveDistricts:response withError:error];
    } parameters:nil andBaseURL:cipele46URL];
}

- (void)loginWithUsername:(NSString *)username andPassword:(NSString *)password {
    [self serverCommunicationGetPathWorker:@"users/show.json" withBlock:^(id response, NSError *error){
        [self.delegate didReceiveLoginResponse:response withError:error];
    } parameters:@{@"username":username, @"password":password} andBaseURL:cipele46URL];
}

-(void) loginWithEmail:(NSString*) email
   facebookAccessToken:(NSString*) accessToken
     completionHandler:(void(^)(NSError* error, NSDictionary* userInfo)) completionHandler
{
    dispatch_async(dispatch_get_current_queue(), ^{
        completionHandler(nil, @{
                          @"name":@"tvrtko tvrtkovic",
                          @"email":@"tvrtko@somemail.com",
                          @"phone":@"+385991234567",
                          });
    });
}

-(void) loginWithUserName:(NSString*) userName
                 password:(NSString*) password
        completionHandler:(void(^)(NSError* error, NSDictionary* userInfo)) completionHandler
{
    dispatch_async(dispatch_get_current_queue(), ^{
        completionHandler(nil, @{
                          @"name":@"tvrtko tvrtkovic",
                          @"email":@"tvrtko@somemail.com",
                          @"phone":@"+385991234567",
                          });
    });
}

@end
