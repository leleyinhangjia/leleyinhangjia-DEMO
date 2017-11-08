//
//  AppDelegate.m
//  MiaoBo
//
//  Created by leleyinhangjia on 2017/3/6.
//  Copyright © 2017年 leleyinhangjia All rights reserved.
//

#import "AppDelegate.h"
#import "ZLyLoginViewController.h"
#import "Reachability.h"
#import "UIDevice+SLExtension.h"
@interface AppDelegate ()
{
    Reachability *_reacha;
    NetworkStates _preStatus;
}
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
   
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    self.window.rootViewController = [[ZLyLoginViewController alloc]init];
    
    [self.window makeKeyWindow];
    
    //判断iPhone X 遇到的问题
    if ([[UIDevice deviceVersion] isEqualToString:@"iPhone X"] ) {
        [self showInfo:@"欢迎来到iPhone X 的世界!"];
    }else {
        //iOS11 网络监听有问题,稍后解决!
        [self checkNetworkStates];
    }

 
    return YES;
}
// 实时监控网络状态
- (void)checkNetworkStates
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(networkChange) name:kReachabilityChangedNotification object:nil];
    _reacha = [Reachability reachabilityWithHostName:@"http://www.baidu.com"];
    [_reacha startNotifier];
}
- (void)networkChange
{
    NSString *tips;
    NetworkStates currentStates = [ALinNetworkTool getNetworkStates];
    if (currentStates == _preStatus) {
        return;
    }
    _preStatus = currentStates;
    switch (currentStates) {
        case NetworkStatesNone:
            tips = @"当前无网络, 请检查您的网络状态";
            break;
        case NetworkStates2G:
            tips = @"切换到了2G网络";
            break;
        case NetworkStates3G:
            tips = @"切换到了3G网络";
            break;
        case NetworkStates4G:
            tips = @"切换到了4G网络";
            break;
        case NetworkStatesWIFI:
            tips = nil;
            
            break;
        default:
            break;
    }
    
    if (tips.length) {
        [[[UIAlertView alloc] initWithTitle:@"喵播" message:tips delegate:nil cancelButtonTitle:@"好的" otherButtonTitles:nil, nil] show];
    }
}

- (void)applicationWillResignActive:(UIApplication *)application {
 
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
 
}


- (void)applicationDidBecomeActive:(UIApplication *)application {

}


- (void)applicationWillTerminate:(UIApplication *)application {
   
}


@end
