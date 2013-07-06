//
//  C46DetailsViewController.m
//  Cipele46
//
//  Created by Ivana Rast on 7/6/13.
//  Copyright (c) 2013 Miran Brajsa. All rights reserved.
//

#import "C46Ad.h"
#import "C46DetailsViewController.h"


@interface C46DetailsViewController ()

@property (weak, nonatomic) IBOutlet UITextView *titleTextView;
@property (weak, nonatomic) IBOutlet UILabel *statusLabel;
@property (weak, nonatomic) IBOutlet UITextView *descriptionTextView;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
@property (weak, nonatomic) IBOutlet UILabel *expirationLabel;
@property (weak, nonatomic) IBOutlet UIButton *favouriteButton;
@property (weak, nonatomic) IBOutlet UIButton *phoneButton;
@property (weak, nonatomic) IBOutlet UIImageView *adImageView;


@end


@implementation C46DetailsViewController

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
    // Do any additional setup after loading the view from its nib.
}

- (void) viewWillAppear:(BOOL)animated{
    
    // TODO: Set status label
    
    [[self titleTextView] setText:[[self ad] title]];
    [[self descriptionTextView] setText:[[self ad] description]];
    
    // TODO: Set expiration label
    
    NSString *address = [NSString stringWithFormat:@"%@%@%@", [[self ad] district], @", ", [[self ad] city]];
    [[self addressLabel] setText:address];
    
    // Phone number is not mandatory.
    if([[self ad] phone] && !([[[self ad] phone] isEqualToString:@""])){
        NSString *phone = [NSString stringWithFormat:@"%@%@%@", @"Nazovi (", [[self ad] phone], @")"];
        [[self phoneButton] setTitle:phone forState:UIControlStateNormal];
    }else{
        // TODO: Still not defined.
    }
    
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


# pragma mark - Button actions

- (IBAction)phoneButtonTapped:(id)sender {
    
    NSString *phoneNo = [[self ad] phone];
    NSString *phoneNoURL = [@"telprompt://" stringByAppendingString:phoneNo];
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:phoneNoURL]];
}

- (IBAction)messageButtonTapped:(id)sender {
}

- (IBAction)favouriteButtonTapped:(id)sender {
    
    UIImage *image=nil;
    
    // TODO: Change file names HeartEmpty.png and HeartFull.png. These are just temporary images.
    // TODO: Save the change
    
    if([[self ad] isFavourite]){
        image = [UIImage imageNamed:@"HeartEmpty.png"];
    }else{
        image = [UIImage imageNamed:@"HeartFull.png"];
    }
    
    [[self favouriteButton] setImage:image forState:UIControlStateNormal];
    
}


@end
