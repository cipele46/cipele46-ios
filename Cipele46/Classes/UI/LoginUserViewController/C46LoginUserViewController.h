//
//  LoginViewController.h
//  Cipele46
//
//  Created by Melvin on 7/6/13.
//  Copyright (c) 2013 Miran Brajsa. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface C46LoginUserViewController : UIViewController <UITextFieldDelegate>

#pragma mark - Properties

@property (retain, nonatomic) IBOutlet UIButton* btnFacebookLogin;
@property (retain, nonatomic) IBOutlet UIButton* btnLogin;
@property (retain, nonatomic) IBOutlet UIButton* btnForgotPassword;
@property (retain, nonatomic) IBOutlet UIButton* btnRegister;
@property (retain, nonatomic) IBOutlet UITextField* fieldEmail;
@property (retain, nonatomic) IBOutlet UITextField* fieldPassword;

#pragma mark - Button events

-(IBAction)tryFacebookLogin:(id)sender;
-(IBAction)tryNormalLogin:(id)sender;
-(IBAction)forgotPassword:(id)sender;
-(IBAction)registerUser:(id)sender;

@end
