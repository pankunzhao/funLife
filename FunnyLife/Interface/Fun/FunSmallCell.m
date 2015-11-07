//
//  FunSmallCell.m
//  FunnyLife
//
//  Created by Wang Haitao on 15/10/10.
//  Copyright © 2015年 qianfeng. All rights reserved.
//

#import "FunSmallCell.h"
#import "UIImageView+WebCache.h"

static NSDictionary * colorMap = nil;

@interface FunSmallCell ()

@property (weak, nonatomic) IBOutlet UIImageView *iconView;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *subtitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *tagLabel;

@end

@implementation FunSmallCell

+ (void)initialize
{
    colorMap = @{@"文化":[UIColor blueColor],
                 @"逗逼":[UIColor orangeColor],
                 @"音乐":[UIColor redColor],
                 @"绘画":[UIColor greenColor],
                 @"娱乐":[UIColor purpleColor],
                 };
}

- (void)awakeFromNib
{
    self.tagLabel.layer.cornerRadius = 4;
    self.tagLabel.clipsToBounds = YES;
}

- (void)setData:(FunData *)data
{
    NSURL * url = [NSURL URLWithString:data.imageArray[0]];
    [self.iconView sd_setImageWithURL:url];
    
    self.titleLabel.text = data.title;
    self.subtitleLabel.text = data.subtitle;
    self.tagLabel.text = data.tag;
    self.tagLabel.backgroundColor = colorMap[data.tag];
}

@end
