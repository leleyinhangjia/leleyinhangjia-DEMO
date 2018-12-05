//
//  LMVideoPlayerView.m
//  LMVideoPlay
//
//  Created by lmj  on 16/3/16.
//  Copyright (c) 2016年 lmj . All rights reserved.
//

#import "LMVideoPlayerView.h"
#import "Masonry.h"
#import "UIImage+Extension.h"

static const CGFloat kVideoControlBarHeight = 40.0;
static const CGFloat kVideoControlAnimationTimeInterval = 0.3;
static const CGFloat kVideoControlTimeLabelFontSize = 10.0;
static const CGFloat kVideoControlBarAutoFadeOutTimeInterval = 5.0;



@interface LMVideoPlayerView ()

@property (nonatomic, assign) BOOL isBarShowing;

/** 背部的遮盖按钮 */
@property (nonatomic, strong) UIButton *maxCoverBtn;
/** 记录父视图的bouns */
@property (nonatomic, assign) CGRect superViewBouns;

@end

@implementation LMVideoPlayerView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.frame = frame;
        [self configView];
        
    }
    return self;
}




- (void)configView {
    
    self.backgroundColor = [UIColor clearColor];
    self.alpha = 1;
    [self addSubview:self.topView];
    [self.topView addSubview:self.closeBtn];
    [self addSubview:self.bottomView];
    [self addSubview:self.playOrPauseBtn];
    //        [self.bottomView addSubview:self.pauseButton];
    //        self.playOrPauseBtn.hidden = YES;
    [self.bottomView addSubview:self.fullScreenButton];
    [self.bottomView addSubview:self.shrinkScreenButton];
    self.shrinkScreenButton.hidden = YES;
    [self.bottomView addSubview:self.progressSlider];
    [self.bottomView addSubview:self.timeLabel];
    [self addSubview:self.indicatorView];
    
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onTap:)];
    [self addGestureRecognizer:tapGesture];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    
    
    self.topView.frame = CGRectMake(CGRectGetMinX(self.bounds), CGRectGetMinY(self.bounds), CGRectGetWidth(self.bounds), kVideoControlBarHeight);
    self.closeBtn.frame = CGRectMake(CGRectGetWidth(self.topView.bounds) - CGRectGetWidth(self.closeBtn.bounds), CGRectGetMinX(self.topView.bounds), CGRectGetWidth(self.closeBtn.bounds), CGRectGetHeight(self.closeBtn.bounds));
    self.bottomView.frame = CGRectMake(CGRectGetMinX(self.bounds), CGRectGetHeight(self.bounds) - kVideoControlBarHeight, CGRectGetWidth(self.bounds), kVideoControlBarHeight);
    
    self.playOrPauseBtn.frame = CGRectMake(CGRectGetWidth(self.bounds)/ 2 -20, CGRectGetHeight(self.bounds) / 2 - 40 , CGRectGetWidth(self.playOrPauseBtn.bounds), CGRectGetHeight(self.playOrPauseBtn.bounds));
    
    
    self.fullScreenButton.frame = CGRectMake(CGRectGetWidth(self.bottomView.bounds) - CGRectGetWidth(self.fullScreenButton.bounds), CGRectGetHeight(self.bottomView.bounds)/2 - CGRectGetHeight(self.fullScreenButton.bounds)/2, CGRectGetWidth(self.fullScreenButton.bounds), CGRectGetHeight(self.fullScreenButton.bounds));
    self.shrinkScreenButton.frame = self.fullScreenButton.frame;
    self.progressSlider.frame = CGRectMake(CGRectGetMinX(self.bottomView.bounds) + 3, CGRectGetHeight(self.bottomView.bounds)/2 - CGRectGetHeight(self.progressSlider.bounds)/2, CGRectGetMinX(self.fullScreenButton.frame) - CGRectGetMinX(self.bottomView.bounds), CGRectGetHeight(self.progressSlider.bounds));
    self.timeLabel.frame = CGRectMake(CGRectGetMidX(self.progressSlider.frame), CGRectGetHeight(self.bottomView.bounds) - CGRectGetHeight(self.timeLabel.bounds) - 2.0, CGRectGetWidth(self.progressSlider.bounds)/2, CGRectGetHeight(self.timeLabel.bounds));
    self.indicatorView.center = CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds));
    
    
    
}


- (void)didMoveToSuperview
{
    [super didMoveToSuperview];
    self.isBarShowing = YES;
}

- (void)animateHide
{
    if (!self.isBarShowing) {
        return;
    }
    [UIView animateWithDuration:kVideoControlAnimationTimeInterval animations:^{
        self.topView.alpha = 0.0;
        self.bottomView.alpha = 0.0;
        self.playOrPauseBtn.alpha = 0.0;
        self.backgroundColor = [UIColor clearColor];
        self.alpha = 1.0;
    } completion:^(BOOL finished) {
        self.isBarShowing = NO;
    }];
}

