//
//  C46Ad.h
//  Cipele46
//
//  Created by Dino Bartosak on 7/6/13.
//  Copyright (c) 2013 Miran Brajsa. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "C46AdCategory.h"
#import "C46City.h"
#import "C46AdImageInfo.h"
#import "C46Region.h"

typedef enum __AdType {
    
    AdTypeSupply = 1,
    AdTypeDemand = 2,
    
} AdType;

NSString * ADTypeDescription(AdType type);

typedef enum __AdStatus {
    
    AdStatusPending = 1,
    AdStatusActive = 2,
    AdStatusClosed = 3
    
} AdStatus;


@interface C46Ad : NSObject

@property (nonatomic, readonly) AdType type;

@property (nonatomic, readonly) C46AdCategory *category;
@property (nonatomic, readonly) NSInteger categoryID;

@property (nonatomic, readonly) C46City *city;
@property (nonatomic, readonly) NSInteger cityID;

@property (nonatomic, readonly) NSDate *dateCreated;
@property (nonatomic, readonly) NSDate *dateUpdated;

@property (nonatomic, readonly) NSString *description;
@property (nonatomic, readonly) NSString *email;
@property (nonatomic, readonly) NSString *identifier;
@property (nonatomic, readonly) C46AdImageInfo *imageInfo;
@property (nonatomic, readonly) NSString *phone;
@property (nonatomic, readonly) C46Region *region;
@property (nonatomic, readonly) AdStatus status;
@property (nonatomic, readonly) NSString *title;

@property (nonatomic, readonly) NSString *userId;


- (id)initWithJSONDictionary:(NSDictionary *)dictionary;

@end
