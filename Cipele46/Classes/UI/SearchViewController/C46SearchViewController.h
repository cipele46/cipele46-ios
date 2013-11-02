//
//  C46SearchViewController.h
//  Cipele46
//
//  Created by Tomislav Grbin on 02/11/13.
//  Copyright (c) 2013 Miran Brajsa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "C46AdsViewControllerDelegate.h"

@interface C46SearchViewController : UIViewController

@property (nonatomic, weak) id <C46AdsViewControllerDelegate> delegate;

@end
