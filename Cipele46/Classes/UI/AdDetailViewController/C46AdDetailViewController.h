//
//  C46DetailViewController.h
//  Cipele46
//
//  Created by Dino Bartosak on 7/22/13.
//  Copyright (c) 2013 Miran Brajsa. All rights reserved.
//

#import <UIKit/UIKit.h>

@class C46Ad;

@interface C46AdDetailViewController : UIViewController

@property (nonatomic) C46Ad *ad;

- (id)initWithAd:(C46Ad *)ad;

@end
