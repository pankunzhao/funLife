//
//  HelloCell.h
//  FunnyLife
//
//  Created by Wang Haitao on 15/10/12.
//  Copyright © 2015年 qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ImageFrameView.h"
#import "HelloData.h"

@interface HelloCell : UITableViewCell

@property (weak, nonatomic) HelloData * data;

@property (weak, nonatomic) IBOutlet UIButton *nameButton;
@property (weak, nonatomic) IBOutlet UIButton *expandButton;

@property (weak, nonatomic) IBOutlet ImageFrameView *imageFrameView;

@end
