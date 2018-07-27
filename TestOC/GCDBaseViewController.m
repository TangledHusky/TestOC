//
//  GCDBaseViewController.m
//  TestOC
//
//  Created by 李亚军 on 2017/1/10.
//  Copyright © 2017年 zyyj. All rights reserved.
//

#import "GCDBaseViewController.h"

@interface GCDBaseViewController ()

@end

@implementation GCDBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton *btn1 = [[UIButton alloc] initWithFrame:CGRectMake(100, 100, 100, 30)];
    [btn1 setTitle:@"异步并发" forState:UIControlStateNormal];
    btn1.backgroundColor = [UIColor grayColor];
    [btn1 addTarget:self action:@selector(ybbf) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn1];
    
    UIButton *btn11 = [[UIButton alloc] initWithFrame:CGRectMake(100, 140, 100, 30)];
    [btn11 setTitle:@"异步串行" forState:UIControlStateNormal];
    btn11.backgroundColor = [UIColor grayColor];
    [btn11 addTarget:self action:@selector(ybcx) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn11];
    
    UIButton *btn111 = [[UIButton alloc] initWithFrame:CGRectMake(100, 180, 100, 30)];
    [btn111 setTitle:@"同步并发" forState:UIControlStateNormal];
    btn111.backgroundColor = [UIColor grayColor];
    [btn111 addTarget:self action:@selector(tbbf) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn111];
    
    UIButton *btn1111 = [[UIButton alloc] initWithFrame:CGRectMake(100, 220, 100, 30)];
    [btn1111 setTitle:@"同步串行" forState:UIControlStateNormal];
    btn1111.backgroundColor = [UIColor grayColor];
    [btn1111 addTarget:self action:@selector(tbcx) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn1111];
    
    UIButton *btngroup = [[UIButton alloc] initWithFrame:CGRectMake(50, 260, 300, 30)];
    [btngroup setTitle:@"两个并行任务执行完，再执行主线程" forState:UIControlStateNormal];
    btngroup.backgroundColor = [UIColor grayColor];
    [btngroup addTarget:self action:@selector(disGroup) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btngroup];
    
    UIButton *btngroupEnter = [[UIButton alloc] initWithFrame:CGRectMake(50, 300, 300, 30)];
    [btngroupEnter setTitle:@"groupEnter+leave" forState:UIControlStateNormal];
    btngroupEnter.backgroundColor = [UIColor grayColor];
    [btngroupEnter addTarget:self action:@selector(disGroupEnterAndLeave) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btngroupEnter];

    UIButton *btngroupSemaphore = [[UIButton alloc] initWithFrame:CGRectMake(50, 340, 300, 30)];
    [btngroupSemaphore setTitle:@"group信号量使用" forState:UIControlStateNormal];
    btngroupSemaphore.backgroundColor = [UIColor grayColor];
    [btngroupSemaphore addTarget:self action:@selector(dispatchSignal) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btngroupSemaphore];

    
//    //1、异步并发
//    [self ybbf];
//    
//    
//    //2、异步串行
//    [self ybcx];
//    
//    //3、同步并发
//    [self tbbf];
//    
//    //4、同步串行
//    [self tbcx];
    
}

//异步并发
-(void)ybbf{
    //获取全局并发队列
    dispatch_queue_t queue =  dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    //2.添加任务到队列中，就可以执行任务
    dispatch_async(queue, ^{
       NSLog(@"下载图片1----%@",[NSThread currentThread]);
       });
    dispatch_async(queue, ^{
       NSLog(@"下载图片2----%@",[NSThread currentThread]);
           });
    dispatch_async(queue, ^{
       NSLog(@"下载图片3----%@",[NSThread currentThread]);
        });
    //打印主线程
    NSLog(@"主线程----%@",[NSThread mainThread]);
    
}

