//
//  C46AdImageInfo.m
//  Cipele46
//
//  Created by Dino Bartošak on 7/16/13.
//  Copyright (c) 2013 Miran Brajsa. All rights reserved.
//

#import "C46AdImageInfo.h"

@implementation C46AdImageInfo


- (id)initWithJSONDictionary:(NSDictionary *)dictionary
{
    if (self = [super init]) {
        
        NSString *urlString = [dictionary objectForKey:@"url"];
        
//        _imageURL = [NSURL URLWithString:[dictionary objectForKey:@"url"]];
//        _largeImageURL = [[NSURL URLWithString:[dictionary objectForKey:@"large"]] objectForKey:@"url"];
//        _mediumImageURL = [[NSURL URLWithString:[dictionary objectForKey:@"medium"]] objectForKey:@"url"];
//        _mobLargeImageURL = [[NSURL URLWithString:[dictionary objectForKey:@"mob_large"]] objectForKey:@"url"];
//        _smallImageURL = [[NSURL URLWithString:[dictionary objectForKey:@"small"]] objectForKey:@"url"];
        
        // temp
        _imageURL = [NSURL URLWithString:@"http://www.lynnwittenburg.com/wp-content/uploads/2013/03/Ball.jpg"];
    }
    
    return self;
}

@end