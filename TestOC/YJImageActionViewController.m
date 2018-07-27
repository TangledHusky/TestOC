//
//  YJImageActionViewController.m
//  TestOC
//
//  Created by liyajun on 2018/7/25.
//  Copyright © 2018年 zyyj. All rights reserved.
//

#import "YJImageActionViewController.h"
#import "TKImageView.h"

@interface YJImageActionViewController ()<TKImageViewDelegate>

@property (nonatomic,strong) TKImageView  *tkImageView;
@property (nonatomic,strong) UIImageView  *resImage;    //显示结果图片
@property (nonatomic,strong) UIButton *btnOK;
@property (nonatomic,strong) UIButton *btnCancel;

@end

@implementation YJImageActionViewController

-(UIImageView *)resImage{
    if(_resImage==nil){
        _resImage=[UIImageView new];
        _resImage.frame = self.view.bounds;
        _resImage.contentMode = UIViewContentModeScaleAspectFit;
    }
    return  _resImage;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.navigationController.navigationBarHidden = YES;
    
    [self setUpTKImageView];
    
    [self addBottom];
}

- (void)setUpTKImageView {
    self.tkImageView = [[TKImageView alloc] initWithFrame:self.view.bounds];
    _tkImageView.toCropImage = _image;          //设置底图（必须属性!）
    
    _tkImageView.needScaleCrop = YES;           //允许手指捏和缩放裁剪框
    _tkImageView.showInsideCropButton = YES;    //允许内部裁剪按钮
    _tkImageView.btnCropWH = 30;                //内部裁剪按钮宽高，有默认值，不设也没事
    _tkImageView.delegate = self;               //需要实现内部裁剪代理事件
    [self.view addSubview:_tkImageView];
    
}

-(void) addBottom {
    self.btnOK = [[UIButton alloc] initWithFrame:CGRectMake(100, KScreenHeight - 40, 40, 40)];
    _btnOK.backgroundColor = [UIColor blackColor];
    [_btnOK setImage:[UIImage imageNamed:@"icon_gou"] forState:UIControlStateNormal];
    [_btnOK setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _btnOK.titleLabel.font = [UIFont systemFontOfSize:40];
    [_btnOK addTarget:self action:@selector(clickOkBtn) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_btnOK];
    
    self.btnCancel = [[UIButton alloc] initWithFrame:CGRectMake( 220, KScreenHeight - 40, 40, 40)];
    _btnCancel.backgroundColor = [UIColor blackColor];
    [_btnCancel setImage:[UIImage imageNamed:@"icon_cha"] forState:UIControlStateNormal];
    [_btnCancel setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _btnCancel.titleLabel.font = [UIFont systemFontOfSize:40];
    [_btnCancel addTarget:self action:@selector(clickCancelBtn) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_btnCancel];
}

-(void) clickOkBtn{
    self.resImage.image = _tkImageView.currentCroppedImage;
    [self.view addSubview:_resImage];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        _resImage.removeFromSuperview;
    });
}

-(void) clickCancelBtn{
   [self.navigationController popViewControllerAnimated: YES];
}


#pragma mark - 裁剪代理事件
-(void)TKImageViewFinish:(UIImage *)cropImage{
    self.resImage.image = cropImage;
    [self.view addSubview:_resImage];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        _resImage.removeFromSuperview;
    });
}

-(void)TKImageViewCancel{
    [self clickCancelBtn];
}

@end
