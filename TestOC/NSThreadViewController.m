//
//  NSThreadViewController.m
//  TestOC
//
//  Created by 李亚军 on 2017/1/12.
//  Copyright © 2017年 zyyj. All rights reserved.
//

#import "NSThreadViewController.h"

@interface NSThreadViewController ()
@property (nonatomic,assign) NSUInteger  ticketCount;


@end

@implementation NSThreadViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    _ticketCount = 10;
    
    UIButton *btn1 = [[UIButton alloc] initWithFrame:CGRectMake(50, 100, 300, 30)];
    [btn1 setTitle:@"模拟多线程卖票，加锁" forState:UIControlStateNormal];
    btn1.backgroundColor = [UIColor grayColor];
    [btn1 addTarget:self action:@selector(sailTicket) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn1];

    UIButton *btn2 = [[UIButton alloc] initWithFrame:CGRectMake(50, 140, 300, 30)];
    [btn2 setTitle:@"下载图片，主线程显示" forState:UIControlStateNormal];
    btn2.backgroundColor = [UIColor grayColor];
    [btn2 addTarget:self action:@selector(downloadPic) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn2];

    [NSThread detachNewThreadSelector:@selector(downloadPic) toTarget:self withObject:nil];
}

- (void)sailTicket {
    NSThread *thread1 = [[NSThread alloc] initWithTarget:self selector:@selector(sale) object:nil];
    NSThread *thread2 = [[NSThread alloc] initWithTarget:self selector:@selector(sale) object:nil];
    NSThread *thread3 = [[NSThread alloc] initWithTarget:self selector:@selector(sale) object:nil];
    thread1.name = @"售票员1";
    thread2.name = @"售票员2";
    thread3.name = @"售票员3";
    [thread1 start];
    [thread2 start];
    [thread3 start];
    
}

-(void)sale{
    while (1) {
//        @synchronized (self) {
//            for (int i = 0; i<10000; i++) {
//                //模拟延迟
//            }
//            
//            if (_ticketCount>0){
//                _ticketCount--;
//                NSLog(@"%@卖出了一张票，余票还有%lu",[NSThread currentThread].name,(unsigned long)_ticketCount);
//            }else{
//                NSLog(@"票已售完");
//                break;
//            }
//        }

        for (int i = 0; i<10000; i++) {
            //模拟延迟
        }
        
        if (_ticketCount>0){
            _ticketCount--;
            NSLog(@"%@卖出了一张票，余票还有%lu",[NSThread currentThread].name,(unsigned long)_ticketCount);
        }else{
            NSLog(@"票已售完");
            break;
        }
    }
    
    
}


-(void)downloadPic{
    NSURL *url = [NSURL URLWithString:@"https://res.wx.qq.com/mpres/htmledition/images/mp_qrcode218877.gif"];
    NSData *pic = [NSData dataWithContentsOfURL:url];
    UIImage *img = [UIImage imageWithData:pic];
    
    [self performSelectorOnMainThread:@selector(showImg:) withObject:img waitUntilDone:YES];
}

-(void)showImg:(UIImage *)image{
    //imageView.image = image
    NSLog(@"显示 pic");
}

@end
