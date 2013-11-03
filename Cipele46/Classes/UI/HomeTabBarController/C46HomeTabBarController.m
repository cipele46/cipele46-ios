//
//  C46HomeTabBarController.m
//  Cipele46
//
//  Created by Dino Bartosak on 7/6/13.
//  Copyright (c) 2013 Miran Brajsa. All rights reserved.
//

#import "C46HomeTabBarController.h"
#import "C46AdsViewController.h"
#import "C46MyAdsViewController.h"
#import "C46AdDetailViewController.h"
#import "C46SearchViewController.h"

@interface C46HomeTabBarController () <C46AdsViewControllerDelegate>

@property (nonatomic) C46AdsViewController *adsViewController;
@property (nonatomic) C46SearchViewController *searchViewController;
@property (nonatomic) UIViewController *createAdViewController;
@property (nonatomic) C46MyAdsViewController *myAdsViewController;
@property (nonatomic) UIViewController *settingsViewController;

@end

@implementation C46HomeTabBarController

- (void)viewDidLoad
{
  [super viewDidLoad];
  
  // Ads
  _adsViewController = [C46AdsViewController new];
  _adsViewController.delegate = self;
  
  // Search
  _searchViewController = [C46SearchViewController new];
  _searchViewController.delegate = self;
  
  // Create ad
  _createAdViewController = [UIViewController new];
  
  // My ads
  _myAdsViewController = [C46MyAdsViewController new];
  _myAdsViewController.delegate = self;
  
  // Settings
  _settingsViewController = [UIViewController new];
  
  self.viewControllers = @[[self wrapIntoNavigationController:_adsViewController],
                           [self wrapIntoNavigationController:_searchViewController],
                           _createAdViewController,
                           [self wrapIntoNavigationController:_myAdsViewController],
                           _settingsViewController];
}

- (UINavigationController *)wrapIntoNavigationController:(UIViewController *)vc
{
  return [[UINavigationController alloc] initWithRootViewController:vc];
}

#pragma mark - C46AdsViewControllerDelegate

- (void)adsViewController:(UIViewController *)controller didSelectAd:(C46Ad *)ad
{
  C46AdDetailViewController *adDetailViewController = [[C46AdDetailViewController alloc] initWithAd:ad];
  [controller.navigationController pushViewController:adDetailViewController animated:YES];
}

@end
