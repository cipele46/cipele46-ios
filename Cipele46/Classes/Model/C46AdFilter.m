//
//  C46AdFilter.m
//  Cipele46
//
//  Created by Dino Bartošak on 7/16/13.
//  Copyright (c) 2013 Miran Brajsa. All rights reserved.
//

#import "C46AdFilter.h"

@implementation C46AdFilter

- (NSString *)description
{
    return [NSString stringWithFormat:@"Type: %@, Category: %@, Region: %@", ADTypeDescription(_type), _category.name, _region.name];
}

@end
