//
//  C46SearchViewController.m
//  Cipele46
//
//  Created by Tomislav Grbin on 02/11/13.
//  Copyright (c) 2013 Miran Brajsa. All rights reserved.
//

#import "C46SearchViewController.h"
#import "C46AdListViewController.h"
#import "C46DataSource.h"
#import "UIViewController+ProgressIndicator.h"

@interface C46SearchViewController () <UISearchBarDelegate, C46AdListViewControllerDelegate>
@property (strong, nonatomic) IBOutlet C46AdListViewController *adListViewController;
@property (strong, nonatomic) IBOutlet UIView *adListHolderView;
@end

@implementation C46SearchViewController

- (id)init {
  if (self = [super initWithNibName:@"C46SearchViewController" bundle:nil]) {
    self.title = NSLocalizedString(@"TAB_SEARCH", nil);
  }
  return self;
}

- (void)viewDidLoad {
  [super viewDidLoad];
  
  [_adListHolderView addSubview:_adListViewController.view];
  _adListViewController.view.frame = _adListHolderView.bounds;
  [self addChildViewController:_adListViewController];
  
  [self showProgressIndicator];

  [[C46DataSource sharedInstance] fetchAdsWithSuccess:^(NSArray *ads) {
    
    DDLogInfo(@"Search results received. Count (%d)", ads.count);
    DDLogVerbose(@"\t\tAds: %@", ads);
    
    self.adListViewController.ads = ads;
    [self hideProgressIndicator];
    
  } failure:^(C46Error *error) {
    
    DDLogError(@"Ads fetch error: %@", error);
    
    [self hideProgressIndicator];
  }];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
  // TODO:
  NSLog(@"search query: %@", searchBar.text);
}

- (void)adListViewController:(UIViewController *)controller didSelectAd:(C46Ad *)ad {
  [_delegate adsViewController:self didSelectAd:ad];
}

@end
