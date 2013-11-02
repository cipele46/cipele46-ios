//
//  UIViewController+ProgressIndicator.h
//  Cipele46
//
//  Created by Tomislav Grbin on 02/11/13.
//  Copyright (c) 2013 Miran Brajsa. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (ProgressIndicator)

- (void)showProgressIndicator;
- (void)showProgressIndicatorWithText:(NSString *)text;
- (void)hideProgressIndicator;

@end
