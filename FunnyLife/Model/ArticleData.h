//
//  ArticleData.h
//  FunnyLife
//
//  Created by qianfeng on 15/8/24.
//  Copyright (c) 2015年 HYZ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ArticleSectionData : NSObject

@property (nonatomic) NSString * title;
@property (nonatomic) NSString * tag;
@property (nonatomic) NSString * contentType;

@property (nonatomic) NSInteger cacheType;

@property (nonatomic) BOOL hidden;
@property (nonatomic, getter=isDownloading) BOOL downloading;

- (ArticleSectionData *) initWithJSONNode: (id)node;


@end

@interface ArticleItemData : NSObject

@property (nonatomic) NSString * url;
@property (nonatomic) NSString * title;
@property (nonatomic) NSString * subtitle;
@property (nonatomic) NSString * additions;
@property (nonatomic) NSString * imageUrl;

- (ArticleItemData *) initWithJSONNode: (id)node;


@end
