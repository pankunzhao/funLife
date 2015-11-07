//
//  PhotoViewController.m
//  FunnyLife
//
//  Created by Wang Haitao on 15/10/13.
//  Copyright © 2015年 qianfeng. All rights reserved.
//

#import "PhotoViewController.h"
#import "Masonry.h"
#import "UIImageView+WebCache.h"
#import "UIViewAdditions.h"

@interface PhotoViewController ()

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;

@end

@implementation PhotoViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.scrollView.backgroundColor = [UIColor blackColor];
    
    NSMutableArray * array = [NSMutableArray arrayWithCapacity:self.urlArray.count];
    
    for (NSString * url in self.urlArray) {
        UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        UIActivityIndicatorView * aiv = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        [imageView addSubview:aiv];
        
        [aiv mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(imageView.mas_centerX);
            make.centerY.equalTo(imageView.mas_centerY);
        }];
        
        [aiv startAnimating];
        
        [imageView sd_setImageWithURL:[NSURL URLWithString:url] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            [aiv stopAnimating];
        }];
        
        [self.scrollView addSubview:imageView];
        [array addObject:imageView];
        imageView.contentMode = UIViewContentModeScaleAspectFit;
    }
    
    for (NSInteger i=0; i<array.count; i++) {
        UIImageView * imageView = array[i];
        UIImageView * lastView = i==0?nil:array[i-1];
        
        if (!lastView) {
            [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.scrollView.mas_top);
                make.left.equalTo(self.scrollView.mas_left);
                make.width.equalTo(self.scrollView.mas_width);
                make.height.equalTo(self.scrollView.mas_height);
            }];
        }
        else {
            [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(lastView.mas_top);
                make.left.equalTo(lastView.mas_right);
                make.width.equalTo(self.scrollView.mas_width);
                make.height.equalTo(self.scrollView.mas_height);
            }];
        }
        
    }

    self.pageControl.numberOfPages = self.urlArray.count;
    self.pageControl.currentPage = self.order;
    self.scrollView.pagingEnabled = YES;
    
    UITapGestureRecognizer * gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(userTapped:)];
//    gesture.delegate = self;
    [self.scrollView addGestureRecognizer:gesture];
}

- (void) userTapped: (UITapGestureRecognizer *) gesture
{
    [self dismissViewControllerAnimated:NO completion:nil];
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    self.scrollView.contentSize = CGSizeMake(self.view.width*self.urlArray.count, self.view.height);
    
    self.scrollView.contentOffset = CGPointMake(self.view.width*self.pageControl.currentPage, 0);
}


-(BOOL)shouldAutorotate {
    return YES;
}

-(UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskAll;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
