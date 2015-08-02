//
//  ViewController.m
//  ResizingCells
//
//  Created by Admin on 01.08.15.
//  Copyright (c) 2015 Admin. All rights reserved.
//

#import "ViewController.h"
#import "DRTextModel.h"
#import "DRResizingViewCell.h"

@interface ViewController () <DRResizingViewCellDelegate>

@property (nonatomic) UIScrollView *scrollView;
@property (nonatomic) NSInteger numberOfCells;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.scrollView = [[UIScrollView alloc] initWithFrame:self.view.frame];
    self.scrollView.backgroundColor = [[UIColor blueColor] colorWithAlphaComponent:0.1f];
    [self.view addSubview:self.scrollView];
   // NSLog(@"%@", [DRTextModel getText]);
    [self addViewCellsToScrollView];
}

- (NSInteger)numberOfCells
{
    if ( !_numberOfCells)
    {
        _numberOfCells = 3;
    }
    return _numberOfCells;
}

- (void)addViewCellsToScrollView
{
    CGFloat currentY = 10.0f;
    
    for (NSInteger i = 0; i < self.numberOfCells; i++)
    {
        CGSize scrollSize = self.scrollView.contentSize;
        scrollSize.height += currentY;
        self.scrollView.contentSize = scrollSize;
        
        CGRect frame;
        CGSize size = CGSizeMake(self.scrollView.frame.size.width - 16.0f, 140.0f);
        CGPoint origin = CGPointMake(8.0f, currentY);
        frame.size = size;
        frame.origin = origin;        
        
        DRResizingViewCell *viewCell = [[DRResizingViewCell alloc] initWithFrame:frame text:[DRTextModel getText]];
        viewCell.delegate = self;
        [self.scrollView addSubview:viewCell];
        
        currentY = currentY + viewCell.frame.size.height + 10.0f;

    }
    
}

#pragma mark - Resizing View Cell Delegate

- (void)resizeWithHeight:(CGFloat)height viewCell:(DRResizingViewCell *)viewCell
{
    NSLog(@"Use Delegate");
    
    NSArray *subviews = self.scrollView.subviews;
    for (DRResizingViewCell *cell in subviews)
    {
        if (viewCell.frame.origin.y < cell.frame.origin.y)
        {
            CGRect newFrame = cell.frame;
            newFrame.origin.y += height;
            cell.frame = newFrame;
        }
    }
    
    CGSize scrollSize = self.scrollView.contentSize;
    scrollSize.height += height;
    self.scrollView.contentSize = scrollSize;
    
}






@end
