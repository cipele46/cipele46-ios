//
//  NSMutableDictionary+Additions.h
//  WinkMe
//
//  Created by Dino Bartošak on 2/21/13.
//  Copyright (c) 2013 Dino Bartošak. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableDictionary (Additions)

- (void)setObjectSafe:(id)object forKey:(id <NSCopying>)key;

@end
