//
//  HelloData.h
//  FunnyLife
//
//  Created by qianfeng on 15-7-24.
//  Copyright (c) 2015年 HYZ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HelloImageData : NSObject

@property (nonatomic) NSString * thumbUrl;
@property (nonatomic) NSString * url;

@end


@interface HelloData : NSObject

@property (nonatomic) NSString * name;
@property (nonatomic) NSString * iconUrl;
@property (nonatomic) NSInteger gender;
@property (nonatomic) NSString * city;
@property (nonatomic) NSString * content;
@property (nonatomic) NSArray * photoArray;
@property (nonatomic) NSString * time;
@property (nonatomic) NSInteger like;
@property (nonatomic) NSInteger comments;
@property (nonatomic) NSString * addon;

@property (nonatomic) BOOL needExpand;
@property (nonatomic) BOOL expanded;

- (HelloData *) initWithJSONNode: (id) node;


@end
