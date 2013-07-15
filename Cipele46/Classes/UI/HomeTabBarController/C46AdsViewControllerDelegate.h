//
//  C46AdsViewControllerDelegate.h
//  Cipele46
//
//  Created by Dino Bartosak on 7/6/13.
//  Copyright (c) 2013 Miran Brajsa. All rights reserved.
//

#import <Foundation/Foundation.h>

@class C46Ad;

@protocol C46AdsViewControllerDelegate <NSObject>

- (void)adsViewController:(UIViewController *)controller didSelectAd:(C46Ad *)ad;

@end
