//
//  LMTabBarController.m
//  36Ke
//
//  Created by lmj  on 16/3/3.
//  Copyright (c) 2016年 lmj . All rights reserved.
//

#import "LMTabBarController.h"
#import "LMNavigationController.h"
#import "NewsViewController.h"
#import "KeTVViewController.h"
#import "MyViewController.h"
#import "InvestmentViewController.h"
#import "UIImage+Extension.h"
#import "LMDiscoveryViewController.h"
@interface LMTabBarController ()

@property (nonatomic, strong) NewsViewController *newsViewController;

@property (nonatomic, strong) KeTVViewController *ketvViewController;


@property (nonatomic, strong) LMDiscoveryViewController *discoveryViewController;

@property (nonatomic, strong) MyViewController *myViewController;

@property (nonatomic, strong) InvestmentViewController *investmentViewController;

@property (nonatomic, strong) NSString * column;

@property (nonatomic, strong) NSString *naviItemtitle;

@end

@implementation LMTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addAllChildVC];
    
}

- (instancetype)initColumn:(NSString *)column title:(NSString *)title {
    _column = column;
    _naviItemtitle = title;
    if (self = [super init]) {
        
    }
    
    return self;
}


- (void)addAllChildVC {
    if ([_column isEqualToString:@"tv"]) {
        KeTVViewController *ketvVC = [[KeTVViewController alloc] initColumn:_column title:_naviItemtitle];
        [self addChildVC:ketvVC title:@"新闻" imageName:[[UIImage imageNamed:@"tabbar_icon_news"] imageByScalingToSize:CGSizeMake(25, 25)]];
        _ketvViewController = ketvVC;
    } else {
        NewsViewController *newsVC = [[NewsViewController alloc] initColumn:_column title:_naviItemtitle];
        //    UIImage *image = [UIImage imageNamed:@"tabbar_icon_news"];
        [self addChildVC:newsVC title:@"新闻" imageName:[[UIImage imageNamed:@"tabbar_icon_news"] imageByScalingToSize:CGSizeMake(25, 25)]];
        _newsViewController = newsVC;
    }
    
    
    LMDiscoveryViewController *discoveryVC = [[LMDiscoveryViewController alloc] init];
    [self addChildVC:discoveryVC title:@"发现" imageName:[[UIImage imageNamed:@"tabbar_icon_discovery"] imageByScalingToSize:CGSizeMake(25, 25)]];
    _discoveryViewController = discoveryVC;
    
    InvestmentViewController *investmentVC = [[InvestmentViewController alloc] init];
    [self addChildVC:investmentVC title:@"股权投资" imageName:[[UIImage imageNamed:@"tabbar_icon_equity"] imageByScalingToSize:CGSizeMake(25, 25)]];
    _investmentViewController = investmentVC;
    
    MyViewController *myVC = [[MyViewController alloc] init];
    [self addChildVC:myVC title:@"我的" imageName:[[UIImage imageNamed:@"tabbar_icon_mine"] imageByScalingToSize:CGSizeMake(25, 25)]];
    _myViewController = myVC;
    
    
}

- (void)addChildVC:(UIViewController *)vc title:(NSString *)title imageName:(UIImage *)imageName {
    
    vc.title = title;
    vc.tabBarItem.image = imageName;
    
    LMNavigationController *nav = [[LMNavigationController alloc] initWithRootViewController:vc];
    [self addChildViewController:nav];
}

+ (void)initialize {
    
    UITabBarItem *apperance = [UITabBarItem appearance];
    [apperance setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor blueColor],NSForegroundColorAttributeName, nil] forState:UIControlStateSelected];
}

@end
