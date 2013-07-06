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
#import <SDWebImage-3.3/UIImageView+WebCache.h>
#import "C46ServerCommunicationManager.h"

@interface C46AdListViewController ()

@end

@implementation C46AdListViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(NSMutableArray *) tDataSource {
    if(!_tDataSource)
        return [[NSMutableArray alloc] init];
    else
        return _tDataSource;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.serverCommunicationManager = [[C46ServerCommunicationManager alloc] init];
    [self.serverCommunicationManager setDelegate:self];
    [self.serverCommunicationManager districts];
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - server comm delegate response method

-(void)didReceiveAds:(NSArray *)ads{
    for (NSDictionary *dic in ads){
        C46Ad *ad = [[C46Ad alloc] init];
        ad.status = [dic valueForKey:@"id"];
        ad.description = [dic valueForKey:@"description"];
        ad.districtID = [dic valueForKey:@"districtID"];
        ad.phone = [dic valueForKey:@"phone"];
        ad.categoryID = [dic valueForKey:@"categoryID"];
        ad.adID = [dic valueForKey:@"id"];
        ad.cityID = [dic valueForKey:@"cityID"];
        ad.type = [dic valueForKey:@"type"];
        ad.mail = [dic valueForKey:@"email"];
        [self.tDataSource addObject:ad];
    }
    [self.tView reloadData];
}

-(void)didReceiveCategories:(NSArray *)categories{
    //Dummy
}

-(void)didReceiveDistricts:(NSArray *)districts{
    //Dummy
}


#pragma mark - table view methods

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.tDataSource count];
}

-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
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
    [cell.leftImage setImageWithURL:[NSURL URLWithString:ad.imageURL]
                   placeholderImage:[UIImage imageNamed:@"placeholder.png"]];
    
    cell.title.text = ad.title;
    //cell.category.text = ad.category;
    //cell.city.text = ad.city;
    return cell;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.delegate didSelectAdListViewController:[self.tDataSource objectAtIndex:indexPath.row]];
}



@end
