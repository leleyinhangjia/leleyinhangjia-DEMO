//
//  MoreContentViewController.m
//  36Ke
//
//  Created by lmj  on 16/3/20.
//  Copyright (c) 2016年 lmj . All rights reserved.
//

#import "MoreContentViewController.h"
#import "MoreHeaderView.h"
#import "MoreViewCell.h"
#import <MJExtension.h>
@interface MoreContentViewController () <UITableViewDelegate,UITableViewDataSource>



@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *arcArray;

@end

@implementation MoreContentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
}

- (void)setupUI {
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height - 64)];
    
    self.tableView.backgroundColor = self.view.backgroundColor;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
}

- (void)setAuthorArray:(NSMutableArray *)authorArray {
    _authorArray = authorArray;
    AuthorData *authorModel = _authorArray[0];
    _arcArray = authorModel.latestArticle;
}

- (UIView *)addHeaderView {
    MoreHeaderView *headerView = [MoreHeaderView headerView];
    AuthorData *authorData = _authorArray[0];
    headerView.model = authorData;
    return headerView;
}
//返回每个headView的高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 120;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 110;
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
    
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return [self addHeaderView];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.arcArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    Latestarticle *arcModel = self.arcArray[indexPath.row];
    
    MoreViewCell * cell = [MoreViewCell cellWithTableView:tableView];
    cell.model = arcModel;
//    cell.selectionStyle = UITableViewCellSelectionStyleGray;
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
//    ChildData *dataChild = self.arcArray[indexPath.row];
//    ContentViewController *contentVC = [[ContentViewController alloc] init];
//    [contentVC setChilData:dataChild];
//    [contentVC setHidesBottomBarWhenPushed:YES];//加上这句就可以把推出的ViewController隐藏Tabbar
//    [self.navigationController setNavigationBarHidden:YES animated:YES];
//    
//    [self.navigationController pushViewController:contentVC animated:YES];
    

    
//    if ([indexPath row]==self.newsArray.count)
//    {
//        return;
//        
//    }
//    ChildData *dataChild = self.newsArray[indexPath.row];
//    ContentViewController *contentVC = [[ContentViewController alloc] init];
//    [contentVC setChilData:dataChild];
//    [contentVC setHidesBottomBarWhenPushed:YES];//加上这句就可以把推出的ViewController隐藏Tabbar
//    [self.navigationController setNavigationBarHidden:YES animated:YES];
//    
//    [self.navigationController pushViewController:contentVC animated:YES];
//    
//    [tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath, nil] withRowAnimation:UITableViewRowAnimationNone];
    
}

@end
