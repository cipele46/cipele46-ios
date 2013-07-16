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

typedef enum __TableSection
{
    TableSectionAdType = 0,
    
} TableSection;

@interface C46AdFilterViewController () <UITableViewDataSource, UITableViewDelegate>
{
    NSIndexPath *_selectedAdvertTypeIndexPath;
    NSIndexPath *_selectedCategoryIndexPath;
    NSIndexPath *_selectedDistrictIndexPath;
    
}

@property (nonatomic) UITableView *filtersTableView;


@end

@implementation C46AdFilterViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {


    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.

    self.filtersTableView = [[UITableView alloc] initWithFrame:self.view.bounds
                                                         style:UITableViewStyleGrouped];
    self.filtersTableView.delegate = self;
    self.filtersTableView.dataSource = self;
    
    [self.view addSubview:self.filtersTableView];
}


#pragma mark - UITableViewDelegate

//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    [tableView deselectRowAtIndexPath:indexPath animated:YES];
//    switch (indexPath.section) {
//        case 0: {
//            
//            UITableViewCell *previousSelectedCell = [self.filtersTableView cellForRowAtIndexPath:_selectedAdvertTypeIndexPath];
//            previousSelectedCell.accessoryType = UITableViewCellAccessoryNone;
//
//            self.selectedAdvertType = (kC46FilterAdvertTypes)indexPath.row;
//            _selectedAdvertTypeIndexPath = indexPath;
//            
//            UITableViewCell *newSelectedCell = [self.filtersTableView cellForRowAtIndexPath:_selectedAdvertTypeIndexPath];
//            newSelectedCell.accessoryType = UITableViewCellAccessoryCheckmark;
//                
//        }
//            
//            break;
//        case 1: {
//            
//            self.selectedCategory = [self.categories objectAtIndex:indexPath.row];
//        
//        }
//            
//            break;
//        
//        case 2: {
//         
//            self.selectedDistrict = [self.districts objectAtIndex:indexPath.row];
//            
//        }
//            break;
//        
//        default:
//            NSAssert(NO, @"Should not be here.");
//    }
//    
//    [self.delegate didUpdateFilters:self.selectedAdvertType category:self.selectedCategory district:self.selectedDistrict];
//}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
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
            return 0;
        case 2:
            return 0;
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
//    switch (indexPath.section) {
//        case 0:
//            if (indexPath.row == (int)kC46FilterAdvertTypeSupply)
//                cell.textLabel.text = NSLocalizedString(@"FILTER_GROUP_HEADER__ADVERT_TYPE__SUPPLY", nil);
//            else
//                cell.textLabel.text = NSLocalizedString(@"FILTER_GROUP_HEADER__ADVERT_TYPE__DEMAND", nil);
//            
//            
//            
//            if (indexPath.row == (int)self.selectedAdvertType) {
//                
//                cell.accessoryType = UITableViewCellAccessoryCheckmark;
//                _selectedAdvertTypeIndexPath = indexPath;
//            
//            } else {
//                
//                cell.accessoryType = UITableViewCellAccessoryNone;
//            }
//            
//            break;
//        
//        
//        case 1:
//            cell.textLabel.text = [[self.categories objectAtIndex:indexPath.row] objectForKey:@"name"];
//            if ([self.selectedCategory isEqualToString:[[self.categories objectAtIndex:indexPath.row] objectForKey:@"name"]])
//                cell.accessoryType = UITableViewCellAccessoryCheckmark;
//            else
//                cell.accessoryType = UITableViewCellAccessoryNone;
//            break;
//        case 2:
//            cell.textLabel.text = [[self.districts objectAtIndex:indexPath.row] objectForKey:@"name"];
//            if ([self.selectedDistrict isEqualToString:[[self.districts objectAtIndex:indexPath.row] objectForKey:@"name"]])
//                cell.accessoryType = UITableViewCellAccessoryCheckmark;
//            else
//                cell.accessoryType = UITableViewCellAccessoryNone;
//            break;
//        default:
//            NSAssert(NO, @"Should not be here.");
//            break;
//        }

    return cell;
}

@end
