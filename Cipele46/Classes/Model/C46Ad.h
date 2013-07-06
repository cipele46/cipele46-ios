//
//  C46Ad.h
//  Cipele46
//
//  Created by Dino Bartosak on 7/6/13.
//  Copyright (c) 2013 Miran Brajsa. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface C46Ad : NSObject

@property (strong, nonatomic) NSString *status;

@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSString *imageURL;
@property (strong, nonatomic) NSString *description;

@property (strong, nonatomic) NSString *district;
@property (strong, nonatomic) NSString *city;
@property (strong, nonatomic) NSString *address;

@property (strong, nonatomic) NSString *mail;
@property (strong, nonatomic) NSString *phone;

@property (nonatomic, getter=isApproved) BOOL approved;
@property (nonatomic, getter=isFavourite) BOOL favourite;

@end
