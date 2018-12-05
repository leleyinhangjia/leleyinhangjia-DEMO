//
//  LMCommentViewController.m
//  36Ke
//
//  Created by lmj  on 16/3/10.
//  Copyright (c) 2016年 lmj . All rights reserved.
//

#import "LMCommentViewController.h"
#import "CommentListJsonHandler.h"
#import "CommentModel.h"
#import "LMNewsRefreshHeader.h"
#import "CommentCell.h"
#import "LMNavigationController.h"
@interface LMCommentViewController () <CommentListJsonHandlerDelegate,UITableViewDelegate,UITableViewDataSource>
{
    CommentListJsonHandler *commentHandler;
    CGFloat heightLabel;
}


@property (nonatomic, strong, readwrite) NSMutableArray *commentArray;

@property (nonatomic, strong) CommentData2 *dataComment;

@property (nonatomic, strong) ChildData *dataChild;

@property (nonatomic, assign) NSInteger commentCount;

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, assign) BOOL update;

@property (nonatomic, strong) NSString *lastId;

//@property (nona)


@end

@implementation LMCommentViewController

- (void)initChildData:(ChildData *)dataChild commentCount:(NSInteger)commentCount {
    _commentCount = commentCount;
    _dataChild = dataChild;
    _lastId = _dataChild.feedId;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    commentHandler = [[CommentListJsonHandler alloc] init];
    commentHandler.delegate = self;
    self.update = YES;
    [self setupUI];
    [self setupNaviItem];
    [self setupHeaderRefresh];
    self.update = YES;
    
    [self.view setBackgroundColor:[UIColor whiteColor]];
    // Do any additional setup after loading the view.
}
- (void)viewWillAppear:(BOOL)animated
{
    
    if (self.update == YES) {
        [self.tableView.mj_header beginRefreshing];
        self.update = NO;
    }

}


- (void)setupUI {
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height - 64)];
    
    
    self.tableView.backgroundColor = [UIColor whiteColor];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
}

- (void)setupNaviItem {
    NSString *comment = [NSString stringWithFormat:@"%ld条记录",_commentCount];
    self.navigationItem.title = comment;
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem initWithNormalImage:@"common_nav_icon_back"  target:self action:@selector(back)];
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem initWithTitle:@"写评论" titleColor:nil target:self action:@selector(writeComment)];
    
    
}


- (void)back {
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)writeComment {
    
}



- (void)setupHeaderRefresh {
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
    NSLog(@"_lastId----%@",_lastId);
    NSString *allUrlstring = [NSString stringWithFormat:@"https://rong.36kr.com/api/mobi/news/comments/%@",_lastId];
    [self loadDataForType:1   withURL:allUrlstring];
}
#pragma mark 上拉刷新
- (void)loadMoreData
{
    //    https://rong.36kr.com/api/mobi/news?   https://rong.36kr.com/api/mobi/news?columnId=67
    NSString *allUrlstring = [NSString stringWithFormat:@"https://rong.36kr.com/api/mobi/news/comments/%@?lastId=%@",_dataChild.feedId,_lastId];
    [self loadDataForType:2   withURL:allUrlstring];
    
}
// ------公共方法
- (void)loadDataForType:(int)type  withURL:(NSString *)allUrlstring
{
    [commentHandler handlerCommentObject:allUrlstring  type:type];
}


#pragma mark - CommentListJsonHandlerDelegate
- (void)CommentListJsonHandler2:(CommentListJsonHandler *)handler withResult:(NSMutableArray *)result type:(int)type {
    
    if (result.count == 0) {
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        return;
    }
    
    _dataComment = result.lastObject;
    _lastId = [NSString stringWithFormat:@"%ld",_dataComment.postId];
    if (type == 1) {
        self.commentArray = result;
        [self.tableView.mj_header endRefreshing];
        [self.tableView reloadData];
    }else if(type == 2){
        [self.commentArray addObjectsFromArray:result];
        [self.tableView.mj_footer endRefreshing];
        //        [self.tableView footerEndRefreshing];
        [self.tableView reloadData];
    }
}



#pragma mark - UITableViewDelegate



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return heightLabel;
}
/** 预估行高，这个方法可以减少上面方法的调用次数，提高性能 */
- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 126;
}
#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _commentArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CommentData2 *dataComment = _commentArray[indexPath.row];
    CommentCell *commentCell = [CommentCell cellWithTableView:tableView];
    commentCell.model = dataComment;
    /* 忽略点击效果 */
    [commentCell setSelectionStyle:UITableViewCellSelectionStyleNone];
    // 获得事先计算好的高度
    heightLabel =  commentCell.heightLabel;
    return commentCell;
}

@end
