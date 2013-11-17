//
//  C46DataSource.h
//  Cipele46
//
//  Created by Dino Bartošak on 7/15/13.
//  Copyright (c) 2013 Miran Brajsa. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WMAFHTTPClientRequest.h"

@class C46User;

@interface C46DataSource : NSObject

+ (C46DataSource *)sharedInstance;

@property (nonatomic, readonly) BOOL isUserLoggedIn;
@property (nonatomic, readonly) C46User *loggedInUser;

#pragma mark - Cipele46 API

- (id <WMRequestProxyProtocol>)fetchAllPublicAdsWithSuccess:(void(^)(NSArray *ads))success // C46Ad objects
                                                    failure:(void(^)(C46Error *error))failure;

- (id <WMRequestProxyProtocol>)fetchPublicAdsWithFilters:(NSArray *)filters // array of C46AdFilter objects
                                                 success:(void(^)(NSArray *ads))success // C46Ad objects
                                                 failure:(void(^)(C46Error *error))failure;


- (id <WMRequestProxyProtocol>)fetchAdsWithFilters:(NSArray *)filters // array of C46AdFilter objects
                                           success:(void(^)(NSArray *ads))success // C46Ad objects
                                           failure:(void(^)(C46Error *error))failure;

- (id <WMRequestProxyProtocol>)fetchCategoriesWithSuccess:(void(^)(NSArray *categories))success // C46Category objects
                                                  failure:(void(^)(C46Error *error))failure;

- (id <WMRequestProxyProtocol>)fetchRegionsWithSuccess:(void(^)(NSArray *regions))success // C46Region objects
                                               failure:(void(^)(C46Error *error))failure;


@end
