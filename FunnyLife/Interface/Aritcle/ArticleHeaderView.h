//
//  ArticleHeaderView.h
//  FunnyLife
//
//  Created by Wang Haitao on 15/10/16.
//  Copyright © 2015年 qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ArticleHeaderView;

@protocol ArticleHeaderViewDelegate <NSObject>

- (void) headerView: (ArticleHeaderView*)header selectedIndexChanged: (NSUInteger) index;
- (void) headerView:(ArticleHeaderView *)header modify: (BOOL) modify;

@end

@interface ArticleHeaderView : UIView

@property (nonatomic, weak) NSArray * sectionArray;
@property (nonatomic) NSUInteger selectedIndex;

@property (nonatomic, weak) id<ArticleHeaderViewDelegate> delegate;

- (void) sectionStatusChangedAtIndex: (NSUInteger) index;

@end
