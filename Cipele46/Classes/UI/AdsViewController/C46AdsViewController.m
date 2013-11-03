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
#import "C46DataSource.h"
#import "UIViewController+ProgressIndicator.h"

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
    self.title = NSLocalizedString(@"TAB__ADS", @"Oglasi");
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
  [self showProgressIndicator];
  
  [[C46DataSource sharedInstance] fetchAdsWithSuccess:^(NSArray *ads) {
    
    DDLogInfo(@"Ads received. Count (%d)", ads.count);
    DDLogVerbose(@"\t\tAds: %@", ads);
    
    self.adListViewController.ads = ads;
    [self hideProgressIndicator];
    
  } failure:^(C46Error *error) {
    
    DDLogError(@"Ads fetch error: %@", error);
    
    [self hideProgressIndicator];
  }];
}

- (void)showFilteredAds:(NSArray *)filters
{
  [self showProgressIndicator];
  
  if (_currentFilterRequest) {
    
    DDLogInfo(@"Filter request in progress, cancel it");
    [_currentFilterRequest cancel];
  }
  
  _currentFilterRequest = [[C46DataSource sharedInstance] fetchAdsWithFilters:filters
                                                                      success:^(NSArray *ads) {
                                                                        
                                                                        DDLogInfo(@"Filtered ads fetched. Count (%d)", ads.count);
                                                                        DDLogVerbose(@"\t%@", ads);
                                                                        
                                                                        self.adListViewController.ads = ads;
                                                                        [self hideProgressIndicator];
                                                                        
                                                                      } failure:^(C46Error *error) {
                                                                        
                                                                        DDLogError(@"Filtered ads fetch error: %@", error);
                                                                        [self hideProgressIndicator];
                                                                      }];
}

#pragma mark - C46AdFilterDelegate

- (void)adFilterViewControllerDidStartUpdatingFilters:(UIViewController *)controller
{
  [self showProgressIndicator];
}

- (void)adFilterViewControllerDidFinishUpdatingFilters:(UIViewController *)controller
{
  [self hideProgressIndicator];
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

@end
