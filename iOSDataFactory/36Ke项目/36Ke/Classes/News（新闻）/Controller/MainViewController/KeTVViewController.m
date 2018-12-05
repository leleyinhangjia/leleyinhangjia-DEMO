//
//  KeTVViewController.m
//  36Ke
//
//  Created by lmj  on 16/3/9.
//  Copyright (c) 2016年 lmj . All rights reserved.
//

#import "KeTVViewController.h"
#import "KeTVCell.h"
#import <MJRefresh.h>
#import <MJExtension.h>
#import "LMNavigationController.h"
#import "LMNewsCell.h"
#import "KeTVModel.h"
#import "Common.h"
#import "NewsListJsonHandler.h"
#import "LMNewsRefreshHeader.h"
#import "LMVideoPlayerOperationView.h"
#import "LMSearchViewController.h"

#define kDeviceVersion [[UIDevice currentDevice].systemVersion floatValue]
#define kNavbarHeight ((kDeviceVersion>=7.0)? 64 :44 )
#define kTabBarHeight 49
@interface KeTVViewController () <UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate,NewsListJsonHandlerDelegate> {
    NewsListJsonHandler *newsHandler;
//    WMPlayer *wmPlayer;
    LMVideoPlayerOperationView *lmPlayer;
    NSIndexPath *currentIndexPath;
}

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong, readwrite) NSMutableArray *newsArray;
@property (nonatomic, assign) BOOL update;
@property (nonatomic, assign) NSString *lastId;
@property (nonatomic, strong) NSString *column;
@property (nonatomic, strong) KeTVData2 *ketvData2;
@property (nonatomic, strong) KeTVCell *currentCell;
@property (nonatomic, strong) NSString *titleItem;
@property (nonatomic, assign) BOOL *identify;



@end

@implementation KeTVViewController



- (instancetype)initColumn:(NSString *)column title:(NSString *)title {
    _column = column;
    _titleItem = title;
    self.newsArray = [NSMutableArray array];
    if (self = [super init]) {
        //
    }
    return self;
}


- (void)viewDidLoad {
    self.update = YES;
    newsHandler = [[NewsListJsonHandler alloc] init];
    newsHandler.delegate = self;
    [self setupUI];
    
    [self setupNaviItem];
    
    [self setupHeaderRefresh];
    
    [self cacheHistory];
    
    // 注册全屏缩放通知
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(shrinkScreenBtnClick:) name:LMShrinkScreenPlayNotification object:nil];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    
    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIDeviceOrientationDidChangeNotification object:nil];
    
    if (self.update == YES) {
        [self.tableView.mj_header beginRefreshing];
        self.update = NO;
    }
}


