//
//  ArticleCellBase.h
//  FunnyLife
//
//  Created by Wang Haitao on 15/10/17.
//  Copyright © 2015年 qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ArticleData.h"

@interface ArticleCellBase : UITableViewCell

@property (nonatomic, weak) ArticleItemData * data;

+ (float) rowHeightFromType: (NSString *) type;

@end
