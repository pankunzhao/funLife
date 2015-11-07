//
//  RotationSupport.m
//  FunnyLife
//
//  Created by qianfeng on 15/8/1.
//  Copyright (c) 2015年 HYZ. All rights reserved.
//

#import "RotationSupport.h"

@implementation UIViewController (Rotation)

-(BOOL)shouldAutorotate {
    return NO;
}

-(UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskPortrait;
}

@end


@implementation UITabBarController (Rotation)

-(BOOL)shouldAutorotate
{
    return [[self.viewControllers lastObject] shouldAutorotate];
}

-(UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return [[self.viewControllers lastObject] supportedInterfaceOrientations];
}

@end

