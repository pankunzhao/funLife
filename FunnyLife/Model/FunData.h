//
//  FunData.h
//  FunnyLife
//
//  Created by Wang Haitao on 15/10/10.
//  Copyright © 2015年 qianfeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FunData : NSObject

@property (nonatomic) NSString * title;
@property (nonatomic) NSString * subtitle;
@property (nonatomic) NSString * tag;
@property (nonatomic) NSArray * imageArray;

- (FunData *) initWithJSONNode: (id) node;

@end
