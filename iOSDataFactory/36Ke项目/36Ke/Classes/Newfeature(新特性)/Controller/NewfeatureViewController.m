//
//  NewfeatureViewController.m
//  36Ke
//
//  Created by lmj  on 16/3/1.
//  Copyright (c) 2016年 lmj . All rights reserved.
//

#import "NewfeatureViewController.h"
#import "LMPageControl.h"
#define LMNewfeatureImageCount 3

@interface NewfeatureViewController () <UIScrollViewDelegate>

// 设置页码
@property (nonatomic, strong) LMPageControl *pageControl;

@end

@implementation NewfeatureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 1.添加UIScrollView
    [self setupScrollView];
    
    // 2.添加pageControl
    [self setupPageControl];
}

- (void)setupScrollView {
    
    // 1.添加UIScrollView
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    scrollView.frame = self.view.bounds;
    scrollView.delegate = self;
    [self.view addSubview:scrollView];
    
    // 2.添加图片
    CGFloat imageH = scrollView.height;
    CGFloat imageW = scrollView.width;
    for (int i = 0; i < LMNewfeatureImageCount; i++) {
        
        // 创建UIImageView
        UIImageView *imageView = [[UIImageView alloc] init];
        NSString *name = [NSString stringWithFormat:@"Guidepage_ph%d_",i + 1];
        if (LMJiPhone4_OR_4s) { // 如果是4s
            name = [name stringByAppendingString:@"i4"];
        } else if (LMJiPhone5_OR_5c_OR_5s) {
            name = [name stringByAppendingString:@"i5"];
        } else if (LMJiPhone6_OR_6s) {
            name = [name stringByAppendingString:@"i6"];
        } else if (LMJiPhone6Plus_OR_6sPlus) {
            name = [name stringByAppendingString:@"i6p"];
        }
        
        imageView.image = [UIImage imageNamed:name];
        [scrollView addSubview:imageView];
        
        // 设置frame
        imageView.y = 0;
        imageView.width = imageW;
        imageView.height = imageH;
        imageView.x = i * imageW;
        
        // 设置最后一个imageView上添加按钮
        if (i == LMNewfeatureImageCount - 1) {
            [self setupLastImageView:imageView];
        }
        
    }
    
    // 3.设置其他属性
    scrollView.contentSize = CGSizeMake(LMNewfeatureImageCount * imageW, 0);
    // 去掉下滑滚条
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.backgroundColor = LMJRGBColor(246, 246, 246);
    
//    [UIColor colorWithRed:246.0 / 255.0f green:246.0 / 255.0f blue:246.0 / 255.0f alpha:1.0]
    
}

- (void)setupPageControl {
    
    // 1.添加LMPageControl
    LMPageControl *pageControl = [[LMPageControl alloc] init];
    pageControl.numberOfPages = LMNewfeatureImageCount;
    [pageControl setPageIndicatorImage:[UIImage imageNamed:@"Guidepage_spot_nomal"]];
    [pageControl setCurrentPageIndicatorImage:[UIImage imageNamed:@"Guidepage_spot_highlight"]];
    [self.view addSubview:pageControl];
    self.pageControl = pageControl;
}

- (void)setupLastImageView:(UIImageView *)imageView {
    
    imageView.userInteractionEnabled = YES;
    
    // 1.添加体验按钮
    [self setupExperienceButton:imageView];
}

- (void)setupExperienceButton:(UIImageView *)imageView {
    
    // 1.添加开始按钮
    UIButton *experienceButton = [[UIButton alloc] init];
    [imageView addSubview:experienceButton];


    // 2.设置边框
    [experienceButton setBackgroundImage:[UIImage imageNamed:@"lijifenxiang"] forState:UIControlStateNormal];
    
    experienceButton.layer.cornerRadius = experienceButton.currentBackgroundImage.size.width / 2;
    experienceButton.layer.masksToBounds = YES;
    experienceButton.layer.borderColor = (__bridge CGColorRef)([UIColor whiteColor]);
    experienceButton.layer.borderWidth = 2;
    
    
    // 3.设置frame
    experienceButton.size = experienceButton.currentBackgroundImage.size;
    experienceButton.centerX = self.view.width * 0.5;
    experienceButton.centerY = self.view.height * 0.8;
    
    
    // 4.设置文字
    [experienceButton setTitle:@"立即体验" forState:UIControlStateNormal];
    [experienceButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [experienceButton addTarget:self action:@selector(experienceClick) forControlEvents:UIControlEventTouchUpInside];
    
    
}



- (void)experienceClick {
    
    [UIApplication sharedApplication].statusBarHidden = NO;
    
    // 显示主控制器
//    [tabbar]
    UIViewController *viewControl = [[UIViewController alloc] init];
    // 切换控制爱
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    window.rootViewController = viewControl;
    
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    CGFloat doublePage = scrollView.contentOffset.x / scrollView.width;
    
    int pageSize = (int)(doublePage + 0.5);
    
    // 设置页码
    _pageControl.currentPage = pageSize;
    
}

@end
