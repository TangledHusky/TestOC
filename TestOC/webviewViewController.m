//
//  webviewViewController.m
//  TestOC
//
//  Created by 李亚军 on 2017/1/17.
//  Copyright © 2017年 zyyj. All rights reserved.
//

#import "webviewViewController.h"
#import "WebviewProgressLine.h"

@interface webviewViewController ()<UIWebViewDelegate>
@property (nonatomic,strong) UIWebView  *webview;
@property (nonatomic,strong) WebviewProgressLine  *progressLine;

@end

@implementation webviewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.webview = [[UIWebView alloc] initWithFrame:self.view.frame];
    self.webview.delegate = self;
    [self.view addSubview:self.webview];
    
    self.progressLine = [[WebviewProgressLine alloc] initWithFrame:CGRectMake(0, 64, KScreenWidth, 3)];
    self.progressLine.lineColor = [UIColor redColor];
    [self.view addSubview:self.progressLine];
    
    
    NSURL *url = [NSURL URLWithString:@"https://www.baidu.com"];
    [self.webview loadRequest:[NSURLRequest requestWithURL:url]];
    
}

-(void)webViewDidStartLoad:(UIWebView *)webView{
    [self.progressLine startLoadingAnimation];
}

-(void)webViewDidFinishLoad:(UIWebView *)webView{
    [self.progressLine endLoadingAnimation];
}

-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    [self.progressLine endLoadingAnimation];
}

@end
