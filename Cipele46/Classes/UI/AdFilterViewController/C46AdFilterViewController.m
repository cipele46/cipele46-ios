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

#define kAdTypeInfoKeyType @"type"
#define kAdTypeInfoKeyText @"text"

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
@property (nonatomic) NSMutableArray *regions;
@property (nonatomic) NSMutableArray *categories;


@property (nonatomic) NSIndexPath *selectedAdTypeInfoIndexPath;
@property (nonatomic) NSIndexPath *selectedAdCategoryIndexPath;
@property (nonatomic) NSIndexPath *selectedRegionIndexPath;

@property (nonatomic) NSDictionary *selectedAdTypeInfo;
@property (nonatomic) C46AdCategory *selectedAdCategory;
@property (nonatomic) C46Region *selectedRegion;

@end

@implementation C46AdFilterViewController

- (id)initWithFilters:(NSArray *)filters
{
    if (self = [self init]) {
        
        _typesFetched = YES;
        _types = @[
                   @{
                       kAdTypeInfoKeyType: @(AdTypeSupply),
                       kAdTypeInfoKeyText : NSLocalizedString(@"FILTER_GROUP_HEADER__ADVERT_TYPE__GIVEAWAYS", nil)
                       },
                   @{
                       kAdTypeInfoKeyType: @(AdTypeDemand),
                       kAdTypeInfoKeyText : NSLocalizedString(@"FILTER_GROUP_HEADER__ADVERT_TYPE__NEEDS", nil)
                       }
                   ];
        
        [self updateSelectedFiltersFromStartingFilters:filters];
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds
                                                  style:UITableViewStyleGrouped];
    self.tableView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    [self.view addSubview:self.tableView];
    
    [self.delegate adFilterViewControllerDidStartUpdatingFilters:self];
    [self fetchTableData];
}

#pragma mark - Private

- (void)updateSelectedFiltersFromStartingFilters:(NSArray *)filters
{
    for (C46AdFilter *filter in filters) {
        
        id initializationContext = filter.initializationContext;
        
        switch (filter.type) {
                
            case AdFilterTypeAdType: {
                
                AdType type = [initializationContext integerValue];
                
                for (NSDictionary *adTypeInfo in _types) {
                    if ([adTypeInfo[kAdTypeInfoKeyType] integerValue] == type) {
                        _selectedAdTypeInfo = adTypeInfo;
                        
                        break;
                    }
                }
                
            }
                break;
                
            case AdFilterTypeAdCategory: {
             
                _selectedAdCategory = (C46AdCategory *)initializationContext;
                
            }
                break;
                
            case AdFilterTypeRegion: {
                _selectedRegion = (C46Region *)initializationContext;
            }
                break;
                
            default:
                break;
        }
    }
}

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

        [_categories removeAllObjects];

        _categories = [[NSMutableArray alloc] initWithObjects:[C46AdCategory defaultRepresentation], nil];
        [_categories addObjectsFromArray:categories];

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

        [_regions removeAllObjects];
        
        _regions = [[NSMutableArray alloc] initWithObjects:[C46Region defaultRepresentation], nil];
        [_regions addObjectsFromArray:regions];

        _regionsFetched = YES;
        
        [self onTableDataPortionFetch];
        
    } failure:^(C46Error *error) {
        
        DDLogError(@"Regions fetch error: %@", error);
        
        [self onTableDataPortionFetchFailWithError:error];
    }];
}

- (void)onTableDataPortionFetch
{
    if ([self isTableDataFetched]) {
        
        [self.tableView reloadData];
        [self.delegate adFilterViewControllerDidFinishUpdatingFilters:self];
    }
}

- (BOOL)isTableDataFetched
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
            
            if (![_selectedAdTypeInfoIndexPath isEqual:indexPath]) {
                
                [self deselectCellAtIndexPath:_selectedAdTypeInfoIndexPath];
                _selectedAdTypeInfoIndexPath = indexPath;
                _selectedAdTypeInfo = _types[row];
                [self selectCellAtIndexPath:indexPath];
                
            } else {
                
                _selectedAdTypeInfoIndexPath = nil;
                _selectedAdTypeInfo = nil;
                [self deselectCellAtIndexPath:indexPath];
            }
        }
            
            break;
            
        case TableSectionAdCategory: {
            
            if (![_selectedAdCategoryIndexPath isEqual:indexPath]) {
                
                [self deselectCellAtIndexPath:_selectedAdCategoryIndexPath];
                _selectedAdCategoryIndexPath = indexPath;
                _selectedAdCategory = _categories[row];
                [self selectCellAtIndexPath:indexPath];
                
            } else {
                
                _selectedAdCategoryIndexPath = nil;
                _selectedAdCategory = nil;
                [self deselectCellAtIndexPath:indexPath];
            }
        }
            
            break;
            
        case TableSectionAdRegion: {
            
            if (![_selectedRegionIndexPath isEqual:indexPath]) {
                
                [self deselectCellAtIndexPath:_selectedRegionIndexPath];
                _selectedRegionIndexPath = indexPath;
                _selectedRegion = _regions[row];
                [self selectCellAtIndexPath:indexPath];
                
            } else {
                
                _selectedRegionIndexPath = nil;
                _selectedRegion = nil;
                [self deselectCellAtIndexPath:indexPath];
            }
        }
            break;
            
        default:
            
            NSAssert(NO, @"Should not be here.");
    }
    
    NSArray *filters = [self filtersFromSelectedRows];
    [self.delegate adFilterViewController:self didSelectFilters:filters];
}

- (NSArray *)filtersFromSelectedRows
{
    NSMutableArray *filters = [NSMutableArray arrayWithCapacity:3];
    
    if (_selectedAdTypeInfo) {
        AdType type = [_selectedAdTypeInfo[kAdTypeInfoKeyType] integerValue];
        [filters addObject:[C46AdFilter filterWithAdType:type]];
    }
    
    if (_selectedAdCategory) {
        [filters addObject:[C46AdFilter filterWithAdCategory:_selectedAdCategory]];
    }
    
    if (_selectedRegion) {
        [filters addObject:[C46AdFilter filterWithRegion:_selectedRegion]];
    }
    
    return filters;
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
            
            NSDictionary *adTypeInfo = _types[indexPath.row];
            cell.textLabel.text = adTypeInfo[kAdTypeInfoKeyText];
            
            if ([adTypeInfo[kAdTypeInfoKeyType] integerValue] ==
                [_selectedAdTypeInfo[kAdTypeInfoKeyType] integerValue]) {
                
                _selectedAdTypeInfoIndexPath = indexPath;
                [self selectCell:cell];
                
            } else {
                
                [self deselectCell:cell];
            }
            
        }
            break;
            
        case TableSectionAdCategory: {
            
            C46AdCategory *category = _categories[indexPath.row];
            cell.textLabel.text = category.name;
            
            if ([category.identifier isEqualToString:_selectedAdCategory.identifier]) {
                
                _selectedAdCategoryIndexPath = indexPath;
                [self selectCell:cell];
                
            } else {
                
                [self deselectCell:cell];
            }
        }
            break;
            
            
        case TableSectionAdRegion: {
            
            C46Region *region = _regions[indexPath.row];
            cell.textLabel.text = region.name;
            
            if ([region.identifier isEqualToString:_selectedRegion.identifier]) {
                
                _selectedRegionIndexPath = indexPath;
                [self selectCell:cell];
                
            } else {
                
                [self deselectCell:cell];
            }
        }
            
            break;
            
        default:
            
            NSAssert(NO, @"Should not be here.");
            break;
    }
    
    return cell;
}

#pragma mark - Table Utils

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
