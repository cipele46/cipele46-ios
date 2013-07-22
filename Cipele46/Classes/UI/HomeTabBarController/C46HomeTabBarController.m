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



@interface C46HomeTabBarController () <C46AdsViewControllerDelegate>

@property (nonatomic) C46AdsViewController *adsViewController;
@property (nonatomic) UIViewController *searchViewController;
@property (nonatomic) UIViewController *createAdViewController;
@property (nonatomic) C46MyAdsViewController *myAdsViewController;
@property (nonatomic) UIViewController *settingsViewController;

@end

@implementation C46HomeTabBarController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Ads
    _adsViewController = [[C46AdsViewController alloc] initWithNibName:@"C46AdsViewController" bundle:nil];
    _adsViewController.delegate = self;
    UINavigationController *adsNavigationController = [[UINavigationController alloc] initWithRootViewController:_adsViewController];

    // Search
    _searchViewController = [[UIViewController alloc] init];
    
    // Create ad
    _createAdViewController = [[UIViewController alloc] init];
    
    // My ads
    _myAdsViewController = [[C46MyAdsViewController alloc] initWithNibName:@"C46MyAdsViewController" bundle:nil];
    _myAdsViewController.delegate = self;
    UINavigationController *myAdsNavigationController = [[UINavigationController alloc] initWithRootViewController:_myAdsViewController];

    // Settings
    _settingsViewController = [[UIViewController alloc] init];
       
    self.viewControllers = @[adsNavigationController, _searchViewController, _createAdViewController, myAdsNavigationController, _settingsViewController];
}

#pragma mark - C46AdsViewControllerDelegate

- (void)adsViewController:(UIViewController *)controller didSelectAd:(C46Ad *)ad
{
    NSAssert(controller == _adsViewController || controller == _myAdsViewController, @"Shit happened");
    NSAssert(controller.navigationController != nil, @"Navigation controller can not be nil");
    
    C46AdDetailViewController *adDetailViewController = [[C46AdDetailViewController alloc] initWithNibName:@"C46DetailsViewController" bundle:nil];
    adDetailViewController.ad = ad;
    
//    [controller.navigationController pushViewController:adDetailViewController animated:YES];
}

@end
