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
#import "C46ServerCommunicationManager.h"

@interface C46AdListViewController (){
    NSArray *categoriesList;
    NSArray *districtsList;
}


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
    self.tDataSource = [[NSMutableArray alloc] init];
    // Do any additional setup after loading the view from its nib.
    self.serverCommunicationManager = [[C46ServerCommunicationManager alloc] init];
    [self.serverCommunicationManager setDelegate:self];
    
    [self.delegate adListViewControllerDidStartRefreshing:self];
    [self.serverCommunicationManager ads];
}


#pragma mark - server comm delegate response method

-(void)didReceiveAds:(NSArray *)ads withError:(NSError *)error {
    for (NSDictionary *dic in ads){
        C46Ad *ad = [[C46Ad alloc] init];
        ad.status = [dic valueForKey:@"id"];
        ad.description = [dic valueForKey:@"description"];
        ad.districtID = [dic valueForKey:@"districtID"];
        ad.phone = [dic valueForKey:@"phone"];
        ad.categoryID = [dic valueForKey:@"categoryID"];
        ad.adID = [dic valueForKey:@"id"];
        ad.cityID = [dic valueForKey:@"cityID"];
        ad.type = [dic valueForKey:@"ad_type"];
        ad.email = [dic valueForKey:@"email"];
        ad.title = [dic valueForKey:@"title"];
        NSDictionary *category = [dic valueForKey:@"category"];
        NSDictionary *city = [dic valueForKey:@"city"];
        NSDictionary *district = [dic valueForKey:@"district"];
        ad.category = [category valueForKey:@"name"];
        ad.city = [city valueForKey:@"name"];
        ad.district = [district valueForKey:@"name"];
        ad.imageURL = [NSURL URLWithString:@"http://www.lynnwittenburg.com/wp-content/uploads/2013/03/Ball.jpg"];
        
        [self.tDataSource addObject:ad];
    
    }
    [self.tView reloadData];
    
    [self.delegate adListViewControllerDidFinishRefreshing:self];
}

-(void)didReceiveCategories:(NSArray *)categories withError:(NSError *)error {
    categoriesList = categories;
    [self.serverCommunicationManager districts];
}

-(void)didReceiveDistricts:(NSArray *)districts withError:(NSError *)error {
    districtsList = districts;
    [self.serverCommunicationManager ads];
}


#pragma mark - table view methods

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.tDataSource count];
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

    C46Ad *ad = [self.tDataSource objectAtIndex:indexPath.row];
    
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
    [self.delegate didSelectAdListViewController:[self.tDataSource objectAtIndex:indexPath.row]];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}



@end
