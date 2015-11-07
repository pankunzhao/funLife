//
//  ContentViewController.m
//  FunnyLife
//
//  Created by Wang Haitao on 15/10/17.
//  Copyright © 2015年 qianfeng. All rights reserved.
//

#import "ContentViewController.h"
#import "ArticleData.h"

@interface ContentViewController ()

@property (weak, nonatomic) IBOutlet UIWebView *webView;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *prevBarItem;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *nextBarItem;

@end

@implementation ContentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.automaticallyAdjustsScrollViewInsets = NO;
    ArticleItemData * data = self.data[self.order];
    self.title = data.title;
    
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:data.url]]];
    
    self.prevBarItem.enabled = self.order != 0;
    self.nextBarItem.enabled = self.order != self.data.count-1;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)prevBarItemClicked:(UIBarButtonItem *)sender
{
    self.order --;
    
    ArticleItemData * data = self.data[self.order];
    self.title = data.title;
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:data.url]]];
    
    self.prevBarItem.enabled = self.order != 0;
    self.nextBarItem.enabled = self.order != self.data.count-1;

}

- (IBAction)nextBarItemClicked:(UIBarButtonItem *)sender
{
    self.order ++;
    
    ArticleItemData * data = self.data[self.order];
    self.title = data.title;
    
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:data.url]]];
    
    self.prevBarItem.enabled = self.order != 0;
    self.nextBarItem.enabled = self.order != self.data.count-1;

}


@end
