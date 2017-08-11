//
//  HomeViewController.m
//  MiaoBo
//
//  Created by mpgy on 2017/3/8.
//  Copyright © 2017年 com.mpgy.www. All rights reserved.
//

#import "HomeViewController.h"
#import "ZLySelectedView.h"
#import "ZlyNewStarViewController.h"
#import "ZLyHotViewController.h"
#import "ZlyCareViewController.h"



@interface HomeViewController () <UIScrollViewDelegate>
/** 顶部选择视图 */
@property(nonatomic, assign) ZLySelectedView *selectedView;
/** UIScrollView */
@property(nonatomic, weak) UIScrollView *scrollView;
/** 热播 */
@property(nonatomic, weak) ZLyHotViewController *hotVc;
/** 最新主播 */
@property(nonatomic, weak) ZlyNewStarViewController *starVc;
/** 关注主播 */
@property(nonatomic, weak) ZlyCareViewController *careVc;

@end

@implementation HomeViewController
- (void)loadView {
   UIScrollView *view = [[UIScrollView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    view.contentSize = CGSizeMake(ZLyScreenWidth * 3, 0);
    view.backgroundColor = [UIColor whiteColor];
    //去掉滚动条
    view.showsVerticalScrollIndicator = NO;
    view.showsHorizontalScrollIndicator = NO;
    //设置分页
    view.pagingEnabled = YES;
    //设置代理
    view.delegate = self;
    //去掉弹簧效果
    view.bounces = NO;
    
    CGFloat height = ZLyScreenHeight - 49;
    
    //添加子视图
    ZLyHotViewController *hot = [ZLyHotViewController  new];
    hot.view.frame = [UIScreen mainScreen].bounds;
    hot.view.height = height;
    [self addChildViewController:hot];
    [view addSubview:hot.view];
    _hotVc = hot;
    
    ZlyNewStarViewController  *newStar = [[ZlyNewStarViewController alloc] init];
    newStar.view.frame = [UIScreen mainScreen].bounds;
    newStar.view.x = ZLyScreenWidth;
    newStar.view.height = height;
    [self addChildViewController:newStar];
    [view addSubview:newStar.view];
    _starVc = newStar;
    
    ZlyCareViewController *care = [UIStoryboard storyboardWithName:NSStringFromClass([ZlyCareViewController class]) bundle:nil].instantiateInitialViewController;
    care.view.frame = [UIScreen mainScreen].bounds;
    care.view.x = ZLyScreenWidth * 2;
    care.view.height = height;
    [self addChildViewController:care];
    [view addSubview:care.view];
    _careVc = care;
    
    self.view = view;
    self.scrollView = view;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // 基本设置
    [self setup];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if (!_selectedView) {
        [self setupTopMenu];
    }
}
- (void)setup
{
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"search_15x14"] style:UIBarButtonItemStyleDone target:nil action:nil];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"head_crown_24x24"] style:UIBarButtonItemStyleDone target:self action:@selector(rankCrown)];
     [self setupTopMenu];
}
- (void)rankCrown
{

}

- (void)setupTopMenu
{
    // 设置顶部选择视图
    ZLySelectedView *selectedView = [[ZLySelectedView alloc] initWithFrame:self.navigationController.navigationBar.bounds];
    selectedView.x = 45;
    selectedView.width = ZLyScreenWidth - 45 * 2;
    [selectedView setSelectedBlock:^(HomeType type) {
        [self.scrollView setContentOffset:CGPointMake(type * ZLyScreenWidth, 0) animated:YES];
    }];
    [self.navigationController.navigationBar addSubview:selectedView];
    _selectedView = selectedView;
    
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat page = scrollView.contentOffset.x / ZLyScreenWidth;
    CGFloat offSetX = scrollView.contentOffset.x / ZLyScreenWidth *(self.selectedView.width * 0.5 - Home_Seleted_Item_W * 0.5 - 15);
    self.selectedView.underLine.x = 15 + offSetX;
    if (page == 1 ) {
        self.selectedView.underLine.x = offSetX + 10;
    }else if (page > 1){
        self.selectedView.underLine.x = offSetX + 5;
    }
    self.selectedView.selectedType = (int)(page + 0.5);

    
}


@end
