//
//  C46MessageViewController.m
//  Cipele46
//
//  Created by Ivana Rast on 7/6/13.
//  Copyright (c) 2013 Miran Brajsa. All rights reserved.
//

#import "C46MessageViewController.h"

@interface C46MessageViewController ()

@property (weak, nonatomic) IBOutlet UITextView *titleTextView;
@property (weak, nonatomic) IBOutlet UITextView *messageTextView;
@property (weak, nonatomic) IBOutlet UITextField *emailTextField;

@end

@implementation C46MessageViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
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
    self.navigationItem.leftBarButtonItem = sendButton;

}

- (void) viewWillAppear:(BOOL)animated{
    
    [[self titleTextView] setText: [self adTitle]];
    [[self emailTextField] setText:[self email]];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) sendButtonPressed{
    
    // TODO: Send message
}

@end
