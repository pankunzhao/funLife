//
//  Fun2Cell.m
//  FunnyLife
//
//  Created by Wang Haitao on 15/10/12.
//  Copyright © 2015年 qianfeng. All rights reserved.
//

#import "Fun2Cell.h"
#import "UIImageView+WebCache.h"

@interface Fun2Cell ()

@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UIButton *imageButton;
@property (weak, nonatomic) IBOutlet UILabel *fromLabel;
@property (weak, nonatomic) IBOutlet UIButton *bookmarkButton;

@property (nonatomic, weak) UIImageView * buttonImageView;

@end

@implementation Fun2Cell

- (void)awakeFromNib {
    // Initialization code
    UIImageView * imageView = [[UIImageView alloc] initWithFrame:self.imageButton.bounds];
    [self.imageButton addSubview:imageView];
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    
    self.buttonImageView = imageView;
}

- (void)setData:(Funny2Data *)data
{
    self.contentLabel.text = data.content;
    self.fromLabel.text = data.source;
    [self.buttonImageView sd_setImageWithURL: [NSURL URLWithString:data.previewImageUrl]];
    
    UIImage * image = [UIImage imageNamed:@"icon_bookmark"];
    
    if (data.bookmarked) {
        image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    }
    
    [self.bookmarkButton setImage:image forState:UIControlStateNormal];
}

- (IBAction)imageButtonClicked:(UIButton *)sender
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(imageButtonClickedOnCell:)]) {
        [self.delegate imageButtonClickedOnCell:self];
    }
}

- (IBAction)bookmarkButtonClicked:(UIButton *)sender
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(bookmarkButtonClickedOnCell:)]) {
        [self.delegate bookmarkButtonClickedOnCell:self];
    }
}



@end
