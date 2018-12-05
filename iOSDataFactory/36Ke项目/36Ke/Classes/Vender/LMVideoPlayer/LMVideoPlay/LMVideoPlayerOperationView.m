//
//  LMVideoPlayerOperationView.m
//  LMVideoPlay
//
//  Created by lmj  on 16/3/18.
//  Copyright (c) 2016年 lmj . All rights reserved.
//

#import "LMVideoPlayerOperationView.h"
#import "LMVideoPlayerView.h"
#import "Masonry.h"


static const CGFloat kVideoPlayerControllerAnimationTimeInterval = 0.3f;


static void *PlayViewStatusObservationContext = &PlayViewStatusObservationContext;


@interface LMVideoPlayerOperationView ()

@property (nonatomic, assign) CGRect originFrame;
@property (nonatomic, retain) NSDateFormatter *dateFormatter;
@property (nonatomic, assign) double currentTimes;
@property (nonatomic, assign) double timeTemp;
/**
 *  定时器
 */
@property (nonatomic, retain) NSTimer *durationTimer;
/**
 *  隐藏LMVideoPlayerView定时器
 */
@property (nonatomic, retain) NSTimer *autoDismissTimer;



@end

@implementation LMVideoPlayerOperationView

- (void)deallocPlayer
{
    [self cancelObserver];
    
}

- (instancetype)initWithFrame:(CGRect)frame videoURLString:(NSString *)videoURLString{
    
    self = [super initWithFrame:frame];
    if (self) {
        _currentTimes = 0;
        self.frame = frame;
        self.originFrame = self.frame;
        self.backgroundColor = [UIColor grayColor];
        self.videoControl.frame = frame;
        self.videoControl.playOrPauseBtn.selected = NO;
        [self addSubview:self.videoControl];
        [self configAvplayer:videoURLString];
        [self configControlAction];
    }
    return self;
}
-(void)layoutSubviews{
    [super layoutSubviews];
    self.playerLayer.frame = self.layer.bounds;
}


- (void)configAvplayer:(NSString *)videoURLString {
    
    
    
    if (self.currentItem) {
        [[NSNotificationCenter defaultCenter] removeObserver:self name:AVPlayerItemDidPlayToEndTimeNotification object:_currentItem];
        [self.currentItem removeObserver:self forKeyPath:@"status"];
    }
    self.currentItem = [self getPlayItemWithURLString:videoURLString];
    //AVPlayer
    self.player = [AVPlayer playerWithPlayerItem:self.currentItem];
    self.playerLayer.backgroundColor = (__bridge CGColorRef)([UIColor redColor]);

    self.playerLayer = [AVPlayerLayer playerLayerWithPlayer:self.player];

    self.playerLayer.videoGravity = AVLayerVideoGravityResize;

    [self.layer addSublayer:self.playerLayer];
    [self bringSubviewToFront:self.videoControl];
    
    [self.currentItem addObserver:self
                       forKeyPath:@"status"
                          options:NSKeyValueObservingOptionInitial | NSKeyValueObservingOptionNew
                          context:PlayViewStatusObservationContext];
    
    
    //旋转屏幕通知
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(onDeviceOrientationChange)
                                                 name:UIDeviceOrientationDidChangeNotification
                                               object:nil
     ];

}

- (void)currentItemEndPause {
    
}


- (void)dismiss
{
    [self deallocPlayer];
    [self stopDurationTimer];
    [UIView animateWithDuration:kVideoPlayerControllerAnimationTimeInterval animations:^{
        self.alpha = 0.0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
        if (self.dimissCompleteBlock) {
            self.dimissCompleteBlock();
        }
    }];
    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationFade];
}

#pragma mark - Private Method

- (void)cancelObserver
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];

    [self.player pause];
    self.player = nil;

    [self.autoDismissTimer invalidate];
    [self.currentItem removeObserver:self forKeyPath:@"status"];
}

