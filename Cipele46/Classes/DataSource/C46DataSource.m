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
#import "C46AdFilter.h"
#import "C46UserManager.h"
#import "C46User.h"
#import "C46AdCategory.h"

int const ddLogLevel = LOG_LEVEL_WARN;

@interface C46DataSource ()

@property (nonatomic) C46UserManager *userManager;

@end

@implementation C46DataSource

+ (C46DataSource *)sharedInstance
{
    static C46DataSource *_sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedInstance = [[C46DataSource alloc] initWithUserManager:[C46UserManager sharedInstance]];
    });
    
    return _sharedInstance;
}

- (id)initWithUserManager:(C46UserManager *)userManager
{
    if (self = [super init]) {
        _userManager = userManager;
    }
    
    return self;
}

#pragma mark - User in session

- (BOOL)isUserLoggedIn
{
    return [[C46UserManager sharedInstance] isLoggedIn];
}

- (C46User *)loggedInUser
{
    return [[C46UserManager sharedInstance] loggedInUser];
}

- (id <WMRequestProxyProtocol>)createUserWithName:(NSString *)name
                                         lastName:(NSString *)lastName
                                            email:(NSString *)email
                                            phone:(NSString *)phone
                                         password:(NSString *)password
                             passwordConfirmation:(NSString *)passwordConfirmation
                                          success:(void (^)(C46User *))success
                                          failure:(void (^)(C46Error *))failure
{
    DDLogInfo(@"Create user");
    
    WMAFHTTPClientRequest *request = [_userManager createUserWithName:name
                                                             lastName:lastName
                                                                email:email
                                                                phone:phone
                                                             password:password
                                                 passwordConfirmation:passwordConfirmation
                                                              success:success
                                                              failure:failure];
    [request start];
    
    return request;
}

- (id<WMRequestProxyProtocol>)loginUserWithEmail:(NSString *)email
                                        password:(NSString *)password
                                         success:(void (^)(C46User *))success
                                         failure:(void (^)(C46Error *))failure
{
    DDLogInfo(@"Create user");
    
    [self setAuthorizationHeadersUsername:email password:password];
    
    WMAFHTTPClientRequest *request = [_userManager loginUserWithEmail:email
                                                             password:password
                                                              success:success
                                                              failure:failure];
    [request start];
    
    return request;
}

- (void)setAuthorizationHeadersUsername:(NSString *)username
                               password:(NSString *)password
{
    [[C46Cipele46APINetworkClient sharedClient] setAuthorizationHeaderWithUsername:username
                                                                          password:password];
    
}


#pragma mark - Cipele46 API - Ad

- (id <WMRequestProxyProtocol>)fetchAllPublicAdsWithSuccess:(void (^)(NSArray *))success
                                                    failure:(void (^)(C46Error *))failure
{
    DDLogInfo(@"Fetch all public ads");
    
    return [self fetchPublicAdsWithFilters:nil
                                   success:success
                                   failure:failure];
}

- (id<WMRequestProxyProtocol>)fetchPublicAdsWithFilters:(NSArray *)filters
                                                success:(void (^)(NSArray *))success
                                                failure:(void (^)(C46Error *))failure
{
    DDLogInfo(@"Fetch public ads with filters");
    DDLogVerbose(@"\t\tFilters: %@", filters);
    
    NSString *path = @"ads.json";
    
    NSDictionary *parameters = [self adFilterParametersFromFilters:filters availableFiltersMask:AdFilterMask_All & ~AdFilterMask_FavoritedAdsOnly & ~AdFilterMask_CurrentUserAdsOnly];
    
    WMAFHTTPClientRequest *request = [WMAFHTTPClientRequest getRequestWithPath:path
                                                                    parameters:parameters
                                                                 networkClient:[C46Cipele46APINetworkClient sharedClient]
                                                                       success:^(id responseInfo, id responseObject) {
                                                                           
                                                                           DDLogInfo(@"Fetch all public ads success");
                                                                           DDLogVerbose(@"\t\tResponse: %@", responseObject);
                                                                           DDLogVerbose(@"\t\tResponse info: %@", responseInfo);
                                                                           
                                                                           success([self.class adsFromResponseObject:responseObject]);
                                                                           
                                                                       } failure:^(id responseInfo, id responseObject) {
                                                                           
                                                                           DDLogError(@"Fetch all public ads error");
                                                                           DDLogVerbose(@"\t\tResponse: %@", responseObject);
                                                                           DDLogVerbose(@"\t\tResponse info: %@", responseInfo);
                                                                           
                                                                           failure([C46Cipele46APIUtils errorFromHTTPResponse:responseObject
                                                                                                                 responseInfo:responseInfo]);
                                                                       }];
    
    [request start];
    
    return request;
    
}

