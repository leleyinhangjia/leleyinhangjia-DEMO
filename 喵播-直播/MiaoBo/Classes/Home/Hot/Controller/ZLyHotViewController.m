//
//  ZLyHotViewController.m
//  MiaoBo
//
//  Created by leleyinhangjia on 2017/3/10.
//  Copyright © 2017年 leleyinhangjia All rights reserved.
//

#import "ZLyHotViewController.h"
#import "ZLyLive.h"
#import "ZLyTopAD.h"
#import "ZLyHotLiveCell.h"
#import "ZLyHomeADCell.h"
#import "ZLyRefreshGifHeader.h"
#import "ZLyWebViewController.h"
#import "ZLyLiveCollectionViewController.h"
@interface ZLyHotViewController ()
/** 当前页 */
@property(nonatomic, assign) NSUInteger currentPage;
/** 直播 */
@property(nonatomic, strong) NSMutableArray *lives;
/** 广告 */
@property(nonatomic, strong) NSArray *topADS;
@end

static NSString *reuseIdentifier = @"ZLyHotLiveCell";
static NSString *ADReuseIdentifier = @"ZLyHomeADCell";

@implementation ZLyHotViewController

- (NSMutableArray *)lives
{
    if (!_lives) {
        _lives = [NSMutableArray array];
    }
    return _lives;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setup];
}
- (void)setup
{
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([ZLyHotLiveCell class]) bundle:nil] forCellReuseIdentifier:reuseIdentifier];
       [self.tableView registerClass:[ZLyHomeADCell class] forCellReuseIdentifier:ADReuseIdentifier];
    self.currentPage = 1;
    
    //头部刷新
    self.tableView.mj_header = [ZLyRefreshGifHeader headerWithRefreshingBlock:^{
        self.lives = [NSMutableArray array];
        self.currentPage = 1;
        //获取顶部的广告
        // 获取顶部的广告
        [self getTopAD];
        [self getHotLiveList];
    }];
    
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        self.currentPage++;
        [self getHotLiveList];
    }];
    
    [self.tableView.mj_header beginRefreshing];
    self.tableView.tableFooterView = [[UIView alloc] init];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
}
//轮播图
- (void)getTopAD
{
    [[ALinNetworkTool shareTool] GET:@"http://live.9158.com/Living/GetAD" parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
         NSArray *result = responseObject[@"data"];
        if ([self isNotEmpty:result]) {
            self.topADS = [ZLyTopAD mj_objectArrayWithKeyValuesArray:result];
            [self.tableView reloadData];
        }else {
              [self showHint:@"网络异常"];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self showHint:@"网络异常"];
    }];
}

- (void)getHotLiveList
{
    [[ALinNetworkTool shareTool] GET:[NSString stringWithFormat:@"http://live.9158.com/Fans/GetHotLive?page=%d", self.currentPage] parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        NSArray *result = [ZLyLive mj_objectArrayWithKeyValuesArray:responseObject[@"data"][@"list"]];
        if ([self isNotEmpty:result]) {
            [self.lives addObjectsFromArray:result];
            [self.tableView reloadData];
        }else{
            [self showHint:@"暂时没有更多最新数据"];
            // 恢复当前页
            self.currentPage--;
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        self.currentPage--;
        [self showHint:@"网络异常"];
    }];
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.lives.count + 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return 100;
    }
    return 465;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        ZLyHomeADCell *cell = [tableView dequeueReusableCellWithIdentifier:ADReuseIdentifier];
        if (self.topADS.count) {
            cell.topADs = self.topADS;
            [cell setImageClickBlock:^(ZLyTopAD *topAD) {
                self.title = nil;
                ZLyWebViewController *web = [[ZLyWebViewController alloc] init];
                web.navigationItem.title = topAD.title;
                web.url = topAD.link;
                [self.navigationController pushViewController:web animated:YES];
                
                //[self presentViewController:web animated:YES completion:nil];
            }];
        }
        return cell;
    }
    ZLyHotLiveCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    if (self.lives.count) {
        ZLyLive *live = self.lives[indexPath.row-1];
        cell.live = live;
    }
    
    return cell;
}
#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZLyLiveCollectionViewController *liveVc = [[ ZLyLiveCollectionViewController alloc] init];
    liveVc.lives = self.lives;
    liveVc.currentIndex = indexPath.row-1;
    [self presentViewController:liveVc animated:YES completion:nil];
}




@end
