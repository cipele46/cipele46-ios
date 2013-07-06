//
//  C46RegisterUserViewController.m
//  Cipele46
//
//  Created by Melvin on 7/6/13.
//  Copyright (c) 2013 Miran Brajsa. All rights reserved.
//

#import "C46RegisterUserViewController.h"

@interface C46RegisterUserViewController ()

@end

@implementation C46RegisterUserViewController

@synthesize fieldName;
@synthesize fieldEmail;
@synthesize fieldPhone;
@synthesize fieldPassword;
@synthesize fieldPasswordAgain;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"Register", @"Register");
        self.tabBarItem.image = [UIImage imageNamed:@"second"];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Set placeholder labels on all fields
    [[self fieldName] setPlaceholder: NSLocalizedString(@"REGISTER_USER_VIEW__NAME", @"") ];
    [[self fieldEmail] setPlaceholder: NSLocalizedString(@"REGISTER_USER_VIEW__EMAIL", @"") ];
    [[self fieldPhone] setPlaceholder: NSLocalizedString(@"REGISTER_USER_VIEW__TELEPHONE", @"") ];
    [[self fieldPassword] setPlaceholder: NSLocalizedString(@"REGISTER_USER_VIEW__PASSWORD", @"") ];
    [[self fieldPasswordAgain] setPlaceholder: NSLocalizedString(@"REGISTER_USER_VIEW__PASSWORD_AGAIN", @"") ];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Text fields events

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [textField resignFirstResponder];
    
    return YES;
}

@end