- (id<WMRequestProxyProtocol>)fetchAdsWithFilters:(NSArray *)filters
                                          success:(void (^)(NSArray *))success
                                          failure:(void (^)(C46Error *))failure
{
    DDLogInfo(@"Fetch ads with filters");
    
    NSString *path = @"ads.json";
    NSDictionary *parameters = [self adFilterParametersFromFilters:filters availableFiltersMask:AdFilterMask_All];
    
    WMAFHTTPClientRequest *request = [WMAFHTTPClientRequest getRequestWithPath:path
                                                                    parameters:parameters
                                                                 networkClient:[C46Cipele46APINetworkClient sharedClient]
                                                                       success:^(id responseInfo, id responseObject) {
                                                                           
                                                                           DDLogInfo(@"Fetch ads with filter success");
                                                                           DDLogVerbose(@"\t\tResponse: %@", responseObject);
                                                                           DDLogVerbose(@"\t\tResponse info: %@", responseInfo);
                                                                           
                                                                           success([self.class adsFromResponseObject:responseObject]);
                                                                           
                                                                       } failure:^(id responseInfo, id responseObject) {
                                                                           
                                                                           DDLogError(@"Fetch ads with filter error");
                                                                           DDLogVerbose(@"\t\tResponse: %@", responseObject);
                                                                           DDLogVerbose(@"\t\tResponse info: %@", responseInfo);
                                                                           
                                                                           failure([C46Cipele46APIUtils errorFromHTTPResponse:responseObject
                                                                                                                 responseInfo:responseInfo]);
                                                                       }];
    
    [request start];
    
    return request;
}


- (id <WMRequestProxyProtocol>)createAdWithAdCategory:(C46AdCategory *)adCategory
                                                 city:(C46City *)city
                                                title:(NSString *)title
                                          description:(NSString *)description
                                                phone:(NSString *)phone
                                               adType:(AdType)adType
                                              success:(void(^)())success
                                              failure:(void(^)(C46Error *error))failure
{
    DDLogInfo(@"Create ad");
    
    NSString *path = @"ads.json";
    NSDictionary *bodyParameters = @{
                                     @"ad" :
                                         @{
                                             @"category_id": adCategory.identifier,
                                             @"city_id":city.identifier,
                                             @"title": title,
                                             @"description":description,
                                             @"phone":phone,
                                             @"ad_type":[@(adType) description]
                                             }
                                     };
    
    WMAFHTTPClientRequest *request = [WMAFHTTPClientRequest postRequestWithPath:path
                                                                 bodyParameters:bodyParameters
                                                                  networkClient:[C46Cipele46APINetworkClient sharedClient]
                                                                        success:^(id responseInfo, id responseObject) {
                                                                            
                                                                            DDLogInfo(@"Create ad success");
                                                                            DDLogVerbose(@"\t\tResponse: %@", responseObject);
                                                                            DDLogVerbose(@"\t\tResponse info: %@", responseInfo);
                                                                            
                                                                            success();
                                                                            
                                                                        } failure:^(id responseInfo, id responseObject) {
                                                                            
                                                                            DDLogError(@"Create ad error error");
                                                                            DDLogVerbose(@"\t\tResponse: %@", responseObject);
                                                                            DDLogVerbose(@"\t\tResponse info: %@", responseInfo);
                                                                            
                                                                            failure([C46Cipele46APIUtils errorFromHTTPResponse:responseObject
                                                                                                                  responseInfo:responseInfo]);
                                                                        }];
    
    [request start];
    
    return request;
}


#pragma mark - Cipele46 API - Category

