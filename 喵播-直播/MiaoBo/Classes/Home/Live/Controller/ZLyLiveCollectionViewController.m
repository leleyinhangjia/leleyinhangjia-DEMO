

//
//  ZLyLiveCollectionViewController.m
//  MiaoBo
//
//  Created by leleyinhangjia on 2017/3/10.
//  Copyright © 2017年 leleyinhangjia All rights reserved.
//

#import "ZLyLiveCollectionViewController.h"
#import "ALinLiveViewCell.h"
#import "ZLyRefreshGifHeader.h"
#import "ALinLiveFlowLayout.h"
#import "ZlyUser.h"
#import "ALinUserView.h"
@interface ZLyLiveCollectionViewController ()
/** 用户信息 */
@property (nonatomic, weak) ALinUserView *userView;
@end

@implementation ZLyLiveCollectionViewController

static NSString * const reuseIdentifier = @"ALinLiveViewCell";

- (instancetype)init
{
       return [super initWithCollectionViewLayout:[[ALinLiveFlowLayout alloc] init]];
}

- (ALinUserView *)userView
{
    if (!_userView) {
        ALinUserView *userView = [ALinUserView userView];
        [self.collectionView addSubview:userView];
        _userView = userView;
        
        [userView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(@0);
            make.width.equalTo(@(ZLyScreenWidth));
            make.height.equalTo(@(ZLyScreenHeight));
        }];
        userView.transform = CGAffineTransformMakeScale(0.01, 0.01);
        [userView setCloseBlock:^{
            [UIView animateWithDuration:0.5 animations:^{
                self.userView.transform = CGAffineTransformMakeScale(0.01, 0.01);
            } completion:^(BOOL finished) {
                [self.userView removeFromSuperview];
                self.userView = nil;
            }];
        }];
        
    }
    return _userView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.collectionView.backgroundColor = [UIColor whiteColor];
    [self.collectionView registerClass:[ALinLiveViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    ZLyRefreshGifHeader *header = [ZLyRefreshGifHeader  headerWithRefreshingBlock:^{
        [self.collectionView.mj_header endRefreshing];
        self.currentIndex++;
        if (self.currentIndex == self.lives.count) {
            self.currentIndex = 0;
        }
        [self.collectionView reloadData];
    }];
    
    //
    self.collectionView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [self.collectionView.mj_footer endRefreshing];
        self.currentIndex++;
        if (self.currentIndex == self.lives.count) {
            self.currentIndex = 0;
        }
        [self.collectionView reloadData];
    }];
 
    
    header.stateLabel.hidden = NO;
    [header setTitle:@"下拉切换另一个主播" forState:MJRefreshStatePulling];
    [header setTitle:@"下拉切换另一个主播" forState:MJRefreshStateIdle];
    self.collectionView.mj_header = header;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(clickUser:) name:kNotifyClickUser object:nil];
    
}
- (void)clickUser:(NSNotification *)notify
{
    if (notify.userInfo[@"user"] != nil) {
        ZlyUser *user = notify.userInfo[@"user"];
        self.userView.user = user;
        [UIView animateWithDuration:0.5 animations:^{
            self.userView.transform = CGAffineTransformIdentity;
        }];
    }
}



#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {

    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ALinLiveViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    cell.parentVc = self;
    cell.live = self.lives[self.currentIndex];
    NSUInteger relateIndex = self.currentIndex;
    if (self.currentIndex + 1 == self.lives.count) {
        relateIndex = 0;
    }else{
        relateIndex += 1;
    }
    cell.relateLive = self.lives[relateIndex];
    [cell setClickRelatedLive:^{
        self.currentIndex += 1;
        [self.collectionView reloadData];
    }];
    return cell;

}

#pragma mark <UICollectionViewDelegate>

@end
