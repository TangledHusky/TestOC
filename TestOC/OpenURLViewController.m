//
//  OpenURLViewController.m
//  TestOC
//
//  Created by 李亚军 on 2017/1/10.
//  Copyright © 2017年 zyyj. All rights reserved.
//

#import "OpenURLViewController.h"

@interface OpenURLViewController ()

@end

@implementation OpenURLViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton *btn1 = [[UIButton alloc] initWithFrame:CGRectMake(100, 100, 100, 30)];
    [btn1 setTitle:@"打电话" forState:UIControlStateNormal];
    btn1.backgroundColor = [UIColor grayColor];
    [btn1 addTarget:self action:@selector(openTel) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn1];
    
    UIButton *btn11 = [[UIButton alloc] initWithFrame:CGRectMake(100, 140, 100, 30)];
    [btn11 setTitle:@"发短信" forState:UIControlStateNormal];
    btn11.backgroundColor = [UIColor grayColor];
    [btn11 addTarget:self action:@selector(openSMS) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn11];
    
    UIButton *btn111 = [[UIButton alloc] initWithFrame:CGRectMake(100, 180, 100, 30)];
    [btn111 setTitle:@"发邮件" forState:UIControlStateNormal];
    btn111.backgroundColor = [UIColor grayColor];
    [btn111 addTarget:self action:@selector(openEMAIL) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn111];
    
    UIButton *btn1111 = [[UIButton alloc] initWithFrame:CGRectMake(100, 220, 100, 30)];
    [btn1111 setTitle:@"打开网页" forState:UIControlStateNormal];
    btn1111.backgroundColor = [UIColor grayColor];
    [btn1111 addTarget:self action:@selector(openSafari) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn1111];
    
    
    
   
}


-(void)openTel{
    UIApplication *app = [UIApplication sharedApplication];
    [app openURL:[NSURL URLWithString:@"tel://10086"]];
    
    
}

-(void)openSMS{
    UIApplication *app = [UIApplication sharedApplication];
    [app openURL:[NSURL URLWithString:@"sms://10086"]];
}

-(void)openEMAIL{
    UIApplication *app = [UIApplication sharedApplication];
    [app openURL:[NSURL URLWithString:@"mailto://994825763@qq.com"]];
}

-(void)openSafari{
    
    UIApplication *app = [UIApplication sharedApplication];
    [app openURL:[NSURL URLWithString:@"http://ios.itcast.cn"]];
    
}




@end
