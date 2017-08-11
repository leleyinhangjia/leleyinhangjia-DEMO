//
//  ZLyTopWindow.m
//  MiaoBo
//
//  Created by leleyinhangjia on 2017/3/7.
//  Copyright © 2017年 leleyinhangjia All rights reserved.
//

#import "ZLyTopWindow.h"

@implementation ZLyTopWindow

static UIButton *btn_;

+ (void)initialize
{
    btn_ = [[UIButton alloc] initWithFrame:[UIApplication sharedApplication].statusBarFrame];
     // 监听和实现放在一起
    [[btn_ rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        NSLog(@"点击了最顶部...");
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        [self searchScrollViewInView:window];
    }];
    
}
+ (void)show
{
    btn_.hidden = NO;
}

+ (void)hide
{
    btn_.hidden = YES;
}

/**
 获取当前状态栏的方法
 */
+ (UIView *)statusBarView
{
    UIView *statusBar = nil;
    NSData *data = [NSData dataWithBytes:(unsigned char []){0x73, 0x74, 0x61, 0x74, 0x75, 0x73, 0x42, 0x61, 0x72} length:9];
    NSString *key = [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];
    id object = [UIApplication sharedApplication];
    if ([object respondsToSelector:NSSelectorFromString(key)]) statusBar = [object valueForKey:key];
    return statusBar;
}

+ (void)searchScrollViewInView:(UIView *)superview {
    for (UIScrollView *subview in superview.subviews) {
        // 如果是scrollview, 滚动最顶部
        if ([subview isKindOfClass:[UIScrollView class]] && subview.isShowingOnKeyWindow) {
            CGPoint offset = subview.contentOffset;
            offset.y = - subview.contentInset.top;
            [subview setContentOffset:offset animated:YES];
        }
        // 继续查找子控件
        [self searchScrollViewInView:subview];
    }
}


@end
