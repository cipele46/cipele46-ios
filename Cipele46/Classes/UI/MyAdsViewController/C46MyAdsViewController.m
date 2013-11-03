//
//  C46MyAdsViewController.m
//  Cipele46
//
//  Created by Dino Bartosak on 7/6/13.
//  Copyright (c) 2013 Miran Brajsa. All rights reserved.
//

#import "C46MyAdsViewController.h"
#import "C46AdListViewController.h"
#import "MBProgressHUD.h"
#import "C46LoginUserViewController.h"
#import "C46UserManager.h"
#import "C46SegmentedView.h"
#import "ColorManager.h"

@interface C46MyAdsViewController () <C46AdListViewControllerDelegate, C46SegmentedViewDataSource, C46SegmentedViewDelegate>

@property (strong, nonatomic) IBOutlet C46AdListViewController *adListViewController;
@property (strong, nonatomic) IBOutlet UIView *adListHolderView;

@end

@implementation C46MyAdsViewController

- (id)init
{
  self = [super initWithNibName:@"C46MyAdsViewController" bundle:nil];
  
  if (self) {
    self.title = NSLocalizedString(@"TAB__MY_ADS", @"Moji");
    self.tabBarItem.image = [UIImage imageNamed:@"second"];
  }
  
  return self;
}

- (void)viewDidLoad
{
  [super viewDidLoad];
  
  [_adListHolderView addSubview:_adListViewController.view];
  _adListViewController.view.frame = _adListHolderView.bounds;
  [self addChildViewController:_adListViewController];
  
  if (![[C46UserManager sharedInstance] isLoggedIn])
  {
    UIViewController* loginVC = [C46LoginUserViewController new];
    
    [self presentViewController:loginVC
                       animated:YES
                     completion:NULL];
  }
}

#pragma mark - C46AdListViewControllerDelegate

- (void)adListViewController:(UIViewController *)controller didSelectAd:(C46Ad *)ad
{
  [_delegate adsViewController:self didSelectAd:ad];
}

#pragma mark - segmented view

- (NSArray *)itemTitlesForSegmentedView:(C46SegmentedView *)segmentedView {
  return @[ @"MY_ADS__ACTIVE", @"MY_ADS__FAVORITES", @"MY_ADS__CLOSED" ];
}

- (NSArray *)itemColorsForSegmentedView:(C46SegmentedView *)segmentedView {
  UIColor *color = [ColorManager demandColor];
  return @[ color, color, color ];
}

- (void)segmentedView:(C46SegmentedView *)segmentedView didPressItemAtIndex:(int)index {
  // TODO:
  NSLog(@"pressed item: %d", index);
}

@end
