//
//  RefreshTableViewController.h
//  FunnyLife
//
//  Created by Wang Haitao on 15/10/12.
//  Copyright © 2015年 qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, FLRefreshType)
{
    FLRefreshTypeHeader = 1,
    FLRefreshTypeFooter = 1 << 1,
    FLRefreshTypeAll = FLRefreshTypeHeader | FLRefreshTypeFooter,
};

@interface RefreshTableViewController : UITableViewController

@property (nonatomic) NSString * cachePath;
@property (nonatomic) NSString * url;
@property (nonatomic) NSMutableArray * data;
@property (nonatomic) FLRefreshType refreshType;

- (void) endFooterRefresh;

@end
