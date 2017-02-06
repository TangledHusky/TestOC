//
//  MainTabbar.m
//  TestOC
//
//  Created by 李亚军 on 2017/1/13.
//  Copyright © 2017年 zyyj. All rights reserved.
//

#import "MainTabbarVC.h"
#import "ViewController.h"

@interface MainTabbarVC ()<UITabBarControllerDelegate>
@property (nonatomic,assign) NSInteger  indexFlag;
@end

@implementation MainTabbarVC

-(instancetype)init{
    self = [super init];
    if (self) {
        self.indexFlag = 0;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    [self setChildNav:@"v2_home" selectedImg:@"v2_home_r" title:@"首页"];
    [self setChildNav:@"v2_order" selectedImg:@"v2_order_r" title:@"订单"];
    [self setChildNav:@"shopCart" selectedImg:@"shopCart_r" title:@"购物车"];
    [self setChildNav:@"v2_my" selectedImg:@"v2_my_r" title:@"我"];
    
}

-(void)setChildNav:(NSString *)img selectedImg:(NSString *)selectedImg title:(NSString *)title{
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:[[ViewController alloc] init]];
    [nav.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:YJColor(254, 213, 48)} forState:UIControlStateSelected];
    nav.navigationItem.title = title;
    nav.tabBarItem.title = title;
    nav.tabBarItem.image = [[UIImage imageNamed:img] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    nav.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImg] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [self addChildViewController:nav];

}


-(void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item{
    NSInteger index = [self.tabBar.items indexOfObject:item];
    if (index != self.indexFlag) {
        //执行动画
        NSMutableArray *arry = [NSMutableArray array];
        for (UIView *btn in self.tabBar.subviews) {
            if ([btn isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
                 [arry addObject:btn];
            }
        }
        //放大效果，并回到原位
        CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
        //速度控制函数，控制动画运行的节奏
        animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        animation.duration = 0.2;       //执行时间
        animation.repeatCount = 1;      //执行次数
        animation.autoreverses = YES;    //完成动画后会回到执行动画之前的状态
        animation.fromValue = [NSNumber numberWithFloat:0.7];   //初始伸缩倍数
        animation.toValue = [NSNumber numberWithFloat:1.3];     //结束伸缩倍数
        [[arry[index] layer] addAnimation:animation forKey:nil];
        
        self.indexFlag = index;
    }
}


//        //z轴旋转180度
//        CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
//        //速度控制函数，控制动画运行的节奏
//        animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
//        animation.duration = 0.2;       //执行时间
//        animation.repeatCount = 1;      //执行次数
//        animation.removedOnCompletion = YES;
//        animation.fromValue = [NSNumber numberWithFloat:0];   //初始伸缩倍数
//        animation.toValue = [NSNumber numberWithFloat:M_PI];     //结束伸缩倍数
//        [[arry[index] layer] addAnimation:animation forKey:nil];

////向上移动
//CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.translation.y"];
////速度控制函数，控制动画运行的节奏
//animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
//animation.duration = 0.2;       //执行时间
//animation.repeatCount = 1;      //执行次数
//animation.removedOnCompletion = YES;
//animation.fromValue = [NSNumber numberWithFloat:0];   //初始伸缩倍数
//animation.toValue = [NSNumber numberWithFloat:-10];     //结束伸缩倍数
//[[arry[index] layer] addAnimation:animation forKey:nil];

////放大效果
//CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
////速度控制函数，控制动画运行的节奏
//animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
//animation.duration = 0.2;       //执行时间
//animation.repeatCount = 1;      //执行次数
//animation.removedOnCompletion = NO;
//animation.fillMode = kCAFillModeForwards;           //保证动画效果延续
//animation.fromValue = [NSNumber numberWithFloat:1.0];   //初始伸缩倍数
//animation.toValue = [NSNumber numberWithFloat:1.15];     //结束伸缩倍数
//[[arry[index] layer] addAnimation:animation forKey:nil];
////移除其他tabbar的动画
//for (int i = 0; i<arry.count; i++) {
//    if (i != index) {
//        [[arry[i] layer] removeAllAnimations];
//    }
//}
//



@end
