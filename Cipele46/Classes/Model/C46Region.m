//
//  C46Region.m
//  Cipele46
//
//  Created by Dino Bartošak on 7/16/13.
//  Copyright (c) 2013 Miran Brajsa. All rights reserved.
//

#import "C46Region.h"

NSString* const kAllRegionsRepresentationIdentifier = @"c46.regions.identifier";

@implementation C46Region

+ (C46Entity *)defaultRepresentation
{
    C46Region *allRegions = [[C46Region alloc] initWithIdentifier:kAllRegionsRepresentationIdentifier name:NSLocalizedString(@"FILTER_ALL_REGIONS_TITLE", @"All regions")];
    return allRegions;
}

@end
