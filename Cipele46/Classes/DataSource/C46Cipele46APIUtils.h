//
//  WMWinkMeDataSourceUtils.h
//  WinkMe
//
//  Created by Dino Bartošak on 5/26/13.
//  Copyright (c) 2013 Dino Bartošak. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CLLocation;
@class WMEvent;
@class WMUser;

@interface C46Cipele46APIUtils : NSObject

+ (WMError *)errorFromHTTPResponse:(NSDictionary *)responseDict
                            responseInfo:(NSDictionary *)responseInfo;

@end

