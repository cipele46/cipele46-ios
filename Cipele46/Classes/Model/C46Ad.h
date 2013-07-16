//
//  C46Ad.h
//  Cipele46
//
//  Created by Dino Bartosak on 7/6/13.
//  Copyright (c) 2013 Miran Brajsa. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface C46Ad : NSObject

@property (nonatomic, retain) NSNumber *status;
@property (nonatomic, retain) NSString *description;
@property (nonatomic, retain) NSNumber *districtID;
@property (nonatomic, retain) NSString *phone;
@property (nonatomic, retain) NSNumber *categoryID;
@property (nonatomic, retain) NSString *title;
@property (nonatomic, retain) NSURL *imageURL;
@property (nonatomic, retain) NSNumber *adID;
@property (nonatomic, retain) NSNumber *cityID;
@property (nonatomic, retain) NSNumber *type;
@property (nonatomic, retain) NSString *email;


@property (strong, nonatomic) NSString *district;
@property (strong, nonatomic) NSString *city;
@property (strong, nonatomic) NSString *address;
@property (strong, nonatomic) NSString *category;

@property (nonatomic, getter=isApproved) BOOL approved;
@property (nonatomic, getter=isFavourite) BOOL favourite;


- (id)initWithHTTPReponseDictionary:(NSDictionary *)dictionary;

@end
