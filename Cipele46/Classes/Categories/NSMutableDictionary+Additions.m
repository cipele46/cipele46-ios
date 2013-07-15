//
//  NSMutableDictionary+Additions.m
//  WinkMe
//
//  Created by Dino Bartošak on 2/21/13.
//  Copyright (c) 2013 Dino Bartošak. All rights reserved.
//

#import "NSMutableDictionary+Additions.h"

@implementation NSMutableDictionary (Additions)

- (void)setObjectSafe:(id)object forKey:(id <NSCopying>)key
{
    if (object && key) {
        [self setObject:object forKey:key];
    }
}

@end
