//
//  C46ServerCommunicationManager.h
//  Cipele46
//
//  Created by Miran Brajsa on 7/6/13.
//  Copyright (c) 2013 Miran Brajsa. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    kC46FilterAdvertTypeSupply,
    kC46FilterAdvertTypeDemand
} kC46FilterAdvertTypes;

@protocol C46ServerCommunicationManagerDelegate <NSObject>
//  Returns an array of dictionaries with keys: 'id', 'name'.
- (void)didReceiveFilterCategories:(NSArray *)categories;
@end

@interface C46ServerCommunicationManager : NSObject

@property (nonatomic, weak) id<C46ServerCommunicationManagerDelegate> delegate;

- (void)filterCategories;

@end
