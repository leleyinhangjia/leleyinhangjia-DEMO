//
//  LMPicNavigationController.m
//  36Ke
//
//  Created by lmj  on 16/3/20.
//  Copyright (c) 2016年 lmj . All rights reserved.
//

#import "LMPicNavigationController.h"
#import "UIBarButtonItem+Extension.h"
@interface LMPicNavigationController ()  <UIGestureRecognizerDelegate>

@end

@implementation LMPicNavigationController




- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addGesture];
    
}

- (void)addGesture {
    //清空interactivePopGestureRecognizer的delegate可以恢复因替换导航条的back按钮失去系统默认手势
    self.interactivePopGestureRecognizer.delegate = nil;
    
    //禁止手势冲突
    self.interactivePopGestureRecognizer.enabled = NO;
    
    //在runtime中查到的系统tagert 和方法名 手动添加手势，调用系统的方法,这个警告看着不爽，我直接强制去掉了~
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wundeclared-selector"
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self.interactivePopGestureRecognizer.delegate action:@selector(handleNavigationTransition:)];
#pragma clang diagnostic pop
    
    pan.delegate = self;
    
    [self.view addGestureRecognizer:pan];

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

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
//    UIBarButtonItem *backItem=[[UIBarButtonItem alloc]init];
//    backItem.image=[UIImage imageNamed:@"common_nav_icon_navigation"];
//     self.navigationItem.backBarButtonItem = backItem;
//    self.navigationItem.leftBarButtonItem = backItem;
    
    [super pushViewController:viewController animated:animated];
    viewController.navigationItem.leftBarButtonItem = [UIBarButtonItem initWithNormalImage:@"common_nav_icon_back" target:self action:@selector(popBack)];
}

- (void)popBack {
    [self dismissViewControllerAnimated:YES completion:nil];
}
#pragma mark - 手势代理方法
// 是否开始触发手势
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    // 判断下当前控制器是否是跟控制器
    return (self.topViewController != [self.viewControllers firstObject]);
}
@end
