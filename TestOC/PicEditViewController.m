//
//  PicEditViewController.m
//  TestOC
//
//  Created by 李亚军 on 2017/1/23.
//  Copyright © 2017年 zyyj. All rights reserved.
//

#import "PicEditViewController.h"
#import "UIImageView+WebCache.h"

@interface PicEditViewController ()

@end

@implementation PicEditViewController{
    UIImageView *imageView;
    UIImageView *imageView2;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    imageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 88, KScreenWidth-20, 200)];
    [self.view addSubview:imageView];
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    imageView.image = [self imageAddText:[UIImage imageNamed:@"WechatIMG2"] text:@"版权所有"];
    
    
    
    imageView2 = [[UIImageView alloc] initWithFrame:CGRectMake(10, 300, KScreenWidth-20, 200)];
    [self.view addSubview:imageView2];
    imageView2.contentMode = UIViewContentModeScaleAspectFit;
//    imageView2.image = [self addImage:[UIImage imageNamed:@"WechatIMG2"] addMsakImage:[UIImage imageNamed:@"meinv"]];
//    
    [self imageAddUrlImage:@"http://cdn.cocimg.com/bbs/attachment/Fid_6/6_131039_dbac75feb1fb9b3.jpg" image2:@"http://avatar.csdn.net/1/D/A/1_zhonggaorong.jpg" showinImageView:imageView2];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


/**
 图片合成文字

 @param img <#img description#>
 @param logoText <#logoText description#>
 @return <#return value description#>
 */
- (UIImage *)imageAddText:(UIImage *)img text:(NSString *)logoText
{
    NSString* mark = logoText;
    int w = img.size.width;
    int h = img.size.height;
    UIGraphicsBeginImageContext(img.size);
    [img drawInRect:CGRectMake(0, 0, w, h)];
    NSDictionary *attr = @{NSFontAttributeName: [UIFont boldSystemFontOfSize:55],                             NSForegroundColorAttributeName : [UIColor redColor]  };
    //位置显示
    [mark drawInRect:CGRectMake(10, 20, w*0.8, h*0.3) withAttributes:attr];
    
    UIImage *aimg = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();  
    
    return aimg;
    
}


/**
 下载网络图片合成

 @param imgUrl <#imgUrl description#>
 @param imgUrl2 <#imgUrl2 description#>
 @param imgView <#imgView description#>
 */
- (void)imageAddUrlImage:(NSString *)imgUrl image2:(NSString *)imgUrl2 showinImageView:(UIImageView *)imgView
{
    // 1.队列组、全局并发队列 的初始化
    dispatch_group_t group = dispatch_group_create();
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    // 2.在block内部不能修改外部的局部变量，这里必须要加前缀 __block
    __block UIImage *image1 = nil;
    
    // 注意这里的异步执行方法多了一个group（队列）
    dispatch_group_async(group, queue, ^{
        NSURL *url1 = [NSURL URLWithString:imgUrl];
        NSData *data1 = [NSData dataWithContentsOfURL:url1];
        image1 = [UIImage imageWithData:data1];
    });
    
    // 3.下载图片2
    __block UIImage *image2 = nil;
    dispatch_group_async(group, queue, ^{
        NSURL *url2 = [NSURL URLWithString:imgUrl2];
        NSData *data2 = [NSData dataWithContentsOfURL:url2];
        image2 = [UIImage imageWithData:data2];
    });
    
    __block UIImage *fullImage;
    // 4.合并图片 (保证执行完组里面的所有任务之后，再执行notify函数里面的block)
    dispatch_group_notify(group, queue, ^{
        
        UIGraphicsBeginImageContextWithOptions(image1.size ,NO, 0.0);
        [image1 drawInRect:CGRectMake(0, 0, image1.size.width, image1.size.height)];
        [image2 drawInRect:CGRectMake(0, 0, image1.size.width, image1.size.height/2)];
        fullImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        
        dispatch_async(dispatch_get_main_queue(), ^{
            imgView.image = fullImage;
        });
    });
}


/**
 本地图片合成

 @param useImage <#useImage description#>
 @param maskImage <#maskImage description#>
 @return <#return value description#>
 */
- (UIImage *)imageAddLocalImage:(UIImage *)useImage addMsakImage:(UIImage *)maskImage
{
    
    UIGraphicsBeginImageContextWithOptions(useImage.size ,NO, 0.0);
    [useImage drawInRect:CGRectMake(0, 0, useImage.size.width, useImage.size.height)];
    
    //四个参数为水印图片的位置
    [maskImage drawInRect:CGRectMake(0, 0, useImage.size.width, useImage.size.height/2)];
    //如果要多个位置显示，继续drawInRect就行
    //[maskImage drawInRect:CGRectMake(0, useImage.size.height/2, useImage.size.width, useImage.size.height/2)];
    UIImage *resultingImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return resultingImage;
}



@end
