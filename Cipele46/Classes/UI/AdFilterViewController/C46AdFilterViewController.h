//
//  C46AdFilterViewController.h
//  Cipele46
//
//  Created by Miran Brajsa on 7/6/13.
//  Copyright (c) 2013 Miran Brajsa. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol C46AdFilterDelegate <NSObject>

- (void)adFilterViewController:(UIViewController *)controller didSelectFilters:(NSArray *)filters; // array of C46AdFilter objects

- (void)adFilterViewControllerDidStartUpdatingFilters:(UIViewController *)controller;
- (void)adFilterViewControllerDidFinishUpdatingFilters:(UIViewController *)controller;
- (void)adFilterViewController:(UIViewController *)controller didFailUpdatingFilterWithError:(C46Error *)error;
- (void)adFilterViewControllerDidFinishSelectingFilters:(UIViewController *)controller;

@end

@interface C46AdFilterViewController : UIViewController

@property (nonatomic, weak) id<C46AdFilterDelegate> delegate;

- (id)initWithFilters:(NSArray *)filters;

@end
