//
//  WMError.m
//  WinkMe
//
//  Created by Dino Bartošak on 2/17/13.
//  Copyright (c) 2013 Dino Bartošak. All rights reserved.
//

#import "C46Error.h"

@implementation C46Error


+ (C46Error *)error
{
    C46Error *error = [C46Error errorWithDomain:kC46ErrorDomain
                                         code:C46ErrorType_Undefined
                                     userInfo:nil];
        
    return error;
}

+ (C46Error *)errorWithUserInfoFromError:(NSError *)error
{
    C46Error *retError = [C46Error errorWithDomain:kC46ErrorDomain
                                            code:C46ErrorType_Undefined
                                        userInfo:error.userInfo];

    return retError;
}

+ (C46Error *)errorWithErrorCode:(NSInteger)code
{
    C46Error *retError = [C46Error errorWithDomain:kC46ErrorDomain
                                            code:code
                                        userInfo:nil];
    
    return retError;
}

@end
