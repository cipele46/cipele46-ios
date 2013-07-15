//
//  WMNetworkOperationProxyProtocol.h
//  WinkMe
//
//  Created by Dino Bartošak on 2/24/13.
//  Copyright (c) 2013 Dino Bartošak. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol WMRequestProxyProtocol <NSObject>

@property (nonatomic, readonly) BOOL isLoading;

- (void)start;
- (void)cancel;

@end


