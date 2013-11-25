//
//  C46DataSource.h
//  Cipele46
//
//  Created by Dino Bartošak on 7/15/13.
//  Copyright (c) 2013 Miran Brajsa. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WMAFHTTPClientRequest.h"
#import "C46Ad.h"

@class C46User;

@interface C46DataSource : NSObject

+ (C46DataSource *)sharedInstance;

#pragma mark - User in session

@property (nonatomic, readonly) BOOL isUserLoggedIn;
@property (nonatomic, readonly) C46User *loggedInUser;

- (id <WMRequestProxyProtocol>)createUserWithName:(NSString *)name
                                         lastName:(NSString *)lastName
                                            email:(NSString *)email
                                            phone:(NSString *)phone
                                         password:(NSString *)password
                             passwordConfirmation:(NSString *)passwordConfirmation
                                          success:(void(^)(C46User *user))success
                                          failure:(void(^)(C46Error *error))failure;

- (id <WMRequestProxyProtocol>)loginUserWithEmail:(NSString *)email
                                         password:(NSString *)password
                                          success:(void(^)(C46User *user))success
                                          failure:(void(^)(C46Error *error))failure;

#pragma mark - Cipele46 API - Ad

- (id <WMRequestProxyProtocol>)fetchAllPublicAdsWithSuccess:(void(^)(NSArray *ads))success // C46Ad objects
                                                    failure:(void(^)(C46Error *error))failure;

- (id <WMRequestProxyProtocol>)fetchPublicAdsWithFilters:(NSArray *)filters // array of C46AdFilter objects
                                                 success:(void(^)(NSArray *ads))success // C46Ad objects
                                                 failure:(void(^)(C46Error *error))failure;


- (id <WMRequestProxyProtocol>)fetchAdsWithFilters:(NSArray *)filters // array of C46AdFilter objects
                                           success:(void(^)(NSArray *ads))success // C46Ad objects
                                           failure:(void(^)(C46Error *error))failure;

- (id <WMRequestProxyProtocol>)createAdWithAdCategory:(C46AdCategory *)adCategory
                                                 city:(C46City *)city
                                                title:(NSString *)title
                                          description:(NSString *)description
                                                phone:(NSString *)phone
                                               adType:(AdType)adType
                                              success:(void(^)())success
                                              failure:(void(^)(C46Error *error))failure;


#pragma mark - Cipele46 API - Category

- (id <WMRequestProxyProtocol>)fetchCategoriesWithSuccess:(void(^)(NSArray *categories))success // C46Category objects
                                                  failure:(void(^)(C46Error *error))failure;

#pragma mark - Cipele46 API - Region

- (id <WMRequestProxyProtocol>)fetchRegionsWithSuccess:(void(^)(NSArray *regions))success // C46Region objects
                                               failure:(void(^)(C46Error *error))failure;


@end
