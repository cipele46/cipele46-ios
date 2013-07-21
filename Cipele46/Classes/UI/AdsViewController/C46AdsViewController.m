//
//  C46AdsViewController.m
//  Cipele46
//
//  Created by Dino Bartosak on 7/6/13.
//  Copyright (c) 2013 Miran Brajsa. All rights reserved.
//

#import "C46AdsViewController.h"
#import "C46AdListViewController.h"
#import "C46AdFilterViewController.h"
#import "C46AdFilter.h"
#import "MBProgressHUD.h"

static const int ddLogLevel = LOG_LEVEL_VERBOSE;

@interface C46AdsViewController () <C46AdListViewControllerDelegate, C46AdFilterDelegate>

@property (weak, nonatomic) IBOutlet UIView *adListViewControllerPlaceholderView;

@property (nonatomic) C46AdListViewController *adListViewController;

@end

@implementation C46AdsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"Ads", @"Oglasi");
        self.tabBarItem.image = [UIImage imageNamed:@"second"];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _adListViewController = [[C46AdListViewController alloc] init];
    _adListViewController.delegate = self;
    [_adListViewControllerPlaceholderView addSubview:_adListViewController.view];    
}


- (IBAction)filterAdsButtonPress:(id)sender
{
    C46AdFilterViewController *adFilterViewController = [[C46AdFilterViewController alloc] init];
    adFilterViewController.delegate = self;
    
    [self.navigationController pushViewController:adFilterViewController animated:YES];
}

#pragma mark - C46AdFilterDelegate

- (void)adFilterViewControllerDidStartUpdatingFilters:(UIViewController *)controller
{
    [self.class showLoadingViewInView:controller.view];

}

- (void)adFilterViewControllerDidFinishUpdatingFilters:(UIViewController *)controller
{
    [self.class hideLoadingViewinView:controller.view];

}

- (void)adFilterViewController:(UIViewController *)controller didFailUpdatingFilterWithError:(C46Error *)error
{
    DDLogError(@"Ad filter view controller did fail updating filter with error: %@", error);
}

- (void)adFilterViewController:(UIViewController *)controller didSelectFilter:(C46AdFilter *)filter
{
    DDLogInfo(@"Filter selected: %@", filter);
}

#pragma mark - C46AdListViewControllerDelegate

- (void)adListViewController:(UIViewController *)controller didSelectAd:(C46Ad *)ad
{
    [_delegate adsViewController:self didSelectAd:ad];
}

- (void)adListViewControllerDidStartRefreshing:(UIViewController *)controller
{
    [self.class showLoadingViewInView:self.view];
}

- (void)adListViewControllerDidFinishRefreshing:(UIViewController *)controller
{
    [self.class hideLoadingViewinView:self.view];
}

#pragma mark - Utils

+ (void)showLoadingViewInView:(UIView *)view
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.labelText = @"Loading";
}

+ (void)hideLoadingViewinView:(UIView *)view
{
    [MBProgressHUD hideHUDForView:view animated:YES];
}

@end
