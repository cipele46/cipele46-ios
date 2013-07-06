//
//  C46HomeTabBarController.m
//  Cipele46
//
//  Created by Dino Bartosak on 7/6/13.
//  Copyright (c) 2013 Miran Brajsa. All rights reserved.
//

#import "C46HomeTabBarController.h"
#import "C46FirstViewController.h"
#import "C46SecondViewController.h"

@interface C46HomeTabBarController ()

@property (nonatomic) UIViewController *adsViewController;
@property (nonatomic) UIViewController *searchViewController;
@property (nonatomic) UIViewController *createAdViewController;
@property (nonatomic) UIViewController *myAdsViewController;
@property (nonatomic) UIViewController *settingsViewController;

@property (nonatomic) UINavigationController *adsNavigationController;

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
    
    _adsViewController = [[C46FirstViewController alloc] initWithNibName:@"C46FirstViewController" bundle:nil];
    _searchViewController = [[C46SecondViewController alloc] initWithNibName:@"C46SecondViewController" bundle:nil];
    _createAdViewController = [[C46SecondViewController alloc] initWithNibName:@"C46SecondViewController" bundle:nil];
    _myAdsViewController = [[C46SecondViewController alloc] initWithNibName:@"C46SecondViewController" bundle:nil];
    _settingsViewController = [[C46SecondViewController alloc] initWithNibName:@"C46SecondViewController" bundle:nil];
   
    _adsNavigationController = [[UINavigationController alloc] initWithRootViewController:_adsViewController];
    
    self.viewControllers = @[_adsNavigationController, _searchViewController, _createAdViewController, _myAdsViewController, _settingsViewController];
}


@end
