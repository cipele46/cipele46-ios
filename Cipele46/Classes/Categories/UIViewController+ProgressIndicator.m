//
//  UIViewController+ProgressIndicator.m
//  Cipele46
//
//  Created by Tomislav Grbin on 02/11/13.
//  Copyright (c) 2013 Miran Brajsa. All rights reserved.
//

#import "UIViewController+ProgressIndicator.h"
#import "MBProgressHUD.h"

@implementation UIViewController (ProgressIndicator)

- (void)showProgressIndicator {
  [self showProgressIndicatorWithText:nil];
}

- (void)showProgressIndicatorWithText:(NSString *)text {
  MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
  if (text != nil) {
    hud.labelText = text;
  }
}

- (void)hideProgressIndicator {
  [MBProgressHUD hideHUDForView:self.view animated:YES];
}

@end
