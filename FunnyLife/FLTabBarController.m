//
//  FLTabBarController.m
//  FunnyLife
//
//  Created by Wang Haitao on 15/10/10.
//  Copyright © 2015年 qianfeng. All rights reserved.
//

#import "FLTabBarController.h"

@interface FLTabBarController ()

@end

@implementation FLTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.tabBar.tintColor = [UIColor colorWithRed:0 green:0.5 blue:0 alpha:1];
    
    UITabBarItem * item = self.tabBar.items[2];
    item.selectedImage = [UIImage imageNamed:@"tab_photoselected"];
    
    item = self.tabBar.items[0];
    item.selectedImage = [UIImage imageNamed:@"tab_funselected"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
