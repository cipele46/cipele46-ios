//
//  C46AdFilter.m
//  Cipele46
//
//  Created by Dino Bartošak on 7/16/13.
//  Copyright (c) 2013 Miran Brajsa. All rights reserved.
//

#import "C46AdFilter.h"

@interface C46AdFilter ()

@property (nonatomic) NSString *C46APIKey;
@property (nonatomic) NSString *C46APIValue;
@property (nonatomic) BOOL requiresAuthentication;
@property (nonatomic) AdFilterType type;
@property (nonatomic) id initializationContext;

@end

@implementation C46AdFilter


//user (boolean) samo oglasi koji pripadaju trenutnom korisniku
//favorites (boolean) samo oglasi koje je logirani korisnik "favoriteao"
//page (integer, default 1) stranica
//per_page (integer, default 15) broj rezultata po stranici

#pragma mark - Factory

+ (C46AdFilter *)filterWithAdCategory:(C46AdCategory *)category
{
    return [self filterWithAPIKey:@"category_id"
                         APIValue:category.identifier
           requiresAuthentication:NO
                             type:AdFilterTypeAdCategory
            initializationContext:category];
}

+ (C46AdFilter *)filterWithAdType:(AdType)type
{
    return [self filterWithAPIKey:@"ad_type"
                         APIValue:[NSString stringWithFormat:@"%d", type]
           requiresAuthentication:NO
                             type:AdFilterTypeAdType
            initializationContext:@(type)];
}

+ (C46AdFilter *)filterWithRegion:(C46Region *)region
{
    return [self filterWithAPIKey:@"region_id"
                         APIValue:region.identifier
           requiresAuthentication:NO
                             type:AdFilterTypeRegion
            initializationContext:region];
}

+ (C46AdFilter *)filterWithAdStatus:(AdStatus)status
{
    return [self filterWithAPIKey:@"status"
                         APIValue:[NSString stringWithFormat:@"%d", status]
           requiresAuthentication:NO
                             type:AdFilterTypeOther
            initializationContext:@(status)];
}

+ (C46AdFilter *)filterWithQueryText:(NSString *)text
{
    return [self filterWithAPIKey:@"query"
                         APIValue:text
           requiresAuthentication:NO
                             type:AdFilterTypeOther
            initializationContext:text];
}

#pragma mark - Overrides

- (NSString *)description
{
    return [NSString stringWithFormat:@"%@ - %@", _C46APIKey, _C46APIValue];
}

#pragma mark - Private

+ (C46AdFilter *)filterWithAPIKey:(NSString *)key
                         APIValue:(NSString *)value
           requiresAuthentication:(BOOL)requiresAuthentication
                             type:(AdFilterType)type
            initializationContext:(id)initializationContext
{
    C46AdFilter *filter = [[C46AdFilter alloc] init];
    
    filter.C46APIKey = key;
    filter.C46APIValue = value;
    filter.requiresAuthentication = requiresAuthentication;
    filter.type = type;
    filter.initializationContext = initializationContext;
    
    return filter;
}

@end
