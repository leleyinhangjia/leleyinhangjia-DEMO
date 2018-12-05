//
//  ViewController.m
//  JavaScript
//
//  Created by tianbai on 16/6/8.
//  Copyright © 2016年 厦门乙科网络公司. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

-(void)viewDidAppear:(BOOL)animated{
//    self.webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 20, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
//    self.webView.delegate = self;
//    
//    NSString* path = [[NSBundle mainBundle] pathForResource:@"index" ofType:@"html"];
//    
//    NSURL* url = [NSURL fileURLWithPath:path];
//    NSURLRequest* request = [NSURLRequest requestWithURL:url] ;
//    [self.webView loadRequest:request];
//    [self.view addSubview:self.webView];
    
    
    UIWebView* webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 20, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    webView.scalesPageToFit = YES;//自动对页面进行缩放以适应屏幕
    [self.view addSubview:webView];
    webView.delegate=self;
    NSURL*url1=[NSURL URLWithString:@"http://weixin.cht360.com/letsgo/index.php/Home/Personal/zhifuchenggong"];

    NSURLRequest* request1 = [NSURLRequest requestWithURL:url1];//创建NSURLRequest
    [webView loadRequest:request1];//加载

}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    self.jsContext = [webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    self.jsContext[@"tianbai"] = self;
    self.jsContext.exceptionHandler = ^(JSContext *context, JSValue *exceptionValue) {
        context.exception = exceptionValue;
        NSLog(@"异常信息：%@", exceptionValue);
    };
}

- (void)call{
    NSLog(@"call");
    // 之后在回调js的方法Callback把内容传出去
    JSValue *Callback = self.jsContext[@"Callback"];
    //传值给web端
    [Callback callWithArguments:@[@"唤起乱七八糟的"]];
}

- (void)getCall:(NSString *)callString{
    NSLog(@"Get:%@", callString);
    // 成功回调js的方法Callback
    JSValue *Callback = self.jsContext[@"alerCallback"];
    [Callback callWithArguments:nil];
    
//    直接添加提示框
    NSString *str = @"alert('OC添加JS提示成功')";
    [self.jsContext evaluateScript:str];

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
