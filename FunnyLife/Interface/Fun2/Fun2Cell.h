//
//  Fun2Cell.h
//  FunnyLife
//
//  Created by Wang Haitao on 15/10/12.
//  Copyright © 2015年 qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Funny2Data.h"

@protocol Fun2CellDelegate <NSObject>

- (void) imageButtonClickedOnCell: (UITableViewCell *)cell;
- (void) bookmarkButtonClickedOnCell: (UITableViewCell *)cell;

@end

@interface Fun2Cell : UITableViewCell

@property (nonatomic, weak) Funny2Data * data;
@property (nonatomic, weak) id<Fun2CellDelegate> delegate;

@end
