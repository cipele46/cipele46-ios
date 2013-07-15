//
//  WMWinkMeDataSourceUtils.m
//  WinkMe
//
//  Created by Dino Bartošak on 5/26/13.
//  Copyright (c) 2013 Dino Bartošak. All rights reserved.
//

static const int ddLogLevel = LOG_LEVEL_VERBOSE;

#import "C46Cipele46APIUtils.h"
#import "WMAFHTTPClientRequest.h"


@implementation C46Cipele46APIUtils

+ (WMError *)errorFromHTTPResponse:(NSDictionary *)responseDict responseInfo:(NSDictionary *)responseInfo
{
    DDLogInfo(@"Error from Wink Me HTTP Response");
    DDLogVerbose(@"\t\tResponse: %@", responseDict);
    DDLogVerbose(@"\t\tResponse info: %@", responseInfo);
    
    WMError *error = nil;
    
    if (responseDict && [responseDict objectForKey:@"errorCode"] != nil) {
        
        NSUInteger errorCode = [[responseDict objectForKey:@"errorCode"] unsignedIntegerValue];
        NSString *message = [responseDict objectForKey:@"message"];
        
        error = [WMError errorWithDomain:kWMErrorDomain code:errorCode userInfo:@{NSLocalizedDescriptionKey : message}];
        
    } else if (responseInfo) {
        
        NSString *errorLocalizedDescription = [responseInfo objectForKey:WMNetworkClientErrorLocalizedDesriptionKey];
        NSInteger code = [[responseInfo objectForKey:WMErrorTypeKey] integerValue];
        
        if (errorLocalizedDescription) {
            
            error = [WMError errorWithDomain:kWMErrorDomain code:code userInfo:@{NSLocalizedDescriptionKey : errorLocalizedDescription}];
        
        } else {
        
            error = [WMError errorWithDomain:kWMErrorDomain code:code userInfo:nil];
        }
    }
    
    if (!error) {
        
        DDLogWarn(@"Error not created. Create default one");
        error = [WMError error];
    }
    
    return error;
}

@end
