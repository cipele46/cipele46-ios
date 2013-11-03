//
//  ButtonCell.h
//  BrainTrainer
//
//  Created by Tomislav Grbin on 3/28/13.
//  Copyright (c) 2013 Five Minutes Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface C46ButtonCell : UITableViewCell

@property (nonatomic, strong) NSString *title;

- (void)setTarget:(id)target andAction:(SEL)action;

+ (C46ButtonCell *)create;

@end
