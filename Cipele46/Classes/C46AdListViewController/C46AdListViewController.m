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

- (NSDictionary *) findDistrictAndCity:(C46Ad *)ad;
- (NSDictionary *) findCategory:(C46Ad *)ad;

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

/*-(NSMutableArray *) tDataSource {
    if(!_tDataSource)
        return [[NSMutableArray alloc] init];
    else
        return _tDataSource;
}*/

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.tDataSource = [[NSMutableArray alloc] init];
    // Do any additional setup after loading the view from its nib.
    self.serverCommunicationManager = [[C46ServerCommunicationManager alloc] init];
    [self.serverCommunicationManager setDelegate:self];
    [self.serverCommunicationManager ads];
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - search for category, city and district in JSONS

/*-(NSDictionary *)findDistrictAndCity:(C46Ad *)ad{
    NSUInteger districtIndex = [districtsList indexOfObjectPassingTest:^BOOL(id obj, NSUInteger idx, BOOL *stop) {
        NSNumber *disId = [obj valueForKey:@"id"];
        if( [disId compare:ad.districtID] == NSOrderedSame){
            return YES;
        }else{
            return NO;
        }
    }];
    NSDictionary *district = [districtsList objectAtIndex:districtIndex];
    
    NSArray *cities = [district valueForKey:@"cities"];
    NSInteger cityIndex = -1;
    
    cityIndex = [cities indexOfObjectPassingTest:^BOOL(id obj, NSUInteger idx, BOOL *stop) {
        NSNumber *citId = [obj valueForKey:@"id"];
        if( [citId compare:ad.cityID] == NSOrderedSame){
            return YES;
        }else{
            return NO;
        }
    }];
    
    if (cityIndex != NSNotFound) {
        NSDictionary *city = [cities objectAtIndex:cityIndex];
        NSDictionary *returnDictionary = [NSDictionary dictionaryWithObjectsAndKeys:
                                          [district valueForKey:@"name"], @"name",
                                          [city valueForKey:@"name"], @"cityName",nil];
        return returnDictionary;
    } else {

        return nil;
    }

}

-(NSDictionary *) findCategory:(C46Ad *)ad{
    NSUInteger categoryIndex = [categoriesList indexOfObjectPassingTest:^BOOL(id obj, NSUInteger idx, BOOL *stop) {
        NSNumber *catId = [obj valueForKey:@"id"];
        if( [catId compare:ad.categoryID] == NSOrderedSame){
            return YES;
        }else{
            return NO;
        }
    }];
    NSDictionary *category = [categoriesList objectAtIndex:categoryIndex];
    return category;
}*/

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
        ad.type = [dic valueForKey:@"type"];
        ad.email = [dic valueForKey:@"email"];
        ad.title = [dic valueForKey:@"title"];
        NSDictionary *category = [dic valueForKey:@"category"];
        NSDictionary *city = [dic valueForKey:@"city"];
        NSDictionary *district = [dic valueForKey:@"district"];
        ad.category = [category valueForKey:@"name"];
        ad.city = [city valueForKey:@"name"];
        ad.district = [district valueForKey:@"name"];
        [self.tDataSource addObject:ad];
    
    }
    [self.tView reloadData];
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
    cell.category.text = ad.category;
    cell.city.text = ad.city;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.delegate didSelectAdListViewController:[self.tDataSource objectAtIndex:indexPath.row]];
}



@end
