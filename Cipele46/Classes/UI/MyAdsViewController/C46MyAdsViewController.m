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

@interface C46MyAdsViewController () <C46AdListViewControllerDelegate>

@property (weak, nonatomic) IBOutlet UIView *adListViewControllerPlaceholderView;
@property (nonatomic) C46AdListViewController *adListViewController;
@property (nonatomic) UISegmentedControl *adsSegmentControl;

@end

@implementation C46MyAdsViewController


- (id)init
{
    self = [super initWithNibName:@"C46MyAdsViewController" bundle:nil];
    
    if (self) {
        self.title = NSLocalizedString(@"TAB_MY_ADS", @"Moji");
        self.tabBarItem.image = [UIImage imageNamed:@"second"];
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Segment control
    _adsSegmentControl = [[UISegmentedControl alloc] initWithItems:@[@"Favoriti", @"Aktivni", @"Zatvoreni"]];
    _adsSegmentControl.selectedSegmentIndex = 0;
    [_adsSegmentControl addTarget:self action:@selector(adsSegmentControlValueChanged:) forControlEvents:UIControlEventValueChanged];
    self.navigationItem.titleView = _adsSegmentControl;
    
    // Ad list
    _adListViewController = [[C46AdListViewController alloc] initWithNibName:@"C46AdListViewController" bundle:nil];
    _adListViewController.delegate = self;
    [_adListViewControllerPlaceholderView addSubview:_adListViewController.view];
    
    if (![[C46UserManager sharedInstance] isLoggedIn])
    {
        UIViewController* loginVC = [[C46LoginUserViewController alloc] init];
        
        [self presentViewController:loginVC
                           animated:YES
                         completion:NULL];
    }
}

- (void)adsSegmentControlValueChanged:(id)sender
{
    NSLog(@"Segment control value changed");
}

#pragma mark - C46AdListViewControllerDelegate

- (void)adListViewController:(UIViewController *)controller didSelectAd:(C46Ad *)ad
{
    [_delegate adsViewController:self didSelectAd:ad];
}

@end
