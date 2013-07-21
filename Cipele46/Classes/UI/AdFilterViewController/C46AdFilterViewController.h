//
//  C46AdFilterViewController.h
//  Cipele46
//
//  Created by Miran Brajsa on 7/6/13.
//  Copyright (c) 2013 Miran Brajsa. All rights reserved.
//

#import <UIKit/UIKit.h>

@class C46AdFilter;

@protocol C46AdFilterDelegate <NSObject>

- (void)adFilterViewController:(UIViewController *)controller didSelectFilter:(C46AdFilter *)filter;

- (void)adFilterViewControllerDidStartUpdatingFilters:(UIViewController *)controller;
- (void)adFilterViewControllerDidFinishUpdatingFilters:(UIViewController *)controller;
- (void)adFilterViewController:(UIViewController *)controller didFailUpdatingFilterWithError:(C46Error *)error;

@end

@interface C46AdFilterViewController : UIViewController

@property (nonatomic, weak) id<C46AdFilterDelegate> delegate;
@property (nonatomic) C46AdFilter *selectedFilter;

@end
