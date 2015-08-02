//
//  DRResizingViewCell.m
//  ResizingCells
//
//  Created by Admin on 01.08.15.
//  Copyright (c) 2015 Admin. All rights reserved.
//

#import "DRResizingViewCell.h"

@interface DRResizingViewCell ()

@property (nonatomic) NSString *text;
@property (nonatomic) UIButton * showMoreButton;
@property (nonatomic) CGSize updateSize;
@property (nonatomic) CGRect initFrame;

@property (nonatomic) BOOL isOpen;

@end

@implementation DRResizingViewCell

- (instancetype)initWithFrame:(CGRect)frame text:(NSString *)text
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.backgroundColor = [UIColor whiteColor];
        _text = text;
        _initFrame = frame;
        [self configurationView];
    }
    return self;
}

- (void)configurationView
{
    self.isOpen = NO;
    CGRect frame;
    CGSize size = CGSizeMake(self.frame.size.width - 16.0f, 80.0f);
    CGPoint origin = CGPointMake(8.0f, 8.0f);
    frame.size = size;
    frame.origin = origin;
    
    UILabel *label = [[UILabel alloc] initWithFrame:frame];
    label.backgroundColor = [[UIColor yellowColor] colorWithAlphaComponent:0.1f];
    label.numberOfLines = 0;
    label.text = self.text;
    self.textLabel.font = [UIFont systemFontOfSize:16];
    self.textLabel = label;
    [self addSubview:self.textLabel];
    
    size = CGSizeMake(self.frame.size.width - 80.0f, 30.0f);
    origin = CGPointMake(self.bounds.size.width/2 - size.width/2, CGRectGetMaxY(label.frame) + 8.0f);
    frame.size = size;
    frame.origin = origin;
    UIButton *button = [[UIButton alloc] initWithFrame:frame];
    [button setTitle:@"Show More..." forState:UIControlStateNormal];
    [button addTarget:self action:@selector(didPressedShowMoreButton) forControlEvents:UIControlEventTouchUpInside];
    button.backgroundColor = [UIColor blueColor];
    self.showMoreButton = button;
    [self addSubview:self.showMoreButton];
    
    
    // finf of size of label with
    CGSize constraint = CGSizeMake(self.frame.size.width - 16, 1000);
    
    NSStringDrawingContext *context  = [[NSStringDrawingContext alloc] init];
    
    CGSize boundingBox = [self.text boundingRectWithSize:constraint
                                                 options:NSStringDrawingUsesLineFragmentOrigin
                                              attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17]}
                                                 context:context].size;
    
    CGSize newSize = CGSizeMake(ceil(boundingBox.width), ceil(boundingBox.height));
    
    self.updateSize = newSize;
    
}

- (void)didPressedShowMoreButton
{
    NSLog(@"OLOLO!!");
    
    if (self.isOpen)
    {
        [self reduceHeightOfCell];
    }
    else
    {
        [self increasHeightOfCell];
    }
    
    self.isOpen = !self.isOpen;
}

- (void)increasHeightOfCell
{
    CGFloat height = self.updateSize.height - self.initFrame.size.height;
    
    CGRect frameForTextLabel = self.textLabel.frame;
    frameForTextLabel.size.height = frameForTextLabel.size.height + height;
    self.textLabel.frame = frameForTextLabel;
    
    CGRect frameForShowButton = self.showMoreButton.frame;
    frameForShowButton.origin.y = frameForShowButton.origin.y + height;
    self.showMoreButton.frame = frameForShowButton;
    
    CGRect frameForViewCell = self.frame;
    frameForViewCell.size.height = frameForViewCell.size.height + height;
    self.frame = frameForViewCell;
    
    if ([self.delegate respondsToSelector:@selector(resizeWithHeight:viewCell:)])
    {
        [self.delegate resizeWithHeight:height viewCell:self];
        NSLog(@"%f", height);
    }
}

- (void)reduceHeightOfCell
{
    CGFloat height = self.updateSize.height - self.initFrame.size.height;
    
    CGRect frameForTextLabel = self.textLabel.frame;
    frameForTextLabel.size.height = frameForTextLabel.size.height - height;
    self.textLabel.frame = frameForTextLabel;
    
    CGRect frameForShowButton = self.showMoreButton.frame;
    frameForShowButton.origin.y = frameForShowButton.origin.y - height;
    self.showMoreButton.frame = frameForShowButton;
    
    CGRect frameForViewCell = self.frame;
    frameForViewCell.size.height = frameForViewCell.size.height - height;
    self.frame = frameForViewCell;
    
    if ([self.delegate respondsToSelector:@selector(resizeWithHeight:viewCell:)])
    {
        [self.delegate resizeWithHeight:-height viewCell:self];
        NSLog(@"%f", height);
    }    
}

@end
