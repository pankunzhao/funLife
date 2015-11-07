//
//  ArticleHeaderView.m
//  FunnyLife
//
//  Created by Wang Haitao on 15/10/16.
//  Copyright © 2015年 qianfeng. All rights reserved.
//

#import "ArticleHeaderView.h"
#import "UIViewAdditions.h"
#import "Masonry.h"
#import "ArticleData.h"

#define SECTION_ITEM_WIDTH          50.
#define SECTION_INDICATOR_HEIGHT    2.

@interface ArticleHeaderView ()

@property (nonatomic, weak) IBOutlet UIScrollView * scrollView;
@property (nonatomic, weak) IBOutlet UIButton * modifyButton;

@property (nonatomic, weak) UIView * leftView;
@property (nonatomic, weak) UIView * indicatorView; // animate display

@property (nonatomic) NSArray * buttonArray;
@property (nonatomic) NSArray * indicatorArray;

@property (nonatomic, weak) UIButton * selectedButton;
@property (nonatomic, weak) UIView * selectedIndicator;

@property (nonatomic) BOOL modify;

@end

@implementation ArticleHeaderView

- (UIButton *)selectedButton
{
    return self.buttonArray[self.selectedIndex];
}

- (UIView *) selectedIndicator
{
    return self.indicatorArray[self.selectedIndex];
}

- (void)awakeFromNib
{
    _selectedIndex = NSNotFound;
    
    UIView * leftView = [[UIView alloc] initWithFrame:CGRectZero];
    [self.scrollView addSubview:leftView];
    self.leftView = leftView;
    
    [leftView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@(0));
        make.left.equalTo(@(0));
        make.width.equalTo(@(0));
        make.height.equalTo(@(0));
    }];
    
    UIView * indicatorView = [[UIView alloc] initWithFrame:CGRectZero];
    indicatorView.backgroundColor = [UIColor redColor];
    [self.scrollView addSubview:indicatorView];
    
    self.indicatorView = indicatorView;
}

- (void)setSectionArray:(NSArray *)sectionArray
{
    _sectionArray = sectionArray;
    
    NSMutableArray * buttonArray = [NSMutableArray arrayWithCapacity:sectionArray.count];
    NSMutableArray * indicatorArray = [NSMutableArray arrayWithCapacity:sectionArray.count];
    
    for (ArticleSectionData * data in sectionArray) {
        UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setTitle:data.title forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:15];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
        
        [self.scrollView addSubview:button];
        [buttonArray addObject:button];
        
        [button addTarget:self action:@selector(sectionButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        
        UIView * indicatorView = [[UIView alloc] initWithFrame:CGRectZero];
        indicatorView.backgroundColor = [UIColor clearColor];
        [self.scrollView addSubview:indicatorView];
        [indicatorArray addObject:indicatorView];
    }
    
    self.buttonArray = buttonArray;
    self.indicatorArray = indicatorArray;
    
    for (NSUInteger i=0; i<buttonArray.count; i++) {
        UIButton * button = self.buttonArray[i];
        UIView * indicatorView = self.indicatorArray[i];
        UIView * lastView = i==0?self.leftView : buttonArray[i-1];
        
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(lastView.mas_right);
            make.top.equalTo(@(0));
            make.width.equalTo(@(SECTION_ITEM_WIDTH));
            make.height.equalTo(@(self.scrollView.height-SECTION_INDICATOR_HEIGHT));
        }];
        
        [indicatorView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(button.mas_left).offset(5);
            make.top.equalTo(button.mas_bottom);
            make.width.equalTo(@(SECTION_ITEM_WIDTH-10));
            make.height.equalTo(@(SECTION_INDICATOR_HEIGHT));
        }];
    }
    
//    [self.scrollView bringSubviewToFront:self.indicatorView];

    float contentWidth = [self getVisableSectionsWidth];
    self.scrollView.contentSize = CGSizeMake(contentWidth, self.scrollView.height);
    
    [self setNeedsLayout];
}

- (float) getVisableSectionsWidth
{
    float width = 0;
    for (ArticleSectionData * data in self.sectionArray) {
        if (data.hidden) {
            continue;
        }
        width += SECTION_ITEM_WIDTH;
    }
    
    return width;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    float leftViewWidth = 0;
    float contentWidth = [self getVisableSectionsWidth];
    
    if (contentWidth < self.scrollView.width) {
        leftViewWidth = (self.scrollView.width - contentWidth) / 2;
    }
    
    [self.leftView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@(leftViewWidth));
    }];
}

