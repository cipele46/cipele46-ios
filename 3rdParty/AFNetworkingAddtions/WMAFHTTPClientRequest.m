//
//  WMNetworkOperation.m
//  WinkMe
//
//  Created by Dino Bartošak on 2/24/13.
//  Copyright (c) 2013 Dino Bartošak. All rights reserved.
//

#import "WMAFHTTPClientRequest.h"
#import "AFHTTPRequestOperation.h"
#import "NSMutableDictionary+Additions.h"

NSString * C46ResponseStatusCodeFromRequestKey = @"C46ResponseStatusCodeFromRequestKey";
NSString * C46NetworkClientErrorLocalizedDesriptionKey = @"C46NetworkClientErrorLocalizedDesriptionKey";
NSString * C46ErrorTypeKey = @"C46ErrorTypeKey";

typedef enum __WMNetworkOperationProxyType {
    
    WMNetworkOperationProxyTypeGET,
    WMNetworkOperationProxyTypePOST
    
} WMNetworkOperationProxyType;

@interface WMAFHTTPClientRequest ()

@property (nonatomic) AFHTTPRequestOperation *operation;
@property (nonatomic) WMNetworkOperationProxyType type;
@property (nonatomic) NSString *path;
@property (nonatomic) AFHTTPClient *networkClient;

// mutualy exclusive
@property (nonatomic) NSDictionary *postBodyParameters;
@property (nonatomic) NSDictionary *getParameters;

@property (nonatomic, strong) WMAFHTTPClientRequestSuccess success;
@property (nonatomic, strong) WMAFHTTPClientRequestFailure failure;

@end

@implementation WMAFHTTPClientRequest

@synthesize isLoading = _isLoading;

#pragma mark - Factory methods

+ (WMAFHTTPClientRequest *)postRequestWithPath:(NSString *)path
                                bodyParameters:(NSDictionary *)bodyParameters
                                 networkClient:(AFHTTPClient *)networkClient
                                       success:(WMAFHTTPClientRequestSuccess)success
                                       failure:(WMAFHTTPClientRequestFailure)failure;
{
    
    WMAFHTTPClientRequest *request = [[WMAFHTTPClientRequest alloc] init];
    
    request.type = WMNetworkOperationProxyTypePOST;
    
    request.path = path;
    request.postBodyParameters = bodyParameters;
    request.networkClient = networkClient;
    request.success = success;
    request.failure = failure;

    return request;
}


+ (WMAFHTTPClientRequest *)getRequestWithPath:(NSString *)path
                                   parameters:(NSDictionary *)parameters
                                networkClient:(AFHTTPClient *)networkClient
                                      success:(WMAFHTTPClientRequestSuccess)success
                                      failure:(WMAFHTTPClientRequestFailure)failure;
{
    WMAFHTTPClientRequest *request = [[WMAFHTTPClientRequest alloc] init];
    
    request.type = WMNetworkOperationProxyTypeGET;
    
    request.path = path;
    request.getParameters = parameters;
    request.networkClient = networkClient;
    request.success = success;
    request.failure = failure;
    
    return request;
}


#pragma mark - Request Protocol

- (void)start
{
    AFHTTPRequestOperation *operation = nil;
    
    switch (_type) {
        case WMNetworkOperationProxyTypePOST:
            
            operation = [self startPostRequest];
            
            break;
            
        case WMNetworkOperationProxyTypeGET:
            
            operation = [self startGetRequest];
            
            break;
    }
    
    NSAssert(operation != nil, @"Operation can not be nil");
    
    _operation = operation;
}

- (void)cancel
{
    [_operation cancel];
}

#pragma mark - Private

- (AFHTTPRequestOperation *)startPostRequest
{
    DDLogInfo(@"Start POST request");
    DDLogVerbose(@"\t\tBase URL: %@", _networkClient.baseURL);
    DDLogVerbose(@"\t\tPath: %@", _path);
    
    AFHTTPRequestOperation *operation = [_networkClient postPath:_path
                                                      parameters:_postBodyParameters
                                                         success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                                            
                                                             DDLogInfo(@"AFHTTPClientRequest POST success.");
                                                             DDLogVerbose(@"\t\tResponse: %@", responseObject);
                                                             
                                                             _success([WMAFHTTPClientRequest responseInfoFromRequestOperation:operation networkClientError:nil],
                                                                      responseObject);
                                                            
                                                             
                                                         } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                                             
                                                             DDLogError(@"AFHTTPClientRequest POST error: %@", error.localizedDescription);
                                                             DDLogVerbose(@"\t\tError: %@", error);
                                                             
                                                             _failure([WMAFHTTPClientRequest responseInfoFromRequestOperation:operation networkClientError:error],
                                                                      [WMAFHTTPClientRequest responseObjectFromRequestOperation:operation]);
                                                         }];
    
    return operation;
}

- (AFHTTPRequestOperation *)startGetRequest
{
    DDLogInfo(@"Start GET request");
    DDLogVerbose(@"\t\tBase URL: %@", _networkClient.baseURL);
    DDLogVerbose(@"\t\tPath: %@", _path);
    
    AFHTTPRequestOperation *operation = [_networkClient getPath:_path
                                                     parameters:_getParameters
                                                        success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                                            
                                                            DDLogInfo(@"AFHTTPClientRequest GET success.");
                                                            DDLogVerbose(@"\t\tResponse: %@", responseObject);
                                                            
                                                            _success([WMAFHTTPClientRequest responseInfoFromRequestOperation:operation networkClientError:nil],
                                                                     responseObject);
                                                            
                                                        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                                            
                                                            DDLogError(@"AFHTTPClientRequest GET error: %@", error.localizedDescription);
                                                            DDLogVerbose(@"\t\tError: %@", error);
                                                            
                                                            _failure([WMAFHTTPClientRequest responseInfoFromRequestOperation:operation networkClientError:error],
                                                                     [WMAFHTTPClientRequest responseObjectFromRequestOperation:operation]);
                                                            
                                                        }];
    
    return operation;
}

#pragma mark - Utils

+ (NSDictionary *)responseInfoFromRequestOperation:(AFHTTPRequestOperation *)operation networkClientError:(NSError *)networkClientError
{
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    
    // TODO: check here if is network failure

    [dict setObjectSafe:@(operation.response.statusCode) forKey:C46ResponseStatusCodeFromRequestKey];
    
    if (networkClientError) {
        [dict setObjectSafe:@([WMAFHTTPClientRequest errorTypeFromRequestOperation:operation]) forKey:C46ErrorTypeKey];
    }
    
    [dict setObjectSafe:networkClientError.localizedDescription forKey:C46NetworkClientErrorLocalizedDesriptionKey];
    
    return dict;
}
         
+ (C46ErrorType)errorTypeFromRequestOperation:(AFHTTPRequestOperation *)operation
{
    C46ErrorType type = C46ErrorType_Undefined;
    
    if (operation.response && operation.response.statusCode >= 500) {
        
        type = C46ErrorType_ServerError;
    
    } else if (!operation.response) {
        
        type = C46ErrorType_NetworkConnection;
    }
    
    return type;
}



+ (NSDictionary *)responseObjectFromRequestOperation:(AFHTTPRequestOperation *)operation
{
    NSDictionary *responseObject = nil;

    if (operation.responseData) {
        responseObject = [NSJSONSerialization JSONObjectWithData:operation.responseData options:0 error:nil];
    }
    
    return responseObject;
}

@end