//异步串行
-(void)ybcx{
    //创建一个队列，queneName不要加@，这里用c写法
    dispatch_queue_t queue =  dispatch_queue_create("queneName", NULL);
    //2.添加任务到队列中，就可以执行任务
    dispatch_async(queue, ^{
        NSLog(@"下载图片1----%@",[NSThread currentThread]);
    });
    dispatch_async(queue, ^{
        NSLog(@"下载图片2----%@",[NSThread currentThread]);
    });
    dispatch_async(queue, ^{
        NSLog(@"下载图片3----%@",[NSThread currentThread]);
    });
    //打印主线程
    NSLog(@"主线程----%@",[NSThread mainThread]);
    
}

//同步并发
-(void)tbbf{
    //获取全局并发队列
    dispatch_queue_t queue =  dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    //2.添加任务到队列中，就可以执行任务
    dispatch_sync(queue, ^{
        NSLog(@"下载图片1----%@",[NSThread currentThread]);
    });
    dispatch_sync(queue, ^{
        NSLog(@"下载图片2----%@",[NSThread currentThread]);
    });
    dispatch_sync(queue, ^{
        NSLog(@"下载图片3----%@",[NSThread currentThread]);
    });
    //打印主线程
    NSLog(@"主线程----%@",[NSThread mainThread]);
    
}

//同步串行
-(void)tbcx{
    //创建一个队列，queneName不要加@，这里用c写法
    dispatch_queue_t queue =  dispatch_queue_create("queneName", NULL);
    //2.添加任务到队列中，就可以执行任务
    dispatch_sync(queue, ^{
        NSLog(@"下载图片1----%@",[NSThread currentThread]);
    });
    dispatch_sync(queue, ^{
        NSLog(@"下载图片2----%@",[NSThread currentThread]);
    });
    dispatch_sync(queue, ^{
        NSLog(@"下载图片3----%@",[NSThread currentThread]);
    });
    //打印主线程
    NSLog(@"主线程----%@",[NSThread mainThread]);
    
    
}

-(void)disGroup{
    dispatch_queue_t globalQuene = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_queue_t selfQuene = dispatch_queue_create("myQuene", 0);
    dispatch_group_t group = dispatch_group_create();
    dispatch_group_async(group, globalQuene, ^{
        NSLog(@"run task 1");
    });
    dispatch_group_async(group, selfQuene, ^{
        NSLog(@"run task 2");
    });
    dispatch_group_async(group, selfQuene, ^{
        NSLog(@"run task 3");
    });
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        NSLog(@"run task 4");
    });
    
    
    
}

-(void)disGroupEnterAndLeave{
    dispatch_queue_t globalQuene = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_group_t group = dispatch_group_create();
    
    //任务1
    dispatch_group_enter(group);
    dispatch_async(globalQuene, ^{
         NSLog(@"run task 1");
        sleep(1);
        dispatch_group_leave(group);
    });
    
    //任务2
    dispatch_group_enter(group);
    dispatch_async(globalQuene, ^{
        NSLog(@"run task 2");
        sleep(2);
        dispatch_group_leave(group);
    });
    
    //任务3
    dispatch_group_enter(group);
    dispatch_async(globalQuene, ^{
        NSLog(@"run task 3");
        sleep(3);
        dispatch_group_leave(group);
    });
    
    //一直等待完成
    dispatch_group_wait(group, DISPATCH_TIME_FOREVER);
  
    //任务3
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        NSLog(@"run task 4");
    });
    
    
    
}


/**
 简单来说就是控制访问资源的数量：比如系统有两个资源可以被利用，同时有三个线程要访问，只能允许两个线程访问，第三个应当等待资源被释放后再访问。
 */
-(void)dispatchSignal{
    //crate的value表示，最多几个资源可访问
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(2);
    
    dispatch_queue_t quene = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    //任务1
    dispatch_async(quene, ^{
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
        NSLog(@"run task 1");
        sleep(1);
        NSLog(@"complete task 1");
        dispatch_semaphore_signal(semaphore);
        
    });
    //任务2
    dispatch_async(quene, ^{
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
        NSLog(@"run task 2");
        sleep(2);
        NSLog(@"complete task 2");
        dispatch_semaphore_signal(semaphore);
        
    });
    //任务3
    dispatch_async(quene, ^{
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
        NSLog(@"run task 3");
        sleep(1);
        NSLog(@"complete task 3");
        dispatch_semaphore_signal(semaphore);
        
    });
    
    
}



@end
