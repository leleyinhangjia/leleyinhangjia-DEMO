//
//  LMNavigationController.m
//  36Ke
//
//  Created by lmj  on 16/3/3.
//  Copyright (c) 2016年 lmj . All rights reserved.
//

#import "LMNavigationController.h"
#import "UIViewController+REFrostedViewController.h"
#import "REFrostedViewController.h"
@interface LMNavigationController ()

@end

@implementation LMNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    
}


- (void)showMenu
{
    // Dismiss keyboard (optional)
    //
    [self.view endEditing:YES];
    [self.frostedViewController.view endEditing:YES];
    
    // Present the view controller
    //
    [self.frostedViewController presentMenuViewController];
}

+ (void)initialize {
    
    
    // 设置UINavigationBarTheme
    [self setupNavigationBarTheme];
    
    // 设置UIBarButtonItem主题
    [self setupBarButtonItemTheme];
}

+ (void)setupNavigationBarTheme {
    
    UINavigationBar *appearance = [UINavigationBar appearance];
    
    // 设置文字属性
    NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
    textAttrs[NSForegroundColorAttributeName] = [UIColor lightGrayColor];
    textAttrs[NSFontAttributeName] = LMJNavigationFont;
    
    // 设置导航栏背景
    [appearance setBackgroundImage:[UIImage imageNamed:@"nanavigationbar_backgroundvi"] forBarMetrics:UIBarMetricsDefault];
    textAttrs[NSShadowAttributeName] = [[NSShadow alloc] init];
    
    [appearance setTitleTextAttributes:textAttrs];
}

+ (void)setupBarButtonItemTheme {
    
    // 通过apperance对象修改整个项目中的UIBarButtomItem的样式
    UIBarButtonItem *appearance = [UIBarButtonItem appearance];
    
    /**设置文字属性**/
    // 设置普通状态的文字属性
    [appearance setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:LMJCommonColor,NSForegroundColorAttributeName,[UIFont systemFontOfSize:15],NSFontAttributeName, nil] forState:UIControlStateNormal];
    // 设置高亮状态的文字属性
    //    [appearance setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:SWCommonColor, NSForegroundColorAttributeName,[UIFont systemFontOfSize:15],NSFontAttributeName,nil] forState:UIControlStateHighlighted];
    
    // 设置不可用状态(disable)的文字属性
    [appearance setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor lightGrayColor], NSForegroundColorAttributeName,[UIFont systemFontOfSize:15],NSFontAttributeName,nil] forState:UIControlStateDisabled];
//    // 自定义返回
    // 将返回按钮的文字position设置不在屏幕上显示
    [appearance setBackButtonTitlePositionAdjustment:UIOffsetMake(NSIntegerMin, NSIntegerMin) forBarMetrics:UIBarMetricsDefault];
}

- (void)showLeftMenu {
//    [self.frostedViewController presentMenuViewController];
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    
    // 1.判断是否为栈底控制器
    if (self.viewControllers.count > 0) {
        viewController.hidesBottomBarWhenPushed = YES;
    }
    
    [super pushViewController:viewController animated:YES];
}

- (void)back
{
    [self popViewControllerAnimated:YES];
}

@end