- (void)configControlAction
{
    [self.videoControl.playOrPauseBtn addTarget:self action:@selector(playButtonClick) forControlEvents:UIControlEventTouchUpInside];
//    [self.videoControl.pauseButton addTarget:self action:@selector(pauseButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.videoControl.closeBtn addTarget:self action:@selector(closeButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.videoControl.fullScreenButton addTarget:self action:@selector(fullScreenButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.videoControl.shrinkScreenButton addTarget:self action:@selector(shrinkScreenButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.videoControl.progressSlider addTarget:self action:@selector(progressSliderValueChanged:) forControlEvents:UIControlEventValueChanged];
    [self.videoControl.progressSlider addTarget:self action:@selector(progressSliderTouchBegan:) forControlEvents:UIControlEventTouchDown];
    [self.videoControl.progressSlider addTarget:self action:@selector(progressSliderTouchEnded:) forControlEvents:UIControlEventTouchUpInside];
    [self.videoControl.progressSlider addTarget:self action:@selector(progressSliderTouchEnded:) forControlEvents:UIControlEventTouchUpOutside];
    [self setProgressSliderMaxMinValues];
//    [self monitorVideoPlayback];
}


- (void)playButtonClick
{
    [self startDurationTimer];
    self.videoControl.playOrPauseBtn.selected = !self.videoControl.playOrPauseBtn.selected;
    if (self.player.rate != 1.f) {
        [self play];
    } else {
        [self pause];
    }
}


- (void)closeButtonClick
{
    [self dismiss];
}

- (void)fullScreenButtonClick
{
    [self removeFromSuperview];
    if (self.isFullscreenMode) {
        return;
    }
//    self.originFrame = self.frame;
    CGFloat height = [[UIScreen mainScreen] bounds].size.width;
    CGFloat width = [[UIScreen mainScreen] bounds].size.height;
    CGRect frame = CGRectMake((height - width) / 2, (width - height) / 2, width, height);;
    [UIView animateWithDuration:0.3f animations:^{
        self.viewframe = frame;
        [self setTransform:CGAffineTransformMakeRotation(M_PI_2)];
    } completion:^(BOOL finished) {
        self.isFullscreenMode = YES;
        self.videoControl.fullScreenButton.hidden = YES;
        self.videoControl.shrinkScreenButton.hidden = NO;
    }];
    
    [[UIApplication sharedApplication].keyWindow addSubview:self];
}

- (void)shrinkScreenButtonClick
{
    if (!self.isFullscreenMode) {
        return;
    }
    if (_currentCell) {
        if (self.isSmallScreen) {
            //放widow上,小屏显示
            [self toSmallScreen];
        }else{
            [self toCell:_currentCell];
        }
        return;
    }
    [self windowsShrinkScreen];
}

- (void)windowsShrinkScreen {
    [UIView animateWithDuration:0.3f animations:^{
        [self setTransform:CGAffineTransformIdentity];
        self.frame = self.originFrame;
        self.videoControl.frame = self.originFrame;
    } completion:^(BOOL finished) {
        self.isFullscreenMode = NO;
        self.videoControl.fullScreenButton.hidden = NO;
        self.videoControl.shrinkScreenButton.hidden = YES;
    }];
}



- (void)setProgressSliderMaxMinValues {
    CGFloat duration = self.playerLayer.duration;
    self.videoControl.progressSlider.minimumValue = 0.f;
    self.videoControl.progressSlider.maximumValue = floor(duration);
}

- (void)progressSliderTouchBegan:(UISlider *)slider {
//    [self pause];
    
    [self.videoControl cancelAutoFadeOutControlBar];
}

- (void)progressSliderTouchEnded:(UISlider *)slider {
    
    [self.player seekToTime:CMTimeMakeWithSeconds(slider.value, 1)];

    [self play];
    [self.videoControl autoFadeOutControlBar];
}

- (void)progressSliderValueChanged:(UISlider *)slider {
    double currentTime = floor(slider.value);
    _currentTimes = currentTime;
    
    double totalTime = floor(_playerLayer.duration);
    [self setTimeLabelValues:currentTime totalTime:totalTime];
}

- (void)monitorVideoPlayback
{
    if (self.currentTime == self.duration&&self.player.rate==.0f) {
        
        self.videoControl.playOrPauseBtn.selected = YES;
        [self dismiss];
        self.durationTimer = nil;
    }
    
}




