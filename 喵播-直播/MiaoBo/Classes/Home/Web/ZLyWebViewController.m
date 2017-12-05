

//
//  ZLyWebViewController.m
//  MiaoBo
//
//  Created by leleyinhangjia on 2017/3/10.
//  Copyright © 2017年 leleyinhangjia All rights reserved.
//

#import "ZLyWebViewController.h"

@interface ZLyWebViewController ()
/** webView */
@property (nonatomic, weak) UIWebView *webView;
@property(nonatomic ,strong) UILabel *BiaoTiLable;
@property(nonatomic ,strong) UIButton *backBtn;
@end

@implementation ZLyWebViewController
-(void)viewWillAppear:(BOOL)animated {
    self.view.backgroundColor = [UIColor whiteColor];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.BiaoTiLable.text = _titleString;
    //RAC
    [[self.backBtn rac_signalForControlEvents:(UIControlEventTouchUpInside)] subscribeNext:^(id x) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }];

    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:_url]]];
}

- (UIWebView *)webView
{
    if (!_webView) {
        UIWebView *web = [[UIWebView alloc] initWithFrame:CGRectMake(0, -20, ZLyScreenWidth, ZLyScreenHeight+20)];
        [self.view addSubview:web];
        web.backgroundColor  = [UIColor whiteColor];
        _webView = web;
       
    }
    return _webView;
}
-(UILabel *)BiaoTiLable {
    if (!_BiaoTiLable) {
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(ZLyScreenWidth/2 -100, 25, 200, 40)];
        label.text = @"haha";
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor = [UIColor blackColor];
        [self.webView addSubview:label];
        _BiaoTiLable = label;
    }
    return _BiaoTiLable;
}
-(UIButton *)backBtn {
    if (!_backBtn) {
        UIButton*btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame  = CGRectMake(20, 35, 25, 25);
        [btn setImage:[UIImage imageNamed:@""] forState:(UIControlStateNormal)];
        [btn setImage:[UIImage imageNamed:@"back_9x16"] forState:(UIControlStateNormal)];
        btn.backgroundColor = [UIColor grayColor];
        [self.webView addSubview:btn];
        _backBtn = btn;
    }
    return _backBtn;
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
