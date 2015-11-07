//
//  FLGlobal.m
//  FunnyLife
//
//  Created by qianfeng on 15-7-23.
//  Copyright (c) 2015年 HYZ. All rights reserved.
//

#import "FLGlobal.h"

@implementation FLGlobal

+ (NSString *) deviceID
{
    // obtain your device id with you method;
    return @"2046e3ca4e2fffd8d9c3f6b08edb5c4f0eae9b11";
}

+ (NSURL *) funnyUrl
{
    return [NSURL URLWithString: @"http://daheli.qiniudn.com/funny.json"];
}

+ (NSString *) funnyCachePath
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    return [paths[0] stringByAppendingPathComponent:@"funny.json"];
}

+ (NSString *) articleUrl
{
    return @"http://daheli.qiniudn.com/article/article.json";
}

+ (NSString *) articleCachePath
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    return [paths[0] stringByAppendingPathComponent:@"article.json"];
}

+ (NSString *) funny2Url
{
    return [@"http://u14.mmbang.com/open/stream/posts/?mobile_os=ios&device=" stringByAppendingString:[self deviceID]];
}

+ (NSString *) funny2MoreUrl: (NSString *)addon
{
    NSString * url = [NSString stringWithFormat:@"http://u14.mmbang.com/open/stream/posts/?mobile_os=ios&device=%@&lt=%@", [self deviceID], addon];
    
    return [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
}

+ (NSString *) funny2CachePath
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    return [paths[0] stringByAppendingPathComponent:@"funny2.json"];
}

+ (NSString *) funny2PostUrlWithID: (NSString *)posID
{
    return [@"http://u14.mmbang.com/open/stream/comments/?post_id=" stringByAppendingString:posID];
}

+ (NSString *)funny2BookmarkUrl
{
    return @"http://u14.mmbang.com/open/stream/bookmark/";
}

+ (NSString *) helloUrl
{
    return @"http://u14.mmbang.com/open/post/posts/?longitude=116.375339&latitude=40.089682&mobile_os=ios&is_refresh=1&device=2046e3ca4e2fffd8d9c3f6b08edb5c4f0eae9b11&mobile=18211673234&province=%E5%8C%97%E4%BA%AC%E5%B8%82&city=%E5%8C%97%E4%BA%AC%E5%B8%82";
}

+ (NSString *) helloCachePath
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    return [paths[0] stringByAppendingPathComponent:@"hello.json"];
}

+ (NSString *) loginUrl
{
    return @"http://u14.mmbang.com/open/user/login/?code=4b71b095ee8ed02945257416c1efd27d&device=2046e3ca4e2fffd8d9c3f6b08edb5c4f0eae9b11&mobile_os=ios";
}

@end
