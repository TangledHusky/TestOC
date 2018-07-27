//
//  TestZFPlayerViewController.m
//  TestOC
//
//  Created by 李亚军 on 2017/1/7.
//  Copyright © 2017年 zyyj. All rights reserved.
//

#import "TestZFPlayerViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "ZFPlayer.h"

@interface TestZFPlayerViewController ()
@property (strong, nonatomic) ZFPlayerView *playerView;
@property (nonatomic, strong) ZFPlayerModel *playerModel;
@property (nonatomic,strong) UIView  *bgView;
@end



@implementation TestZFPlayerViewController

- (ZFPlayerModel *)playerModel
{
    if (!_playerModel) {
        _playerModel                  = [[ZFPlayerModel alloc] init];
        _playerModel.title            = @"这里设置视频标题";
        _playerModel.videoURL         = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"智能拼图" ofType:@".mov"]];
        _playerModel.videoURL = [NSURL URLWithString:@"http://baobab.wdjcdn.com/1456117847747a_x264.mp4"];
        _playerModel.videoURL         = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"K12-2017-09-23-16-08-02" ofType:@".mp4"]];
        _playerModel.placeholderImage = [UIImage imageNamed:@"loading_bgView1"];
        _playerModel.fatherView       = _bgView;
        
    }
    return _playerModel;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    _bgView = [UIView new];
    _bgView.frame = CGRectMake(0, 65, KScreenWidth, 200);
    [self.view addSubview:_bgView];
    
    self.playerView = [[ZFPlayerView alloc] init];
    [self.playerView playerControlView:nil playerModel:self.playerModel];
    self.playerView.hasPreviewView = YES;
    [self.playerView autoPlayTheVideo];
    

}

// 返回值要必须为NO
- (BOOL)shouldAutorotate
{
    return NO;
}





@end
