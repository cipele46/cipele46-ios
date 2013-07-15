//
//  WMError.h
//  WinkMe
//
//  Created by Dino Bartošak on 2/17/13.
//  Copyright (c) 2013 Dino Bartošak. All rights reserved.
//

#import <Foundation/Foundation.h>

#define kWMErrorDomain @"com.winkme.error"

typedef enum _WMErrorType{

    WMErrorType_Undefined,
    WMErrorType_NetworkConnection,
    WMErrorType_ServerError

} WMErrorType;

@interface WMError : NSError

+ (WMError *)error;
+ (WMError *)errorWithUserInfoFromError:(NSError *)error;
+ (WMError *)errorWithErrorCode:(NSInteger)code;

@end
