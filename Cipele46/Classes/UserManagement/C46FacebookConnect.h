//
//  C46FacebookConnect.h
//  Cipele46
//
//  Created by Drago Ruzman on 7/6/13.
//  Copyright (c) 2013 Miran Brajsa. All rights reserved.
//

#import <Foundation/Foundation.h>

@class C46User;

@interface C46FacebookConnect : NSObject

+(id) sharedInstance;

-(void) connectWithCompletionHandler:(void(^)(NSError* error, C46User* userInfo)) completionHandler;
-(void) disconnect;

-(BOOL) handleOpenURL:(NSURL*) url;
-(void) handleDidBecomeActive;

@property(nonatomic,readonly) NSString* accessToken;

@end
