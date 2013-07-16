//
//  WMError.h
//  WinkMe
//
//  Created by Dino Bartošak on 2/17/13.
//  Copyright (c) 2013 Dino Bartošak. All rights reserved.
//

#import <Foundation/Foundation.h>

#define kC46ErrorDomain @"org.cipele46.error"

typedef enum _C46ErrorType{

    C46ErrorType_Undefined,
    C46ErrorType_NetworkConnection,
    C46ErrorType_ServerError

} C46ErrorType;

@interface C46Error : NSError

+ (C46Error *)error;
+ (C46Error *)errorWithUserInfoFromError:(NSError *)error;
+ (C46Error *)errorWithErrorCode:(NSInteger)code;

@end
