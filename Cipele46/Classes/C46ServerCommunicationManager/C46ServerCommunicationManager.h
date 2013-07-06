//
//  C46ServerCommunicationManager.h
//  Cipele46
//
//  Created by Miran Brajsa on 7/6/13.
//  Copyright (c) 2013 Miran Brajsa. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    kC46FilterAdvertTypeSupply,
    kC46FilterAdvertTypeDemand
} kC46FilterAdvertTypes;

@protocol C46ServerCommunicationManagerDelegate <NSObject>
@optional
//   Returns an array of dictionaries with keys: 'cityID', 'phone',
// 'categoryID', 'description', 'title', 'imageUrl', 'districtID', 'id',
// 'email'.
- (void)didReceiveAds:(NSArray *)ads;
//   Returns an array of dictionaries with keys: 'id', 'name'.
- (void)didReceiveCategories:(NSArray *)categories;
//   Returns an array of dictionaries with keys: 'id', 'name'.
- (void)didReceiveDistricts:(NSArray *)districts;

//   Returns dictionary with keys: 'name', 'email', 'phone' (optional).
- (void)didReceiveLoginResponse:(NSDictionary *)userInfo;
@end

@interface C46ServerCommunicationManager : NSObject

@property (nonatomic, weak) id<C46ServerCommunicationManagerDelegate> delegate;

- (void)ads;
- (void)categories;
- (void)districts;

- (void)loginWithUsername:(NSString *)username;

@end
