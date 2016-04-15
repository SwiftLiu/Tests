//
//  ViewController.m
//  Demo
//
//  Created by FineexMac on 16/2/23.
//  Copyright © 2016年 iOS_LiuLiuLiu. All rights reserved.
//

#import "ViewController.h"
#import "LPAudioPlayer.h"

@interface ViewController ()<LPMusicPlayerDelegate>
{
    LPAudioPlayer *player;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    player = [LPAudioPlayer playerWithUrl:@"http://music.baidutt.com/up/kwcywkku/yucydu.mp3"];
    player.delegate = self;
}

- (IBAction)play:(id)sender {
    [player play];
}
- (IBAction)pause:(id)sender {
    [player pause];
}
- (IBAction)stop:(id)sender {
    [player stop];
}

#pragma mark - <LPMusicPlayerDelegate>
- (void)musicPlayer:(LPMusicPlayer *)player didPlayingProgress:(double)playProgress wordIndex:(NSInteger)index wordProgress:(double)wordProgress
{
    
}

@end
