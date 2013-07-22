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
#import "C46DataSource.h"

static const int ddLogLevel = LOG_LEVEL_INFO;

@interface C46AdsViewController () <C46AdListViewControllerDelegate, C46AdFilterDelegate>

@property (weak, nonatomic) IBOutlet UIView *adListViewControllerPlaceholderView;

@property (nonatomic) C46AdListViewController *adListViewController;

@property (nonatomic) id <WMRequestProxyProtocol> currentFilterRequest;
@property (nonatomic) NSArray *currentSelectedFilters;

@end

@implementation C46AdsViewController

- (id)init
{
    self = [super initWithNibName:@"C46AdsViewController" bundle:nil];
    
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
    
    [self showAllAds];
}


- (IBAction)filterAdsButtonPress:(id)sender
{
    C46AdFilterViewController *adFilterViewController = [[C46AdFilterViewController alloc] initWithFilters:_currentSelectedFilters];
    adFilterViewController.delegate = self;
    
    [self.navigationController pushViewController:adFilterViewController animated:YES];
}

#pragma mark - Private

- (void)showAllAds
{
    [self.class showLoadingViewInView:self.view];
    
    [[C46DataSource sharedInstance] fetchAdsWithSuccess:^(NSArray *ads) {
        
        DDLogInfo(@"Ads received. Count (%d)", ads.count);
        DDLogVerbose(@"\t\tAds: %@", ads);
        
        self.adListViewController.ads = ads;
        [self.class hideLoadingViewinView:self.view];
        
    } failure:^(C46Error *error) {
        
        DDLogError(@"Ads fetch error: %@", error);
        
        [self.class hideLoadingViewinView:self.view];
    }];
}

- (void)showFilteredAds:(NSArray *)filters
{
    [self.class showLoadingViewInView:self.view];

    if (_currentFilterRequest) {
        
        DDLogInfo(@"Filter request in progress, cancel it");
        [_currentFilterRequest cancel];
    }
    
    _currentFilterRequest = [[C46DataSource sharedInstance] fetchAdsWithFilters:filters
                                                                        success:^(NSArray *ads) {
                                                                            
                                                                            DDLogInfo(@"Filtered ads fetched. Count (%d)", ads.count);
                                                                            DDLogVerbose(@"\t%@", ads);
                                                                            
                                                                            self.adListViewController.ads = ads;
                                                                            [self.class hideLoadingViewinView:self.view];
                                                                            
                                                                        } failure:^(C46Error *error) {
                                                                            
                                                                            DDLogError(@"Filtered ads fetch error: %@", error);
                                                                            [self.class hideLoadingViewinView:self.view];
                                                                        }];
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

- (void)adFilterViewController:(UIViewController *)controller didSelectFilters:(NSArray *)filters
{
    DDLogInfo(@"Filters selected");
    DDLogVerbose(@"\t\t%@", filters);
    
    _currentSelectedFilters = filters;
    
    if (filters.count == 0) {
    
        [self showAllAds];
    
    } else {

        [self showFilteredAds:filters];
    }
}

#pragma mark - C46AdListViewControllerDelegate

- (void)adListViewController:(UIViewController *)controller didSelectAd:(C46Ad *)ad
{
    [_delegate adsViewController:self didSelectAd:ad];
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
