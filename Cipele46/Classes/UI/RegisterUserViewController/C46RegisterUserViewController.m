//
//  C46RegisterUserViewController.m
//  Cipele46
//
//  Created by Melvin on 7/6/13.
//  Copyright (c) 2013 Miran Brajsa. All rights reserved.
//

#import "C46RegisterUserViewController.h"
#import "C46UserManager.h"

#define viewSpacement 10.0f //px

@interface C46RegisterUserViewController ()

#pragma mark - Private methods declaration

-(BOOL)areAllFieldsWithValues;
-(BOOL)passwordsAreSame;
//! Method iterates through all baseView (UIScrollView ) subviews,
// calculates and sets (vertical) content size to baseView. This method
// must be called after adding'removing error labels to view
-(void)modifyBaseViewContentSize;

@end

@implementation C46RegisterUserViewController

@synthesize fieldName;
@synthesize fieldEmail;
@synthesize fieldPhone;
@synthesize fieldPassword;
@synthesize fieldPasswordAgain;
@synthesize btnBack;
@synthesize btnRegister;
@synthesize baseView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"REGISTER_USER_VIEW__TITLE", @"Register");
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
    [[self btnBack] setTitle: NSLocalizedString(@"REGISTER_USER_VIEW__BTN_BACK", @"") forState: UIControlStateNormal ];
    [[self btnRegister] setTitle: NSLocalizedString(@"REGISTER_USER_VIEW__BTN_REGISTER", @"") forState: UIControlStateNormal ];
    
    [self modifyBaseViewContentSize];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Text fields events

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    if ( [self areAllFieldsWithValues] ) {
        [textField resignFirstResponder];
    }
    
    return YES;
}

#pragma mark - Button events

-(IBAction)btnBackTapped:(id)sender {
    // Just dismiss
    [self dismissViewControllerAnimated: YES completion: nil];
}

-(IBAction)btnRegisterTapped:(id)sender {
    // Check if all fields are filled, if not notifu user
    // If filled check if both passwords are the same, if not notify user
    // Else just dismiss
    
    if ( ![self areAllFieldsWithValues]) {
        // Notify user that not all fields are filled
        [self displayAlertView: NSLocalizedString(@"REGISTER_USER_VIEW__ALERT_MESSAGE_ALL_FIELDS", @"")];
    } else if ( ![self passwordsAreSame] ) {
        // Notify user that the passwords are not the sam
        [self displayAlertView: NSLocalizedString(@"REGISTER_USER_VIEW__ALERT_MESSAGE_PASSWORDS_NOT_SAME", @"")];
    } else {
        [[C46UserManager sharedInstance] createUserWithName:self.fieldName.text
                                                      email:self.fieldEmail.text
                                                      phone:self.fieldPhone.text
                                                   password:self.fieldPassword.text
                                          completionHandler:^(NSError *error)
        {
            if (nil == error)
            {
                // Just dismmis view controller
                [self dismissViewControllerAnimated: YES completion: nil];
            }
            else
            {
                // TODO
                NSAssert(NO, @"");
            }
        }];
        
    }
}

#pragma mark - Private methods implementation

-(BOOL)areAllFieldsWithValues {
    const NSString *nameText = [[[self fieldName] text] stringByTrimmingCharactersInSet: [NSCharacterSet whitespaceCharacterSet]];
    const NSString *emailText = [[[self fieldEmail] text] stringByTrimmingCharactersInSet: [NSCharacterSet whitespaceCharacterSet]];
    const NSString *phoneText = [[[self fieldPhone] text] stringByTrimmingCharactersInSet: [NSCharacterSet whitespaceCharacterSet]];
    const NSString *passwdText = [[[self fieldPassword] text] stringByTrimmingCharactersInSet: [NSCharacterSet whitespaceCharacterSet]];
    const NSString *passwdAgainText = [[[self fieldPasswordAgain] text] stringByTrimmingCharactersInSet: [NSCharacterSet whitespaceCharacterSet]];
    
    if ( [nameText length] == 0 || [emailText length] == 0 || [phoneText length] == 0
                || [passwdText length] == 0 || [passwdAgainText length] == 0 ) {
        return NO;
    }
    
    return YES;
}

-(BOOL)passwordsAreSame {
    if ( [self fieldPassword] == nil || [self fieldPasswordAgain] == nil ) {
        return NO;
    }
    
    if ( ![[[self fieldPassword] text] isEqualToString: [[self fieldPasswordAgain] text]] ) {
        return NO;
    }
    
    return YES;
}

-(void)displayAlertView:(NSString*)message {
    UIAlertView *openAlert = [[UIAlertView alloc] initWithTitle:@"" message:message delegate:nil
                                              cancelButtonTitle:NSLocalizedString(@"GLOBAL_ALERT_DIALOG_BTN_OK", @"") otherButtonTitles:nil];
    [openAlert show];
}

-(void)modifyBaseViewContentSize {
    
    const CGRect oldFrame = [[self baseView] frame];
    
    [[self baseView] sizeToFit];
    
    const CGFloat newContentSize = [baseView frame].size.height;
    
    [[self baseView] setFrame: oldFrame];
    
    [[self baseView] setContentSize: CGSizeMake( oldFrame.size.width, newContentSize )];
}

@end
