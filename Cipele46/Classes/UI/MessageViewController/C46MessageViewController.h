//
//  C46MessageViewController.h
//  Cipele46
//
//  Created by Ivana Rast on 7/6/13.
//  Copyright (c) 2013 Miran Brajsa. All rights reserved.
//

#import <UIKit/UIKit.h>

@class C46Ad;

@interface C46MessageViewController : UIViewController

@property (nonatomic) C46Ad *ad;

- (id)initWithAd:(C46Ad *)ad;

@end
