//
//  Funny2Data.m
//  FunnyLife
//
//  Created by qianfeng on 15-7-23.
//  Copyright (c) 2015年 HYZ. All rights reserved.
//

#import "Funny2Data.h"

@implementation Funny2Data

- (Funny2Data *) initWithJSONNode: (id) node
{
    self = [super init];
    if (self) {
        self.content = node[@"content"];
        self.source = node[@"source"];
        self.imageUrl = node[@"pic"];
        self.previewImageUrl = node[@"thumb"];
        self.bookmarked = [node[@"is_bookmarked"] boolValue];
        self.comments = [node[@"comments"] integerValue];
        self.addon = node[@"added_on"];
        self.objectID = node[@"id"];
    }
    
    return self;
}

@end
