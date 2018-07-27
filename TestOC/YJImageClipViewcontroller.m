//
//  YJImageClipViewcontroller.m
//  TestOC
//
//  Created by liyajun on 2018/7/25.
//  Copyright © 2018年 zyyj. All rights reserved.
//

#import "YJImageClipViewcontroller.h"
#import "YJImageActionViewController.h"

@interface YJImageClipViewcontroller ()<UIImagePickerControllerDelegate>

@end


@implementation YJImageClipViewcontroller

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"照片裁剪";
    [self setBtn];
}


-(void)setBtn{
    
    UIButton *btnTakePhoto = [[UIButton alloc] initWithFrame:CGRectMake(100, 100, 100, 40)];
    btnTakePhoto.backgroundColor = [UIColor blackColor];
    [btnTakePhoto setTitle:@"拍照" forState:UIControlStateNormal];
    [btnTakePhoto setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btnTakePhoto.titleLabel.font = [UIFont systemFontOfSize:40];
    [btnTakePhoto addTarget:self action:@selector(takePhoto) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnTakePhoto];
    
    UIButton *btnSelectPhoto = [[UIButton alloc] initWithFrame:CGRectMake(100, 200, 100, 40)];
    btnSelectPhoto.backgroundColor = [UIColor blackColor];
    [btnSelectPhoto setTitle:@"相册" forState:UIControlStateNormal];
    [btnSelectPhoto setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btnSelectPhoto.titleLabel.font = [UIFont systemFontOfSize:40];
    [btnSelectPhoto addTarget:self action:@selector(selectPhoto) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnSelectPhoto];

}

-(void)takePhoto{
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
    imagePicker.sourceType = sourceType;
    imagePicker.delegate = self;
    [self presentViewController: imagePicker animated:YES completion: NULL];
}

-(void)selectPhoto{
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    imagePicker.sourceType = sourceType;
    imagePicker.delegate = self;
    [self presentViewController: imagePicker animated:YES completion: NULL];
}

#pragma mark - UIImagePickerDelegate
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    UIImage *toCropImage = info[UIImagePickerControllerOriginalImage];
    [self actionImage: toCropImage];
    [picker dismissViewControllerAnimated: YES completion: NULL];
}


- (void)actionImage: (UIImage *)image {
    
    YJImageActionViewController *cropImageViewController = [[YJImageActionViewController alloc] init];
    cropImageViewController.image = image;
    [self.navigationController pushViewController: cropImageViewController animated: YES];
    
}
@end
