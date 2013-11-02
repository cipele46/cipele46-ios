//
//  WMWinkMeDataSourceUtils.m
//  WinkMe
//
//  Created by Dino Bartošak on 5/26/13.
//  Copyright (c) 2013 Dino Bartošak. All rights reserved.
//

#import "C46Cipele46APIUtils.h"
#import "WMAFHTTPClientRequest.h"

@implementation C46Cipele46APIUtils

+ (C46Error *)errorFromHTTPResponse:(NSDictionary *)responseDict responseInfo:(NSDictionary *)responseInfo
{
    DDLogInfo(@"Error from Wink Me HTTP Response");
    DDLogVerbose(@"\t\tResponse: %@", responseDict);
    DDLogVerbose(@"\t\tResponse info: %@", responseInfo);
    
    C46Error *error = nil;
    
    if (responseDict && responseDict[@"errorCode"] != nil) {
        
        NSUInteger errorCode = [responseDict[@"errorCode"] unsignedIntegerValue];
        NSString *message = responseDict[@"message"];
        
        error = [C46Error errorWithDomain:kC46ErrorDomain code:errorCode userInfo:@{NSLocalizedDescriptionKey : message}];
        
    } else if (responseInfo) {
        
        NSString *errorLocalizedDescription = responseInfo[C46NetworkClientErrorLocalizedDesriptionKey];
        NSInteger code = [responseInfo[C46ErrorTypeKey] integerValue];
        
        if (errorLocalizedDescription) {
            
            error = [C46Error errorWithDomain:kC46ErrorDomain code:code userInfo:@{NSLocalizedDescriptionKey : errorLocalizedDescription}];
        
        } else {
        
            error = [C46Error errorWithDomain:kC46ErrorDomain code:code userInfo:nil];
        }
    }
    
    if (!error) {
        
        DDLogWarn(@"Error not created. Create default one");
        error = [C46Error error];
    }
    
    return error;
}

@end
