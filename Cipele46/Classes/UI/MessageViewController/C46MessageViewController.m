//
//  C46MessageViewController.m
//  Cipele46
//
//  Created by Ivana Rast on 7/6/13.
//  Copyright (c) 2013 Miran Brajsa. All rights reserved.
//

#import "C46MessageViewController.h"
#import "C46Ad.h"

static const int ddLogLevel = LOG_LEVEL_VERBOSE;

@interface C46MessageViewController ()

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UITextField *emailTextField;
@property (weak, nonatomic) IBOutlet UITextView *messageTextView;

@end

@implementation C46MessageViewController

- (id)initWithAd:(C46Ad *)ad
{
    self = [super initWithNibName:@"C46MessageViewController" bundle:nil];
    if (self) {
        _ad = ad;
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIBarButtonItem *sendButton = [[UIBarButtonItem alloc] initWithTitle:@"Pošalji"
                                                                   style:UIBarButtonItemStylePlain
                                                                  target:self
                                                                  action:@selector(sendButtonPressed:)];
    self.navigationItem.rightBarButtonItem = sendButton;
    
    [self refreshAdUI];
}

- (void)setAd:(C46Ad *)ad
{
    _ad = ad;
    [self refreshAdUI];
}

- (void)refreshAdUI
{
    _titleLabel.text = _ad.title;
    _emailTextField.text = _ad.email;
}


- (void)sendButtonPressed:(id)sender
{
    DDLogInfo(@"Send");
}

@end
