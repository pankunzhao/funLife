//
//  HelloCell.m
//  FunnyLife
//
//  Created by Wang Haitao on 15/10/12.
//  Copyright © 2015年 qianfeng. All rights reserved.
//

#import "HelloCell.h"
#import "UIImageView+WebCache.h"
#import "UIViewAdditions.h" 
#import "NSString+Frame.h"
#import "UIButton+AutoWidth.h"

@interface HelloCell ()

@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property (weak, nonatomic) IBOutlet UIImageView *genderImageView;
@property (weak, nonatomic) IBOutlet UILabel *fromLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UIView *contentFrameView;
@property (weak, nonatomic) IBOutlet UIView *contentFrameLine;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *nameButtonWidthConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imageFrameViewHeightConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentLabelHeightConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *expandButtonHeightConstraint;


@end

@implementation HelloCell

- (void)awakeFromNib
{
    self.contentFrameView.layer.cornerRadius = 4;
    self.contentFrameView.clipsToBounds = YES;
    
    self.contentFrameLine.layer.cornerRadius = 4;
    self.contentFrameLine.clipsToBounds = YES;
  
}

- (void)setData:(HelloData *)data
{
    self.contentLabel.text = data.content;
    self.fromLabel.text = data.city;
    self.timeLabel.text = data.time;
    [self.iconView sd_setImageWithURL:[NSURL URLWithString:data.iconUrl]];
    self.genderImageView.image = [UIImage imageNamed:data.gender==0?@"icon_male":@"icon_female"];
    [self.nameButton setTitle:data.name forState:UIControlStateNormal];
    
    float width = self.contentView.width-20;
    [self.imageFrameView setImageArray:data.photoArray withInWidth:width];
    float contentHeight = [data.content heightWithFont:[UIFont systemFontOfSize:17] withinWidth:width];

    if (data.needExpand) {
        [self.expandButton setTitle:data.expanded?@"收起":@"展开" forState:UIControlStateNormal];
        self.expandButton.hidden = NO;
        self.expandButtonHeightConstraint.constant = 30;
        if (!data.expanded) {
            contentHeight = 21*2;
        }
    }
    else {
        self.expandButton.hidden = YES;
        self.expandButtonHeightConstraint.constant = 0;
    }
    
    self.contentLabelHeightConstraint.constant = contentHeight;
    self.nameButtonWidthConstraint.constant = [self.nameButton adjustWidth];
    self.imageFrameViewHeightConstraint.constant = [ImageFrameView heightOfContent:data.photoArray withInWidth:width];
    
    [self updateConstraintsIfNeeded];
}

@end
