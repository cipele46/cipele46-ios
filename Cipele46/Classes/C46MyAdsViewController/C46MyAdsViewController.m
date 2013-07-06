//
//  C46MyAdsViewController.m
//  Cipele46
//
//  Created by Dino Bartosak on 7/6/13.
//  Copyright (c) 2013 Miran Brajsa. All rights reserved.
//

#import "C46MyAdsViewController.h"

#import "C46SecondViewController.h"

@interface C46MyAdsViewController ()

@property (weak, nonatomic) IBOutlet UIView *adListViewControllerPlaceholderView;
@property (nonatomic) UIViewController *adListViewController;
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
    [_adsSegmentControl addTarget:self action:@selector(adsSegmentControlValueChanged:) forControlEvents:UIControlEventValueChanged];
    self.navigationItem.titleView = _adsSegmentControl;
    
    // Ad list
    _adListViewController = [[C46SecondViewController alloc] initWithNibName:@"C46SecondViewController" bundle:nil];
    [_adListViewControllerPlaceholderView addSubview:_adListViewController.view];
}


- (void)adsSegmentControlValueChanged:(id)sender
{
    [_delegate adsViewController:self didSelectAd:nil];
}

@end
