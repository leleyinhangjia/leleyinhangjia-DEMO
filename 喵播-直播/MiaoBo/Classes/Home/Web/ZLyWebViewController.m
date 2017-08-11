

//
//  ZLyWebViewController.m
//  MiaoBo
//
//  Created by mpgy on 2017/3/10.
//  Copyright © 2017年 com.mpgy.www. All rights reserved.
//

#import "ZLyWebViewController.h"

@interface ZLyWebViewController ()
/** webView */
@property (nonatomic, weak) UIWebView *webView;
@end

@implementation ZLyWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
     [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:_url]]];
}

- (UIWebView *)webView
{
    if (!_webView) {
        UIWebView *web = [[UIWebView alloc] initWithFrame:self.view.bounds];
        [self.view addSubview:web];
        web.backgroundColor  = [UIColor whiteColor];
        _webView = web;
    }
    return _webView;
}

- (instancetype)initWithUrlStr:(NSString *)url
{
    url = _url;
    if (self = [self init]) {
        [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:url]]];
    }
    return self;
}

@end
