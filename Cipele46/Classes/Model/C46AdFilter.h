//
//  C46AdFilter.h
//  Cipele46
//
//  Created by Dino Bartošak on 7/16/13.
//  Copyright (c) 2013 Miran Brajsa. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "C46Ad.h"

typedef enum __AdFilterType {
    
    AdFilterTypeOther,
    AdFilterTypeAdCategory,
    AdFilterTypeAdType,
    AdFilterTypeRegion
    
} AdFilterType;

@interface C46AdFilter : NSObject

@property (nonatomic, readonly) NSString *C46APIKey;
@property (nonatomic, readonly) NSString *C46APIValue;
@property (nonatomic, readonly) BOOL requiresAuthentication;
@property (nonatomic, readonly) AdFilterType type;


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

@end



// TODO:
//user (boolean) samo oglasi koji pripadaju trenutnom korisniku
//favorites (boolean) samo oglasi koje je logirani korisnik "favoriteao"
//page (integer, default 1) stranica
//per_page (integer, default 15) broj rezultata po stranici