- (void)setTimeLabelValues:(double)currentTime totalTime:(double)totalTime {
    double minutesElapsed = floor(currentTime / 60.0);
    double secondsElapsed = fmod(currentTime, 60.0);
    NSString *timeElapsedString = [NSString stringWithFormat:@"%02.0f:%02.0f", minutesElapsed, secondsElapsed];
    
    double minutesRemaining = floor(totalTime / 60.0);;
    double secondsRemaining = floor(fmod(totalTime, 60.0));;
    NSString *timeRmainingString = [NSString stringWithFormat:@"%02.0f:%02.0f", minutesRemaining, secondsRemaining];
    
    self.videoControl.timeLabel.text = [NSString stringWithFormat:@"%@/%@",timeElapsedString,timeRmainingString];
}

- (void)startDurationTimer
{
    
    if (self.durationTimer==nil) {
        self.durationTimer = [NSTimer timerWithTimeInterval:0.2 target:self selector:@selector(monitorVideoPlayback) userInfo:nil repeats:YES];
        [[NSRunLoop currentRunLoop] addTimer:self.durationTimer forMode:NSDefaultRunLoopMode];
    }
    
    
}

- (void)stopDurationTimer
{
    [self.durationTimer invalidate];
}

- (void)fadeDismissControl
{
    [self.videoControl animateHide];
}

#pragma mark - Property

- (LMVideoPlayerView *)videoControl
{
    if (!_videoControl) {
        _videoControl = [[LMVideoPlayerView alloc] init];
    }
    return _videoControl;
}



#pragma mark AVPlayerItem
- (AVPlayerItem *)getPlayItemWithURLString:(NSString *)urlString{
    if ([urlString rangeOfString:@"http"].location!=NSNotFound) {
        AVPlayerItem *playerItem=[AVPlayerItem playerItemWithURL:[NSURL URLWithString:[urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]];
        return playerItem;
    }else{
        AVAsset *movieAsset  = [[AVURLAsset alloc]initWithURL:[NSURL fileURLWithPath:urlString] options:nil];
        AVPlayerItem *playerItem = [AVPlayerItem playerItemWithAsset:movieAsset];
        return playerItem;
    }
    
}
#pragma mark play pause
-(void)play{
    if (self.player.rate !=1.f) {
        if ([self currentTime] == [self duration]){
            [self setCurrentTime:0.f];
        }
        [self.player play];
    }
}
-(void)pause{
    if (self.player.rate !=0.f) {
        [self.player pause];
    }
}
- (void)setViewframe:(CGRect)viewframe
{
    [self setFrame:viewframe];
    [self.videoControl setFrame:CGRectMake(0, 0, viewframe.size.width, viewframe.size.height)];
    [self.videoControl setNeedsLayout];
    [self.videoControl layoutIfNeeded];
}



- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
    /* AVPlayerItem "status" property value observer. */
    if (context == PlayViewStatusObservationContext)
    {
        
        AVPlayerStatus status = [[change objectForKey:NSKeyValueChangeNewKey] integerValue];
        switch (status)
        {
                /* Indicates that the status of the player is not yet known because
                 it has not tried to load new media resources for playback */
            case AVPlayerStatusUnknown:
            {
                [self setupAutoDismissTimer:0.0];

                [self.videoControl.indicatorView startAnimating];
            }
                break;
                
            case AVPlayerStatusReadyToPlay:
            {
                
                /* Once the AVPlayerItem becomes ready to play, i.e.
                 [playerItem status] == AVPlayerItemStatusReadyToPlay,
                 its duration can be fetched from the item. */
                if (CMTimeGetSeconds(self.player.currentItem.duration)) {
                    self.videoControl.progressSlider.maximumValue = CMTimeGetSeconds(self.player.currentItem.duration);
                }
                [self.videoControl.indicatorView stopAnimating];
                [self initTimer];
                [self startDurationTimer];
                
                //5s dismiss bottomView no repeats
//                [self setupAutoDismissTimer:5.0];
                
                
            }
                break;
                
            case AVPlayerStatusFailed:
            {
                [self setupAutoDismissTimer:0.0];
                [self.videoControl.indicatorView startAnimating];
            }
                break;
        }
    }
    
}

