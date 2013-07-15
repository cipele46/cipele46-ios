//
//  WMNetworkOperation.h
//  WinkMe
//
//  Created by Dino Bartošak on 2/24/13.
//  Copyright (c) 2013 Dino Bartošak. All rights reserved.
//

#import "AFHTTPClient.h"
#import "WMRequestProxyProtocol.h"

NSString * WMResponseStatusCodeFromRequestKey; //NSUInteger
NSString * WMNetworkClientErrorLocalizedDesriptionKey; // NSString
NSString * WMErrorTypeKey; // WMWinkMeError

typedef void (^WMAFHTTPClientRequestSuccess)(id responseInfo, id responseObject);
typedef void (^WMAFHTTPClientRequestFailure)(id responseInfo, id responseObject);

@interface WMAFHTTPClientRequest : NSObject <WMRequestProxyProtocol>

+ (WMAFHTTPClientRequest *)postRequestWithPath:(NSString *)path
                                bodyParameters:(NSDictionary *)bodyParameters
                                 networkClient:(AFHTTPClient *)networkClient
                                       success:(WMAFHTTPClientRequestSuccess)success
                                       failure:(WMAFHTTPClientRequestFailure)failure;

+ (WMAFHTTPClientRequest *)getRequestWithPath:(NSString *)path
                                   parameters:(NSDictionary *)parameters
                                networkClient:(AFHTTPClient *)networkClient
                                      success:(WMAFHTTPClientRequestSuccess)success
                                      failure:(WMAFHTTPClientRequestFailure)failure;



@end
