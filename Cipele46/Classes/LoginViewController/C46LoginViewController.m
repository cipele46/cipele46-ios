//
//  LoginViewController.m
//  Cipele46
//
//  Created by Melvin on 7/6/13.
//  Copyright (c) 2013 Miran Brajsa. All rights reserved.
//

#import "C46LoginViewController.h"

@interface C46LoginViewController ()

-(void)displayAlertView:(NSString*)message;
-(BOOL)areLoginAndPasswordEntered;

@end

@implementation C46LoginViewController

@synthesize fieldEmail;
@synthesize fieldPassword;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"Login", @"Login");
        self.tabBarItem.image = [UIImage imageNamed:@"second"];        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.fieldPassword setSecureTextEntry: YES];
    [self.fieldPassword setPlaceholder:@"Lozinka"];
    [self.fieldEmail setPlaceholder:@"Email"];
    
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
    UIAlertView *openAlert = [[UIAlertView alloc] initWithTitle:@"Poruka:" message:message delegate:nil cancelButtonTitle:@"U redu" otherButtonTitles:nil];
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

@end
