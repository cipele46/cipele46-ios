//
//  C46AdFilterUtils.h
//  Cipele46
//
//  Created by Mijo Kaliger on 17/11/13.
//  Copyright (c) 2013 cipele46.org. All rights reserved.
//

#import <Foundation/Foundation.h>

@class C46AdFilter;

@interface C46AdFilterUtils : NSObject

+ (NSArray *)savedAdFilters;
+ (void)saveAdFilters:(NSArray *)adFilters;

+ (NSString *)filterStringFromAdFilter:(C46AdFilter *)adFilter;
+ (NSString *)adFiltersStringFromFilters:(NSArray *)adFilters;

@end