- (id<WMRequestProxyProtocol>)fetchCategoriesWithSuccess:(void (^)(NSArray *))success
                                                 failure:(void (^)(C46Error *))failure
{
    DDLogInfo(@"Fetch categories");
    
    NSString *path = @"categories.json";
    
    WMAFHTTPClientRequest *request = [WMAFHTTPClientRequest getRequestWithPath:path
                                                                    parameters:nil
                                                                 networkClient:[C46Cipele46APINetworkClient sharedClient]
                                                                       success:^(id responseInfo, id responseObject) {
                                                                           
                                                                           DDLogInfo(@"Fetch categories success");
                                                                           DDLogVerbose(@"\t\tResponse: %@", responseObject);
                                                                           DDLogVerbose(@"\t\tResponse info: %@", responseInfo);
                                                                           
                                                                           success([self.class categoriesFromResponseObject:responseObject]);
                                                                           
                                                                       } failure:^(id responseInfo, id responseObject) {
                                                                           
                                                                           DDLogError(@"Fetch categories error");
                                                                           DDLogVerbose(@"\t\tResponse: %@", responseObject);
                                                                           DDLogVerbose(@"\t\tResponse info: %@", responseInfo);
                                                                           
                                                                           failure([C46Cipele46APIUtils errorFromHTTPResponse:responseObject
                                                                                                                 responseInfo:responseInfo]);
                                                                       }];
    
    [request start];
    
    return request;
}


#pragma mark - Cipele46 API - Region

- (id<WMRequestProxyProtocol>)fetchRegionsWithSuccess:(void (^)(NSArray *))success
                                              failure:(void (^)(C46Error *))failure
{
    DDLogInfo(@"Fetch regions");
    
    NSString *path = @"regions.json";
    
    WMAFHTTPClientRequest *request = [WMAFHTTPClientRequest getRequestWithPath:path
                                                                    parameters:nil
                                                                 networkClient:[C46Cipele46APINetworkClient sharedClient]
                                                                       success:^(id responseInfo, id responseObject) {
                                                                           
                                                                           DDLogInfo(@"Fetch regions success");
                                                                           DDLogVerbose(@"\t\tResponse: %@", responseObject);
                                                                           DDLogVerbose(@"\t\tResponse info: %@", responseInfo);
                                                                           
                                                                           success([self.class regionsFromResponseObject:responseObject]);
                                                                           
                                                                       } failure:^(id responseInfo, id responseObject) {
                                                                           
                                                                           DDLogError(@"Fetch regions error");
                                                                           DDLogVerbose(@"\t\tResponse: %@", responseObject);
                                                                           DDLogVerbose(@"\t\tResponse info: %@", responseInfo);
                                                                           
                                                                           failure([C46Cipele46APIUtils errorFromHTTPResponse:responseObject
                                                                                                                 responseInfo:responseInfo]);
                                                                       }];
    
    [request start];
    
    return request;
}


#pragma mark - Private

- (NSDictionary *)adFilterParametersFromFilters:(NSArray *)filters availableFiltersMask:(AdFilterMask)availableFiltersMask
{
    NSMutableDictionary *parameters = [NSMutableDictionary dictionaryWithCapacity:filters.count];
    
    for (C46AdFilter *filter in filters) {
        
        BOOL shouldAdd = NO;
        shouldAdd =  availableFiltersMask & filter.adFilterMask;
        
        if (filter.requiresAuthentication) {
            DDLogWarn(@"Needs user authentication");
            shouldAdd = shouldAdd && [self isUserLoggedIn];
        }
        
        if (shouldAdd) {
            parameters[filter.C46APIKey] = filter.C46APIValue;
        } else {
            NSAssert(NO, @"Filter mask wrong.");
        }
    }
    
    return parameters;
}

#pragma mark - Utils

+ (NSArray *)adsFromResponseObject:(id)responseObject
{
    NSMutableArray *ads = [NSMutableArray array];
    
    for (NSDictionary *dictionary in responseObject) {
        
        C46Ad *ad = [[C46Ad alloc] initWithJSONDictionary:dictionary];
        [ads addObject:ad];
    }
    
    return ads;
}

+ (NSArray *)categoriesFromResponseObject:(id)responseObject
{
    NSMutableArray *categories = [NSMutableArray array];
    
    for (NSDictionary *dictionary in responseObject) {
        
        C46AdCategory *adCategory = [[C46AdCategory alloc] initWithJSONDictionary:dictionary];
        [categories addObject:adCategory];
    }
    
    return categories;
}

+ (NSArray *)regionsFromResponseObject:(id)responseObject
{
    NSMutableArray *regions = [NSMutableArray array];
    
    for (NSDictionary *dictionary in responseObject) {
        
        C46Region *region = [[C46Region alloc] initWithJSONDictionary:dictionary];
        [regions addObject:region];
    }
    
    return regions;
}

@end
