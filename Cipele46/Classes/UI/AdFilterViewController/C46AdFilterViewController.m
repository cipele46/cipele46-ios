//
//  C46AdFilterViewController.m
//  Cipele46
//
//  Created by Miran Brajsa on 7/6/13.
//  Copyright (c) 2013 Miran Brajsa. All rights reserved.
//

#import "C46AdFilterViewController.h"
#import "C46AdFilter.h"
#import "C46DataSource.h"
#import "C46Ad.h"

static const int ddLogLevel = LOG_LEVEL_VERBOSE;

typedef enum __TableSection
{
    TableSectionAdType = 0,
    TableSectionAdCategory = 1,
    TableSectionAdRegion = 2
    
} TableSection;

@interface C46AdFilterViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic) UITableView *tableView;

@property (nonatomic) BOOL typesFetched;
@property (nonatomic) BOOL regionsFetched;
@property (nonatomic) BOOL categoriesFetched;

@property (nonatomic) NSArray *types;
@property (nonatomic) NSArray *regions;
@property (nonatomic) NSArray *categories;


@property (nonatomic) NSIndexPath *selectedAdTypeInfoIndexPath;
@property (nonatomic) NSIndexPath *selectedAdCategoryIndexPath;
@property (nonatomic) NSIndexPath *selectedRegionIndexPath;

@property (nonatomic) NSDictionary *selectedAdTypeInfo;
@property (nonatomic) C46AdCategory *selectedAdCategory;
@property (nonatomic) C46Region *selectedRegion;

@end

@implementation C46AdFilterViewController

- (id)init
{
    if (self = [super init]) {
        
        _typesFetched = YES;
        _types = @[
                   @{
                       @"type": @(AdTypeSupply),
                       @"text" : NSLocalizedString(@"FILTER_GROUP_HEADER__ADVERT_TYPE__SUPPLY", nil)
                       },
                   @{
                       @"type": @(AdTypeDemand),
                       @"text" : NSLocalizedString(@"FILTER_GROUP_HEADER__ADVERT_TYPE__DEMAND", nil)
                       }
                   ];
        
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds
                                                  style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    [self.view addSubview:self.tableView];
    
    [self.delegate adFilterViewControllerDidStartUpdatingFilters:self];
    [self fetchTableData];
}

#pragma mark - Private

- (void)fetchTableData
{
    [self fetchCategories];
    [self fetchRegions];
}

- (void)fetchCategories
{
    [[C46DataSource sharedInstance] fetchCategoriesWithSuccess:^(NSArray *categories) {
        
        DDLogInfo(@"Categories received");
        DDLogVerbose(@"\t\t%@", categories);
        
        _categories = categories;
        _categoriesFetched = YES;
        
        [self onTableDataPortionFetch];
        
    } failure:^(C46Error *error) {
        
        DDLogError(@"Categories fetch error: %@", error);
        
        [self onTableDataPortionFetchFailWithError:error];
    }];
}

- (void)fetchRegions
{
    [[C46DataSource sharedInstance] fetchRegionsWithSuccess:^(NSArray *regions) {
        
        DDLogInfo(@"Regions received");
        DDLogVerbose(@"\t\t%@", regions);
        
        _regions = regions;
        _regionsFetched = YES;
        
        [self onTableDataPortionFetch];
        
    } failure:^(C46Error *error) {
        
        DDLogError(@"Regions fetch error: %@", error);
        
        [self onTableDataPortionFetchFailWithError:error];
    }];
}

- (void)onTableDataPortionFetch
{
    if ([self tableDataFetched]) {
        [self.delegate adFilterViewControllerDidFinishUpdatingFilters:self];
        [self.tableView reloadData];
    }
}

- (BOOL)tableDataFetched
{
    return _categoriesFetched && _regionsFetched && _typesFetched;
}

- (void)onTableDataPortionFetchFailWithError:(C46Error *)error
{
    [self.delegate adFilterViewController:self didFailUpdatingFilterWithError:error];
}


#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSInteger row = indexPath.row;
    
    switch (indexPath.section) {
            
        case TableSectionAdType: {
            
            [self deselectCellAtIndexPath:_selectedAdTypeInfoIndexPath];
            _selectedAdTypeInfoIndexPath = indexPath;
            _selectedAdTypeInfo = [_types objectAtIndex:row];
            [self selectCellAtIndexPath:indexPath];
        }
            
            break;
       
         case TableSectionAdCategory: {
       
             [self deselectCellAtIndexPath:_selectedAdCategoryIndexPath];
             _selectedAdCategoryIndexPath = indexPath;
             _selectedAdCategory = [_categories objectAtIndex:row];
             [self selectCellAtIndexPath:indexPath];
       
         }
       
             break;
       
         case TableSectionAdRegion: {
             
             [self deselectCellAtIndexPath:_selectedRegionIndexPath];
             _selectedRegionIndexPath = indexPath;
             _selectedRegion = [_regions objectAtIndex:row];
             [self selectCellAtIndexPath:indexPath];
       
         }
             break;
            
        default:
            
            NSAssert(NO, @"Should not be here.");
    }
    
    C46AdFilter *filter = [self filterFromSelectedRows];
    [self.delegate adFilterViewController:self didSelectFilter:filter];
}

