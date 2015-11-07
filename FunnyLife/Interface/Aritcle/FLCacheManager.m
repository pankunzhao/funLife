//
//  FLCacheManager.m
//  FunnyLife
//
//  Created by Wang Haitao on 15/10/16.
//  Copyright © 2015年 qianfeng. All rights reserved.
//

#import "FLCacheManager.h"
#import "AFNetworking.h"
#import "ArticleData.h"

@interface FLCacheManager ()

@property (nonatomic) NSString * cachePath;
@property (nonatomic) NSString * baseUrl;

@property (nonatomic) BOOL downloading;

@end

@implementation FLCacheManager

- (void) loadSectionData: (NSString *) url
               cachePath: (NSString *) path
                 success: (void(^)(NSArray *sectionArray)) successBlock
                 waiting: (void (^)()) waitBlock
                    fail: (void (^)()) failBlock
{
    if (self.downloading) {
        return;
    }
    
    self.cachePath = path;
    
    if ([[NSFileManager defaultManager] fileExistsAtPath:path]) {
        [self loadSectionDataFromFile];
        successBlock(self.sectionArray);
        return;
    }
    
    self.downloading = YES;
    
    AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager];
    
    [manager GET:url
      parameters:nil
         success:^(AFHTTPRequestOperation *operation, id responseObject) {
             self.downloading = NO;
             if (responseObject) {
                 [[NSFileManager defaultManager] removeItemAtPath:self.cachePath error:nil];
                 [operation.responseData writeToFile:self.cachePath atomically:NO];
                 
                 [self loadSectionDataFromFile];
                 successBlock(self.sectionArray);
                 return;
             }
             failBlock();
         }
         failure:^(AFHTTPRequestOperation *operation, NSError *error) {
             self.downloading = NO;
             failBlock();
         }
     ];
    
    waitBlock();
}

- (void) loadSectionDataFromFile
{
    NSData * fileData = [NSData dataWithContentsOfFile:self.cachePath];
    NSDictionary * objects = [NSJSONSerialization JSONObjectWithData:fileData options:NSJSONReadingMutableContainers error:nil];
    if (!objects) {
        return;
    }
    
    NSMutableArray * array = [NSMutableArray new];
    
    self.baseUrl = objects[@"base_url"];
    
    NSArray * dataArray = objects[@"items"];
    for (id node in dataArray) {
        ArticleSectionData * data = [[ArticleSectionData alloc] initWithJSONNode:node];
        [array addObject:data];
    }

    self.sectionArray = array;
}

- (NSString *) urlAtIndex: (NSUInteger) index
{
    ArticleSectionData * data = self.sectionArray[index];
    return [NSString stringWithFormat:@"%@%@.json", self.baseUrl, data.tag];
}

- (NSString *) cachePathAtIndex: (NSUInteger) index
{
    ArticleSectionData * data = self.sectionArray[index];
    
    return [NSString stringWithFormat:@"%@/%@.json", NSTemporaryDirectory(), data.tag];
}



- (void) loadDataAtSectionIndex: (NSUInteger) index
                        refresh: (BOOL) isRefresh
                        success: (void(^)(NSString * filePath)) successBlock
                        waiting: (void (^)()) waitBlock
                           fail: (void (^)()) failBlock
{
    ArticleSectionData * data = self.sectionArray[index];
    
    if (data.isDownloading) {
        waitBlock();
        return;
    }
    
    NSString * url = [self urlAtIndex:index];
    
    if (!isRefresh) {
        if ([[NSFileManager defaultManager] fileExistsAtPath:[self cachePathAtIndex:index]]) {
            successBlock([self cachePathAtIndex:index]);
            return;
        }
    }
    else {
        ///
        // do your own url merge or change.....
        // url = .......
        ///
    }
    
    data.downloading = YES;
    
    AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager];
    
    [manager GET:url
      parameters:nil
         success:^(AFHTTPRequestOperation *operation, id responseObject) {
             data.downloading = NO;
             if (responseObject) {
                 [[NSFileManager defaultManager] removeItemAtPath:[self cachePathAtIndex:index] error:nil];
                 [operation.responseData writeToFile:[self cachePathAtIndex:index] atomically:NO];
                     successBlock([self cachePathAtIndex:index]);
                 return;
             }
             failBlock();
         }
         failure:^(AFHTTPRequestOperation *operation, NSError *error) {
             data.downloading = NO;
             failBlock();
         }
     ];
    
    waitBlock();
}

@end
