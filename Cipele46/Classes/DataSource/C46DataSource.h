//
//  C46DataSource.h
//  Cipele46
//
//  Created by Dino Bartošak on 7/15/13.
//  Copyright (c) 2013 Miran Brajsa. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WMAFHTTPClientRequest.h"

@interface C46DataSource : NSObject

+ (C46DataSource *)sharedInstance;


- (id <WMRequestProxyProtocol>)fetchAdsWithSuccess:(void(^)(NSArray *ads))success // C46Ad objects
                                           failure:(void(^)(WMError *error))failure;

@end
