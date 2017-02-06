//
//  DeepCopyViewController.m
//  TestOC
//
//  Created by 李亚军 on 2016/12/23.
//  Copyright © 2016年 zyyj. All rights reserved.
//

#import "DeepCopyViewController.h"

@interface DeepCopyViewController ()

@end

@implementation DeepCopyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self testDeepCopy];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/**
 <#Description#>
 */
-(void)testDeepCopy{
    //    NSMutableArray *arry = [NSMutableArray arrayWithObjects:@"1",@"2",@"3", nil];
    //    NSArray *arry2 = [arry copy];   //内容拷贝
    //    NSLog(@"arry2:%@\narr:%@", arry2,arry);
    //    //[arry removeObjectAtIndex:1];
    //    arry[0] = @"11";
    //    NSLog(@"arry2:%@\narr:%@", arry2,arry);
    //
    NSMutableArray *arry = [NSMutableArray arrayWithObjects:@"1",@"2",@"3", nil];
    NSArray *arry2 = arry;   //内容拷贝
    NSLog(@"arry2:%@\narr:%@", arry2,arry);
    //[arry removeObjectAtIndex:1];
    arry[0] = @"11";
    NSLog(@"arry2:%@\narr:%@", arry2,arry);
    
    
    NSString *str = @"123";
    NSString *strCopy = [str copy];
    NSLog(@"strCopy:%@",strCopy);
    str = @"456";
    NSLog(@"strCopy:%@",strCopy);
    
    NSString *ss = str;
    NSString *ssNew = ss;
    NSLog(@"ssNew:%@",ssNew);
    ss = @"asd";
    NSLog(@"ssNew:%@",ssNew);
}

@end
