
//
//  ZlyNavigationViewController.m
//  MiaoBo
//
//  Created by mpgy on 2017/3/8.
//  Copyright © 2017年 com.mpgy.www. All rights reserved.
//

#import "ZlyNavigationViewController.h"

@interface ZlyNavigationViewController ()

@end

@implementation ZlyNavigationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}
+(void)initialize {
    UINavigationBar *bar = [UINavigationBar appearance];
    [bar setBackgroundImage:[UIImage imageNamed:@"navBar_bg_414x70"] forBarMetrics:UIBarMetricsDefault];
}
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if (self.childViewControllers.count) {//隐藏导航栏
        viewController.hidesBottomBarWhenPushed = YES;
        //自定义返回按钮
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
      
        [btn setImage:[UIImage imageNamed:@"back_9x16"] forState:(UIControlStateNormal)];
        
          //RAC
        [[btn rac_signalForControlEvents:(UIControlEventTouchUpInside)] subscribeNext:^(id x) {
            // 判断两种情况: push 和 present
            if ((self.presentedViewController || self.presentingViewController) && self.childViewControllers.count == 1) {
                [self dismissViewControllerAnimated:YES completion:nil];
            }else
                [self popViewControllerAnimated:YES];
         }];
        
        [btn sizeToFit];
        
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:btn];
        // 如果自定义返回按钮后, 滑动返回可能失效, 需要添加下面的代码
        __weak typeof(viewController)Weakself = viewController;
        self.interactivePopGestureRecognizer.delegate = (id)Weakself;
       
    }
    [super pushViewController:viewController animated:animated];
}

@end
