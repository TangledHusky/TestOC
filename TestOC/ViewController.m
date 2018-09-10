//
//  ViewController.m
//  TestOC
//
//  Created by 李亚军 on 16/8/3.
//  Copyright © 2016年 zyyj. All rights reserved.
//

#import "ViewController.h"
#import "MJRefresh.h"
#import "AppDelegate.h"

#import "DeepCopyViewController.h"
#import "FDTemplateViewController.h"
#import "TestAVPlayerViewController.h"
#import "TestZFPlayerViewController.h"
#import "JBSViewController.h"
#import "LandScreenViewController.h"
#import "FMDBViewController.h"
#import "OpenURLViewController.h"
#import "GCDBaseViewController.h"
#import "NSThreadViewController.h"
#import "WKWebViewViewController.h"
#import "webviewViewController.h"
#import "TestXibViewController.h"
#import "PicEditViewController.h"
#import "JSBridgeVC.h"
#import "BaiBanViewController.h"
#import "TestOnceViewController.h"
#import "TestCornerTableViewController.h"
#import "TestBuglyViewController.h"
#import "YJImageClipViewcontroller.h"
#import "WKLoadHtmlViewController.h"


@interface ViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,assign,getter=isnormal) BOOL  isNormalOrientation;

@end

@implementation ViewController{
    UITableView *mytableview;
    NSMutableArray *dataArry;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"OC测试";
    
    _isNormalOrientation = false;
    
    dataArry = [NSMutableArray arrayWithObjects:
                @"深浅拷贝测试",
                @"FDTemplateLayoutCell测试",
                @"AVPlayer视频播放 ZFPlayer",
                @"渐变色3种方式",
                @"---通用测试，即用即删-----",
                @"测试横屏 present",
                @"FMDB-建库-建表-增删改",
                @"openURL-打电话、短信、邮件",
                @"GCD基础篇",
                @"NSThread",
                @"WKWebviw进度条",
                @"UIWebviw进度条",
                @"xib到试图显示之间的方法调用",
                @"图片添加水印",
                @"WebViewJavascriptBridge测试",
                @"白板绘画",
                @"测试圆角性能",
                @"bugly集成测试",
                @"照片裁剪",
                @"wkwebview loadHTMLString用外部样式",
                nil];
    
    mytableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, KScreenHeight-64) style:UITableViewStylePlain];
    mytableview.delegate = self;
    mytableview.dataSource = self;
    [self.view addSubview:mytableview];
}


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
//    //默认选中第一行，并执行点击事件
//    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
//    [mytableview selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:YES scrollPosition:UITableViewScrollPositionTop];
//    if ([mytableview.delegate respondsToSelector:@selector(tableView:didSelectRowAtIndexPath:)]) {
//        [mytableview.delegate tableView:mytableview didSelectRowAtIndexPath:indexPath];
//    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return dataArry.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        
        
    }
    cell.textLabel.text = [NSString stringWithFormat:@"%ld、%@",(long)indexPath.row+1,dataArry[indexPath.row]];
    
    return  cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.row) {
        case 0:{
            DeepCopyViewController *deep = [[DeepCopyViewController alloc] init];
            [self.navigationController pushViewController:deep animated:YES];
            break;
        }
        case 1:{
            FDTemplateViewController *fdt = [[FDTemplateViewController alloc] init];
            [self.navigationController pushViewController:fdt animated:YES];
            break;
        }
        case 2:{
//            TestAVPlayerViewController *avplayer = [[TestAVPlayerViewController alloc] initWithNibName:@"TestAVPlayerViewController" bundle:nil];
//            [self.navigationController pushViewController:avplayer animated:YES];
            TestZFPlayerViewController *zfplayer = [TestZFPlayerViewController new];
            [self.navigationController pushViewController:zfplayer animated:YES];
            break;
        }
        case 3:{
            JBSViewController *avplayer = [[JBSViewController alloc] init];
            [self.navigationController pushViewController:avplayer animated:YES];
            break;
        }
        case 4:{
//          ---通用测试，即用即删-----
            TestOnceViewController *once = [[TestOnceViewController alloc] init];
            [self.navigationController pushViewController:once animated:YES];
            
            break;
        }
        case 5:{
            LandScreenViewController *landScreen = [[LandScreenViewController alloc] init];
            landScreen.newPageType = NewPageTypePresent;
            [self presentViewController:landScreen animated:YES completion:nil];
            break;
        }
        case 6:{
            FMDBViewController *fmdb = [[FMDBViewController alloc] init];
            [self.navigationController pushViewController:fmdb animated:YES];
            break;
        }
        case 7:{
            OpenURLViewController *openurl = [[OpenURLViewController alloc] init];
            [self.navigationController pushViewController:openurl animated:YES];
            break;
        }
        case 8:{
            GCDBaseViewController *gcdBase = [[GCDBaseViewController alloc] init];
            [self.navigationController pushViewController:gcdBase animated:YES];
            break;
        }
        case 9:{
            NSThreadViewController *thread = [[NSThreadViewController alloc] init];
            [self.navigationController pushViewController:thread animated:YES];
            break;
        }
        case 10:{
            WKWebViewViewController *web = [[WKWebViewViewController alloc] init];
            [self.navigationController pushViewController:web animated:YES];
            break;
        }

        case 11:{
            webviewViewController *web = [[webviewViewController alloc] init];
            [self.navigationController pushViewController:web animated:YES];
            break;
        }
        case 12:{
//            TestXibViewController *web = [[TestXibViewController alloc] init];
//            [self.navigationController pushViewController:web animated:YES];
            
            TestXibViewController *xib = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"TestXibViewController"];
             [self.navigationController pushViewController:xib animated:YES];
            
            break;
        }
        case 13:{
            PicEditViewController *web = [[PicEditViewController alloc] init];
            [self.navigationController pushViewController:web animated:YES];
            break;
        }

        case 14:{
            JSBridgeVC *web = [[JSBridgeVC alloc] init];
            [self.navigationController pushViewController:web animated:YES];
            break;
        }
        case 15:{
            BaiBanViewController *web = [[BaiBanViewController alloc] init];
            web.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:web animated:YES];
            break;
        }
        case 16:{
            TestCornerTableViewController *web = [[TestCornerTableViewController alloc] init];
            web.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:web animated:YES];
            break;
        }

        case 17:{
            TestBuglyViewController *web = [[TestBuglyViewController alloc] init];
            web.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:web animated:YES];
            break;
        }
        case 18:{
            YJImageClipViewcontroller *web = [[YJImageClipViewcontroller alloc] init];
            web.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:web animated:YES];
            break;
        }
        case 19:{
            WKLoadHtmlViewController *web = [[WKLoadHtmlViewController alloc] init];
            web.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:web animated:YES];
            break;
        }

            
        default:
            break;
    }
}


-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1;
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    cell.transform = CGAffineTransformMakeScale(0.8, 0.8);
    [UIView animateWithDuration:0.3 animations:^{
        cell.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
        
    }];
}





@end
