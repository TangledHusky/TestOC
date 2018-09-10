//
//  WKLoadHtmlViewController.m
//  TestOC
//
//  Created by liyajun on 2018/9/5.
//  Copyright © 2018年 zyyj. All rights reserved.
//


/*
 
 需求：
 当我们需要加载一段自拼接html时，如果css样式没写在里面，而在外面引用.css文件
 
 1、.css文件在项目里：loadBundle
 2、.css文件在沙盒目录下：loadLocal(比如css文件直接放在documents下)
 
 我们只要指定baseurl，然后html的link css路径，基于这个路径引用即可。
 */

#import "WKLoadHtmlViewController.h"
#import <WebKit/WebKit.h>

@interface WKLoadHtmlViewController ()

@property (nonatomic,strong) WKWebView  *webView;
@end

@implementation WKLoadHtmlViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    _webView = [[WKWebView alloc] initWithFrame:self.view.bounds];
  
    [self.view addSubview:_webView];
  
    
//    [self loadLocal];
    
    [self loadBundle];
}

-(void) loadBundle{
    NSMutableString *html = [NSMutableString string];
    [html appendString:@"<html><head>"];
    [html appendFormat:@"<link rel=\"stylesheet\" href=\"testwai.css\"></head>"];
    [html appendString:@"<body><p>qfdkjeakofjadfdsjf</p></body></html>"];
    
    NSURL *myUrl = [NSURL fileURLWithPath:[NSBundle mainBundle].bundlePath];
    [_webView loadHTMLString:html baseURL:myUrl];
    
}

-(void) loadLocal{
    NSMutableString *html = [NSMutableString string];
    [html appendString:@"<html><head>"];
    [html appendFormat:@"<link rel=\"stylesheet\" href=\"testwai.css\"></head>"];
    [html appendString:@"<body><p>qfdkjeakofjadfdsjf</p></body></html>"];
    
    NSString *cssUrl = [NSString stringWithFormat:@"%@",NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)];
    NSURL *myUrl = [NSURL fileURLWithPath:cssUrl];
    [_webView loadHTMLString:html baseURL:myUrl];
    
}

- (void)dealloc {
    // if you have set either WKWebView delegate also set these to nil here

}

@end
