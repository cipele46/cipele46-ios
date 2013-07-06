//
//  C46MyAdsViewController.h
//  Cipele46
//
//  Created by Dino Bartosak on 7/6/13.
//  Copyright (c) 2013 Miran Brajsa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "C46AdsViewControllerDelegate.h"

@interface C46MyAdsViewController : UIViewController

@property (nonatomic, weak) id <C46AdsViewControllerDelegate> delegate;

@end
