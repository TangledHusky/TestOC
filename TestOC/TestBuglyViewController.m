//
//  TestBuglyViewController.m
//  TestOC
//
//  Created by liyajun on 2017/8/16.
//  Copyright © 2017年 zyyj. All rights reserved.
//

#import "TestBuglyViewController.h"

@interface TestBuglyViewController ()

@end

@implementation TestBuglyViewController{
    UILabel *lbl;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self tsetArry];
    
    [self tsetUnselector];
    
}

-(void)tsetArry{
    NSArray *arry = @[@1,@2];
    NSLog(@"%@", arry[2]);
}

-(void)tsetUnselector{
    [lbl removeFromSuperview];
}

@end
