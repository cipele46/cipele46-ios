//
//  C46AdFilterViewController.m
//  Cipele46
//
//  Created by Miran Brajsa on 7/6/13.
//  Copyright (c) 2013 Miran Brajsa. All rights reserved.
//

#import "C46AdFilterViewController.h"

#import "C46ServerCommunicationManager.h"

@interface C46AdFilterViewController () <UITableViewDataSource, UITableViewDelegate, C46ServerCommunicationManagerDelegate>

@property (nonatomic) UITableView *filtersTableView;

@property (nonatomic) NSArray *categories;
@property (nonatomic) NSArray *districts;

@property (atomic) BOOL categoriesFetched;
@property (atomic) BOOL districtsFetched;

- (BOOL)shouldUpdateTableViewSource;
- (void)updateTableViewSource;

@end

@implementation C46AdFilterViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.categoriesFetched = NO;
        self.districtsFetched = NO;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.

    self.filtersTableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStyleGrouped];
    self.filtersTableView.delegate = self;
    C46ServerCommunicationManager *manager = [[C46ServerCommunicationManager alloc] init];
    manager.delegate = self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)shouldUpdateTableViewSource {
    return (self.categoriesFetched && self.districtsFetched);
}

- (void)updateTableViewSource {
    if (!self.shouldUpdateTableViewSource)
        return;
    [self.filtersTableView reloadData];
}

#pragma mark - C46ServerCommunicationManagerDelegate

- (void)didReceiveCategories:(NSArray *)categories {
    self.categories = categories;
    self.categoriesFetched = YES;
    [self updateTableViewSource];
}

- (void)didReceiveDistricts:(NSArray *)districts {
    self.districts = districts;
    self.districtsFetched = YES;
    [self updateTableViewSource];
}

#pragma mark - UITableViewDelegate

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"CellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    cell.textLabel.text = @"aaa";

    return cell;
}

@end
