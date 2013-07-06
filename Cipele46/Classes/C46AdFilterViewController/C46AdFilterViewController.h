//
//  C46AdFilterViewController.h
//  Cipele46
//
//  Created by Miran Brajsa on 7/6/13.
//  Copyright (c) 2013 Miran Brajsa. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "C46ServerCommunicationManager.h"

@protocol C46AdFilterDelegate <NSObject>
- (void)didUpdateFilters:(kC46FilterAdvertTypes)advertType category:(NSString *)category district:(NSString *)district;
@end

@interface C46AdFilterViewController : UIViewController

@property (nonatomic, weak) id<C46AdFilterDelegate> delegate;

@end
