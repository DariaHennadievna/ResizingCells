//
//  DRResizingViewCell.h
//  ResizingCells
//
//  Created by Admin on 01.08.15.
//  Copyright (c) 2015 Admin. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol DRResizingViewCellDelegate;

@interface DRResizingViewCell : UIView

@property (nonatomic) UILabel *textLabel;
@property (nonatomic, assign) id<DRResizingViewCellDelegate> delegate;

- (instancetype)initWithFrame:(CGRect)frame text:(NSString *)text;

@end

@protocol DRResizingViewCellDelegate <NSObject>

- (void)resizeWithHeight:(CGFloat)height viewCell:(DRResizingViewCell *)viewCell;

@end
