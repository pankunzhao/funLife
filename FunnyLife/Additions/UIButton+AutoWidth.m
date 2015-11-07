//
//  UIButton+AutoWidth.m
//  FunnyLife
//
//  Created by qianfeng on 15-7-24.
//  Copyright (c) 2015年 HYZ. All rights reserved.
//

#import "UIButton+AutoWidth.h"
#import "NSString+Frame.h"

#define EXPAND_SIZE     2

@implementation UIButton (AutoWidth)

- (float) adjustWidth
{
    float width = [[self titleForState:UIControlStateNormal] widthWithFont:self.titleLabel.font];
    return width;
}

@end
