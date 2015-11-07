//
//  FLCacheManager.h
//  FunnyLife
//
//  Created by Wang Haitao on 15/10/16.
//  Copyright © 2015年 qianfeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FLCacheManager : NSObject

@property (nonatomic) NSArray * sectionArray;

- (void) loadSectionData: (NSString *) url
               cachePath: (NSString *) path
                 success: (void(^)(NSArray *sectionArray)) successBlock
                 waiting: (void (^)()) waitBlock
                    fail: (void (^)()) failBlock;


- (void) loadDataAtSectionIndex: (NSUInteger) index
                        refresh: (BOOL) isRefresh
                        success: (void(^)(NSString * filePath)) successBlock
                        waiting: (void (^)()) waitBlock
                           fail: (void (^)()) failBlock;



@end
