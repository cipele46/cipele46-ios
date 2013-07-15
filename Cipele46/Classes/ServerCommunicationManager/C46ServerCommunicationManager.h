//
//  C46ServerCommunicationManager.h
//  Cipele46
//
//  Created by Miran Brajsa on 7/6/13.
//  Copyright (c) 2013 Miran Brajsa. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    kC46FilterAdvertTypeSupply = 0,
    kC46FilterAdvertTypeDemand = 1
} kC46FilterAdvertTypes;

@protocol C46ServerCommunicationManagerDelegate <NSObject>
@optional
//   Returns an array of dictionaries with keys: 'cityID', 'phone',
// 'categoryID', 'description', 'title', 'imageUrl', 'districtID', 'id',
// 'email'.
- (void)didReceiveAds:(NSArray *)ads withError:(NSError *)error;
//   Returns an array of dictionaries with keys: 'id', 'name'.
- (void)didReceiveCategories:(NSArray *)categories withError:(NSError *)error;
//   Returns an array of dictionaries with keys: 'id', 'name'.
- (void)didReceiveDistricts:(NSArray *)districts withError:(NSError *)error;

//   Returns dictionary with keys: 'name', 'email', 'phone' (optional).
- (void)didReceiveLoginResponse:(NSDictionary *)userInfo withError:(NSError *)error;
@end

@interface C46ServerCommunicationManager : NSObject

@property (nonatomic, weak) id<C46ServerCommunicationManagerDelegate> delegate;

//- (void)ads;
- (void)categories;
- (void)districts;

- (void)loginWithUsername:(NSString *)username andPassword:(NSString *)password;

-(void) loginWithEmail:(NSString*) email
   facebookAccessToken:(NSString*) accessToken
     completionHandler:(void(^)(NSError* error, NSDictionary* userInfo)) completionHandler;

-(void) loginWithUserName:(NSString*) userName
                 password:(NSString*) password
        completionHandler:(void(^)(NSError* error, NSDictionary* userInfo)) completionHandler;


@end
