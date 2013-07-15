//
//  WMError.m
//  WinkMe
//
//  Created by Dino Bartošak on 2/17/13.
//  Copyright (c) 2013 Dino Bartošak. All rights reserved.
//

#import "WMError.h"

@implementation WMError


+ (WMError *)error
{
    WMError *error = [WMError errorWithDomain:kWMErrorDomain
                                         code:WMErrorType_Undefined
                                     userInfo:nil];
        
    return error;
}

+ (WMError *)errorWithUserInfoFromError:(NSError *)error
{
    WMError *retError = [WMError errorWithDomain:kWMErrorDomain
                                            code:WMErrorType_Undefined
                                        userInfo:error.userInfo];

    return retError;
}

+ (WMError *)errorWithErrorCode:(NSInteger)code
{
    WMError *retError = [WMError errorWithDomain:kWMErrorDomain
                                            code:code
                                        userInfo:nil];
    
    return retError;
}

@end
