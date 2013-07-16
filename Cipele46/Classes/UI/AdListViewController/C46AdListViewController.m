//
//  C46AdListViewController.m
//  Cipele46
//
//  Created by Lora Plesko on 7/6/13.
//  Copyright (c) 2013 Miran Brajsa. All rights reserved.
//

#import "C46AdListViewController.h"
#import "C46AdCell.h"
#import "C46Ad.h"
#import "C46DataSource.h"

static const int ddLogLevel = LOG_LEVEL_INFO;

@interface C46AdListViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, weak) IBOutlet UITableView *tView;
@property (nonatomic, strong) NSArray *ads;

@end

@implementation C46AdListViewController

- (id)init
{
    self = [super initWithNibName:@"C46AdListViewController" bundle:nil];
    
    if (self) {
        
        
    }

    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
        
    [self.delegate adListViewControllerDidStartRefreshing:self];
    
    [[C46DataSource sharedInstance] fetchAdsWithSuccess:^(NSArray *ads) {
        
        DDLogInfo(@"Ads received");
        DDLogVerbose(@"\t\tAds: %@", ads);
        
        [self.delegate adListViewControllerDidFinishRefreshing:self];
        
        self.ads = ads;
        [self.tView reloadData];
        
    } failure:^(C46Error *error) {
        
        DDLogError(@"Ads fetch error: %@", error);
        
        [self.delegate adListViewControllerDidFinishRefreshing:self];
    }];
}


#pragma mark - table view methods

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.ads count];
}

-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *AdCellIdentifier = @"AdCell";
    
    C46AdCell *cell =(C46AdCell *) [tableView dequeueReusableCellWithIdentifier:AdCellIdentifier];
    if(cell==nil) {
        NSArray * topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"C46AdCell" owner:self options:nil];
        for(id currentObject in topLevelObjects){
            if([currentObject isKindOfClass:[UITableViewCell class]]){
                cell = (C46AdCell *) currentObject;
                [cell setOpaque:YES];
                break;
            }
        }
    }

    C46Ad *ad = [self.ads objectAtIndex:indexPath.row];
    cell.ad = ad;
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    C46Ad *ad = [self.ads objectAtIndex:indexPath.row];
    
    [self.delegate adListViewController:self didSelectAd:ad];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}



@end
