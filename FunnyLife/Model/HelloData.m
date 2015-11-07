//
//  HelloData.m
//  FunnyLife
//
//  Created by qianfeng on 15-7-24.
//  Copyright (c) 2015年 HYZ. All rights reserved.
//

#import "HelloData.h"

@implementation HelloImageData

@end

@implementation HelloData

- (HelloData *) initWithJSONNode: (id) node
{
    self = [super init];
    if (self) {
        self.name = node[@"user_name"];
        self.gender = [node[@"user_gender"] integerValue];
        self.city = node[@"loc_city"];
        self.iconUrl = node[@"avatar_thumb_url"];
        self.content = node[@"content"];
        self.time = node[@"time"];
        self.like = [node[@"num_of_likes"] integerValue];
        self.comments = [node[@"num_of_comments"] integerValue];
        self.addon = node[@"added_on"];
        
        NSMutableArray * array = [NSMutableArray new];
        
        NSArray * photos = [node objectForKey:@"photos"];
        for (id photo in photos) {
            HelloImageData * imageData = [HelloImageData new];
            imageData.thumbUrl = photo[@"thumb_url"];
            imageData.url = photo[@"mobile_large_url"];
            
            [array addObject:imageData];
        }
        
        self.photoArray = array;
    }
    
    return self;
}

@end
