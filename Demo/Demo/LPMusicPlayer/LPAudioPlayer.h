//
//  LPMusicPlayer.h
//  Demo
//
//  Created by FineexMac on 16/2/23.
//  Copyright © 2016年 iOS_LiuLiuLiu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LPAudioPlayerDelegate.h"

@interface LPAudioPlayer : NSObject

///所有歌词
@property (strong, nonatomic, readonly) NSString *words;

///代理
@property (assign) id<LPMusicPlayerDelegate> delegate;

///便利初始化网络播放器
+ (LPAudioPlayer *)playerWithUrl:(NSString *)url;
///便利初始化本地播放器
+ (LPAudioPlayer *)playerWithPath:(NSString *)path;

///开始播放
- (void)play;
///暂停播放
- (void)pause;
///停止播放
- (void)stop;

@end