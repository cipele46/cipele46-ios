//
//  FormCell.h
//  BrainTrainer
//
//  Created by Tomislav Grbin on 4/9/13.
//  Copyright (c) 2013 Five Minutes Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface C46FormCell : UITableViewCell <UITextFieldDelegate>

+ (id)createWithTitle:(NSString *)title andPlaceholder:(NSString *)placeholder;

@property (nonatomic, strong) C46FormCell *nextCell;

@property (strong, nonatomic) IBOutlet UITextField *textField;

- (void)beginEditing;

@end
