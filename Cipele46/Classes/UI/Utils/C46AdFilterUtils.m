//
//  C46AdFilterUtils.m
//  Cipele46
//
//  Created by Mijo Kaliger on 17/11/13.
//  Copyright (c) 2013 cipele46.org. All rights reserved.
//

#import "C46AdFilterUtils.h"
#import "C46AdFilter.h"

#define kSavedAdFiltersKey @"saveAdFiltersKey"

@implementation C46AdFilterUtils

+ (NSArray *)savedAdFilters
{
    NSArray *savedAdFilters = [C46AdFilter defaultFilters];
    NSData *archivedAdFilterData = [[NSUserDefaults standardUserDefaults] objectForKey:kSavedAdFiltersKey];
    NSArray *unarchivedAdFilterData = nil;

    if(archivedAdFilterData != nil)
    {
        unarchivedAdFilterData = [NSKeyedUnarchiver unarchiveObjectWithData:archivedAdFilterData];
    }

    if (unarchivedAdFilterData != nil) {
        savedAdFilters = unarchivedAdFilterData;
    }
    else
    {
        [C46AdFilterUtils saveAdFilters:savedAdFilters];
    }

    return savedAdFilters;
}

+ (void)saveAdFilters:(NSArray *)adFilters
{
    NSData *archivedAdFilterData = [NSKeyedArchiver archivedDataWithRootObject:adFilters];

    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:archivedAdFilterData forKey:kSavedAdFiltersKey];
    [userDefaults synchronize];
}

+ (NSString *)filterStringFromAdFilter:(C46AdFilter *)adFilter
{
    NSString *filterString = nil;
    
    if ([adFilter.initializationContext isKindOfClass:[C46Entity class]]) {
        filterString = ((C46Entity*)adFilter.initializationContext).name;
    }
    else if ([adFilter.initializationContext isKindOfClass:[NSNumber class]])
    {
        AdType adType = (AdType)[adFilter.initializationContext intValue];
        
        switch (adType) {
            case AdTypeDemand:
                filterString = NSLocalizedString(@"FILTER_GROUP_HEADER__ADVERT_TYPE__NEEDS", nil);
                break;
            case AdTypeSupply:
                filterString = NSLocalizedString(@"FILTER_GROUP_HEADER__ADVERT_TYPE__GIVEAWAYS", nil);
                break;
            default:
                break;
        }
    }
    return filterString;
}

+ (NSString *)adFiltersStringFromFilters:(NSArray *)adFilters
{
    if ([adFilters count] == 0) {
        return nil;
    }
    
    NSMutableString *adFiltersString = [[NSMutableString alloc] init];

    for (C46AdFilter *adFilter in adFilters) {

        NSString *filterString = [self filterStringFromAdFilter:adFilter];

        if ([adFilter isEqual:[adFilters lastObject]]) {
            [adFiltersString appendString:filterString];
        }
        else
        {
            [adFiltersString appendFormat:@"%@, ", filterString];
        }
    }

    return adFiltersString;
}

@end
