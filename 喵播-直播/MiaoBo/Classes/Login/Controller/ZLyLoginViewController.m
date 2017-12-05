//
//  ZLyLoginViewController.m
//  MiaoBo
//
//  Created by leleyinhangjia on 2017/3/7.
//  Copyright © 2017年 leleyinhangjia All rights reserved.
//

#import "ZLyLoginViewController.h"
#import "ZLyThirdLoginView.h"
#import "MainViewController.h"
#import <CommonCrypto/CommonDigest.h>
#import<IJKMediaFramework/IJKMediaFramework.h>
@interface ZLyLoginViewController ()
/** palyer */
@property (nonatomic,strong) IJKFFMoviePlayerController *player;
/** 第三方登录 */
@property (nonatomic,strong,nonnull)  ZLyThirdLoginView *thirdView;
/** 快速通道 */
@property (nonatomic,strong,nonnull) UIButton *quickBtn;
/** 封面图片 */
@property (nonatomic,strong,nonnull) UIImageView *coverView;
@end

@implementation ZLyLoginViewController


#pragma mark - lifr circle
#pragma mark - 懒加载
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setup];
    
}
- (IJKFFMoviePlayerController *)player  {
    if (!_player) {
        //随机播放一组视频
        NSString *path = arc4random_uniform(10) % 2 ? @"login_video" : @"loginmovie";
        IJKFFMoviePlayerController *player = [[IJKFFMoviePlayerController alloc]initWithContentURLString:[[NSBundle mainBundle] pathForResource:path ofType:@"mp4"] withOptions:[IJKFFOptions optionsByDefault]];
        //设计player
        player.view.frame = CGRectMake(0, 0,ZLyScreenWidth, ZLyScreenHeight);
        //填充fill
        player.scalingMode = IJKMPMovieScalingModeAspectFill;
        [self.view addSubview:player.view];
        //设置自动播放
        player.shouldAutoplay = NO;
        //准备播放
        [player prepareToPlay];
        _player = player;
    }
    return _player;
}

- (ZLyThirdLoginView *)thirdView {
    if (!_thirdView) {
        
        ZLyThirdLoginView *third = [[ZLyThirdLoginView alloc] initWithFrame:CGRectMake(0, 0,ZLyScreenWidth , 200)];
        [third setClickLogin:^(LoginType type) {
            NSLog(@"type==================================%lu",(unsigned long)type);
            if ((unsigned long)type == 1) {
               // [self QQ];
                [self loginSuccess];
            }else{
               // [self wx];
            }
            
        }];
        third.hidden = YES;
        [self.view addSubview:third];
        _thirdView = third;
    }
    return _thirdView;
}
//封面
- (UIImageView *)coverView {
    if (!_coverView) {
        UIImageView *cover = [[UIImageView alloc]initWithFrame:self.view.bounds];
        cover.image = [UIImage imageNamed:@"LaunchImage"];
        [self.player.view addSubview:cover];
        _coverView = cover;
    }
    return _coverView;
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [self.player shutdown];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    
    [self.player.view removeFromSuperview];
    self.player = nil;
    
}

//设置UI
- (void)setup {
    [self initObserver];
    self.coverView.hidden = NO;
    
    //快送通道
    self.quickBtn = [UIButton new];
    _quickBtn.backgroundColor = [UIColor clearColor];
    _quickBtn.layer.borderWidth = 1;
    _quickBtn.layer.borderColor = [UIColor yellowColor].CGColor;
    [_quickBtn setTitle:@"快速通道" forState:(UIControlStateNormal)];
    [_quickBtn setTitleColor:[UIColor yellowColor] forState:(UIControlStateNormal)];
    [self.view addSubview:self.quickBtn];
    [[_quickBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        [self loginSuccess];
    }];
    [self.quickBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@40);
        make.right.equalTo(@-40);
        make.bottom.equalTo(@-60);
        make.height.equalTo(@40);
    }];
    
    [self.thirdView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(@0);
        make.height.equalTo(@60);
        make.bottom.equalTo(self.quickBtn.mas_top).offset(-40);
    }];
}
#pragma mark - private method
- (void)initObserver
{    // 监听视频是否播放完成
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didFinish) name:IJKMPMoviePlayerPlaybackDidFinishNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(stateDidChange) name:IJKMPMoviePlayerLoadStateDidChangeNotification object:nil];
}
//播放完继续播放
- (void)didFinish {
    [self.player play];
}
//观察状态是否改变
- (void)stateDidChange{
    //loadState 成功 IJKMPMovieLoadStatePlaythroughOK//播放自动启动
    if ((self.player.loadState & IJKMPMovieLoadStatePlaythroughOK) != 0) {
        if (!self.player.isPlaying) {
            self.coverView.frame = self.view.bounds;
            [self.view insertSubview:self.coverView atIndex:0];
            [self.player play];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                self.thirdView.hidden = NO;
                self.quickBtn.hidden = NO;
            });
        }
    }
}

//登录
- (void)loginSuccess {
    [self showHint:@"登陆成功"];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self presentViewController:[MainViewController new] animated:YES completion:^{
            [self.player stop];
            [self.player.view removeFromSuperview];
            self.player = nil;
        }];
        
    });
}

- (void)dealloc
{
   // NSLog(@"%s", __FUNCTION__);
}
@end
