//
//  PicsViewController.m
//  36Ke
//
//  Created by lmj  on 16/3/20.
//  Copyright (c) 2016年 lmj . All rights reserved.
//

#import "PicsViewController.h"
#import "Common.h"

@interface PicsViewController () <UIWebViewDelegate>{
    UIActivityIndicatorView *actView;
    UILabel *loadingLabel;
    UIView *loadingView;
    BOOL isFirstLoad;//解决web黑色
        
        
    
}
@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end

@implementation PicsViewController 

- (void)viewDidLoad {
    [super viewDidLoad];
    isFirstLoad=YES;
    [self.webView setBackgroundColor:[Common translateHexStringToColor:@"#f5f5f5"]];
    self.webView.delegate=self;
    
    [self loadDisplay];
}

- (void)loadDisplay {
    //加载显示
    loadingView=[[UIView alloc] initWithFrame:self.webView.frame];
    [loadingView setBackgroundColor:[Common translateHexStringToColor:@"#f5f5f5"]];
    actView=[[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    actView.center=self.webView.center;
    loadingLabel=[[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.webView.bounds.size.width, 30)];
    loadingLabel.center=CGPointMake(self.webView.center.x, self.webView.center.y+30);
    [loadingLabel setTextColor:[UIColor lightGrayColor]];
    [loadingLabel setFont:[UIFont systemFontOfSize:12]];
    [loadingLabel setTextAlignment:NSTextAlignmentCenter];
    [loadingLabel setBackgroundColor:[UIColor clearColor]];
    [loadingView addSubview:actView];
    [loadingView addSubview:loadingLabel];
}

-(void)startLoading
{
    
//    [self.view addSubview:self.webView];
    [self.view addSubview:loadingView];
    [actView startAnimating];
    [loadingLabel setText:@"正在加载..."];
    
}
-(void)endLoading
{
    
    [actView stopAnimating];
    [loadingView removeFromSuperview];
    
}
- (void)setPicModel:(Pics *)picModel {
    [self startLoading];
    
    NSURL *url = [NSURL URLWithString:picModel.location];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:request];
    
    if (!isFirstLoad) {
        [self endLoading];
    }
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.hidesBottomBarWhenPushed=YES;
    }
    return self;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma -
#pragma scrollview delegate
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    if ([[request.URL absoluteString] hasPrefix:@"http://"]) {
        return NO;
    }
    return YES;
}
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    if (isFirstLoad) {
        [self endLoading];
        isFirstLoad=NO;
    }
}

@end