- (void)setupAutoDismissTimer:(double)timeInterval {
    if (self.autoDismissTimer==nil) {
        self.autoDismissTimer = [NSTimer timerWithTimeInterval:timeInterval target:self selector:@selector(autoDismissBottomView:) userInfo:nil repeats:NO];
        [[NSRunLoop currentRunLoop] addTimer:self.autoDismissTimer forMode:NSDefaultRunLoopMode];
    }
}

#pragma mark finished Means
- (double)currentTime{
    return CMTimeGetSeconds([[self player] currentTime]);
}

- (void)setCurrentTime:(double)time{
    [[self player] seekToTime:CMTimeMakeWithSeconds(time, 1)];
}

- (double)duration{
    AVPlayerItem *playerItem = self.player.currentItem;
    if (playerItem.status == AVPlayerItemStatusReadyToPlay){
        return CMTimeGetSeconds([[playerItem asset] duration]);
    }
    else{
        return 0.f;
    }
}

#pragma mark
#pragma mark autoDismissBottomView
-(void)autoDismissBottomView:(NSTimer *)timer{
    
    if (self.player.rate==.0f&&self.currentTime != self.duration) {
        
    }else if(self.player.rate==1.0f){
        if (self.videoControl.bottomView.alpha==1.0) {
            [UIView animateWithDuration:0.5 animations:^{
                
                [self.videoControl animateHide];
                
            } completion:^(BOOL finish){
                
            }];
        }
    }
}

#pragma mark time
#pragma  maik - 定时器
-(void)initTimer{
    double interval = .1f;
    
    CMTime playerDuration = [self playerItemDuration];
    if (CMTIME_IS_INVALID(playerDuration))
    {
        return;
    }
    double duration = CMTimeGetSeconds(playerDuration);
    if (isfinite(duration))
    {
        CGFloat width = CGRectGetWidth([self.videoControl.progressSlider bounds]);
        interval = 0.5f * duration / width;
    }
    NSLog(@"interva === %f",interval);
    
    __weak typeof(self) weakSelf = self;
    
    [weakSelf.player addPeriodicTimeObserverForInterval:CMTimeMakeWithSeconds(interval, NSEC_PER_SEC)  queue:NULL /* If you pass NULL, the main queue is used. */ usingBlock:^(CMTime time){
        [weakSelf syncScrubber];
    }];
    
}
- (void)syncScrubber{
    __weak typeof(self) weakSelf = self;
    
    CMTime playerDuration = [self playerItemDuration];

    if (CMTIME_IS_INVALID(playerDuration)){
        weakSelf.videoControl.progressSlider.minimumValue = 0.0;
        return;
    }
    
    double duration = CMTimeGetSeconds(playerDuration);
    if (isfinite(duration)){
        float minValue = [weakSelf.videoControl.progressSlider minimumValue];
        float maxValue = [weakSelf.videoControl.progressSlider maximumValue];
        double time = CMTimeGetSeconds([weakSelf.player currentTime]);
        _timeTemp = time;
        [self setTimeLabelValues:time totalTime:duration];
        [weakSelf.videoControl.progressSlider setValue:(maxValue - minValue) * time / duration + minValue];
        // 解决网速慢的问题
        dispatch_queue_t queue = dispatch_queue_create("cachePlay", DISPATCH_QUEUE_CONCURRENT);
        dispatch_async(queue, ^{
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                if (_timeTemp == time) {
                
                    [self.videoControl.indicatorView startAnimating];
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(7 * NSEC_PER_SEC)), queue, ^{
                        [self.videoControl.indicatorView stopAnimating];
                        [self play];
                    });
                    
                }
            });
        });
    

    }
}


- (CMTime)playerItemDuration{
    AVPlayerItem *playerItem = [self.player currentItem];
    if (playerItem.status == AVPlayerItemStatusReadyToPlay){
        return([playerItem duration]);
    }
    
    return(kCMTimeInvalid);
}


