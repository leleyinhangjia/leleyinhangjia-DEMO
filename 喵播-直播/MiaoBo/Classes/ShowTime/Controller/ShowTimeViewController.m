//
//  ShowTimeViewController.m
//  MiaoBo
//
//  Created by leleyinhangjia on 2017/3/9.
//  Copyright © 2017年 leleyinhangjia All rights reserved.
//

#import "ShowTimeViewController.h"
//美颜相机
#import "LFLiveKit.h"

@interface ShowTimeViewController () <LFLiveSessionDelegate>
@property (weak, nonatomic) IBOutlet UIButton *beautifulBtn;//美颜按钮
@property (weak, nonatomic) IBOutlet UIButton *livingBtn;//开启直播按钮
@property (weak, nonatomic) IBOutlet UILabel *statusLabel;//状态(直播)

/** RTMP地址 */
@property (nonatomic, copy) NSString *rtmpUrl;
@property (nonatomic, weak) UIView *livingPreView;
/** LFLive */
@property (nonatomic,strong) LFLiveSession *session;
@end

@implementation ShowTimeViewController
//懒加载
- (UIView *)livingPreView {
    if (!_livingPreView) {
        UIView *livingPreView = [[UIView alloc] initWithFrame:self.view.bounds];
        livingPreView.backgroundColor = [UIColor clearColor];
        livingPreView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        [self.view insertSubview:livingPreView atIndex:0];
        _livingPreView = livingPreView;
    }
    return _livingPreView;
}
- (LFLiveSession *)session {
    if (!_session) {
        /***   默认分辨率 360*640  音频 44.1 iPhone6以上48 双声道 方向竖屏 ***/
        _session = [[LFLiveSession alloc] initWithAudioConfiguration:[LFLiveAudioConfiguration defaultConfiguration] videoConfiguration:[LFLiveVideoConfiguration defaultConfigurationForQuality:LFLiveVideoQuality_Medium2]];
        
         /**    自己定制高质量音频128K 分辨率设置为720*1280 方向竖屏 */
//        LFLiveAudioConfiguration *audioConfiguration  = [LFLiveAudioConfiguration new];
//        ///声道
//        audioConfiguration.numberOfChannels = 2;
//        /// 码率
//        audioConfiguration.audioBitrate = LFLiveAudioBitRate_128Kbps;
//        /// 采样率
//        audioConfiguration.audioSampleRate = LFLiveAudioSampleRate_44100Hz;
        
//         /***         默认视频配置          ***/
//     
//        LFLiveVideoConfiguration *videoConfiguration = [LFLiveVideoConfiguration new];
//        /// 视频的分辨率，宽高务必设定为 2 的倍数，否则解码播放时可能出现绿边
//        videoConfiguration.videoSize = CGSizeMake(720, 1280);
//        // 视频的码率，单位是 bps 码流 / 码率
//         /***   　
//          码流(Data Rate)是指视频文件在单位时间内使用的数据流量，也叫码率或码流率，通俗一点的理解就是取样率,是视频编码中画面质量控制中最重要的部分，一般我们用的单位是kb/s或者Mb/s。一般来说同样分辨率下，视频文件的码流越大，压缩比就越小，画面质量就越高。码流越大，说明单位时间内取样率越大，数据流，精度就越高，处理出来的文件就越接近原始文件，图像质量越好，画质越清晰，要求播放设备的解码能力也越高
//          
//          当然，码流越大，文件体积也越大，其计算公式是文件体积=时间X码率/8。例如，网络上常见的一部90分钟1Mbps码流的720P RMVB文件，其体积就=5400秒×1Mb/8=675MB
//          ***/
//        videoConfiguration.videoBitRate = 800 * 1024;
//        /// 视频的最大码率，即 fps
//        videoConfiguration.videoMaxBitRate = 1000*1024;
//        /// 视频的最小码率，即 fps
//        videoConfiguration.videoMinBitRate = 500*1024;
//        
//         /***   视频的帧率，即 fps ***/
//         /***  
//           帧速率也称为FPS(Frames PerSecond)的缩写——帧/秒。是指每秒钟刷新的图片的帧数，也可以理解为图形处理器每秒钟能够刷新几次。越高的帧速率可以得到更流畅、更逼真的动画。每秒钟帧数(FPS)越多，所显示的动作就会越流畅。
//          ***/
//        videoConfiguration.videoFrameRate = 15;
//        /// 最大关键帧间隔，可设定为 fps 的2倍，影响一个 gop 的大小
//        videoConfiguration.videoMaxKeyframeInterval = 30;
//        //视频方向
//        videoConfiguration.landscape = UIInterfaceOrientationIsPortrait(UIInterfaceOrientationPortrait);
//        ///< 分辨率
//        /***  
//          就是帧大小每一帧就是一副图像。
//         
//         640*480分辨率的视频，建议视频的码速率设置在700以上，音频采样率44100就行了
//         
//         一个音频编码率为128Kbps，视频编码率为800Kbps的文件，其总编码率为928Kbps，意思是经过编码后的数据每秒钟需要用928K比特来表示。
//         
//         计算输出文件大小公式：
//         （音频编码率（KBit为单位）/8 +视频编码率（KBit为单位）/8）×影片总长度（秒为单位）=文件大小（MB为单位）
//         
//         ***/
//        videoConfiguration.sessionPreset = LFCaptureSessionPreset720x1280;
//        
//         _session = [[LFLiveSession alloc] initWithAudioConfiguration:audioConfiguration videoConfiguration:videoConfiguration ];
        
        // 设置代理
        _session.delegate = self;
        _session.running = YES;
        _session.preView = self.livingPreView;
        
      
    }
    return _session;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setup];
}
- (void)setup {
    self.beautifulBtn.layer.cornerRadius = self.beautifulBtn.height * 0.5;
    self.beautifulBtn.layer.masksToBounds = YES;
    
    self.livingBtn.backgroundColor = KeyColor;
    self.livingBtn.layer.cornerRadius = self.livingBtn.height * 0.5;
    self.livingBtn.layer.masksToBounds = YES;
    
    self.statusLabel.numberOfLines = 0;
    
    // 默认开启后置摄像头
    self.session.captureDevicePosition = AVCaptureDevicePositionBack;
}
//关闭直播
- (IBAction)close:(UIButton *)sender {
    if (self.session.state == LFLivePending || self.session.state == LFLiveStart) {
        [self.session stopLive];
    }
    [self dismissViewControllerAnimated:YES completion:nil];
    
}
// 开启/关闭美颜相机
- (IBAction)beautiful:(UIButton *)sender {
    sender.selected = !sender.selected;
    //默认开启美颜功能的
    self.session.beautyFace = !self.session.beautyFace;
}
// 切换前置/后置摄像头
- (IBAction)switchCamare:(UIButton *)sender {
    AVCaptureDevicePosition devicePositon =  self.session.captureDevicePosition;
    self.session.captureDevicePosition = (devicePositon == AVCaptureDevicePositionBack) ? AVCaptureDevicePositionFront : AVCaptureDevicePositionBack;
     NSLog(@"切换前置/后置摄像头");
}
//开启直播
- (IBAction)living:(UIButton *)sender {
    sender.selected = !sender.selected;
    if (sender.selected) { // 开始直播
        LFLiveStreamInfo *stream = [LFLiveStreamInfo new];
        // 如果是跟我blog教程搭建的本地服务器, 记得填写你电脑的IP地址
        stream.url = @"rtmp://192.168.1.117:1935/rtmplive/room";
        self.rtmpUrl = stream.url;
        [self.session startLive:stream];
    }else{ // 结束直播
        [sender setTitle:@"结束直播" forState:(UIControlStateSelected)];
        [self.session stopLive];
        self.statusLabel.text = [NSString stringWithFormat:@"状态: 直播被关闭\nRTMP: %@", self.rtmpUrl];
      
    }
    
}
#pragma mark -- LFStreamingSessionDelegate
/** live status changed will callback */
- (void)liveSession:(LFLiveSession *)session liveStateDidChange:(LFLiveState)state {
     NSString *tempStatus;
    switch (state) {
        case LFLiveReady:
            tempStatus = @"准备中";
            break;
        case LFLivePending:
            tempStatus = @"连接中";
            break;
        case LFLiveStart:
            tempStatus = @"已连接";
            break;
        case LFLiveStop:
            tempStatus = @"已断开";
            break;
        case LFLiveError:
            tempStatus = @"连接出错";
            break;
        default:
            break;
    }
    self.statusLabel.text = [NSString stringWithFormat:@"状态: %@\nRTMP: %@", tempStatus, self.rtmpUrl];
}
/** live debug info callback */
- (void)liveSession:(nullable LFLiveSession *)session debugInfo:(nullable LFLiveDebug*)debugInfo{
    
}

/** callback socket errorcode */
- (void)liveSession:(nullable LFLiveSession*)session errorCode:(LFLiveSocketErrorCode)errorCode{
    
}

@end
