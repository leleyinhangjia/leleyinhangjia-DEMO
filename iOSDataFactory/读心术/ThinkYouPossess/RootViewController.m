//
//  RootViewController.m
//  ThinkYouPossess
//
//  Created by qianfeng on 15-3-3.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "RootViewController.h"
#import "ASIHTTPRequest.h"
@interface RootViewController ()


@property (nonatomic, copy) NSString* yesurl;
@property (nonatomic, copy) NSString* nourl;
@property (nonatomic, copy) NSString* notsureurl;
@end
@implementation RootViewController
{
    NSString *urlChoose;
    UILabel *label;
    ASIHTTPRequest  *asi;
    NSInteger k;
    UIImageView *imageView;
    NSURL *url;
}
-(void)dealloc
{
   
    [urlChoose release];
    [label release];
    [asi release];
    [imageView release];
    [url release];
    [super dealloc];
    
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    
    NSArray *array=@[@"是",@"不是",@"不确定"];
    for (NSInteger i=0; i<3; i++) {
        UIButton *button=[UIButton buttonWithType:UIButtonTypeRoundedRect];
        button.frame=CGRectMake(10+i*100, 400, 80, 30);
        [button setTitle:[NSString stringWithFormat:@"%@",array[i]] forState:UIControlStateNormal];
        button.tag=100+i;
        [self.view addSubview:button];
        
        [button addTarget:self action:@selector(onButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    label=[[UILabel alloc]initWithFrame:CGRectMake(10, 200, 300, 50)];
    label.text=@"";
    label.numberOfLines=0;
    [self.view addSubview:label];
    [label release];
    
    imageView=[[UIImageView alloc]initWithFrame:CGRectMake(100, 50, 130, 130)];
    imageView.image=[UIImage imageNamed:@"2.jpg"];
    [self.view addSubview:imageView];
    
    
    k=1;
    
    [self customUI];
}
-(void)customUI
{
    NSURL *url1=[NSURL URLWithString:@"http://renlifang.msra.cn/Q20/api/gamestart.ashx?alias=WP7&stamp=366"];
    asi=[ASIHTTPRequest requestWithURL:url1];
    asi.delegate=self;
    [asi startAsynchronous];
    
}
-(void)onButtonClick:(UIButton*)sender
{
    if (sender.tag==100) {
        [self  request:self.yesurl];
    }else if (sender.tag==101){
        [self request:self.nourl];
    }else if (sender.tag==102){
        [self request:self.notsureurl];
    }
}
-(void)request:(NSString*)nul
{
    ASIHTTPRequest *reques=[ASIHTTPRequest requestWithURL:[NSURL URLWithString:nul]];
    reques.delegate=self;
    reques.tag=20;
    [reques startAsynchronous];
}
-(void)requestFailed:(ASIHTTPRequest *)request
{
    NSLog(@"请求失败");
}
-(void)requestFinished:(ASIHTTPRequest *)request
{

    if (k<=1) {
        k+=2;
        NSDictionary *dic=[NSJSONSerialization JSONObjectWithData:request.responseData options:0 error:nil];
        [self request:dic[@"starturl"]];
            }
    if (request.tag==20) {
    NSDictionary *dic=[NSJSONSerialization JSONObjectWithData:request.responseData options:0 error:nil];
    if ([dic[@"step"] intValue]== 1){
        label.text=dic[@"qtext"];
        self.yesurl=dic[@"yesurl"];
        self.nourl=dic[@"nourl"];
        self.notsureurl=dic[@"notsureurl"];
    }else if([dic[@"step"]intValue]==2){
        label.text=[NSString stringWithFormat:@"小主想的是：%@",dic[@"guessname"]];
        NSString* imageUrl = [NSString stringWithFormat:@"http://renlifang.msra.cn/portrait.aspx?id=%@", dic[@"pid"]];
        ASIHTTPRequest* imageRequest = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:imageUrl]];
        imageRequest.tag = 30;
        imageRequest.delegate = self;
        [imageRequest startAsynchronous];
     }
    }
    //拿到图片
    if (request.tag == 30) {
        imageView.image = [UIImage imageWithData:request.responseData];
    }

}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
