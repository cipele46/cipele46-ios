//
//  C46AdCell.m
//  Cipele46
//
//  Created by Lora Plesko on 7/6/13.
//  Copyright (c) 2013 Miran Brajsa. All rights reserved.
//

#import "C46AdCell.h"
#import "C46Ad.h"
#import "ColorManager.h"

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
  if (_ad != ad) {
    
    _ad = ad;
    
    [self.leftImage setImageWithURL:ad.imageInfo.imageURL
                   placeholderImage:[UIImage imageNamed:@"favorites_icon_full.png"]];
    
    self.title.text = ad.title;
    self.category.text = ad.category.name;
    self.city.text = ad.city.name;
    
    UIColor *color = ad.type == AdTypeSupply? [ColorManager supplyColor]: [ColorManager demandColor];
    self.colorView.backgroundColor = color;
  }
}

@end
