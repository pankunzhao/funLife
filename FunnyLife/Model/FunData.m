//
//  FunData.m
//  FunnyLife
//
//  Created by Wang Haitao on 15/10/10.
//  Copyright © 2015年 qianfeng. All rights reserved.
//

#import "FunData.h"

@implementation FunData

- (FunData *) initWithJSONNode: (id) node
{
    self = [super init];
    if (self) {
        self.title = node[@"title"];
        self.subtitle = node[@"subtitle"];
        self.tag = node[@"tag"];
        self.imageArray = node[@"items"];
    }
    
    return self;
}

@end
