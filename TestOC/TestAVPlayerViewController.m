//
//  TestAVPlayerViewController.m
//  TestOC
//
//  Created by 李亚军 on 2016/12/24.
//  Copyright © 2016年 zyyj. All rights reserved.
//

#import "TestAVPlayerViewController.h"
#import <AVFoundation/AVFoundation.h>

typedef NS_ENUM(NSInteger,Direction){
    LEFT,
    RIGHT,
};

@interface TestAVPlayerViewController ()
@property (weak, nonatomic) IBOutlet UIView *viewHead;              //显示返回按钮View
@property (weak, nonatomic) IBOutlet UIView *viewLogin;             //加载view
@property (weak, nonatomic) IBOutlet UIImageView *imageViewLogin;   //加载image
@property (weak, nonatomic) IBOutlet UIView *viewAvPlayer;          //播放视图
@property (weak, nonatomic) IBOutlet UISlider *slider;              //进度条
@property (weak, nonatomic) IBOutlet UIView *viewBottom;            //底部控制view
@property (weak, nonatomic) IBOutlet UIButton *btnPause;            //暂停播放按钮
@property (weak, nonatomic) IBOutlet UIButton *btnNetx;             //下一个按钮
@property (weak, nonatomic) IBOutlet UILabel *labelTimeNow;         //当前时间label
@property (weak, nonatomic) IBOutlet UILabel *labelTimeTotal;       //总时间label
@property (strong, nonatomic) AVPlayer *player;                     //播放器对象
@property (strong, nonatomic) id timeObserver;                      //视频播放时间观察者
@property (assign, nonatomic) float totalTime;                      //视频总时长
@property (assign, nonatomic) BOOL isHasMovie;                      //是否进行过移动
@property (assign, nonatomic) BOOL isBottomViewHide;                //底部的view是否隐藏
@property (assign, nonatomic) NSInteger subscript;                  //数组下标，记录当前播放视频
@property (assign, nonatomic) NSInteger currentTime;                //当前视频播放时间位置

@property (nonatomic,assign) BOOL  isPlayEnd;                       //是否播放结束
@property (nonatomic,assign) BOOL  isFullScreen;                       //是否 全屏

@property (nonatomic,assign) CGRect  lastFrame;
@property (nonatomic,strong) NSTimer  *splashTimer;
@end

@implementation TestAVPlayerViewController

-(AVPlayer *)player{
    if(_player==nil){
        AVPlayerItem *playerItem = [self getPlayItem:0];
        [self addObserverToPlayerItem:playerItem];
        _player = [AVPlayer playerWithPlayerItem:playerItem];
    }
    return  _player;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self initViews];   //初始化控件样式
    
    [self addPlayerClick];//双击,单击事件
    
    [self playVideo];   //设置视频源
    
    [self addProgressObserver]; //进度监听
    
    [self addNotification]; //添加播放完成监听

    
    _splashTimer = [NSTimer scheduledTimerWithTimeInterval:1  target:self selector:@selector(roteImageView) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:_splashTimer forMode:NSRunLoopCommonModes];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [[UIApplication sharedApplication]setStatusBarHidden:YES];
    [self.navigationController.navigationBar setHidden:YES];
    
    //接受远程控制事件
    [[UIApplication sharedApplication]beginReceivingRemoteControlEvents];
    [self becomeFirstResponder];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];

    [self.navigationController.navigationBar setHidden:NO];
    [[UIApplication sharedApplication] endReceivingRemoteControlEvents];
    [self resignFirstResponder];
    [_splashTimer invalidate];
}

- (void)initViews{
    self.slider.minimumTrackTintColor = [UIColor redColor];
    [self.slider setThumbImage:[UIImage imageNamed:@"圆点"] forState:UIControlStateNormal];
    
}

- (void)playVideo {
    AVPlayerLayer *playerlayer = [AVPlayerLayer playerLayerWithPlayer:self.player];
    playerlayer.frame = CGRectMake(0, 0, KScreenWidth, 200);
    [self.viewAvPlayer.layer addSublayer:playerlayer];
    //播放到历史记录的时间 参数:第几帧， 帧率  秒=time/timescale
    //[self.player seekToTime:CMTimeMake(30, 10)];
}

- (IBAction)btnPlayOrStop:(id)sender {
    if (_player.rate == 0) {
        
        //重播
        if (_isPlayEnd) {
            self.isPlayEnd = NO;
            [self.player seekToTime:kCMTimeZero];
        }
        
        [_player play];
        [self.btnPause setTitle:@"暂停" forState:UIControlStateNormal];
        [self.btnPause setBackgroundImage:[UIImage imageNamed:@"play_stop.png"] forState:UIControlStateNormal];
    }else{
        [_player pause];
        [self.btnPause setTitle:@"播放" forState:UIControlStateNormal];
        [self.btnPause setBackgroundImage:[UIImage imageNamed:@"play_start.png"] forState:UIControlStateNormal];
    }
}


- (IBAction)btnfullscreen:(id)sender {
    if (_isFullScreen == NO)
    {
        [self fullScreenWithDirection:LEFT];
    }
    else
    {
        [self originalscreen];
    }
    
}