- (void)animateShow
{
    if (self.isBarShowing) {
        return;
    }
    [UIView animateWithDuration:kVideoControlAnimationTimeInterval animations:^{
        self.topView.alpha = 1.0;
        self.bottomView.alpha = 1.0;
//        [self maskCoverBtn];
        self.backgroundColor = [UIColor grayColor];
        self.alpha = 0.8;
        self.playOrPauseBtn.alpha = 1.0;
    } completion:^(BOOL finished) {
        self.isBarShowing = YES;
        [self autoFadeOutControlBar];
    }];
}

- (void)autoFadeOutControlBar
{
    if (!self.isBarShowing) {
        return;
    }
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(animateHide) object:nil];
    [self performSelector:@selector(animateHide) withObject:nil afterDelay:kVideoControlBarAutoFadeOutTimeInterval];
}

- (void)cancelAutoFadeOutControlBar
{
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(animateHide) object:nil];
}

- (void)onTap:(UITapGestureRecognizer *)gesture
{

    if (gesture.state == UIGestureRecognizerStateRecognized) {
        if (self.isBarShowing) {
            [self animateHide];
        } else {
            [self animateShow];
        }
    }
}

#pragma mark - Property

- (UIView *)topView
{
    if (!_topView) {
        _topView = [UIView new];
        _topView.backgroundColor = [UIColor clearColor];
    }
    return _topView;
}

- (UIView *)bottomView
{
    if (!_bottomView) {
        _bottomView = [UIView new];
        _bottomView.backgroundColor = [UIColor clearColor];
    }
    return _bottomView;
}

- (UIButton *)playOrPauseBtn
{
    if (!_playOrPauseBtn) {
        _playOrPauseBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_playOrPauseBtn setImage:[UIImage imageNamed:[self videoImageName:@"kr-video-player-play"]] forState:UIControlStateNormal];
        [_playOrPauseBtn setImage:[UIImage imageNamed:[self videoImageName:@"kr-video-player-pause"]] forState:UIControlStateSelected];
        _playOrPauseBtn.showsTouchWhenHighlighted = YES;
        _playOrPauseBtn.bounds = CGRectMake(0, 0, kVideoControlBarHeight, kVideoControlBarHeight);
    }
    return _playOrPauseBtn;
}


- (UIButton *)fullScreenButton
{
    if (!_fullScreenButton) {
        _fullScreenButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_fullScreenButton setImage:[UIImage imageNamed:[self videoImageName:@"kr-video-player-fullscreen"]] forState:UIControlStateNormal];
        _fullScreenButton.bounds = CGRectMake(0, 0, kVideoControlBarHeight, kVideoControlBarHeight);
    }
    return _fullScreenButton;
}

- (UIButton *)shrinkScreenButton
{
    if (!_shrinkScreenButton) {
        _shrinkScreenButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_shrinkScreenButton setImage:[UIImage imageNamed:[self videoImageName:@"kr-video-player-shrinkscreen"]] forState:UIControlStateNormal];
        _shrinkScreenButton.bounds = CGRectMake(0, 0, kVideoControlBarHeight, kVideoControlBarHeight);
    }
    return _shrinkScreenButton;
}

- (UISlider *)progressSlider
{
    if (!_progressSlider) {
        _progressSlider = [[UISlider alloc] init];
        [_progressSlider setThumbImage:[UIImage imageNamed:[self videoImageName:@"kr-video-player-point"]] forState:UIControlStateNormal];
        [_progressSlider setMinimumTrackTintColor:[UIColor whiteColor]];
        [_progressSlider setMaximumTrackTintColor:[UIColor lightGrayColor]];
        _progressSlider.value = 0.f;
        _progressSlider.continuous = YES;
    }
    return _progressSlider;
}

- (UIButton *)closeBtn
{
    if (!_closeBtn) {
        _closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_closeBtn setImage:[[UIImage imageNamed:[self videoImageName:@"news_krtv_close"]] imageByScalingToSize:CGSizeMake(15, 15)] forState:UIControlStateNormal];
        _closeBtn.bounds = CGRectMake(0, 0, kVideoControlBarHeight, kVideoControlBarHeight);
    }
    return _closeBtn;
}

- (UILabel *)timeLabel
{
    if (!_timeLabel) {
        _timeLabel = [UILabel new];
        _timeLabel.backgroundColor = [UIColor clearColor];
        _timeLabel.font = [UIFont systemFontOfSize:kVideoControlTimeLabelFontSize];
        _timeLabel.textColor = [UIColor whiteColor];
        _timeLabel.textAlignment = NSTextAlignmentRight;
        _timeLabel.bounds = CGRectMake(0, 0, kVideoControlTimeLabelFontSize, kVideoControlTimeLabelFontSize);
    }
    return _timeLabel;
}

- (UIActivityIndicatorView *)indicatorView
{
    if (!_indicatorView) {
        _indicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
        [_indicatorView stopAnimating];
    }
    return _indicatorView;
}

#pragma mark - Private Method

- (NSString *)videoImageName:(NSString *)name
{
    if (name) {
        NSString *path = [NSString stringWithFormat:@"LMPlayer.bundle/%@",name];
        return path;
    }
    return nil;
}



@end

