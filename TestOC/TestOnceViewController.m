//
//  TestOnceViewController.m
//  TestOC
//
//  Created by 李亚军 on 2017/2/22.
//  Copyright © 2017年 zyyj. All rights reserved.
//

#import "TestOnceViewController.h"

typedef NS_ENUM(NSUInteger,ModeType){
        ModeType1,
        ModeType2
    
};

@interface TestOnceViewController ()

@property (nonatomic,copy) NSMutableString *name;

@end

@implementation TestOnceViewController{
    UILabel *label;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
  
    label = [[UILabel alloc] init];
    label.frame = CGRectMake(100, 100, 150, 30);
    label.textColor = [UIColor redColor];
    label.text = @"lager max";
    [self.view addSubview:label];
    
    
    
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self testLabel];
}



/**
 动画更改label文字
 */
-(void)testLabel{
    NSInteger vv = arc4random_uniform(3);
    NSLog(@"%ld", (long)vv);
    switch (vv) {
        case 0:{
            CATransition *animation = [CATransition animation];
            animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
            animation.type = kCATransitionFade;
            animation.duration = 0.75;
            [label.layer addAnimation:animation forKey:@"kCATransitionFade"];
            label.text = @"New";
        }
            break;
        case 1:{
            [UIView transitionWithView:label duration:0.5 options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
                label.text = @"well done";
            } completion:nil];}
            break;
            
        case 2:{
            [UIView animateWithDuration:1.0 animations:^{
                label.alpha = 0;
                label.text = @"new text";
                label.alpha = 1.0;
            }];}
            break;
        default:
            break;
    }
    
    
    
}

@end