- (void)fullScreenWithDirection:(Direction)direction
{
    
    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
    
    _isFullScreen = YES;
    
    self.lastFrame = self.viewAvPlayer.frame;
    
    [[UIApplication sharedApplication] setStatusBarHidden:YES];
    //添加到Window上
    [window addSubview:self.viewAvPlayer];
    
    if (direction == LEFT)
    {
        [UIView animateWithDuration:0.25 animations:^{
            self.viewAvPlayer.transform = CGAffineTransformMakeRotation(M_PI / 2);
        }];
    }
    else
    {
        [UIView animateWithDuration:0.25 animations:^{
            self.viewAvPlayer.transform = CGAffineTransformMakeRotation( - M_PI / 2);
        }];
    }
    
}
#pragma mark - 原始大小
- (void)originalscreen
{
    _isFullScreen = NO;

    [[UIApplication sharedApplication] setStatusBarHidden:NO];
    
    [UIView animateWithDuration:0.25 animations:^{
        //还原大小
        self.viewAvPlayer.transform = CGAffineTransformMakeRotation(0);
    }];
    
    self.viewAvPlayer.frame = self.lastFrame;
   
}

- (void)addPlayerClick{
    //单机手势监听
    UITapGestureRecognizer * tapGes=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(playerSingleClick:)];
    tapGes.numberOfTapsRequired=1;
    [self.viewAvPlayer addGestureRecognizer:tapGes];
    /*
     //双击手势监听
     UITapGestureRecognizer * tapGesDouble=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(playerDoubleTap:)];
     tapGesDouble.numberOfTapsRequired=2;
     [self.viewAvPlayer addGestureRecognizer:tapGesDouble];
     //双击手势确定监测失败才会触发单击手势的相应操作
     [tapGes requireGestureRecognizerToFail:tapGesDouble];*/
}
//显示或隐藏控制view
- (void)playerSingleClick:(UITapGestureRecognizer*)recognizer{
    if (self.isBottomViewHide) {
        //显示
        [UIView animateWithDuration:0.3 animations:^{
            [self.viewBottom setAlpha:1];
            [self.viewHead setAlpha:1];
        }];
    }else{
        //隐藏
        [UIView animateWithDuration:0.3 animations:^{
            [self.viewBottom setAlpha:0.0];
            [self.viewHead setAlpha:0.0];
        }];
    }
    self.isBottomViewHide=!self.isBottomViewHide;
}

- (AVPlayerItem *)getPlayItem:(NSUInteger)videoIndex{
    NSString *urlStr = [[NSBundle mainBundle] pathForResource:@"智能拼图" ofType:@"mov"];
    AVPlayerItem *playerItem = [AVPlayerItem playerItemWithURL:[NSURL fileURLWithPath:urlStr]];
    return playerItem;
}

//设置播放时长
- (void)setTime:(float)current withTotal:(float)total{
    self.slider.value = current/total;
    self.labelTimeNow.text = [self displayTime:(int)current];
    self.labelTimeTotal.text = [self displayTime:(int)total];
}
- (NSString*)displayTime:(int)timeInterval{
    NSString * time = @"";
    int seconds = timeInterval % 60;
    int minutes = (timeInterval / 60) % 60;
    int hours = timeInterval / 3600;
    NSString * secondsStr=seconds<10?[NSString stringWithFormat:@"%@%d",@"0",seconds]:[NSString stringWithFormat:@"%d",seconds];
    NSString * minutesStr=minutes<10?[NSString stringWithFormat:@"%@%d",@"0",minutes]:[NSString stringWithFormat:@"%d",minutes];
    NSString * hoursStr=hours<10?[NSString stringWithFormat:@"%@%d",@"0",hours]:[NSString stringWithFormat:@"%d",hours];
    if (self.totalTime > 3600) {
        time = [NSString stringWithFormat:@"%@%@%@%@%@",hoursStr,@":",minutesStr,@":",secondsStr];
    }else{
        time = [NSString stringWithFormat:@"%@%@%@",minutesStr,@":",secondsStr];
        
    }
    return time;
}

//视频加载指示条
- (void)roteImageView{
    CABasicAnimation* rotationAnimation;
    rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation.toValue = [NSNumber numberWithFloat: M_PI * 2.0 ];
    rotationAnimation.cumulative = YES;
    rotationAnimation.repeatCount = 1;
    rotationAnimation.duration = 1;
    [self.imageViewLogin.layer addAnimation:rotationAnimation forKey:@"rotationAnimation"];
}

- (void)addProgressObserver{
    AVPlayerItem *playerItem = self.player.currentItem;
    //这里设置每秒执行一次
    __weak __typeof(self) weakself = self;
    self.timeObserver = [_player addPeriodicTimeObserverForInterval:CMTimeMake(1.0, 1.0) queue:dispatch_get_main_queue() usingBlock:^(CMTime time) {
        float current = CMTimeGetSeconds(time);
        float total = CMTimeGetSeconds([playerItem duration]);
        weakself.currentTime = current;
        if (current) {
            [weakself setTime:current withTotal:total];
        }
    }];
}


