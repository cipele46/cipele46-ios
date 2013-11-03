//
//  FormCell.m
//  BrainTrainer
//
//  Created by Tomislav Grbin on 4/9/13.
//  Copyright (c) 2013 Five Minutes Ltd. All rights reserved.
//

#import "C46FormCell.h"

@interface C46FormCell()
@property (strong, nonatomic) IBOutlet UIView *holderView;
@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@end

@implementation C46FormCell

+ (id)createWithTitle:(NSString *)title andPlaceholder:(NSString *)placeholder {
  C46FormCell *cell = [[self alloc] initWithStyle:UITableViewCellStyleDefault
                               reuseIdentifier:NSStringFromClass([self class])];

  [[NSBundle mainBundle] loadNibNamed:@"C46FormCell"
                                owner:cell
                              options:nil];

  cell.frameHeight = cell.holderView.frameHeight;
  [cell.contentView addSubview:cell.holderView];

  cell.titleLabel.text = NSLocalizedString(title, nil);
  cell.textField.placeholder = NSLocalizedString(placeholder, nil);

  return cell;
}

- (void)setNextCell:(C46FormCell *)nextCell {
  _nextCell = nextCell;
  _textField.returnKeyType = UIReturnKeyNext;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
  [_textField resignFirstResponder];
  if (_nextCell) {
    [_nextCell beginEditing];
  }
  return YES;
}

- (void)beginEditing {
  [self.textField becomeFirstResponder];
}

@end