-(void)toSmallScreen{
    
    for (UIGestureRecognizer *recognizer in self.videoControl.gestureRecognizers) {
        [self.videoControl removeGestureRecognizer:recognizer];
    }
    // 如果是小屏幕添加一个小屏幕的手势
    if (!self.isSmallScreen) {
    // 单击的 Recognizer
        UITapGestureRecognizer* singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTap)];
        singleTap.numberOfTapsRequired = 1; // 单击
        [self addGestureRecognizer:singleTap];
    }
    //放widow上
    [self removeFromSuperview];
    [UIView animateWithDuration:0.5f animations:^{
        self.transform = CGAffineTransformIdentity;
        self.frame = CGRectMake(kScreenWidth/2,kScreenHeight-kTabBarHeight-(kScreenWidth/2)*0.75, kScreenWidth/2, (kScreenWidth/2)*0.75);
        self.playerLayer.frame =  self.bounds;
        self.videoControl.frame = self.bounds;
        [[UIApplication sharedApplication].keyWindow addSubview:self];
        
    }completion:^(BOOL finished) {
        self.isFullscreenMode = NO;
        self.isSmallScreen = YES;
        [[UIApplication sharedApplication].keyWindow bringSubviewToFront:self];
    }];
}

#pragma mark 为了达到app上的效果，暂时先这样
#pragma mark - 单击手势方法
- (void)handleSingleTap{
    // 跳到大屏幕后，移除自身小屏幕的手势，添加大屏幕的手势
    if (self.isSmallScreen) {
        [self fullScreenButtonClick];
    }
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self.videoControl action:@selector(onTap:)];
    [self.videoControl addGestureRecognizer:tapGesture];
    
    
}

- (void)toCell:(UITableViewCell *)cell{
    NSLog(@"cell-%@",cell);
    [self removeFromSuperview];
    [UIView animateWithDuration:0.5f animations:^{
        self.transform = CGAffineTransformIdentity;
        self.frame = cell.bounds;
        self.playerLayer.frame =  cell.bounds;
        self.videoControl.frame = cell.bounds;
        [cell addSubview:self];
        [cell bringSubviewToFront:self];
    }completion:^(BOOL finished) {
        self.isFullscreenMode = NO;
        self.isSmallScreen = NO;
        
    }];
}

-(void)toFullScreenWithInterfaceOrientation:(UIInterfaceOrientation )interfaceOrientation{
    [self removeFromSuperview];
    self.transform = CGAffineTransformIdentity;
    if (interfaceOrientation==UIInterfaceOrientationLandscapeLeft) {
        self.transform = CGAffineTransformMakeRotation(-M_PI_2);
    }else if(interfaceOrientation==UIInterfaceOrientationLandscapeRight){
        self.transform = CGAffineTransformMakeRotation(M_PI_2);
    }
    self.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
    self.playerLayer.frame =  CGRectMake(0,0, kScreenHeight,kScreenWidth);
    self.videoControl.frame = CGRectMake(0, 0, kScreenHeight, kScreenWidth);
    
    
    
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    
    // BUG
//    [self.current bringSubviewToFront:self];
    //    lmPlayer.fullScreenBtn.selected = YES;
//    [self bringSubviewToFront:self.videoControl.bottomView];
    
}
/**
 *  旋转屏幕通知
 */
- (void)onDeviceOrientationChange{
    if (self==nil||self.superview==nil){
        return;
    }
    UIDeviceOrientation orientation = [UIDevice currentDevice].orientation;
    UIInterfaceOrientation interfaceOrientation = (UIInterfaceOrientation)orientation;
    switch (interfaceOrientation) {
        case UIInterfaceOrientationPortraitUpsideDown:{
        }
            break;
        case UIInterfaceOrientationPortrait:{
            if (self.isFullscreenMode) {
                if (_currentCell) {
                    if (self.isSmallScreen) {
                        //放widow上,小屏显示
                        [self toSmallScreen];
                    }else{
                    
                        [self toCell:_currentCell];
                    }
                } else {
                    [self windowsShrinkScreen];
                }
            }
        }
            break;
        case UIInterfaceOrientationLandscapeLeft:{
            if (self.isFullscreenMode == NO) {
                self.isFullscreenMode = YES;
                
//                [self setNeedsStatusBarAppearanceUpdate];
                [self toFullScreenWithInterfaceOrientation:interfaceOrientation];
            }
        }
            break;
        case UIInterfaceOrientationLandscapeRight:{
            if (self.isFullscreenMode == NO) {
                self.isFullscreenMode = YES;
//                [self setNeedsStatusBarAppearanceUpdate];
                [self toFullScreenWithInterfaceOrientation:interfaceOrientation];
            }
        }
            break;
        default:
            break;
    }
}


@end