//给AVPlayerItem添加播放完成通知
- (void)addNotification{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playbackFinished:) name:AVPlayerItemDidPlayToEndTimeNotification object:_player.currentItem];
}
// 播放完成通知
- (void)playbackFinished:(NSNotification *)notification{
    NSLog(@"视频播放完成.");
    [self savePayHistory];
    self.isPlayEnd = YES;
    [self.btnPause setTitle:@"再次播放" forState:UIControlStateNormal];
    
}

//保存播放历史
- (void)savePayHistory{
    NSDate *currentDate = [NSDate date];//获取当前时间,日期
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"YYYY-MM-dd"];
    NSString *dateString = [dateFormatter stringFromDate:currentDate];
//    VedioModel *vedioModel = _arrVedio[subscript];
//    VedioHistory *vedioHistory = [[VedioHistory alloc] init];
//    [vedioHistory insertTitle:vedioModel.strTitle createTime:dateString userId:[NSNumber numberWithInt:[vedioModel.strUserID intValue]] videoType:[NSNumber numberWithInt:vedioModel.vedioType]  playTime:[NSNumber numberWithInteger:self.currentTime] videoUrl:vedioModel.strURL picUrl:vedioModel.strImage];
}

/**
 *  给AVPlayerItem添加监控
 *  @param playerItem AVPlayerItem对象
 */
- (void)addObserverToPlayerItem:(AVPlayerItem *)playerItem{
    //监控状态属性，注意AVPlayer也有一个status属性，通过监控它的status也可以获得播放状态
    [playerItem addObserver:self forKeyPath:@"status" options:NSKeyValueObservingOptionNew context:nil];
    //监控网络加载情况属性
    [playerItem addObserver:self forKeyPath:@"loadedTimeRanges" options:NSKeyValueObservingOptionNew context:nil];
    //监听播放的区域缓存是否为空
    [playerItem addObserver:self forKeyPath:@"playbackBufferEmpty" options:NSKeyValueObservingOptionNew context:nil];
    //缓存可以播放的时候调用
    [playerItem addObserver:self forKeyPath:@"playbackLikelyToKeepUp" options:NSKeyValueObservingOptionNew context:nil];
}

/**
 *  通过KVO监控播放器状态
 *  @param keyPath 监控属性
 *  @param object  监视器
 *  @param change  状态改变
 *  @param context 上下文
 */
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    AVPlayerItem *playerItem = object;
    if ([keyPath isEqualToString:@"status"]) {
         AVPlayerStatus status= [[change objectForKey:@"new"] intValue];
        if(status == AVPlayerStatusReadyToPlay){
            self.totalTime = CMTimeGetSeconds(playerItem.duration);
            NSLog(@"开始播放,视频总长度:%.2f",CMTimeGetSeconds(playerItem.duration));
            [self.btnPause setTitle:@"暂停" forState:UIControlStateNormal];
            [self.btnPause setBackgroundImage:[UIImage imageNamed:@"play_stop.png"] forState:UIControlStateNormal];
            [_player play];
            [self.viewLogin setHidden:YES];
        }else if(status == AVPlayerStatusUnknown){
            NSLog(@"%@",@"AVPlayerStatusUnknown");
        }else if (status == AVPlayerStatusFailed){
            NSLog(@"%@",@"AVPlayerStatusFailed");
        }
    }else if([keyPath isEqualToString:@"loadedTimeRanges"]){
        NSArray *array = playerItem.loadedTimeRanges;
        CMTimeRange timeRange = [array.firstObject CMTimeRangeValue];//本次缓冲时间范围
        float startSeconds = CMTimeGetSeconds(timeRange.start);
        float durationSeconds = CMTimeGetSeconds(timeRange.duration);
        NSTimeInterval totalBuffer = startSeconds + durationSeconds;//缓冲总长度
        if (self.currentTime < (startSeconds + durationSeconds + 8)) {
            self.viewLogin.hidden  = YES;
            if ([self.btnPause.titleLabel.text isEqualToString:@"暂停"]) {
                [_player play];
            }
        }else{
            self.viewLogin.hidden = NO;
        }
        NSLog(@"缓冲：%.2f",totalBuffer);
    }else if ([keyPath isEqualToString:@"playbackBufferEmpty"]){
        NSLog(@"playbackBufferEmpty");
        [self.viewLogin setHidden:YES];
    }else if ([keyPath isEqualToString:@"playbackLikelyToKeepUp"]){
        [self.viewLogin setHidden:NO];
        NSLog(@"playbackLikelyToKeepUp");
    }
    
}


- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [self removeObserverFromPlayerItem:self.player.currentItem];
    [self.player removeTimeObserver:self.timeObserver];
}

- (void)removeObserverFromPlayerItem:(AVPlayerItem *)playerItem{
    [playerItem removeObserver:self forKeyPath:@"status"];
    [playerItem removeObserver:self forKeyPath:@"loadedTimeRanges"];
    [playerItem removeObserver:self forKeyPath:@"playbackBufferEmpty"];
    [playerItem removeObserver:self forKeyPath:@"playbackLikelyToKeepUp"];
}

@end
