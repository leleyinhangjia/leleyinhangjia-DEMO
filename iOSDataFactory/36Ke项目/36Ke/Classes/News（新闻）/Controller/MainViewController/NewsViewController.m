//
//  NewsViewController.m
//  36Ke
//
//  Created by lmj  on 16/3/3.
//  Copyright (c) 2016年 lmj . All rights reserved.
//

#import "NewsViewController.h"
#import "HeaderListJsonHandler.h"
#import "HeaderModel.h"
#import "LMNewsRefreshHeader.h"
#import <SDCycleScrollView.h>
#import <MJRefresh.h>
#import <MJExtension.h>
#import "LMNavigationController.h"
#import "NewsListJsonHandler.h"
#import "LMNewsCell.h"
#import "ContentViewController.h"
#import "Common.h"
#import <MJExtension.h>
#import "NewsModel.h"

#import "PicsViewController.h"
#import "LMPicNavigationController.h"

#import "LMSearchViewController.h"

#define kDeviceVersion [[UIDevice currentDevice].systemVersion floatValue]
#define kNavbarHeight ((kDeviceVersion>=7.0)? 64 :44 )
#define kIOS7DELTA   ((kDeviceVersion>=7.0)? 20 :0 )
#define kTabBarHeight 49

@interface NewsViewController () <SDCycleScrollViewDelegate,HeaderListJsonHandlerDelegate,NewsListJsonHandlerDelegate,UITableViewDelegate,UITableViewDataSource>
{
    HeaderListJsonHandler *listHandler;
    NewsListJsonHandler *newsHandler;
    SDCycleScrollView *_cycleScrollView;
}

@property (nonatomic, strong, readwrite) NSMutableArray *dataArray;
@property (nonatomic, strong, readwrite) NSMutableArray *newsArray;

@property (nonatomic, strong) ChildData *childData;

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, assign) BOOL update;

@property (nonatomic, assign) NSString *lastId;
@property (nonatomic, strong) NSString *column;
@property (nonatomic, strong) NSString *titleItem;


@end
@implementation NewsViewController

- (instancetype)initColumn:(NSString *)column title:(NSString *)title {
    _column = column;
    _titleItem = title;
    if (self = [super init]) {
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.update = YES;
    listHandler = [[HeaderListJsonHandler alloc] init];
    listHandler.delegate = self;
    newsHandler = [[NewsListJsonHandler alloc] init];
    newsHandler.delegate = self;
    [self setupUI];
    
    [self setupNaviItem];
    
    [self setupHeaderRefresh];
    
    [self cacheHistory];

}

- (void)viewWillAppear:(BOOL)animated
{
    
    [super viewWillAppear:animated];

    if (self.update == YES) {
        [self.tableView.mj_header beginRefreshing];
        self.update = NO;
    }
}




- (void)cacheHistory {
    
    if ([_column isEqualToString:@"all"]) {
        // 读取历史
        NSString *path=[k_DocumentsPath stringByAppendingPathComponent:[NSString stringWithFormat:@"/cach_header.txt"]];
        NSString *history = [Common readLocalString:path];
        
        NSError *error = nil;
        NSArray *array =
        [NSJSONSerialization JSONObjectWithData: [history dataUsingEncoding:NSUTF8StringEncoding]
                                        options: NSJSONReadingMutableContainers
                                          error: &error];
        if (history.length>0) {
            _dataArray = [Pics mj_objectArrayWithKeyValuesArray:array];
            _tableView.tableHeaderView =  [self addHeaderView];
        }
    }

    
    
    // 读取历史
    NSString *path=[k_DocumentsPath stringByAppendingPathComponent:[NSString stringWithFormat:@"/cach_%@.txt",_column]];
    NSString *history = [Common readLocalString:path];
    
    NSError *error = nil;
    NSArray *array =
    [NSJSONSerialization JSONObjectWithData: [history dataUsingEncoding:NSUTF8StringEncoding]
                                    options: NSJSONReadingMutableContainers
                                      error: &error];

    if (history.length>0) {
        
        
        
        _update = NO;
        self.newsArray = [ChildData mj_objectArrayWithKeyValuesArray:array];
        ChildData *dataChild = self.newsArray.lastObject;
        _lastId = dataChild.feedId;
        [self.tableView reloadData];
    }
    

}


- (void)setupUI {
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height - 64)];
    
    self.tableView.backgroundColor = self.view.backgroundColor;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
}

