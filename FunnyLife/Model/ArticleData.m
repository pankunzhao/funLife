//
//  ArticleData.m
//  FunnyLife
//
//  Created by qianfeng on 15/8/24.
//  Copyright (c) 2015年 HYZ. All rights reserved.
//

#import "ArticleData.h"

@implementation ArticleSectionData

- (ArticleSectionData *) initWithJSONNode: (id) node
{
    self = [super init];
    if (self) {
        self.title = node[@"title"];
        self.contentType = node[@"contentType"];
        self.tag = node[@"tag"];
        self.cacheType = [node[@"cacheType"] integerValue];
    }
    
    return self;
}
@end

@implementation ArticleItemData

- (ArticleItemData *) initWithJSONNode: (id)node
{
    self = [super init];
    if (self) {
        self.title = node[@"title"];
        self.subtitle = node[@"subtitle"];
        self.additions = node[@"additions"];
        self.url = node[@"url"];
        self.imageUrl = node[@"image_url"];
    }
    
    return self;
}

@end

