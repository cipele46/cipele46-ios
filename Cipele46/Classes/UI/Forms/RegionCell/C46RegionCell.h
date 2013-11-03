//
//  AgeCell.h
//  BrainTrainer
//
//  Created by Tomislav Grbin on 3/27/13.
//  Copyright (c) 2013 Five Minutes Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "C46PickerFormCell.h"

@interface C46RegionCell : C46PickerFormCell

+ (C46RegionCell *)create;

@property (nonatomic, assign) int age;

@end
