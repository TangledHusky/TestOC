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
    
    //添加画板功能
    [self.view addSubview:self.baibanV];
    
}










@end
