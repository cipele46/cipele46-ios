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
#import "C46DetailsViewController.h"

#import "C46FirstViewController.h"
#import "C46SecondViewController.h"


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
    _searchViewController = [[C46SecondViewController alloc] initWithNibName:@"C46SecondViewController" bundle:nil];
    
    // Create ad
    _createAdViewController = [[C46SecondViewController alloc] initWithNibName:@"C46SecondViewController" bundle:nil];
    
    // My ads
    _myAdsViewController = [[C46MyAdsViewController alloc] initWithNibName:@"C46MyAdsViewController" bundle:nil];
    _myAdsViewController.delegate = self;
    UINavigationController *myAdsNavigationController = [[UINavigationController alloc] initWithRootViewController:_myAdsViewController];

    // Settings
    _settingsViewController = [[C46SecondViewController alloc] initWithNibName:@"C46SecondViewController" bundle:nil];
       
    self.viewControllers = @[adsNavigationController, _searchViewController, _createAdViewController, myAdsNavigationController, _settingsViewController];
}

#pragma mark - C46AdsViewControllerDelegate

- (void)adsViewController:(UIViewController *)controller didSelectAd:(C46Ad *)ad
{
    NSAssert(controller == _adsViewController || controller == _myAdsViewController, @"Shit happened");
    NSAssert(controller.navigationController != nil, @"Navigation controller can not be nil");
    
    C46DetailsViewController *adViewController = [[C46DetailsViewController alloc] initWithNibName:@"C46DetailsViewController" bundle:nil];
    adViewController.ad = ad;
    
    [controller.navigationController pushViewController:adViewController animated:YES];
}

@end
