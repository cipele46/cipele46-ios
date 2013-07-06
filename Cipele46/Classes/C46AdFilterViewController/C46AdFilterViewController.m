//
//  C46AdFilterViewController.m
//  Cipele46
//
//  Created by Miran Brajsa on 7/6/13.
//  Copyright (c) 2013 Miran Brajsa. All rights reserved.
//

#import "C46AdFilterViewController.h"

@interface C46AdFilterViewController () <UITableViewDataSource, UITableViewDelegate, C46ServerCommunicationManagerDelegate>

@property (nonatomic) UITableView *filtersTableView;

@property (nonatomic) NSArray *categories;
@property (nonatomic) NSArray *districts;

@property (atomic) BOOL categoriesFetched;
@property (atomic) BOOL districtsFetched;

- (BOOL)shouldUpdateTableViewSource;
- (void)updateTableViewSource;

@property (nonatomic) kC46FilterAdvertTypes selectedAdvertType;
@property (nonatomic) NSString *selectedCategory;
@property (nonatomic) NSString *selectedDistrict;

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
    self.view = self.filtersTableView;
    C46ServerCommunicationManager *manager = [[C46ServerCommunicationManager alloc] init];
    manager.delegate = self;
    [manager categories];
    [manager districts];
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
    self.filtersTableView.dataSource = self;
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    switch (section) {
        case 0:
            return NSLocalizedString(@"FILTER_GROUP_HEADER__ADVERT_TYPE", nil);
        case 1:
            return NSLocalizedString(@"FILTER_GROUP_HEADER__CATEGORY", nil);
        case 2:
            return NSLocalizedString(@"FILTER_GROUP_HEADER__DISTRICT", nil);
        default:
            NSAssert(NO, @"Should not be here.");
            return nil;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    switch (section) {
        case 0:
            return 2;
        case 1:
            return self.categories.count;
        case 2:
            return self.districts.count;
        default:
            NSAssert(NO, @"Should not be here.");
            return 0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"CellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    switch (indexPath.section) {
        case 0:
            if (indexPath.row == (int)kC46FilterAdvertTypeSupply)
                cell.textLabel.text = NSLocalizedString(@"FILTER_GROUP_HEADER__ADVERT_TYPE__SUPPLY", nil);
            else
                cell.textLabel.text = NSLocalizedString(@"FILTER_GROUP_HEADER__ADVERT_TYPE__DEMAND", nil);
            break;
        case 1:
            cell.textLabel.text = [[self.categories objectAtIndex:indexPath.row] objectForKey:@"name"];
            break;
        case 2:
            cell.textLabel.text = [[self.districts objectAtIndex:indexPath.row] objectForKey:@"name"];
            break;
        default:
            NSAssert(NO, @"Should not be here.");
            break;
        }

    return cell;
}

@end