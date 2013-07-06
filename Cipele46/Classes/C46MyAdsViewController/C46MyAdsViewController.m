//
//  C46MyAdsViewController.m
//  Cipele46
//
//  Created by Dino Bartosak on 7/6/13.
//  Copyright (c) 2013 Miran Brajsa. All rights reserved.
//

#import "C46MyAdsViewController.h"
#import "C46AdListViewController.h"

@interface C46MyAdsViewController () <C46AdListViewControllerDelegate>

@property (weak, nonatomic) IBOutlet UIView *adListViewControllerPlaceholderView;
@property (nonatomic) C46AdListViewController *adListViewController;
@property (nonatomic) UISegmentedControl *adsSegmentControl;

@end

@implementation C46MyAdsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"MyAds", @"Moji");
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
}


- (void)adsSegmentControlValueChanged:(id)sender
{
    NSLog(@"Segment control value changed");
}

#pragma mark - C46AdListViewControllerDelegate

- (void)didSelectAdListViewController:(C46Ad *)ad
{
    [_delegate adsViewController:self didSelectAd:nil];
}

@end
