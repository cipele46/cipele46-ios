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
                                           failure:(void (^)(WMError *))failure
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

#pragma mark - server comm delegate response method

+ (NSArray *)adsFromResponseObject:(id)responseObject
{
    NSMutableArray *ads = [NSMutableArray array];
    
    for (NSDictionary *dic in responseObject)
    {
        C46Ad *ad = [[C46Ad alloc] init];
        
        ad.status = [dic valueForKey:@"id"];
        ad.description = [dic valueForKey:@"description"];
        ad.districtID = [dic valueForKey:@"districtID"];
        ad.phone = [dic valueForKey:@"phone"];
        ad.categoryID = [dic valueForKey:@"categoryID"];
        ad.adID = [dic valueForKey:@"id"];
        ad.cityID = [dic valueForKey:@"cityID"];
        ad.type = [dic valueForKey:@"ad_type"];
        ad.email = [dic valueForKey:@"email"];
        ad.title = [dic valueForKey:@"title"];
        NSDictionary *category = [dic valueForKey:@"category"];
        NSDictionary *city = [dic valueForKey:@"city"];
        NSDictionary *district = [dic valueForKey:@"district"];
        ad.category = [category valueForKey:@"name"];
        ad.city = [city valueForKey:@"name"];
        ad.district = [district valueForKey:@"name"];
        ad.imageURL = [NSURL URLWithString:@"http://www.lynnwittenburg.com/wp-content/uploads/2013/03/Ball.jpg"];
        
        [ads addObject:ad];
    }

    return ads;
}

@end
