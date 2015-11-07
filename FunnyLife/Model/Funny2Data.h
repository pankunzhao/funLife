//
//  Funny2Data.h
//  FunnyLife
//
//  Created by qianfeng on 15-7-23.
//  Copyright (c) 2015年 HYZ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Funny2Data : NSObject

@property (nonatomic) NSString * content;
@property (nonatomic) NSString * imageUrl;
@property (nonatomic) NSString * previewImageUrl;
@property (nonatomic) NSString * source;
@property (nonatomic) NSInteger comments;
@property (nonatomic) BOOL bookmarked;
@property (nonatomic) NSString * addon;
@property (nonatomic) NSString * objectID;

- (Funny2Data *) initWithJSONNode: (id) node;

@end