- (C46AdFilter *)filterFromSelectedRows
{
    C46AdFilter *filter = [[C46AdFilter alloc] init];
    
    if (_selectedAdTypeInfo) {
        AdType type = [[_selectedAdTypeInfo objectForKey:@"type"] integerValue];
        filter.type = type;
    }
    
    if (_selectedAdCategory) {
        filter.category = _selectedAdCategory;
    }
    
    if (_selectedRegion) {
        filter.region = _selectedRegion;
    }

    return filter;
}


#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    
    switch (section) {
        case TableSectionAdType:
            return NSLocalizedString(@"FILTER_GROUP_HEADER__ADVERT_TYPE", nil);
            
        case TableSectionAdCategory:
            return NSLocalizedString(@"FILTER_GROUP_HEADER__CATEGORY", nil);
            
        case TableSectionAdRegion:
            return NSLocalizedString(@"FILTER_GROUP_HEADER__REGION", nil);
            
        default:
            NSAssert(NO, @"Should not be here.");
            return nil;
    }
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (section) {
        case TableSectionAdType:
            return _types.count;
            
        case TableSectionAdCategory:
            return _categories.count;
            
        case TableSectionAdRegion:
            return _regions.count;
            
        default:
            NSAssert(NO, @"Should not be here.");
            return 0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"CellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        
    }
    
    switch (indexPath.section) {
            
        case TableSectionAdType: {
            
            NSDictionary *adTypeInfo = [_types objectAtIndex:indexPath.row];
            cell.textLabel.text = [adTypeInfo objectForKey:@"text"];
            
            [self selectCell:cell ifObject:adTypeInfo isEqualToObject:_selectedAdTypeInfo];
            
        }
            break;
            
        case TableSectionAdCategory: {
            
            C46AdCategory *category = [_categories objectAtIndex:indexPath.row];
            cell.textLabel.text = category.name;
            
            [self selectCell:cell ifObject:category isEqualToObject:_selectedAdCategory];
            
            break;
        }
            
        case TableSectionAdRegion: {
            
            C46Region *region = [_regions objectAtIndex:indexPath.row];
            cell.textLabel.text = region.name;
            
            [self selectCell:cell ifObject:region isEqualToObject:_selectedRegion];
        }
            
            break;
            
        default:
            
            NSAssert(NO, @"Should not be here.");
            break;
    }
    
    return cell;
}

#pragma mark - Table Utils

- (void)selectCell:(UITableViewCell *)cell
          ifObject:(id)firstObject
   isEqualToObject:(id)secondObject
{
    if (firstObject == secondObject) {
        
        [self selectCell:cell];
        
    } else {
        
        [self deselectCell:cell];
    }
}

- (void)deselectCellAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
    [self deselectCell:cell];
}

- (void)selectCellAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
    [self selectCell:cell];
}

- (void)selectCell:(UITableViewCell *)cell
{
    cell.accessoryType = UITableViewCellAccessoryCheckmark;
}

- (void)deselectCell:(UITableViewCell *)cell
{
    cell.accessoryType = UITableViewCellAccessoryNone;
}

@end
