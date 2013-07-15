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
-(void)didSelectAdListViewController:(C46Ad *)ad;
-(void)adListViewControllerDidStartRefreshing:(UIViewController *)controller;
-(void)adListViewControllerDidFinishRefreshing:(UIViewController *)controller;

@end

@interface C46AdListViewController: UIViewController<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, weak) IBOutlet UITableView *tView;
@property (nonatomic, weak) IBOutlet UIButton *header;

@property (nonatomic, weak) id<C46AdListViewControllerDelegate> delegate;


@end
