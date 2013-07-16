//
//  C46AdImageInfo.h
//  Cipele46
//
//  Created by Dino Bartošak on 7/16/13.
//  Copyright (c) 2013 Miran Brajsa. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface C46AdImageInfo : NSObject


@property (nonatomic, readonly) NSURL *imageURL;
@property (nonatomic, readonly) NSURL *largeImageURL;
@property (nonatomic, readonly) NSURL *mediumImageURL;
@property (nonatomic, readonly) NSURL *mobLargeImageURL; // dafuq is this?
@property (nonatomic, readonly) NSURL *smallImageURL;

- (id)initWithJSONDictionary:(NSDictionary *)dictionary;

@end