//
//  C46AdCategory.m
//  Cipele46
//
//  Created by Dino Bartošak on 7/16/13.
//  Copyright (c) 2013 Miran Brajsa. All rights reserved.
//

#import "C46AdCategory.h"

NSString* const kAllCategoriesRepresentationIdentifier = @"c46.categories.identifier";

@implementation C46AdCategory

+ (C46Entity *)defaultRepresentation
{
    C46AdCategory *allCategories = [[C46AdCategory alloc] initWithIdentifier:kAllCategoriesRepresentationIdentifier name:NSLocalizedString(@"FILTER_ALL_CATEGORIES_TITLE", @"All categories")];
    return allCategories;
}

@end