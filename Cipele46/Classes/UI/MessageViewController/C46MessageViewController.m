//
//  C46MessageViewController.m
//  Cipele46
//
//  Created by Ivana Rast on 7/6/13.
//  Copyright (c) 2013 Miran Brajsa. All rights reserved.
//

#import "C46MessageViewController.h"
#import "C46Ad.h"

@interface C46MessageViewController ()

@property (weak, nonatomic) IBOutlet UIScrollView *containerScrollView;
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
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShowNotification:) name:UIKeyboardWillShowNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHideNotification:) name:UIKeyboardWillHideNotification object:nil];
    }
    
    return self;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
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

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    _containerScrollView.contentSize = self.view.bounds.size;
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

#pragma mark - Keyboard notifications

- (void)keyboardWillShowNotification:(NSNotification *)notification
{
    NSDictionary *userInfo = notification.userInfo;
    
    // frame relative to the window
    CGRect keyboardEndRect = [userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    // frame relative to the self.view
    CGRect convertedKeyboardEndRect = [self.view convertRect:keyboardEndRect fromView:nil];
    
    CGRect scrollNewFrame = _containerScrollView.frame;
    scrollNewFrame.size.height = convertedKeyboardEndRect.origin.y;
    
    
    // animate resizing
    NSTimeInterval animationDuration = [userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    [UIView animateWithDuration:animationDuration animations:^{
        _containerScrollView.frame = scrollNewFrame;
    }];
}

- (void)keyboardWillHideNotification:(NSNotification *)notification
{
    
}

@end
