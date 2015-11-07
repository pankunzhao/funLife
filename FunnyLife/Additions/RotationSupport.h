//
//  RotationSupport.h
//  FunnyLife
//
//  Created by qianfeng on 15/8/1.
//  Copyright (c) 2015年 HYZ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (Rotation)

-(BOOL)shouldAutorotate;
-(UIInterfaceOrientationMask)supportedInterfaceOrientations;

@end

@interface UITabBarController (Rotation)

-(BOOL)shouldAutorotate;
-(UIInterfaceOrientationMask)supportedInterfaceOrientations;

@end