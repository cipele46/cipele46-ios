//
//  FormTableViewController.m
//  BrainTrainer
//
//  Created by Tomislav Grbin on 3/28/13.
//  Copyright (c) 2013 Five Minutes Ltd. All rights reserved.
//

#import "C46FormTableViewController.h"

@implementation C46FormTableViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  [self initCells];
  [self.tableView reloadData];
}

- (void)initCells {}

#pragma mark - table

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
  return ((UITableViewCell *)_cells[indexPath.row]).frameHeight;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return _cells? _cells.count: 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  return _cells[indexPath.row];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  [self.view endEditing:YES];
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
  cell.backgroundColor = [UIColor clearColor];
}

@end
