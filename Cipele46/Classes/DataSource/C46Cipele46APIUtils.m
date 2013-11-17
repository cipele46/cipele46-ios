//
//  WMWinkMeDataSourceUtils.m
//  WinkMe
//
//  Created by Dino Bartošak on 5/26/13.
//  Copyright (c) 2013 Dino Bartošak. All rights reserved.
//

#import "C46Cipele46APIUtils.h"
#import "WMAFHTTPClientRequest.h"
#import "NSMutableDictionary+Additions.h"

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
    
        NSInteger code = [responseInfo[C46ErrorTypeKey] integerValue];
        
        NSMutableDictionary *userInfo = [NSMutableDictionary dictionary];
        
        NSString *errorLocalizedDescription = responseInfo[C46NetworkClientErrorLocalizedDesriptionKey];
        NSString *errorLocalizedREcoverySuggestion = responseInfo[C46NetworkClientErrorLocalizedResoverySuggestionKey];
        
        [userInfo setObjectSafe:errorLocalizedDescription forKey:NSLocalizedDescriptionKey];
        [userInfo setObjectSafe:errorLocalizedREcoverySuggestion forKey:NSLocalizedRecoverySuggestionErrorKey];

        error = [C46Error errorWithDomain:kC46ErrorDomain code:code userInfo:userInfo];
    }
    
    if (!error) {
        
        DDLogWarn(@"Error not created. Create default one");
        error = [C46Error error];
    }
    
    return error;
}

@end
