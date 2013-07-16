//
//  C46AdFilterViewController.m
//  Cipele46
//
//  Created by Miran Brajsa on 7/6/13.
//  Copyright (c) 2013 Miran Brajsa. All rights reserved.
//

#import "C46AdFilterViewController.h"

@interface C46AdFilterViewController () <UITableViewDataSource, UITableViewDelegate, C46ServerCommunicationManagerDelegate>
{
    NSIndexPath *_selectedAdvertTypeIndexPath;
    NSIndexPath *_selectedCategoryIndexPath;
    NSIndexPath *_selectedDistrictIndexPath;
    
}

@property (nonatomic) UITableView *filtersTableView;

@property (nonatomic) NSArray *categories;
@property (nonatomic) NSArray *districts;

@property (atomic) BOOL categoriesFetched;
@property (atomic) BOOL districtsFetched;

@property (nonatomic) BOOL overrideInitialAdvertTypeSetup;
@property (nonatomic) BOOL overrideInitialCategoriesSetup;
@property (nonatomic) BOOL overrideInitialDistrictsSetup;

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

        self.selectedAdvertType = kC46FilterAdvertTypeSupply;
        self.selectedCategory = nil;
        self.selectedDistrict = nil;
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
//    [manager categories];
//    [manager districts];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setSelectedAdvertType:(kC46FilterAdvertTypes)selectedAdvertType {
    _selectedAdvertType = selectedAdvertType;
    self.overrideInitialAdvertTypeSetup = YES;
}

- (void)setSelectedCategory:(NSString *)selectedCategory {
    _selectedCategory = selectedCategory;
    self.overrideInitialCategoriesSetup = YES;
}

- (void)setSelectedDistrict:(NSString *)selectedDistrict {
    _selectedDistrict = selectedDistrict;
    self.overrideInitialDistrictsSetup = YES;
}

- (BOOL)shouldUpdateTableViewSource {
    return (self.categoriesFetched && self.districtsFetched);
}

- (void)setupStartingFilters {
    if (!self.overrideInitialAdvertTypeSetup)
        _selectedAdvertType = kC46FilterAdvertTypeSupply;
    if (!self.overrideInitialCategoriesSetup)
        _selectedCategory = [self.categories objectAtIndex:0];
    if (!self.overrideInitialDistrictsSetup)
        _selectedDistrict = [self.districts objectAtIndex:0];
}

- (void)updateTableViewSource {
    if (!self.shouldUpdateTableViewSource)
        return;
    self.filtersTableView.dataSource = self;
    [self setupStartingFilters];
    [self.filtersTableView reloadData];
}

#pragma mark - C46ServerCommunicationManagerDelegate

- (void)didReceiveCategories:(NSArray *)categories withError:(NSError *)error {
    self.categories = categories;
    self.categoriesFetched = YES;
    [self updateTableViewSource];
}

- (void)didReceiveDistricts:(NSArray *)districts withError:(NSError *)error {
    self.districts = districts;
    self.districtsFetched = YES;
    [self updateTableViewSource];
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    switch (indexPath.section) {
        case 0: {
            
            UITableViewCell *previousSelectedCell = [self.filtersTableView cellForRowAtIndexPath:_selectedAdvertTypeIndexPath];
            previousSelectedCell.accessoryType = UITableViewCellAccessoryNone;

            self.selectedAdvertType = (kC46FilterAdvertTypes)indexPath.row;
            _selectedAdvertTypeIndexPath = indexPath;
            
            UITableViewCell *newSelectedCell = [self.filtersTableView cellForRowAtIndexPath:_selectedAdvertTypeIndexPath];
            newSelectedCell.accessoryType = UITableViewCellAccessoryCheckmark;
                
        }
            
            break;
        case 1: {
            
            self.selectedCategory = [self.categories objectAtIndex:indexPath.row];
        
        }
            
            break;
        
        case 2: {
         
            self.selectedDistrict = [self.districts objectAtIndex:indexPath.row];
            
        }
            break;
        
        default:
            NSAssert(NO, @"Should not be here.");
    }
    
    [self.delegate didUpdateFilters:self.selectedAdvertType category:self.selectedCategory district:self.selectedDistrict];
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
            
            
            
            if (indexPath.row == (int)self.selectedAdvertType) {
                
                cell.accessoryType = UITableViewCellAccessoryCheckmark;
                _selectedAdvertTypeIndexPath = indexPath;
            
            } else {
                
                cell.accessoryType = UITableViewCellAccessoryNone;
            }
            
            break;
        
        
        case 1:
            cell.textLabel.text = [[self.categories objectAtIndex:indexPath.row] objectForKey:@"name"];
            if ([self.selectedCategory isEqualToString:[[self.categories objectAtIndex:indexPath.row] objectForKey:@"name"]])
                cell.accessoryType = UITableViewCellAccessoryCheckmark;
            else
                cell.accessoryType = UITableViewCellAccessoryNone;
            break;
        case 2:
            cell.textLabel.text = [[self.districts objectAtIndex:indexPath.row] objectForKey:@"name"];
            if ([self.selectedDistrict isEqualToString:[[self.districts objectAtIndex:indexPath.row] objectForKey:@"name"]])
                cell.accessoryType = UITableViewCellAccessoryCheckmark;
            else
                cell.accessoryType = UITableViewCellAccessoryNone;
            break;
        default:
            NSAssert(NO, @"Should not be here.");
            break;
        }

    return cell;
}

@end
