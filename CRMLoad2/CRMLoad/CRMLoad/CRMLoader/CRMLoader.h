//
//  CRMLoader.h
//  CRMLoad
//
//  Created by FineexMac on 16/3/30.
//  Copyright © 2016年 iOS_Liu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CRMLoader : UIView

///开始加载
+ (void)loadingInView:(UIView *)view;

///停止加载
+ (void)endLoading;

@end
