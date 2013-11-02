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

static NSString * const kCellName = @"C46AdCell";

@interface C46AdListViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, weak) IBOutlet UITableView *tView;

@end

@implementation C46AdListViewController

- (void)viewDidLoad
{
  [self.tView registerNib:[UINib nibWithNibName:kCellName bundle:nil]
   forCellReuseIdentifier:kCellName];
}

- (void)setAds:(NSArray *)ads
{
  _ads = ads;
  [self.tView reloadData];
}


#pragma mark - table view methods

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
  return [self.ads count];
}

-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  C46AdCell *cell = (C46AdCell *) [tableView dequeueReusableCellWithIdentifier:kCellName];
  cell.ad = (self.ads)[indexPath.row];
  return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
  C46Ad *ad = (self.ads)[indexPath.row];
  
  [self.delegate adListViewController:self didSelectAd:ad];
  [tableView deselectRowAtIndexPath:indexPath animated:YES];
}



@end