- (IBAction)modifyButtonClicked:(id)sender
{
    self.modify = !self.modify;
    
    [UIView animateWithDuration:0.2 animations:^{
        self.modifyButton.transform = CGAffineTransformMakeRotation(self.modify?M_PI:0);

    } completion:^(BOOL finished) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(headerView:modify:)]) {
            [self.delegate headerView:self modify:self.modify];
        }
    }];
}

- (void) sectionButtonClicked: (UIButton *) sender
{
    NSUInteger newIndex = [self.buttonArray indexOfObject:sender];
    if (newIndex==self.selectedIndex) {
        return;
    }
    
//    self.selectedIndex = newIndex;
    [self setSelectedIndexAnimated:newIndex];
}

- (void)setSelectedIndex:(NSUInteger)selectedIndex
{
    if(_selectedIndex==selectedIndex || selectedIndex>=self.buttonArray.count) {
        return;
    }
    
    if (_selectedIndex!=NSNotFound) {
        self.selectedButton.selected = NO;
        self.selectedIndicator.backgroundColor = [UIColor clearColor];
    }
    
    _selectedIndex = selectedIndex;
    
    self.selectedButton.selected = YES;
    self.selectedIndicator.backgroundColor = [UIColor redColor];
    
    self.indicatorView.frame = self.selectedIndicator.frame;
    self.indicatorView.hidden = YES;
    
    [self.scrollView scrollRectToVisible:self.selectedIndicator.frame animated:NO];
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(headerView:selectedIndexChanged:)]) {
        [self.delegate headerView:self selectedIndexChanged:self.selectedIndex];
    }
}

- (void) setSelectedIndexAnimated:(NSUInteger)selectedIndex
{
    if(_selectedIndex==selectedIndex || selectedIndex>=self.buttonArray.count) {
        return;
    }
    
    if (_selectedIndex!=NSNotFound) {
        self.selectedButton.selected = NO;
        self.selectedIndicator.backgroundColor = [UIColor clearColor];
    }
    
    _selectedIndex = selectedIndex;
    self.indicatorView.hidden = NO;
    
    [UIView animateWithDuration:0.2 animations:^{
        self.indicatorView.frame = self.selectedIndicator.frame;

    } completion:^(BOOL finished) {
        self.indicatorView.hidden = YES;
        self.selectedButton.selected = YES;
        self.selectedIndicator.backgroundColor = [UIColor redColor];
        
        [self.scrollView scrollRectToVisible:self.selectedIndicator.frame animated:YES];
    }];
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(headerView:selectedIndexChanged:)]) {
        [self.delegate headerView:self selectedIndexChanged:self.selectedIndex];
    }
}

- (NSUInteger) getNextSectionIndex
{
    if (_selectedIndex>0) {
        for (NSInteger i=_selectedIndex-1; i>=0; i--) {
            ArticleSectionData * data = self.sectionArray[i];
            if (!data.hidden) {
                return i;
            }
        }
    }
    
    if (_selectedIndex<=self.sectionArray.count-2) {
        for (NSInteger i=_selectedIndex+1; i<self.sectionArray.count; i++) {
            ArticleSectionData * data = self.sectionArray[i];
            if (!data.hidden) {
                return i;
            }
        }
    }

    return NSNotFound;
}

- (void) sectionStatusChangedAtIndex: (NSUInteger) index
{
    if (index==_selectedIndex) {
//        self.selectedIndex = [self getNextSectionIndex];
        [self setSelectedIndexAnimated:[self getNextSectionIndex]];
    }
    ArticleSectionData * data = self.sectionArray[index];
    
    UIButton * button = self.buttonArray[index];
    UIView * indicator = self.indicatorArray[index];
    
    [button mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@(data.hidden?0:SECTION_ITEM_WIDTH));
    }];
    
    [indicator mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@(data.hidden?0:SECTION_ITEM_WIDTH-10));
    }];
    
    float leftViewWidth = 0;
    float contentWidth = [self getVisableSectionsWidth];
    
    if (contentWidth < self.scrollView.width) {
        leftViewWidth = (self.scrollView.width - contentWidth) / 2;
    }
    
    [self.leftView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@(leftViewWidth));
    }];
    
    self.scrollView.contentSize = CGSizeMake(contentWidth, self.scrollView.height);

    [UIView animateWithDuration:0.2
                     animations:^{
                         [self.scrollView layoutIfNeeded];
                     }
                     completion:^(BOOL finished) {
                         [self.scrollView scrollRectToVisible:self.selectedButton.frame animated:YES];
    }];
    
}


@end
