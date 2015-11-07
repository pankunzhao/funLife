//
//  FunLargeCell.m
//  FunnyLife
//
//  Created by Wang Haitao on 15/10/10.
//  Copyright © 2015年 qianfeng. All rights reserved.
//

#import "FunLargeCell.h"
#import "UIImageView+WebCache.h"
#import "UIViewAdditions.h"

@interface FunLargeCell () <UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;

@end

@implementation FunLargeCell

- (void)setData:(FunData *)data
{
    self.titleLabel.text = data.title;
    
    float x = 0;
    
    for (NSString * url in data.imageArray) {
        UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(x, 0, self.contentView.width, self.contentView.height)];
        [imageView sd_setImageWithURL:[NSURL URLWithString:url]];
        [self.scrollView addSubview:imageView];
        
        x += self.contentView.width;
    }
    
    self.pageControl.numberOfPages = data.imageArray.count;
    self.pageControl.currentPage = 0;
    
    self.scrollView.contentSize = CGSizeMake(x, self.contentView.height);
    self.scrollView.delegate = self;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSInteger index = scrollView.contentOffset.x / scrollView.width;
    if (index>0) {
        self.pageControl.currentPage = index;
    }
}


@end
