//
//  C46AdCell.m
//  Cipele46
//
//  Created by Lora Plesko on 7/6/13.
//  Copyright (c) 2013 Miran Brajsa. All rights reserved.
//

#import "C46AdCell.h"
#import "C46Ad.h"

#import <SDWebImage/UIImageView+WebCache.h>


@interface C46AdCell ()

@property (nonatomic, weak) IBOutlet UILabel *title;
@property (nonatomic, weak) IBOutlet UILabel *category;
@property (nonatomic, weak) IBOutlet UILabel *city;
@property (nonatomic, weak) IBOutlet UIImageView *leftImage;
@property (nonatomic, weak) IBOutlet UIView *colorView;

@end

@implementation C46AdCell

- (void)setAd:(C46Ad *)ad
{
    [self.leftImage setImageWithURL:ad.imageURL
                   placeholderImage:[UIImage imageNamed:@"favorites_icon_full.png"]];
    
    self.title.text = ad.title;
    self.category.text = ad.category;
    self.city.text = ad.city;
    
    if([ad.type compare:[NSNumber numberWithInt:1]] == NSOrderedSame){
        [self.colorView setBackgroundColor:[UIColor colorWithRed:25.0f/255.0f green:225.0f/255.0f blue:206.0f/255.0f alpha:1.0]];
    }else{
        [self.colorView setBackgroundColor:[UIColor colorWithRed:251.0f/255.0f green:62.0f/255.0f blue:38.0f/255.0f alpha:1.0]];
    }
}

@end
