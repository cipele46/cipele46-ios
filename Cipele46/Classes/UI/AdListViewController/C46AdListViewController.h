//
//  C46AdListViewController.h
//  Cipele46
//
//  Created by Lora Plesko on 7/6/13.
//  Copyright (c) 2013 Miran Brajsa. All rights reserved.
//

#import <UIKit/UIKit.h>
@class C46Ad;

@protocol C46AdListViewControllerDelegate

@required
-(void)adListViewController:(UIViewController *)controller didSelectAd:(C46Ad *)ad;

@end

@interface C46AdListViewController: UIViewController

@property (nonatomic, weak) IBOutlet id<C46AdListViewControllerDelegate> delegate;

@property (nonatomic) NSArray *ads;

@end
