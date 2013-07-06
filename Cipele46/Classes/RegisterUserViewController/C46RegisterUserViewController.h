//
//  C46RegisterUserViewController.h
//  Cipele46
//
//  Created by Melvin on 7/6/13.
//  Copyright (c) 2013 Miran Brajsa. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface C46RegisterUserViewController : UIViewController <UITextFieldDelegate>

#pragma mark - Properties

@property (retain, nonatomic) IBOutlet UITextField* fieldName;
@property (retain, nonatomic) IBOutlet UITextField* fieldEmail;
@property (retain, nonatomic) IBOutlet UITextField* fieldPhone;
@property (retain, nonatomic) IBOutlet UITextField* fieldPassword;
@property (retain, nonatomic) IBOutlet UITextField* fieldPasswordAgain;

@end
