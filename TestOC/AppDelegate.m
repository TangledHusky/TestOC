//
//  AppDelegate.m
//  TestOC
//
//  Created by 李亚军 on 16/8/3.
//  Copyright © 2016年 zyyj. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import "BaseLandScreenViewController.h"
#import "GCDBaseViewController.h"
#import "MainTabbarVC.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    MainTabbarVC *main = [MainTabbarVC new];
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.rootViewController = main;
    [self.window makeKeyAndVisible];
    
   
    
    return YES;
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
