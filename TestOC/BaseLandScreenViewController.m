//
//  BaseLandScreenViewController.m
//  TestOC
//
//  Created by 李亚军 on 2017/1/6.
//  Copyright © 2017年 zyyj. All rights reserved.
//

#import "BaseLandScreenViewController.h"

@interface BaseLandScreenViewController ()

@end

@implementation BaseLandScreenViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(BOOL)shouldAutorotate{
    return [self.topViewController shouldAutorotate];
}

-(UIInterfaceOrientationMask)supportedInterfaceOrientations{
    return  [self.topViewController supportedInterfaceOrientations];
}


@end
