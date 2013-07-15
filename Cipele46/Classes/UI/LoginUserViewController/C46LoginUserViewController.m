//
//  LoginViewController.m
//  Cipele46
//
//  Created by Melvin on 7/6/13.
//  Copyright (c) 2013 Miran Brajsa. All rights reserved.
//

#import "C46LoginUserViewController.h"

#import "C46RegisterUserViewController.h"

@interface C46LoginUserViewController ()

-(void)displayAlertView:(NSString*)message;
-(BOOL)areLoginAndPasswordEntered;
-(void)setLocalizedLabelsOnButtons;

@end

@implementation C46LoginUserViewController

@synthesize btnFacebookLogin;
@synthesize btnLogin;
@synthesize btnForgotPassword;
@synthesize btnRegister;
@synthesize fieldEmail;
@synthesize fieldPassword;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"LOGIN_VIEW__TITLE", @"Login");
        self.tabBarItem.image = [UIImage imageNamed:@"second"];        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self.fieldEmail setPlaceholder: NSLocalizedString(@"LOGIN_VIEW__EMAIL", @"Email") ];
    
    [self.fieldPassword setPlaceholder:NSLocalizedString(@"LOGIN_VIEW__PASSWORD", @"Password") ];
    [self.fieldPassword setSecureTextEntry: YES];
    
    [self setLocalizedLabelsOnButtons];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Button events

-(IBAction)tryFacebookLogin:(id)sender {

}

-(IBAction)tryNormalLogin:(id)sender {
    
    if ( ![self areLoginAndPasswordEntered]) {
        [self displayAlertView: @"Email/Lozinka nisu unešeni"];
    }
}

-(IBAction)forgotPassword:(id)sender {

}

-(IBAction)registerUser:(id)sender {
    [self presentViewController: [[C46RegisterUserViewController alloc] initWithNibName:@"C46RegisterUserViewController" bundle:nil] animated: YES completion: nil];
}

#pragma mark - Text fields events

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    if ( [self areLoginAndPasswordEntered] ) {
        [textField resignFirstResponder];
    }

    return YES;
}

#pragma mark - Private Methods

-(void)displayAlertView:(NSString*)message {
    UIAlertView *openAlert = [[UIAlertView alloc] initWithTitle:@"" message:message delegate:nil cancelButtonTitle:@"U redu" otherButtonTitles:nil];
    [openAlert show];
}

-(BOOL)areLoginAndPasswordEntered {
    
    NSString* password = [self.fieldPassword text];
    NSString* email = [self.fieldEmail text];
    
    if ( password == nil || email == nil ) {
        return NO;
    }
    
    if ( [password isEqualToString:@""] || [email isEqualToString:@""] ) {
        return NO;
    }
    
    return YES;
}

-(void)setLocalizedLabelsOnButtons {
    [[self btnFacebookLogin] setTitle: NSLocalizedString(@"LOGIN_VIEW__FACEBOOK_LOGIN", @"Facebook login") forState: UIControlStateNormal];
    [[self btnLogin] setTitle: NSLocalizedString(@"LOGIN_VIEW__LOGIN", @"Login") forState: UIControlStateNormal];
    [[self btnForgotPassword] setTitle: NSLocalizedString(@"LOGIN_VIEW__FORGOT_PASSWORD", @"Forgot password") forState: UIControlStateNormal];
    [[self btnRegister] setTitle: NSLocalizedString(@"LOGIN_VIEW__REGISTER", @"Register") forState: UIControlStateNormal];
}

@end