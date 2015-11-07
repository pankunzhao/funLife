//
//  ArticleCellBase.m
//  FunnyLife
//
//  Created by Wang Haitao on 15/10/17.
//  Copyright © 2015年 qianfeng. All rights reserved.
//

#import "ArticleCellBase.h"

@implementation ArticleCellBase

+ (float) rowHeightFromType: (NSString *) type
{
    if ([type isEqualToString:@"TYPE1"]) {
        return 80.;
    }
    else if ([type isEqualToString:@"TYPE2"]) {
        return 120.;
    }
    else return 80;
}

@end
