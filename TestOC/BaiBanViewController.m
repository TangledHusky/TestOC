//
//  BaiBanViewController.m
//  TestOC
//
//  Created by 李亚军 on 2017/2/8.
//  Copyright © 2017年 zyyj. All rights reserved.
//

#import "BaiBanViewController.h"
#import "BaibanView.h"


@interface BaiBanViewController ()

@property (nonatomic,strong) BaibanView  *baibanV;



@end

@implementation BaiBanViewController

-(BaibanView *)baibanV{
    if(_baibanV==nil){
        _baibanV=[[BaibanView alloc] initWithFrame:CGRectMake(0, 64, KScreenWidth, KScreenHeight - 64)];
    }
    return  _baibanV;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"画 板";
    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(0, -60) forBarMetrics:UIBarMetricsDefault];
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    //1.测试背景图为图片，注意，这里只是为了测试支持图片背景，图片可能有点变形，到时需要自己处理
    UIImageView *imgv = [[UIImageView alloc] init];
    imgv.userInteractionEnabled = YES;
    imgv.image = [UIImage imageNamed:@"meinv"];
    imgv.frame = self.view.bounds;
    [self.view addSubview:imgv];
    //添加画板功能
    self.baibanV.backgroundColor = [UIColor clearColor];
    [imgv addSubview:self.baibanV];
    
    // 2.背景是纯色
//    [self.view addSubview:self.baibanV];
    
}










@end
