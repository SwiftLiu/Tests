//
//  LPMusicPlayer.m
//  Demo
//
//  Created by FineexMac on 16/2/23.
//  Copyright © 2016年 iOS_LiuLiuLiu. All rights reserved.
//

#import "LPAudioPlayer.h"
#import <AVFoundation/AVFoundation.h>

@interface LPAudioPlayer ()<NSURLConnectionDataDelegate, AVAudioPlayerDelegate>
{
    AVAudioPlayer *player;//播放器
    
    long long dataLength;//资源总长度
    NSMutableArray<NSData*> *dataArray;//数据分段储存
    NSMutableData *stageData;//当前加载的数据段
    
    NSInteger dataIndex;//当前播放段索引
}


@end

@implementation LPAudioPlayer

#pragma mark - 初始化
- (instancetype)init
{
    self = [super init];
    if (self) {
        dataArray = [NSMutableArray array];
        stageData = [NSMutableData data];
    }
    return self;
}

+ (LPAudioPlayer *)playerWithPath:(NSString *)path
{
    //初始化播放器
    LPAudioPlayer *LPPlayer = [LPAudioPlayer new];
    
    return LPPlayer;
}

+ (LPAudioPlayer *)playerWithUrl:(NSString *)url
{
    //初始化播放器
    LPAudioPlayer *LPPlayer = [LPAudioPlayer new];
    
    //请求数据
    NSURL *URL = [NSURL URLWithString:url];
    NSURLRequest *request = [NSURLRequest requestWithURL:URL
                                             cachePolicy:NSURLRequestReloadIgnoringCacheData
                                         timeoutInterval:60];
    [NSURLConnection connectionWithRequest:request delegate:self];
    
    return LPPlayer;
}

#pragma mark - 播放器
- (void)initPlayerWithData:(NSData *)data
{
    player = nil;
    player = [[AVAudioPlayer alloc] initWithData:data error:nil];
    player.delegate = self;
    player.volume = 0.5;
    player.numberOfLoops = 1;
    if (![player prepareToPlay]) {
        NSLog(@"播放准备失败");
    }
}

#pragma mark - 重写
- (void)play
{
    if (![player play]) {
        NSLog(@"播放失败");
    }
}

- (void)pause
{
    [player pause];
}

- (void)stop
{
    [player stop];
    player = nil;
}


#pragma mark - <NSURLConnectionDataDelegate>
//接收到服务器响应
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    dataLength = [response expectedContentLength];
    NSString *fileName = [response suggestedFilename];
    NSLog(@"%@：%lld", fileName, dataLength);
}

//接收到数据
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [stageData appendData:data];
    if (stageData.length >= dataLength*0.05) {
        [dataArray addObject:stageData];
        stageData = [NSMutableData data];
    }
}

//接收完毕
- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    
}

@end
