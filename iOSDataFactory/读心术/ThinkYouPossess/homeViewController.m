//
//  homeViewController.m
//  ThinkYouPossess
//
//  Created by qianfeng on 15-3-3.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "homeViewController.h"
#import "RootViewController.h"
@interface homeViewController ()

@end

@implementation homeViewController

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
    // Do any additional setup after loading the view.
    UIImageView *imageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 320, 240)];
    imageView.image=[UIImage imageNamed:@"0.jpg"];
    [self.view addSubview:imageView];
    imageView.userInteractionEnabled=YES;
    [imageView release];
    
    UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(0, 240, 320, 240)];
    label.text=@"读心术，猜出你心中所想的人。";
    label.font=[UIFont boldSystemFontOfSize:45];
    label.numberOfLines=0;
    [self.view addSubview:label];
    [label release];
    
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onTap)];
    [self.view addGestureRecognizer:tap];

}
-(void)onTap
{
    RootViewController *vc=[[RootViewController alloc]init];
    [self presentViewController:vc animated:YES completion:nil];
    [vc release];
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
