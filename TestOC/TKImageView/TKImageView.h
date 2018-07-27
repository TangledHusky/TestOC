//
//  TKImageView.h
//  TKImageDemo
//
//  Created by yinyu on 16/7/10.
//  Copyright © 2016年 yinyu. All rights reserved.
//

#import <UIKit/UIKit.h>


/**
 裁剪按钮代理事件
 */
@protocol TKImageViewDelegate <NSObject>
- (void)TKImageViewFinish:(UIImage *)cropImage; //完成裁剪
- (void)TKImageViewCancel;      //取消裁剪
@end



@interface TKImageView : UIView
//需要裁剪的背景图
@property (strong, nonatomic) UIImage *toCropImage;

/* -----------------自定义属性--------------------------- */
//是否允许手指捏合,默认NO （如果需要，必须使用时设置yes）
@property (assign, nonatomic) BOOL needScaleCrop;

//是否允许拖动边框,默认yes
@property (assign, nonatomic) BOOL showMidLines;

//裁剪框的border宽度是否计算在裁剪框长宽里面，默认no，一般默认值即可。
@property (assign, nonatomic) BOOL cornerBorderInImage;

//是否显示内部的裁剪按钮，默认no （设置yes，会在裁剪框旁边显示裁剪和取消按钮）
//一般在ipone横屏或pad上使用时，放开这个比较好，不然iphone竖屏，屏幕太小，更适合外部设置裁剪按钮
@property (nonatomic,assign) BOOL  showInsideCropButton;

//裁剪框 宽高比（比如设置0.5，就是一个竖直的长方形），默认0（任意形状）
//注意：设置了这个，showMidLines就无效了=不能拖动边，只能拖角进行缩放
@property (assign, nonatomic) CGFloat cropAspectRatio;

//裁剪框最小间距，默认10
//注意：这里的最小要排除掉边角点击区域view的宽度，所以真实的最小裁剪框边长 = 2*cropAreaCornerWidth+minSpace）
@property (assign, nonatomic) CGFloat minSpace;

//初始裁剪框大小比例（用占比图片长宽比得出宽高）,默认0.5
@property (assign, nonatomic) CGFloat initialScaleFactor;

//遮罩层透明度，默认0.6
@property (assign, nonatomic) CGFloat maskAlpha;


/* -----------------颜色、宽度属性--------------------------- */
//裁剪边框颜色
@property (strong, nonatomic) UIColor *cropAreaBorderLineColor;
//裁剪边框宽度
@property (assign, nonatomic) CGFloat cropAreaBorderLineWidth;
//4个边角线颜色 （这个外贴着边角显示两条边）
@property (strong, nonatomic) UIColor *cropAreaCornerLineColor;
//4个边角线宽度
@property (assign, nonatomic) CGFloat cropAreaCornerLineWidth;
//4个边角点击区域宽度
@property (assign, nonatomic) CGFloat cropAreaCornerWidth;
//4个边角点击区域高度
@property (assign, nonatomic) CGFloat cropAreaCornerHeight;
//4条边中间显示的线宽（这个线外贴着边框线中间显示）
@property (assign, nonatomic) CGFloat cropAreaMidLineWidth;
//4条边中间显示的线高
@property (assign, nonatomic) CGFloat cropAreaMidLineHeight;
//4条边中间显示的线颜色
@property (strong, nonatomic) UIColor *cropAreaMidLineColor;
//裁剪按钮的宽高，默认：边角点击区域高宽（只有设置showInsideCropButton = yes 才有效）
@property (nonatomic, assign) CGFloat  btnCropWH;


/* -----------------获取截取图片--------------------------- */
//最终截取的图片
- (UIImage *)currentCroppedImage;


/* ----------------- 代理事件--------------------------- */
//裁剪按钮delegate
@property (nonatomic, assign)id<TKImageViewDelegate>delegate;
@end
