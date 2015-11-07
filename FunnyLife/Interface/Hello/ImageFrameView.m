//
//  ImageFrameView.m
//  FunnyLife
//
//  Created by Wang Haitao on 15/10/12.
//  Copyright © 2015年 qianfeng. All rights reserved.
//

#import "ImageFrameView.h"
#import "UIImageView+WebCache.h"
#import "HelloData.h"

@implementation ImageFrameView

- (void)awakeFromNib
{
    self.backgroundColor = [UIColor whiteColor];
    
    NSMutableArray * array = [NSMutableArray arrayWithCapacity:4];
    for (NSInteger i=0; i<4; i++) {
        UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        [self addSubview:imageView];
        [array addObject:imageView];
    }
    
    self.imageArray = array;
}

+ (float) heightOfContent: (NSArray *)imageArray withInWidth: (float)width
{
    if (imageArray.count==0) {
        return 0;
    }
    if (imageArray.count<3) {
        return 120;
    }
    
    return width / 4;
}

- (void) setImageArray: (NSArray *)imageArray withInWidth: (float)width
{
    if (imageArray.count==0) {
        return;
    }
    
    float x = 0;
    
    float height = [ImageFrameView heightOfContent:imageArray withInWidth:width];
    
    for (NSInteger i=0; i<4; i++) {
        UIImageView * imageView = self.imageArray[i];
        if (i<imageArray.count) {
            HelloImageData * imageData = imageArray[i];
            [imageView sd_setImageWithURL:[NSURL URLWithString:imageData.thumbUrl]];
            imageView.frame = CGRectMake(x, 0, height-5, height-5);
            x += height;
        }
       
        imageView.hidden = i>=imageArray.count;
        
    }
    
}


@end
