//
//  LPMusicPlayerDelegate.h
//  Demo
//
//  Created by FineexMac on 16/2/23.
//  Copyright © 2016年 iOS_LiuLiuLiu. All rights reserved.
//

#import <Foundation/Foundation.h>

@class LPMusicPlayer;

@protocol LPMusicPlayerDelegate <NSObject>
@optional

///播放时回调(wordsIndex：正在播放的歌词；progress：该句歌词播放进度)
- (void)musicPlayer:(LPMusicPlayer *)player didPlayingProgress:(double)playProgress wordIndex:(NSInteger)index wordProgress:(double)wordProgress;

@end
