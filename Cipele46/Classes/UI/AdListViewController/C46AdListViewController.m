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
#import <SDWebImage/UIImageView+WebCache.h>
#import "C46DataSource.h"

static const int ddLogLevel = LOG_LEVEL_INFO;

@interface C46AdListViewController (){
    NSArray *categoriesList;
    NSArray *districtsList;
}

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
        
    } failure:^(WMError *error) {
        
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
    
    // add a placeholder cell while waiting on table data
    //NSUInteger nodeCount = [self.tDataSource count];
	
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
    
    // Here we use the new provided setImageWithURL: method to load the web image
    NSLog(@"imageURL is %@", ad.imageURL);
    [cell.leftImage setImageWithURL:ad.imageURL
                   placeholderImage:[UIImage imageNamed:@"favorites_icon_full.png"]];
    
    cell.title.text = ad.title;
    cell.category.text = ad.category;
    cell.city.text = ad.city;
    NSLog(@"adtype=%@",ad.type);
    if([ad.type compare:[NSNumber numberWithInt:1]] == NSOrderedSame){
        [cell.colorView setBackgroundColor:[UIColor colorWithRed:25.0f/255.0f green:225.0f/255.0f blue:206.0f/255.0f alpha:1.0]];
    }else{
        [cell.colorView setBackgroundColor:[UIColor colorWithRed:251.0f/255.0f green:62.0f/255.0f blue:38.0f/255.0f alpha:1.0]];
    }
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.delegate didSelectAdListViewController:[self.ads objectAtIndex:indexPath.row]];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}



@end