- (UIView *)addHeaderView {
    
    
    UIView *header=[[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.width, 180)];
    NSMutableArray *imagesURLStrings = [NSMutableArray array];
    for (Pics *pic in _dataArray) {
        [imagesURLStrings addObject:pic.imgUrl];
    }
    
    
    
    
    // 网络加载 --- 创建不带标题的图片轮播器
    _cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, self.view.width, 180) imageURLStringsGroup:nil];
    
    _cycleScrollView.infiniteLoop = YES;
//    _cycleScrollView
    _cycleScrollView.pageControlAliment = SDCycleScrollViewPageContolAlimentRight;
    _cycleScrollView.delegate = self;
    _cycleScrollView.pageControlStyle = SDCycleScrollViewPageContolStyleClassic;
    _cycleScrollView.autoScrollTimeInterval = 3.5; // 轮播时间间隔，默认1.0秒，可自定义
    
    _cycleScrollView.imageURLStringsGroup = imagesURLStrings;

    
    [header addSubview:_cycleScrollView];
    
    
    return header;

}


#pragma mark - HeaderListJsonHandlerDelegate
- (void)HeaderListJsonHandler:(HeaderListJsonHandler *)handler withResult:(NSMutableArray *)result {
    
    _dataArray = [NSMutableArray arrayWithArray:result];
    
    _tableView.tableHeaderView =  [self addHeaderView];
    
    if (_dataArray.count == 0) {
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        return;
    }

}


#pragma mark - NewsListJsonHandlerDelegate
- (void)NewsListJsonHandler:(NewsListJsonHandler *)handler withResult:(NSMutableArray *)result type:(int)type {
    
    if (result.count == 0) {
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        return;
    }
    
        
    _childData = result.lastObject;
    _lastId = _childData.feedId;
    if (type == 1) {
        self.newsArray = result;
        [self.tableView.mj_header endRefreshing];
        [self.tableView reloadData];
    }else if(type == 2){
        [self.newsArray addObjectsFromArray:result];
        [self.tableView.mj_footer endRefreshing];
        [self.tableView reloadData];
    }
    
}

- (void)NewsListJsonHandlerError:(NewsListJsonHandler *)handler error:(int)error {
    [self.tableView.mj_header endRefreshing];
    [self.tableView.mj_footer endRefreshing];
}

- (void)setupNaviItem {
    
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem initWithNormalImage:@"common_nav_icon_navigation"  target:(LMNavigationController *)self.navigationController action:@selector(showMenu)];
    
    
    
    
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem initWithNormalImage:@"common_nav_icon_search"  target:self action:@selector(commonSearch)];
    self.navigationItem.title = _titleItem;
    
}



- (void)commonSearch {
    LMSearchViewController *searchVC = [[LMSearchViewController alloc] init];
    [self.navigationController pushViewController:searchVC animated:YES];
//    [self.navigationController setNavigationBarHidden:NO animated:YES];
//    [self presentViewController:searchVC animated:YES completion:nil];
}

- (void)setupHeaderRefresh {
    
    
    
//    __unsafe_unretained __typeof(self) weakSelf = self;
    self.view.backgroundColor = [UIColor whiteColor];
    // 设置回调（一旦进入下拉刷新刷新状态就会调用这个refreshingBlock）
    LMNewsRefreshHeader *header = [LMNewsRefreshHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadData)];
    // 隐藏时间
    header.lastUpdatedTimeLabel.hidden = YES;
    // 隐藏文字
//    header.
    
    // 隐藏状态
    header.stateLabel.hidden = YES;
    self.tableView.mj_header = header;
    // 设置回调（一旦进入上拉刷新刷新状态就会调用这个refreshingBlock）
    MJRefreshBackStateFooter *footer = [MJRefreshBackStateFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];

    [footer setTitle:@"" forState:MJRefreshStateIdle];
    self.tableView.mj_footer = footer;
}

