//
//  PickerFormCell.m
//  BrainTrainer
//
//  Created by Tomislav Grbin on 10/15/13.
//  Copyright (c) 2013 Five Minutes Ltd. All rights reserved.
//

#import "C46PickerFormCell.h"

@implementation C46PickerFormCell

+ (id)createWithTitle:(NSString *)title andPlaceholder:(NSString *)placeholder {
  C46PickerFormCell *cell = [super createWithTitle:title andPlaceholder:placeholder];
  [[NSBundle mainBundle] loadNibNamed:@"C46PickerFormCell"
                                owner:cell
                              options:nil];

  cell.textField.inputView = cell.pickerView;
  cell.textField.inputAccessoryView = cell.pickerToolbar;

  return cell;
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
  return YES;
}

- (void)setNextCell:(C46FormCell *)nextCell {
  [super setNextCell:nextCell];
  UIBarButtonItem *doneItem = (UIBarButtonItem *)[self.pickerToolbar.items lastObject];
  doneItem.title = NSLocalizedString(@"Next", nil);
}

- (IBAction)cancelPressed:(id)sender {
  [self.textField resignFirstResponder];
}

- (IBAction)donePressed:(id)sender {
  [self.textField resignFirstResponder];
  [self updateValue];
  if (self.nextCell) {
    [self.nextCell beginEditing];
  }
}

- (void)didDismissPopover {
  [self updateValue];
}

#pragma mark - to override

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView { return 0; }
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component { return 0; }
- (void)updateValue {}

@end
