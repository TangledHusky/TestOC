//
//  TestXibViewController.m
//  TestOC
//
//  Created by 李亚军 on 2017/1/23.
//  Copyright © 2017年 zyyj. All rights reserved.
//

#import "TestXibViewController.h"
#import "XibShow.h"
#import "NoXibView.h"

@interface TestXibViewController ()

@end

@implementation TestXibViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"viewDidLoad");
    self.view.backgroundColor = [UIColor whiteColor];
    
    XibShow *xib = [[XibShow alloc] initWithFrame:CGRectMake(0, 250, KScreenWidth, 50)];
    [self.view addSubview:xib];

    
    NoXibView *noxib = [[NoXibView alloc] initWithFrame:CGRectMake(0, 310, KScreenWidth, 150)];
    [self.view addSubview:noxib];

    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




@end
