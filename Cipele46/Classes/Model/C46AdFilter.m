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
@property (nonatomic) AdFilterMask adFilterMask;

@property (nonatomic) id initializationContext;

@end

@implementation C46AdFilter

#pragma mark - Public properties

+ (NSArray *)defaultFilters
{
    C46AdFilter *defaultCategoryFilter = [C46AdFilter filterWithAdCategory:(C46AdCategory*)[C46AdCategory defaultRepresentation]];
    C46AdFilter *defaultRegionFilter = [C46AdFilter filterWithRegion:(C46Region*)[C46Region defaultRepresentation]];
    C46AdFilter *defaultAdTypeFilter = [C46AdFilter filterWithAdType:AdTypeDemand];
    
    return @[defaultCategoryFilter, defaultRegionFilter, defaultAdTypeFilter];
}


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
                     adFilterMask:AdFilterMask_Category
            initializationContext:category];
}

+ (C46AdFilter *)filterWithAdType:(AdType)type
{
    return [self filterWithAPIKey:@"ad_type"
                         APIValue:[NSString stringWithFormat:@"%d", type]
           requiresAuthentication:NO
                     adFilterMask:AdFilterMask_AdType
            initializationContext:@(type)];
}

+ (C46AdFilter *)filterWithRegion:(C46Region *)region
{
    return [self filterWithAPIKey:@"region_id"
                         APIValue:region.identifier
           requiresAuthentication:NO
                     adFilterMask:AdFilterMask_Region
            initializationContext:region];
}

+ (C46AdFilter *)filterWithAdStatus:(AdStatus)status
{
    return [self filterWithAPIKey:@"status"
                         APIValue:[NSString stringWithFormat:@"%d", status]
           requiresAuthentication:NO
                     adFilterMask:AdFilterMask_Status
            initializationContext:@(status)];
}

+ (C46AdFilter *)filterWithQueryText:(NSString *)text
{
    return [self filterWithAPIKey:@"query"
                         APIValue:text
           requiresAuthentication:NO
                     adFilterMask:AdFilterMask_QueryText
            initializationContext:text];
}

+ (C46AdFilter *)filterWithCurrentUserAdsOnly:(BOOL)currentUserAdsOnly
{
    return [self filterWithAPIKey:@"user"
                         APIValue:[self APIValueForBool:currentUserAdsOnly]
           requiresAuthentication:YES
                     adFilterMask:AdFilterMask_CurrentUserAdsOnly
            initializationContext:@(currentUserAdsOnly)];
}

+ (C46AdFilter *)filterWithFavoritedAdsOnly:(BOOL)favoritedAdsOnly
{
    return [self filterWithAPIKey:@"favorites"
                         APIValue:[self APIValueForBool:favoritedAdsOnly]
           requiresAuthentication:YES
                     adFilterMask:AdFilterMask_FavoritedAdsOnly
            initializationContext:@(favoritedAdsOnly)];
}

+ (C46AdFilter *)filterWithPage:(NSUInteger)page
{
    
    return [self filterWithAPIKey:@"page"
                         APIValue:[@(page) description]
           requiresAuthentication:NO
                     adFilterMask:AdFilterMask_Page
            initializationContext:@(page)];
}

+ (C46AdFilter *)filterWithPerPage:(NSUInteger)perPage
{
    return [self filterWithAPIKey:@"per_page"
                         APIValue:[@(perPage) description]
           requiresAuthentication:NO
                     adFilterMask:AdFilterMask_PerPage
            initializationContext:@(perPage)];
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
                     adFilterMask:(AdFilterMask)adFilterMask
            initializationContext:(id)initializationContext
{
    C46AdFilter *filter = [[C46AdFilter alloc] init];
    
    filter.C46APIKey = key;
    filter.C46APIValue = value;
    filter.requiresAuthentication = requiresAuthentication;
    filter.adFilterMask = adFilterMask;
    filter.initializationContext = initializationContext;
    
    return filter;
}

#pragma mark - Utils

+ (NSString *)APIValueForBool:(BOOL)boolValue
{
    return boolValue ? @"true" : @"false";
}

#pragma mark - Keyed Archiving

- (void)encodeWithCoder:(NSCoder *)encoder
{
    [encoder encodeObject:self.C46APIKey forKey:@"c46APIKey"];
    [encoder encodeObject:self.C46APIValue forKey:@"c46APIValue"];
    [encoder encodeBool:self.requiresAuthentication forKey:@"requiresAuthentication"];
    [encoder encodeInt:self.adFilterMask forKey:@"adFilterType"];
    [encoder encodeObject:self.initializationContext forKey:@"initializationContext"];
}

- (id)initWithCoder:(NSCoder *)decoder
{
    self = [super init];
    if (self) {
        self.C46APIKey = [decoder decodeObjectForKey:@"c46APIKey"];
        self.C46APIValue = [decoder decodeObjectForKey:@"c46APIValue"];
        self.requiresAuthentication = [decoder decodeBoolForKey:@"requiresAuthentication"];
        self.adFilterMask = [decoder decodeInt32ForKey:@"adFilterType"];
        self.initializationContext = [decoder decodeObjectForKey:@"initializationContext"];
    }
    return self;
}

- (id)copyWithZone:(NSZone *)zone
{
    id theCopy = [[[self class] allocWithZone:zone] init];  // use designated initializer
    
    [theCopy setC46APIKey:[self.C46APIKey copy]];
    [theCopy setC46APIValue:[self.C46APIValue copy]];
    [theCopy setRequiresAuthentication:self.requiresAuthentication];
    [theCopy setAdFilterMask:self.adFilterMask];
    [theCopy setInitializationContext:[self.initializationContext copy]];
    
    return theCopy;
}

@end
