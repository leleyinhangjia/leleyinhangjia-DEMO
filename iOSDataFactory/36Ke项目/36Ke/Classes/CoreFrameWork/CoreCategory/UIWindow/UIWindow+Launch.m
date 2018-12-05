//
//  UIWindow+Launch.m
//  LMJJDNC
//
//  Created by lmj on 16/1/7.
//  Copyright (c) 2016年 lmj. All rights reserved.
//

#import "UIWindow+Launch.h"

@implementation UIWindow (Launch)

+ (UIWindow *)appWindow
{
    UIWindow *window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    // 显示状态栏
    [[UIApplication sharedApplication] setStatusBarHidden:NO];
    
    // 状态栏样式
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    // 设置背景色
    window.backgroundColor = [UIColor whiteColor];
    
    // 成为主窗口
    [window makeKeyAndVisible];
    
    return window;
}

@end
