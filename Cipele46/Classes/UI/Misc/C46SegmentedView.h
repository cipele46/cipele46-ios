//
//  C46SegmentedView.h
//  Cipele46
//
//  Created by Tomislav Grbin on 03/11/13.
//  Copyright (c) 2013 Miran Brajsa. All rights reserved.
//

#import <UIKit/UIKit.h>

@class C46SegmentedView;

@protocol C46SegmentedViewDataSource
- (NSArray *)itemTitlesForSegmentedView:(C46SegmentedView *)segmentedView;
- (NSArray *)itemColorsForSegmentedView:(C46SegmentedView *)segmentedView;
@end

@protocol C46SegmentedViewDelegate
- (void)segmentedView:(C46SegmentedView *)segmentedView didPressItemAtIndex:(int)index;
@end

@interface C46SegmentedView : UIView

@property (nonatomic, weak) IBOutlet id<C46SegmentedViewDelegate> delegate;
@property (nonatomic, weak) IBOutlet id<C46SegmentedViewDataSource> dataSource;

@end
