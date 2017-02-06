//
//  LandScreenPushViewController.m
//  TestOC
//
//  Created by 李亚军 on 2017/1/9.
//  Copyright © 2017年 zyyj. All rights reserved.
//

#import "LandScreenPushViewController.h"
#import "AppDelegate.h"


@interface LandScreenPushViewController ()

@end

@implementation LandScreenPushViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    UIView *ziV = [[UIView alloc] initWithFrame:CGRectMake(0, 100, KScreenHeight, 100)];
    ziV.backgroundColor = [UIColor redColor];
    [self.view addSubview:ziV];
    
    [self setFullScreen];
}


-(void)setFullScreen{
    
    AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    delegate.allowRotation = YES;
    
}


-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    delegate.allowRotation = NO;
}

@end
