//
//  WMNetworkClient.m
//  WinkMe
//
//  Created by Dino Bartošak on 2/23/13.
//  Copyright (c) 2013 Dino Bartošak. All rights reserved.
//

#import "C46Cipele46APINetworkClient.h"
#import "AFJSONRequestOperation.h"

#define kBaseURL @"http://cipele46.org/"
#define kStageURL @"http://staging.cipele46.org/api"


@implementation C46Cipele46APINetworkClient

+ (C46Cipele46APINetworkClient *)sharedClient
{
    static C46Cipele46APINetworkClient *__instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        __instance = [[C46Cipele46APINetworkClient alloc] initWithBaseURL:[NSURL URLWithString:kBaseURL]];
    });
    
    return __instance;
}

- (id)initWithBaseURL:(NSURL *)url
{
    if (self = [super initWithBaseURL:url]) {
        [self setDefaultHeader:@"Accept" value:@"application/json"];
        [self registerHTTPOperationClass:[AFJSONRequestOperation class]];
        self.parameterEncoding = AFJSONParameterEncoding;
        
    }
    
    return self;
}

@end
