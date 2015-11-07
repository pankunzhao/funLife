//
//  ArticleDeriveCells.m
//  FunnyLife
//
//  Created by Wang Haitao on 15/10/17.
//  Copyright © 2015年 qianfeng. All rights reserved.
//

#import "ArticleDeriveCells.h"
#import "UIImageView+WebCache.h"

@interface ArticleCellType1 ()

@property (weak, nonatomic) IBOutlet UIImageView *photoImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *subtitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *addtionsLabel;


@end

@implementation ArticleCellType1

- (void)setData:(ArticleItemData *)data
{
    [self.photoImageView sd_setImageWithURL:[NSURL URLWithString:data.imageUrl]];
    self.titleLabel.text = data.title;
    self.subtitleLabel.text = data.subtitle;
    self.addtionsLabel.text = data.additions;
}

@end

@interface ArticleCellType2 ()

@property (weak, nonatomic) IBOutlet UIImageView *photoImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *subtitleLabel;


@end

@implementation ArticleCellType2

- (void)setData:(ArticleItemData *)data
{
    [self.photoImageView sd_setImageWithURL:[NSURL URLWithString:data.imageUrl]];
    self.titleLabel.text = data.title;
    self.subtitleLabel.text = data.subtitle;
}


@end

@interface ArticleCellType3 ()

@property (weak, nonatomic) IBOutlet UIImageView *photoImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *subtitleLabel;

@end

@implementation ArticleCellType3

- (void)setData:(ArticleItemData *)data
{
    [self.photoImageView sd_setImageWithURL:[NSURL URLWithString:data.imageUrl]];
    self.titleLabel.text = data.title;
    self.subtitleLabel.text = data.subtitle;
}

@end
