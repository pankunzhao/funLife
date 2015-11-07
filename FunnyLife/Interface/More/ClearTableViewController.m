//
//  ClearTableViewController.m
//  FunnyLife
//
//  Created by Wang Haitao on 15/10/14.
//  Copyright © 2015年 qianfeng. All rights reserved.
//

#import "ClearTableViewController.h"

@interface ClearTableViewController ()
{
    __weak IBOutlet UIImageView *imageIcon;
    
    NSTimer * _timer;
    float angle;
    
}

@end

@implementation ClearTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _timer = [NSTimer scheduledTimerWithTimeInterval:0.05 target:self selector:@selector(onTimer:) userInfo:nil repeats:YES];
    
    [self performSelector:@selector(autoClose) withObject:nil afterDelay:4];
}


- (void) onTimer: (NSTimer *)timer
{
    imageIcon.transform = CGAffineTransformMakeRotation(angle * M_PI / 180.0);
    angle += 2;
    if (angle>360) {
        angle = 0;
    }
}

- (void) autoClose
{
    [_timer invalidate];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
