//
//  C46DetailsViewController.m
//  Cipele46
//
//  Created by Ivana Rast on 7/6/13.
//  Copyright (c) 2013 Miran Brajsa. All rights reserved.
//

#import <SDWebImage/UIImageView+WebCache.h>
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
@property (weak, nonatomic) IBOutlet UIButton *messageButton;
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
    
    [self setLocalizedLabelsOnButtons];
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
        NSString *phone = [[self phoneButton] titleLabel].text;
        [[self phoneButton] setTitle:[NSString stringWithFormat:@"%@%@%@%@", phone, @" (", [[self ad] phone], @")"] forState:UIControlStateNormal];
    }else{
        [[self phoneButton] setHidden:YES];
    }
    
    [[self adImageView] setImageWithURL:[NSURL URLWithString:@"http://www.domain.com/path/to/image.jpg"]
                       placeholderImage:[UIImage imageNamed:@"placeholder.png"]];
    
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
    
    // TODO: Save the change
    
    if([[self ad] isFavourite]){
        image = [UIImage imageNamed:@"favorites_icon_full.png"];
    }else{
        image = [UIImage imageNamed:@"favorites_icon_empty.png"];
    }
    
    [[self favouriteButton] setImage:image forState:UIControlStateNormal];
    
}

-(void)setLocalizedLabelsOnButtons {
    
    [[self messageButton] setTitle: NSLocalizedString(@"DETAIL_VIEW__BTN_MESSAGE", @"") forState: UIControlStateNormal];
    [[self phoneButton] setTitle: NSLocalizedString(@"DETAIL_VIEW__BTN_CALL", @"") forState: UIControlStateNormal];
    
}

@end
