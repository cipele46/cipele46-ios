//
//  C46SegmentedView.m
//  Cipele46
//
//  Created by Tomislav Grbin on 03/11/13.
//  Copyright (c) 2013 Miran Brajsa. All rights reserved.
//

#import "C46SegmentedView.h"

static NSString * const kFontName = @"Helvetica-Bold";
static const int kFontSize = 16;
static const double kFontWhite = 0.4;

static const int kBottomLineHeight = 2;
static const double kBottomLineWhite = 0.7;

static const int kSelectedIndicatorTagOffset = 100;
static const int kButtonTagOffset = 200;

static const double kHighlightedAlpha = 0.7;

@interface C46SegmentedView()
@property (nonatomic, assign) int selectedSegment;
@end

@implementation C46SegmentedView {
  int numberOfItems;
  NSArray *itemTitles;
  NSArray *colors;
}

- (void)awakeFromNib {
  [self setup];
}

- (void)setup {
  itemTitles = [_dataSource itemTitlesForSegmentedView:self];
  colors = [_dataSource itemColorsForSegmentedView:self];
  numberOfItems = itemTitles.count;
  
  self.backgroundColor = [UIColor whiteColor];
  self.opaque = YES;
  
  for (int i = 0; i < numberOfItems; ++i) {
    UIView *selectedIndicatorView = [UIView new];
    selectedIndicatorView.tag = kSelectedIndicatorTagOffset + i;
    [self addSubview:selectedIndicatorView];
    
    [self createAndAddButtonWithIndex:i];
  }
  
  self.selectedSegment = 0;
}

- (void)createAndAddButtonWithIndex:(int)i {
  UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
  button.tag = kButtonTagOffset + i;
  [button setTitle:NSLocalizedString(itemTitles[i], nil)
          forState:UIControlStateNormal];
  button.titleLabel.font = [UIFont fontWithName:kFontName size:kFontSize];

  [self setTitleColorsForButton:button];
  [self addActionsForButton:button];
  
  [self addSubview:button];
}

- (void)setTitleColorsForButton:(UIButton *)button {
  int i = button.tag - kButtonTagOffset;
  
  if (button.selected) {
    [button setTitleColor:[self lighterColorForColor:colors[i]]
                 forState:UIControlStateNormal];
  } else {
    [button setTitleColor:[UIColor colorWithWhite:kFontWhite alpha:1]
                 forState:UIControlStateNormal];
    [button setTitleColor:colors[i]
                 forState:UIControlStateSelected];
    [button setTitleColor:[self lighterColorForColor:colors[i]]
                 forState:UIControlStateHighlighted];
  }
}

- (void)addActionsForButton:(UIButton *)button {
  [button addTarget:self
             action:@selector(didPressButton:)
   forControlEvents:UIControlEventTouchUpInside];
  
  [button addTarget:self
             action:@selector(touchedDownButton:)
   forControlEvents:UIControlEventTouchDown];
  
  [button addTarget:self
             action:@selector(touchedDownButton:)
   forControlEvents:UIControlEventTouchDragEnter];
  
  [button addTarget:self
             action:@selector(dragExitButton:)
   forControlEvents:UIControlEventTouchDragExit];
}

- (void)layoutSubviews {
  int indicatorY = self.bounds.size.height - kBottomLineHeight;
  
  double itemWidth = self.bounds.size.width / numberOfItems;
  for (int i = 0; i < numberOfItems; ++i) {
    [self viewWithTag:kSelectedIndicatorTagOffset + i].frame = CGRectMake(i * itemWidth,
                                                                          indicatorY,
                                                                          itemWidth,
                                                                          kBottomLineHeight);
    
    [self viewWithTag:kButtonTagOffset + i].frame = CGRectMake(i * itemWidth,
                                                               0,
                                                               itemWidth,
                                                               self.bounds.size.height);
  }
}

- (void)setSelectedSegment:(int)selectedSegment {
  _selectedSegment = selectedSegment;
  
  for (int i = 0; i < numberOfItems; ++i) {
    UIView *selectedIndicatorView = [self viewWithTag:kSelectedIndicatorTagOffset + i];
    selectedIndicatorView.backgroundColor = (selectedSegment == i)? colors[i]: [UIColor colorWithWhite:kBottomLineWhite alpha:1];
    
    UIButton *button = (UIButton *)[self viewWithTag:kButtonTagOffset + i];
    button.selected = (selectedSegment == i);
    [self setTitleColorsForButton:button];
  }
}

#pragma mark - button actions

- (void)didPressButton:(UIButton *)button {
  int index = button.tag - kButtonTagOffset;
  self.selectedSegment = index;
  [_delegate segmentedView:self didPressItemAtIndex:index];
}

- (void)touchedDownButton:(UIButton *)button {
  int index = button.tag - kButtonTagOffset;
  UIView *selectedIndicatorView = [self viewWithTag:kSelectedIndicatorTagOffset + index];
  selectedIndicatorView.backgroundColor = [self lighterColorForColor:colors[index]];
}

- (void)dragExitButton:(UIButton *)button {
  int index = button.tag - kButtonTagOffset;
  UIView *selectedIndicatorView = [self viewWithTag:kSelectedIndicatorTagOffset + index];
  selectedIndicatorView.backgroundColor = button.selected? colors[index]: [UIColor colorWithWhite:kBottomLineWhite alpha:1];
}

- (UIColor *)lighterColorForColor:(UIColor *)color {
  return [color colorWithAlphaComponent:kHighlightedAlpha];
}

@end
