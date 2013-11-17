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
@property (nonatomic) AdFilterType adFilterType;
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
    filter.adFilterType = type;
    filter.initializationContext = initializationContext;
    
    return filter;
}

#pragma mark - Keyed Archiving

- (void)encodeWithCoder:(NSCoder *)encoder
{
    [encoder encodeObject:self.C46APIKey forKey:@"c46APIKey"];
    [encoder encodeObject:self.C46APIValue forKey:@"c46APIValue"];
    [encoder encodeBool:self.requiresAuthentication forKey:@"requiresAuthentication"];
    [encoder encodeInt:self.adFilterType forKey:@"adFilterType"];
    [encoder encodeObject:self.initializationContext forKey:@"initializationContext"];
}

- (id)initWithCoder:(NSCoder *)decoder
{
    self = [super init];
    if (self) {
        self.C46APIKey = [decoder decodeObjectForKey:@"c46APIKey"];
        self.C46APIValue = [decoder decodeObjectForKey:@"c46APIValue"];
        self.requiresAuthentication = [decoder decodeBoolForKey:@"requiresAuthentication"];
        self.adFilterType = [decoder decodeInt32ForKey:@"adFilterType"];
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
    [theCopy setAdFilterType:self.adFilterType];
    [theCopy setInitializationContext:[self.initializationContext copy]];

    return theCopy;
}

@end
