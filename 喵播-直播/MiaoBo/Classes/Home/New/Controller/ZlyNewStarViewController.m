
//
//  ZlyNewStarViewController.m
//  MiaoBo
//
//  Created by leleyinhangjia on 2017/3/10.
//  Copyright © 2017年 leleyinhangjia All rights reserved.
//

#import "ZlyNewStarViewController.h"
#import "ZlyUser.h"
#import "ZLyAnchorViewCell.h"
#import "ZLyHomeFlowLayout.h"
#import "ZLyRefreshGifHeader.h"
#import "ZLyLiveCollectionViewController.h"
#import "ZLyLive.h"
@interface ZlyNewStarViewController ()
/** 最新主播列表 */
@property(nonatomic, strong) NSMutableArray *anchors;
/** 当前页 */
@property(nonatomic, assign) NSUInteger currentPage;
/** NSTimer */
@property (nonatomic, strong) NSTimer *timer;
@end

@implementation ZlyNewStarViewController

static NSString * const reuseIdentifier = @"NewStarCell";
- (NSMutableArray *)anchors
{
    if (!_anchors) {
        _anchors = [NSMutableArray array];
    }
    return _anchors;
}
- (instancetype)init {
    return [super initWithCollectionViewLayout:[ZLyHomeFlowLayout new]];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
     [self setup];
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    // 首先自动刷新一次
    [self autoRefresh];
    // 然后开启每一分钟自动更新
    _timer = [NSTimer scheduledTimerWithTimeInterval:60 target:self selector:@selector(autoRefresh) userInfo:nil repeats:YES];
}

- (void)autoRefresh
{
    [self.collectionView.mj_header beginRefreshing];
    NSLog(@"刷新最新主播界面");
}
- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [self.timer invalidate];
    self.timer = nil;
}

- (void)setup
{
    // 默认当前页从1开始的
    self.currentPage = 1;
      // 注册cell
    [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([ZLyAnchorViewCell class]) bundle:nil] forCellWithReuseIdentifier:reuseIdentifier];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    //设置Header和Footer
    self.collectionView.mj_header = [ZLyRefreshGifHeader headerWithRefreshingBlock:^{
        self.currentPage = 1;
        self.anchors = [NSMutableArray array];
       [self getAnchorsList];
    }];
    self.collectionView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        self.currentPage++;
        [self getAnchorsList];
    }];
    [self.collectionView.mj_header beginRefreshing];
    
}
//获取数据
- (void)getAnchorsList
{
    [[ALinNetworkTool shareTool] GET:[NSString stringWithFormat:@"http://live.9158.com/Room/GetNewRoomOnline?page=%ld", self.currentPage]  parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //记住这些
        [self.collectionView.mj_header endRefreshing];
        [self.collectionView.mj_footer endRefreshing];
         NSString *statuMsg = responseObject[@"msg"];
        if ([statuMsg isEqualToString:@"fail"]) {
            // 数据已经加载完毕, 没有更多数据了
            [self.collectionView.mj_footer endRefreshingWithNoMoreData];
            [self showHint:@"暂时没有更多最新数据"];
            // 恢复当前页
            self.currentPage--;
        }else {
             [responseObject[@"data"][@"list"] writeToFile:@"/Users/apple/Desktop/user.plist" atomically:YES];
            NSArray *result = [ZlyUser mj_objectArrayWithKeyValuesArray:responseObject[@"data"][@"list"]];
            if (result.count) {
                [self.anchors addObjectsFromArray:result];
                [self.collectionView reloadData];
            }
            
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self.collectionView.mj_header endRefreshing];
        [self.collectionView.mj_footer endRefreshing];
        self.currentPage--;
        [self showHint:@"网络异常"];
    }];
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {

    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
   return self.anchors.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ZLyAnchorViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    cell.user = self.anchors[indexPath.item];
    return cell;

}

#pragma mark <UICollectionViewDelegate>
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    ZLyLiveCollectionViewController *liveVc = [[ZLyLiveCollectionViewController alloc] init];
    NSMutableArray *array = [NSMutableArray array];
    for (ZlyUser *user in self.anchors) {
        ZLyLive *live = [[ZLyLive alloc] init];
        live.bigpic = user.photo;
        live.myname = user.nickname;
        live.smallpic = user.photo;
        live.gps = user.position;
        live.useridx = user.useridx;
        live.allnum = arc4random_uniform(2000);
        live.flv = user.flv;
        [array addObject:live];
    }
    liveVc.lives = array;
    liveVc.currentIndex = indexPath.item;
    [self presentViewController:liveVc animated:YES completion:nil];
}
@end