#pragma mark scrollView delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if(scrollView ==self.tableView){
        if (lmPlayer==nil) {
            return;
        }
        
        if (lmPlayer.superview) {
            CGRect rectInTableView = [self.tableView rectForRowAtIndexPath:currentIndexPath];
            CGRect rectInSuperview = [self.tableView convertRect:rectInTableView toView:[self.tableView superview]];
            if (rectInSuperview.origin.y<-self.currentCell.frame.size.height||rectInSuperview.origin.y>self.view.frame.size.height-kNavbarHeight-kTabBarHeight) {//往上拖动
                
                if ([[UIApplication sharedApplication].keyWindow.subviews containsObject:lmPlayer]&&lmPlayer.isSmallScreen) {
                    lmPlayer.isSmallScreen = YES;
                }else{
                    //放widow上,小屏显示
                    [lmPlayer toSmallScreen];
                }
                
            }else{
                if ([self.currentCell.subviews containsObject:lmPlayer]) {
//                    [self toCell];
                }else{
                    _currentCell = (KeTVCell *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:currentIndexPath.row inSection:0]];
                    lmPlayer.currentCell = _currentCell;
                    [lmPlayer toCell:_currentCell];
                }
            }
        }
        
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}
-(void)dealloc{
    NSLog(@"%@ dealloc",[self class]);
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark
- (void)cacheHistory {
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
        
        self.newsArray = [KeTVData2 mj_objectArrayWithKeyValuesArray:array];
        KeTVData2 *ketvData = self.newsArray.lastObject;
        _lastId = ketvData.tv.id;
        [self.tableView beginUpdates];
        [self.tableView endUpdates];
        
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


#pragma mark - NewsListJsonHandlerDelegate
- (void)NewsListJsonHandler:(NewsListJsonHandler *)handler withResult:(NSMutableArray *)result type:(int)type {
    
    if (result.count == 0) {
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        return;
    }
    _ketvData2  = result.lastObject;
    _lastId = _ketvData2.tv.id;
    if (type == 1) {
        //        NSString *writeString = [NSString stringWithFormat:@"%@",self.newsArray];
        //        NSLog(@"writeString---%@",writeString);
        //        /** 缓存newsArray,整个分类的数据都存入其中，我可以通过传入的column来判断文件名称是哪种数据
        //          *  如果是全部，那么我命令文件可以是all,其他分类，可以通过传入的column命名，
        //             缓存文件只存当时第一次传入的数据，读取数据也是一样的
        //          */
        //        NSString *path=[k_DocumentsPath stringByAppendingPathComponent:[NSString stringWithFormat:@"/cach_%@.txt",_column]];
        //        [Common writeString:writeString toPath:path];
        
        
        self.newsArray = result;
        
        [self.tableView.mj_header endRefreshing];
        [self.tableView reloadData];
//        [self.tableView reloadData];
    }else if(type == 2){
        [self.newsArray addObjectsFromArray:result];
        [self.tableView.mj_footer endRefreshing];
        //        [self.tableView footerEndRefreshing];
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
    self.navigationItem.title = @"氪TV";
    
}

- (void)commonSearch {
    LMSearchViewController *searchVC = [[LMSearchViewController alloc] init];
    [self.navigationController pushViewController:searchVC animated:YES];
}

- (void)setupHeaderRefresh {
    
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
#pragma mark -－ 刷新数据
#pragma mark 下拉刷新
- (void)loadData
{
    
    NSString *allUrlstring = [NSString stringWithFormat:@"https://rong.36kr.com/api/mobi/news?columnId=%@",_column];
    
    [self loadDataForType:1  column:_column  withURL:allUrlstring];
}
#pragma mark 上拉刷新
- (void)loadMoreData
{
    NSString *allUrlstring = [NSString stringWithFormat:@"https://rong.36kr.com/api/mobi/news?columnId=%@&lastId=%@",_column,_lastId];
    
    
    [self loadDataForType:2 column:_column  withURL:allUrlstring];
    
}
// ------公共方法
- (void)loadDataForType:(int)type column:(NSString *)column withURL:(NSString *)allUrlstring
{
    [newsHandler handlerKeTVObject:allUrlstring type:type column:column];
    
}

#pragma mark - UITableViewDelegate


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    NSLog(@"cell----currentIndexPath.row = %ld",currentIndexPath.row);
    
    KeTVData2 *ketvModel = self.newsArray[indexPath.row];
    KeTVCell *cell = [KeTVCell cellWithTableView:tableView model:ketvModel];
    
    [cell.playBtn addTarget:self action:@selector(startPlayVideo:) forControlEvents:UIControlEventTouchUpInside];
    cell.playBtn.tag = indexPath.row;
    
    
    if (lmPlayer&&lmPlayer.superview) {
        if (indexPath.row==currentIndexPath.row) {
            [cell.playBtn.superview sendSubviewToBack:cell.playBtn];
        }else{
            [cell.playBtn.superview bringSubviewToFront:cell.playBtn];
        }
        NSArray *indexpaths = [tableView indexPathsForVisibleRows];
        if (![indexpaths containsObject:currentIndexPath]) {//复用
            
            if ([[UIApplication sharedApplication].keyWindow.subviews containsObject:lmPlayer]) {
                lmPlayer.hidden = NO;
                
            }else{
                lmPlayer.hidden = YES;
                [cell.playBtn.superview bringSubviewToFront:cell.playBtn];
            }
        }else{
            if ([cell.subviews containsObject:lmPlayer]) {
                [cell addSubview:lmPlayer];
                
                [lmPlayer play];
//                lmPlayer.playOrPauseBtn.selected = NO;
                lmPlayer.hidden = NO;
            }
            
        }
    }
    
    
    
    return cell;
}
-(void)startPlayVideo:(UIButton *)sender{
    currentIndexPath = [NSIndexPath indexPathForRow:sender.tag inSection:0];
    NSLog(@"startPlayVideo--currentIndexPath.row = %ld",currentIndexPath.row);
    if ([UIDevice currentDevice].systemVersion.floatValue>=8||[UIDevice currentDevice].systemVersion.floatValue<7) {
        self.currentCell = (KeTVCell *)sender.superview.superview;
    }else{//ios7系统 UITableViewCell上多了一个层级UITableViewCellScrollView
        self.currentCell = (KeTVCell *)sender.superview.superview.subviews;
        
    }
    KeTVData2 *model = [_newsArray objectAtIndex:sender.tag];
    if (lmPlayer.player) {
        [lmPlayer removeFromSuperview];
        [lmPlayer.player replaceCurrentItemWithPlayerItem:nil];
        [lmPlayer configAvplayer:model.tv.videoSource360];
        _currentCell = (KeTVCell *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:currentIndexPath.row inSection:0]];
        lmPlayer.currentCell = _currentCell;
        [lmPlayer play];
        
    }else{
        NSLog(@"model.tv.videoSource480---%@",model.tv.videoSource720);
        lmPlayer = [[LMVideoPlayerOperationView alloc]initWithFrame:self.currentCell.backgroundIV.bounds videoURLString:model.tv.videoSource360];
//        lmPlayer = [[LMVideoPlayerOperationView alloc] initWithFrame:<#(CGRect)#> videoURLString:<#(NSString *)#>]
        lmPlayer.currentCell = self.currentCell;
        [lmPlayer play];
        
    }
    self.currentCell = (KeTVCell *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:currentIndexPath.row inSection:0]];
    
    // 解决小屏幕的时候，点击其他视频，视频不出现在点击的cell上，而是出现在小屏幕上，而且小屏幕会往下移动，不便查看
    if (lmPlayer.isSmallScreen) {
        _currentCell = (KeTVCell *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:currentIndexPath.row inSection:0]];
        [lmPlayer toCell:_currentCell];
    } else {
        [self.currentCell addSubview:lmPlayer];
        [self.currentCell bringSubviewToFront:lmPlayer];
        [self.currentCell.playBtn.superview sendSubviewToBack:self.currentCell.playBtn];
    }
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 274;
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.newsArray.count;
}




@end
