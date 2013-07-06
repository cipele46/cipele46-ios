//
//  C46AdsViewController.m
//  Cipele46
//
//  Created by Dino Bartosak on 7/6/13.
//  Copyright (c) 2013 Miran Brajsa. All rights reserved.
//

#import "C46AdsViewController.h"
#import "C46AdListViewController.h"

@interface C46AdsViewController () <C46AdListViewControllerDelegate>

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
    
    _adListViewController = [[C46AdListViewController alloc] initWithNibName:@"C46AdListViewController" bundle:nil];
    _adListViewController.delegate = self;
    [_adListViewControllerPlaceholderView addSubview:_adListViewController.view];
    
}


- (IBAction)filterAdsButtonPress:(id)sender
{
    
}

#pragma mark - C46AdListViewControllerDelegate

- (void)didSelectAdListViewController:(C46Ad *)ad
{
    [_delegate adsViewController:self didSelectAd:nil];
}


@end
