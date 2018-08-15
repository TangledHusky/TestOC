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
    
    //1、设置corner
    _img1.layer.cornerRadius = 20;
    _img1.layer.masksToBounds = YES;


    
    //测试label、button，在ios9之后可以直接这样变圆角
    _lbl.layer.backgroundColor = [[UIColor redColor] CGColor];
    _lbl.layer.cornerRadius = 5;
    
    _btn.layer.backgroundColor = [[UIColor redColor] CGColor];
    _btn.layer.cornerRadius = 5;
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}




-(void)fill{
    //方法1
//    [_img1 sd_setImageWithURL:[NSURL URLWithString:@"http://scimg.jb51.net/touxiang/201703/2017030220440915.jpg"] placeholderImage:[UIImage imageNamed:@"WechatIMG2"]];
    
    //通过Core Graphics重新绘制带圆角的视图，增加CPU的负担，但能保持较高帧率（不推荐这周，太耗cpu了）
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        UIImage *img = [[UIImage imageNamed:@"WechatIMG2"] drawCircleImage];
        dispatch_async(dispatch_get_main_queue(), ^{
            _img2.image = img;
        });
    });
    
    //设置CALayer的mask,绘制圆角
    CAShapeLayer *mask = [CAShapeLayer new];
    mask.path = [UIBezierPath bezierPathWithOvalInRect:_img2.bounds].CGPath;
    _img3.layer.mask = mask;
    
}

@end
