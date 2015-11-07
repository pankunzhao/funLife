//
//  ImageFrameView.h
//  FunnyLife
//
//  Created by Wang Haitao on 15/10/12.
//  Copyright © 2015年 qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ImageFrameView : UIView

@property (nonatomic) NSArray * imageArray;

+ (float) heightOfContent: (NSArray *)imageArray withInWidth: (float)width;

- (void) setImageArray: (NSArray *)imageArray withInWidth: (float)width;


@end