- (void)setUrlString:(NSString *)urlString
{
    _urlString = urlString;
}


#pragma mark -－ 刷新数据
#pragma mark 下拉刷新
- (void)loadData
{
    NSString *allUrlstring;
    if ([_column isEqualToString:@"all"]) {
        allUrlstring = [NSString stringWithFormat:@"https://rong.36kr.com/api/mobi/news"];
    } else {
        allUrlstring = [NSString stringWithFormat:@"https://rong.36kr.com/api/mobi/news?columnId=%@",_column];
    }
    [self loadDataForType:1  column:_column  withURL:allUrlstring];

}
#pragma mark 上拉刷新
- (void)loadMoreData
{
//    https://rong.36kr.com/api/mobi/news?   https://rong.36kr.com/api/mobi/news?columnId=67
    NSString *allUrlstring;
//    NSString *allUrlstring;
    
    if ([_column isEqualToString:@"all"]) {
        allUrlstring = [NSString stringWithFormat:@"https://rong.36kr.com/api/mobi/news?lastId=%@",_lastId];
    }
    else {
        allUrlstring = [NSString stringWithFormat:@"https://rong.36kr.com/api/mobi/news?columnId=%@&lastId=%@",_column,_lastId];
    }
    
    [self loadDataForType:2 column:_column  withURL:allUrlstring];

}
// ------公共方法
- (void)loadDataForType:(int)type column:(NSString *)column withURL:(NSString *)allUrlstring
{
    if ([column isEqualToString:@"all"]) {
        [listHandler handlerHeaderObject];
    }

    
    [newsHandler handlerNewsObject:allUrlstring type:type column:column];

}

#pragma mark - UITableViewDelegate



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([_column hasPrefix:@"tv"]) {
        return 300.0f;
    }
    return 90.0f;
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.newsArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    ChildData *childModel = self.newsArray[indexPath.row];
    
    LMNewsCell * cell = [LMNewsCell cellWithTableView:tableView model:childModel];
    cell.selectionStyle = UITableViewCellSelectionStyleGray;
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([indexPath row]==self.newsArray.count)
    {
        return;
        
    }
    ChildData *dataChild = self.newsArray[indexPath.row];
    ContentViewController *contentVC = [[ContentViewController alloc] init];
    [contentVC setChilData:dataChild];
    [contentVC setHidesBottomBarWhenPushed:YES];//加上这句就可以把推出的ViewController隐藏Tabbar
    [self.navigationController setNavigationBarHidden:YES animated:YES];

    [self.navigationController pushViewController:contentVC animated:YES];

    [tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath, nil] withRowAnimation:UITableViewRowAnimationNone];
    
}

#pragma mark - SDCycleScrollViewDelegate

- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
    Pics *picModel = self.dataArray[index];
//    PicsViewController *picsVC = [[PicsViewController alloc] initWithNibName:@"PicsViewController" bundle:nil];
    PicsViewController *picsVC = [[PicsViewController alloc] init];
    [picsVC setPicModel:picModel];
//    [contentVC setHidesBottomBarWhenPushed:YES];//加上这句就可以把推出的ViewController隐藏Tabbar
//    [self.navigationController setNavigationBarHidden:YES animated:YES];
    LMPicNavigationController *naviVC = [[LMPicNavigationController alloc] initWithRootViewController:picsVC];
    
//    [self.navigationController pushViewController:naviVC animated:YES];
//    [self addChildViewController:naviVC];
//    [naviVC pushViewController:picsVC animated:YES];
//    [naviVC pushViewController:picsVC animated:YES];
    [self presentViewController:naviVC animated:YES completion:nil];
}

/**
 解决办法，在presentModalViewController的时候加上UINavigationController，就可以了，如下:
 
 [objc] view plain copy 在CODE上查看代码片派生到我的代码片
 LoginViewController *login = [[LoginViewController alloc]init];
 UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:login];
 [self.navigationController presentModalViewController:nav animated:YES];
 */


@end
