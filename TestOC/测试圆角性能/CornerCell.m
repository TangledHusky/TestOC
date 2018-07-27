//
//  CornerCell.m
//  TestOC
//
//  Created by 李亚军 on 2017/3/4.
//  Copyright © 2017年 zyyj. All rights reserved.
//

#import "CornerCell.h"
#import "UIImageView+WebCache.h"

@implementation CornerCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    
//    _img1.layer.cornerRadius = 20;
//    _img1.layer.masksToBounds = YES;
//    
//    _img2.layer.cornerRadius = 20;
//    _img2.layer.masksToBounds = YES;
//    
//    _img3.layer.cornerRadius = 20;
//    _img3.layer.masksToBounds = YES;
//    
//    _img4.layer.cornerRadius = 20;
//    _img4.layer.masksToBounds = YES;
    
//    UIImage *imgae1 = [_img1.image cutCircleImage];
//    _img1.image = imgae1;
//    UIImage *imgae2 = [_img2.image cutCircleImage];
//    _img2.image = imgae2;
//    UIImage *imgae3 = [_img3.image cutCircleImage];
//    _img3.image = imgae3;
//    UIImage *imgae4 = [_img4.image cutCircleImage];
//    _img4.image = imgae4;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}



/**
 两种方式：
 1、直接图片设置cornerradius，ios9之后，不会有离屏渲染
 2、用重新绘制的方法，增大cpu开销代替离屏渲染带来的失贞（放弃，不好用）

 */
-(void)fill{
    [_img1 sd_setImageWithURL:[NSURL URLWithString:@"http://scimg.jb51.net/touxiang/201703/2017030220440915.jpg"] placeholderImage:[UIImage imageNamed:@"WechatIMG2"]];
    [_img2 sd_setImageWithURL:[NSURL URLWithString:@"http://scimg.jb51.net/touxiang/201703/2017030220440915.jpg"] placeholderImage:[UIImage imageNamed:@"WechatIMG2"]];
    [_img3 sd_setImageWithURL:[NSURL URLWithString:@"http://scimg.jb51.net/touxiang/201703/2017030220440915.jpg"] placeholderImage:[UIImage imageNamed:@"WechatIMG2"]];
    [_img4 sd_setImageWithURL:[NSURL URLWithString:@"http://scimg.jb51.net/touxiang/201703/2017030220440915.jpg"] placeholderImage:[UIImage imageNamed:@"WechatIMG2"]];

    return
    
    //经过我的测试，有几次这样会闪退，提示：Terminated due to memory issue
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        UIImage *placeholder = [[UIImage imageNamed:@"WechatIMG2"] cutCircleImage];

        __weak typeof(self) weakView = self;
        [_img1 sd_setImageWithURL:[NSURL URLWithString:@"http://scimg.jb51.net/touxiang/201703/2017030220440915.jpg"] placeholderImage:placeholder completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            dispatch_async(dispatch_get_main_queue(), ^{
                weakView.img1.image = image ? [image cutCircleImage] : placeholder;
            });
        }];
        [_img2 sd_setImageWithURL:[NSURL URLWithString:@"http://scimg.jb51.net/touxiang/201703/2017030220440915.jpg"] placeholderImage:placeholder completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            dispatch_async(dispatch_get_main_queue(), ^{
                weakView.img2.image = image ? [image cutCircleImage] : placeholder;
            });
        }];
        [_img3 sd_setImageWithURL:[NSURL URLWithString:@"http://scimg.jb51.net/touxiang/201703/2017030220440915.jpg"] placeholderImage:placeholder completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            dispatch_async(dispatch_get_main_queue(), ^{
                weakView.img3.image = image ? [image cutCircleImage] : placeholder;
            });
        }];
        [_img4 sd_setImageWithURL:[NSURL URLWithString:@"http://scimg.jb51.net/touxiang/201703/2017030220440915.jpg"] placeholderImage:placeholder completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            dispatch_async(dispatch_get_main_queue(), ^{
                weakView.img4.image = image ? [image cutCircleImage] : placeholder;
            });
        }];


    });
    
   
    
}

@end
