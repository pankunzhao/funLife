//
//  FLGlobal.h
//  FunnyLife
//
//  Created by qianfeng on 15-7-23.
//  Copyright (c) 2015年 HYZ. All rights reserved.
//

#import <Foundation/Foundation.h>
 

@interface FLGlobal : NSObject

+ (NSURL *) funnyUrl;
+ (NSString *) funnyCachePath;

+ (NSString *) funny2Url;
+ (NSString *) funny2MoreUrl: (NSString *)addon;
+ (NSString *) funny2CachePath;
+ (NSString *) funny2PostUrlWithID: (NSString *)posID;
+ (NSString *) funny2BookmarkUrl;


+ (NSString *) helloUrl;
+ (NSString *) helloCachePath;

+ (NSString *) articleUrl;
+ (NSString *) articleCachePath;


+ (NSString *) loginUrl;

+ (NSString *) deviceID;

@end
