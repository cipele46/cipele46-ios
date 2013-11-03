//
//  AgeCell.m
//  BrainTrainer
//
//  Created by Tomislav Grbin on 3/27/13.
//  Copyright (c) 2013 Five Minutes Ltd. All rights reserved.
//

#import "C46RegionCell.h"

@implementation C46RegionCell

+ (C46RegionCell *)create {
  return [super createWithTitle:@"Age"
                 andPlaceholder:@"Enter your age"];
}

- (void)setAge:(int)age {
  _age = age;

  if (age == 0) {
    self.textField.text = nil;
  } else {
    self.textField.text = [NSString stringWithFormat:@"%d", age];
  }

  [self.pickerView selectRow:_age inComponent:0 animated:NO];
}

- (void)updateValue {
  self.age = [self.pickerView selectedRowInComponent:0];
}

#pragma mark - picker

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
  return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
  return 121;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
  if (row == 0) return NSLocalizedString(@"Not specified", nil);
  return [NSString stringWithFormat:@"%d", row];
}

@end
