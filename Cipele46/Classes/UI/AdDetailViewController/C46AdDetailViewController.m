//
//  C46DetailViewController.m
//  Cipele46
//
//  Created by Dino Bartosak on 7/22/13.
//  Copyright (c) 2013 Miran Brajsa. All rights reserved.
//

#import "C46AdDetailViewController.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "C46Ad.h"

static const int ddLogLevel = LOG_LEVEL_VERBOSE;

@interface C46AdDetailViewController ()

@property (weak, nonatomic) IBOutlet UIScrollView *containerScrollView;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UITextView *descriptionTextView;
@property (weak, nonatomic) IBOutlet UIView *detailsView;
@property (weak, nonatomic) IBOutlet UIButton *phoneButton;
@property (weak, nonatomic) IBOutlet UIButton *messageButton;

@end

@implementation C46AdDetailViewController

- (id)initWithAd:(C46Ad *)ad
{
    self = [super initWithNibName:@"C46AdDetailViewController" bundle:nil];
    
    if (self) {
        _ad = ad;
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self refreshAdUI];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    // TODO do this better later
    _containerScrollView.contentSize = CGSizeMake(_containerScrollView.bounds.size.width, 548); //_containerView.bounds.size;
}

- (void)setAd:(C46Ad *)ad
{
    _ad = ad;
    
    [self refreshAdUI];
}

- (void)refreshAdUI
{
    _titleLabel.text = _ad.title;
    
    NSURL *imageURL = _ad.imageInfo.imageURL;
    [_imageView setImageWithURL:imageURL
               placeholderImage:[UIImage imageNamed:@"favorites_icon_full.png"]];
    
    _descriptionTextView.text = _ad.description;
    
    [_phoneButton setTitle:_ad.phone forState:UIControlStateNormal];
}

- (IBAction)phoneButtonPress:(id)sender
{
    NSString *phoneNo = _ad.phone;
    phoneNo = [phoneNo stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSString *phoneNoURL = [@"telprompt://" stringByAppendingString:phoneNo];
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:phoneNoURL]];
}

- (IBAction)messageButtonPress:(id)sender
{

}

@end
