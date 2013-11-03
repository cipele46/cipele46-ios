//
//  PickerFormCell.h
//  BrainTrainer
//
//  Created by Tomislav Grbin on 10/15/13.
//  Copyright (c) 2013 Five Minutes Ltd. All rights reserved.
//

#import "C46FormCell.h"

@interface C46PickerFormCell : C46FormCell <UIPickerViewDataSource, UIPickerViewDelegate>

@property (strong, nonatomic) IBOutlet UIToolbar *pickerToolbar;
@property (strong, nonatomic) IBOutlet UIPickerView *pickerView;

- (void)updateValue;

@end
