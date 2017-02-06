//
//  JBSViewController.m
//  TestOC
//
//  Created by 李亚军 on 2016/12/27.
//  Copyright © 2016年 zyyj. All rights reserved.
//

#import "JBSViewController.h"

typedef NS_ENUM(NSUInteger, GradientType) {
    GradientTypeTopToBottom = 0,//从上到下
    GradientTypeLeftToRight = 1,//从左到右
};

@interface JBSViewController ()

@end

@implementation JBSViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    
//    1、CAGradientLayer
    UILabel *lbl1 = [[UILabel alloc] initWithFrame:CGRectMake(0,0, KScreenWidth, 20)];
    lbl1.center = CGPointMake(KScreenWidth/2, 90);
    lbl1.text = @"添加layer实现";
    [self.view addSubview:lbl1];
    [self createByCAGradientLayer:YJColor(54, 221, 255) endColor:YJColor(35, 221, 195) layerFrame:CGRectMake(0, 110, KScreenWidth, 44) direction:GradientTypeTopToBottom];
    [self createByCAGradientLayer:YJColor(54, 221, 255) endColor:YJColor(35, 221, 195) layerFrame:CGRectMake(0, 160, KScreenWidth, 44) direction:GradientTypeLeftToRight];
    
    
    //   2、CGGradientRef
    UILabel *lbl2 = [[UILabel alloc] initWithFrame:CGRectMake(0,0, KScreenWidth, 20)];
    lbl2.center = CGPointMake(KScreenWidth/2, 250);
    lbl2.text = @"返回image实现";
    [self.view addSubview:lbl2];
    UIView *v2 = [[UIView alloc] initWithFrame:CGRectMake(0,0, KScreenWidth, 44)];
    v2.center = CGPointMake(KScreenWidth/2, 290);
    v2.backgroundColor = [UIColor colorWithPatternImage:[self getGradientImageFromColors:@[YJColor(54, 221, 255),YJColor(35, 221, 195)] gradientType:GradientTypeTopToBottom imgSize:CGSizeMake(KScreenWidth, 44)]];
    [self.view addSubview:v2];
    
}


-(void)createByCAGradientLayer:(UIColor *)startColor endColor:(UIColor *)endColor layerFrame:(CGRect)frame direction:(GradientType)direction{

    CAGradientLayer *layer = [CAGradientLayer new];
    //存放渐变的颜色的数组
    layer.colors = @[(__bridge id)startColor.CGColor, (__bridge id)endColor.CGColor];
    //渐变颜色的分割点(0-1)
    //layer.locations = @[@0.3,@0.5,@1.0];  //加了感觉不对了。。。
    //起点和终点表示的坐标系位置，(0,0)表示左上角，(1,1)表示右下角
    switch (direction) {
        case GradientTypeTopToBottom:
            layer.startPoint = CGPointMake(0.0, 0.0);
            layer.endPoint = CGPointMake(0.0, 1);
            break;
        case GradientTypeLeftToRight:
            layer.startPoint = CGPointMake(0.0, 0.0);
            layer.endPoint = CGPointMake(1, 0.0);
            break;
        default:
            break;
    }

    layer.frame = frame;
    [self.view.layer addSublayer:layer];
    
}

- (UIImage *)getGradientImageFromColors:(NSArray*)colors gradientType:(GradientType)gradientType imgSize:(CGSize)imgSize {
    NSMutableArray *ar = [NSMutableArray array];
    for(UIColor *c in colors) {
        [ar addObject:(id)c.CGColor];
    }
    UIGraphicsBeginImageContextWithOptions(imgSize, YES, 1);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    CGColorSpaceRef colorSpace = CGColorGetColorSpace([[colors lastObject] CGColor]);
    CGGradientRef gradient = CGGradientCreateWithColors(colorSpace, (CFArrayRef)ar, NULL);
    CGPoint start;
    CGPoint end;
    switch (gradientType) {
        case GradientTypeTopToBottom:
            start = CGPointMake(0.0, 0.0);
            end = CGPointMake(0.0, imgSize.height);
            break;
        case GradientTypeLeftToRight:
            start = CGPointMake(0.0, 0.0);
            end = CGPointMake(imgSize.width, 0.0);
            break;
        default:
            break;
    }
    CGContextDrawLinearGradient(context, gradient, start, end, kCGGradientDrawsBeforeStartLocation | kCGGradientDrawsAfterEndLocation);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    CGGradientRelease(gradient);
    CGContextRestoreGState(context);
    CGColorSpaceRelease(colorSpace);
    UIGraphicsEndImageContext();
    return image;
}

@end
