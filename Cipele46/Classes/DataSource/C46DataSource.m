//
//  C46DataSource.m
//  Cipele46
//
//  Created by Dino Bartošak on 7/15/13.
//  Copyright (c) 2013 Miran Brajsa. All rights reserved.
//

#import "C46DataSource.h"
#import "C46Cipele46APINetworkClient.h"
#import "C46Cipele46APIUtils.h"
#import "C46Ad.h"

static const int ddLogLevel = LOG_LEVEL_WARN;

@implementation C46DataSource

+ (C46DataSource *)sharedInstance
{
    static C46DataSource *_sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedInstance = [[C46DataSource alloc] init];
    });
    
    return _sharedInstance;
}

- (id <WMRequestProxyProtocol>)fetchAdsWithSuccess:(void (^)(NSArray *))success
                                           failure:(void (^)(C46Error *))failure
{
    NSString *path = @"ads.json";
    
    WMAFHTTPClientRequest *request = [WMAFHTTPClientRequest getRequestWithPath:path
                                                                    parameters:nil
                                                                 networkClient:[C46Cipele46APINetworkClient sharedClient]
                                                                       success:^(id responseInfo, id responseObject) {
                                                                           
                                                                           DDLogInfo(@"Fetch ads success");
                                                                           DDLogVerbose(@"\t\tResponse: %@", responseObject);
                                                                           DDLogVerbose(@"\t\tResponse info: %@", responseInfo);
                                                                           
                                                                           success([self.class adsFromResponseObject:responseObject]);
                                                                           
                                                                       } failure:^(id responseInfo, id responseObject) {
                                                                           
                                                                           DDLogError(@"Fetch ads error");
                                                                           DDLogVerbose(@"\t\tResponse: %@", responseObject);
                                                                           DDLogVerbose(@"\t\tResponse info: %@", responseInfo);
                                                                           
                                                                           failure([C46Cipele46APIUtils errorFromHTTPResponse:responseObject
                                                                                                                 responseInfo:responseInfo]);
                                                                       }];
    
    [request start];
    
    return request;
}

#pragma mark - Utils

+ (NSArray *)adsFromResponseObject:(id)responseObject
{
    NSMutableArray *ads = [NSMutableArray array];
    
    for (NSDictionary *dictionary in responseObject) {

        C46Ad *ad = [[C46Ad alloc] initWithHTTPReponseDictionary:dictionary];
        [ads addObject:ad];
    }

    return ads;
}

@end
