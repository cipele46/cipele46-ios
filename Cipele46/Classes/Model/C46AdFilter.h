//
//  C46AdFilter.h
//  Cipele46
//
//  Created by Dino Bartošak on 7/16/13.
//  Copyright (c) 2013 Miran Brajsa. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "C46Ad.h"

@interface C46AdFilter : NSObject

@property (nonatomic) AdType type;
@property (nonatomic) C46AdCategory *category;
@property (nonatomic) C46Region *region;

@end
