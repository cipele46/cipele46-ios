//
//  ButtonCell.m
//  BrainTrainer
//
//  Created by Tomislav Grbin on 3/28/13.
//  Copyright (c) 2013 Five Minutes Ltd. All rights reserved.
//

#import "C46ButtonCell.h"

@interface C46ButtonCell()
@property (strong, nonatomic) IBOutlet UIButton *button;
@end

@implementation C46ButtonCell

+ (C46ButtonCell *)create {
  return [[NSBundle mainBundle] loadNibNamed:@"C46ButtonCell" owner:nil options:nil][0];
}

- (void)setTarget:(id)target andAction:(SEL)action {
  [_button removeTarget:nil
                 action:NULL
       forControlEvents:UIControlEventAllEvents];

  [_button addTarget:target
              action:action
    forControlEvents:UIControlEventTouchUpInside];
}

- (void)setTitle:(NSString *)title {
  [_button setTitle:title forState:UIControlStateNormal];
}

@end
