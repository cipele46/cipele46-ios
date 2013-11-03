//
//  ColorManager.m
//  Cipele46
//
//  Created by Tomislav Grbin on 02/11/13.
//  Copyright (c) 2013 Miran Brajsa. All rights reserved.
//

#import "ColorManager.h"

@implementation ColorManager

+ (UIColor *)supplyColor {
  return [UIColor colorWithRed:25.0f/255.0f green:225.0f/255.0f blue:206.0f/255.0f alpha:1.0];
}

+ (UIColor *)demandColor {
  return  [UIColor colorWithRed:251.0f/255.0f green:62.0f/255.0f blue:38.0f/255.0f alpha:1.0];
}

@end
