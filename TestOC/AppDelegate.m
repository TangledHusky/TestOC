//
//  AppDelegate.m
//  TestOC
//
//  Created by 李亚军 on 16/8/3.
//  Copyright © 2016年 zyyj. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import "GCDBaseViewController.h"
#import "MainTabbarVC.h"
#import <JPFPSStatus.h>
#import "AFNetworking.h"
#import <arpa/inet.h>
#import <Bugly/Bugly.h>
//#import "ExceptionHandler.h"

@interface AppDelegate ()

@end

@implementation AppDelegate



void uncaughtExceptionHandler(NSException *exception)
{
    // 异常的堆栈信息
    NSArray *stackArray = [exception callStackSymbols];
    // 出现异常的原因
    NSString *reason = [exception reason];
    // 异常名称
    NSString *name = [exception name];
    NSString *exceptionInfo = [NSString stringWithFormat:@"Exception reason：%@\nException name：%@\nException stack：%@",name, reason, stackArray];
    NSLog(@"%@", exceptionInfo);
    
    NSMutableArray *tmpArr = [NSMutableArray arrayWithArray:stackArray];
    [tmpArr insertObject:reason atIndex:0];
    
    //保存到本地  --  当然你可以在下次启动的时候，上传这个log
    [exceptionInfo writeToFile:[NSString stringWithFormat:@"%@/Documents/error.log",NSHomeDirectory()]  atomically:YES encoding:NSUTF8StringEncoding error:nil];
    
    [[NSUserDefaults standardUserDefaults] setObject:@"123" forKey:@"testtest"];
    [[NSUserDefaults standardUserDefaults] synchronize];

}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    [Bugly startWithAppId:@"0a140ad788"];
    [Bugly setUserIdentifier:@"123"];
    
    NSSetUncaughtExceptionHandler(&uncaughtExceptionHandler);
    
    MainTabbarVC *main = [MainTabbarVC new];
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.rootViewController = main;
    [self.window makeKeyAndVisible];
    
    //检测fps
    #if defined(DEBUG)||defined(_DEBUG)
        [[JPFPSStatus sharedInstance] open];
    #endif
    
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    [[AFNetworkReachabilityManager sharedManager ] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
            case -1:
                NSLog(@"未知网络");
                break;
            case 0:
                NSLog(@"网络不可达");
                break;
            case 1:
                NSLog(@"GPRS网络");
                break;
            case 2:
                NSLog(@"wifi网络");
                break;
            default:
                break;
        }
        if(status ==AFNetworkReachabilityStatusReachableViaWWAN || status == AFNetworkReachabilityStatusReachableViaWiFi)
        {
            [self socketReachabilityTest];
            
            
        }else
        {
            NSLog(@"没有网");
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"网络失去连接" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:nil, nil];
            alert.delegate = self;
            [alert show];
        }
    }];
    
        
    return YES;
}

/// 服务器可达返回true
- (void)socketReachabilityTest {
    int socketNumber = socket(AF_INET, SOCK_STREAM, 0);
    // 配置服务器端套接字
    struct sockaddr_in serverAddress;
    // 设置服务器ipv4
    serverAddress.sin_family = AF_INET;
    // 百度的ip
    serverAddress.sin_addr.s_addr = inet_addr("202.108.22.5");
    // 设置端口号，HTTP默认80端口
    serverAddress.sin_port = htons(80);
    __block result = true;

    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        // 客户端 AF_INET:ipv4  SOCK_STREAM:TCP链接
        if (connect(socketNumber, (const struct sockaddr *)&serverAddress, sizeof(serverAddress)) == 0) {
            result = true;
            NSLog(@"you wang");
        }else{
            result = false;
            NSLog(@"no wang");
        }
        close(socketNumber);;
        
        
    
    });
    
    
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

-(BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url{
    if (!url) {
        return  NO;
    }
    
    NSString *urlStr = url.absoluteString;
    NSLog(@"handleOpenURL:%@",urlStr);
    
    return YES;
}



@end
