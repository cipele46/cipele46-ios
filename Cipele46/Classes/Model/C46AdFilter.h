//
//  C46AdFilter.h
//  Cipele46
//
//  Created by Dino Bartošak on 7/16/13.
//  Copyright (c) 2013 Miran Brajsa. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "C46Ad.h"

typedef enum __AdFilterMask {
    
    AdFilterMask_Category               =   1 << 0,
    AdFilterMask_AdType                 =   1 << 1,
    AdFilterMask_Region                 =   1 << 2,
    AdFilterMask_Status                 =   1 << 3,
    AdFilterMask_QueryText              =   1 << 4,
    AdFilterMask_CurrentUserAdsOnly     =   1 << 5,
    AdFilterMask_FavoritedAdsOnly       =   1 << 6,
    AdFilterMask_Page                   =   1 << 7,
    AdFilterMask_PerPage                =   1 << 8,
    AdFilterMask_None                   =   0,
    AdFilterMask_All                    =   NSUIntegerMax,
    
} AdFilterMask;

@interface C46AdFilter : NSObject <NSCoding>

@property (nonatomic, readonly) NSString *C46APIKey;
@property (nonatomic, readonly) NSString *C46APIValue;
@property (nonatomic, readonly) BOOL requiresAuthentication;
@property (nonatomic, readonly) AdFilterMask adFilterMask;


// E.g.
//
// filterWithAdCategory:(C46AdCategory *)category;
// initializationContext will be category object
//
// filterWithAdType:(AdType)type;
// initializationContext will be NSNumber object representing AdType as integer

@property (nonatomic, readonly) id initializationContext;

+ (C46AdFilter *)filterWithAdCategory:(C46AdCategory *)category;
+ (C46AdFilter *)filterWithRegion:(C46Region *)region;
+ (C46AdFilter *)filterWithAdType:(AdType)type;
+ (C46AdFilter *)filterWithAdStatus:(AdStatus)status;
+ (C46AdFilter *)filterWithQueryText:(NSString *)text;
+ (C46AdFilter *)filterWithCurrentUserAdsOnly:(BOOL)currentUserAdsOnly;
+ (C46AdFilter *)filterWithFavoritedAdsOnly:(BOOL)favoritedAdsOnly;
+ (C46AdFilter *)filterWithPage:(NSUInteger)page;
+ (C46AdFilter *)filterWithPerPage:(NSUInteger)perPage;


+ (NSArray *)defaultFilters;

@end
