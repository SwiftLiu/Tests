//
//  CRMLoader.m
//  CRMLoad
//
//  Created by FineexMac on 16/3/30.
//  Copyright © 2016年 iOS_Liu. All rights reserved.
//

#import "CRMLoader.h"
#import "CRMLoaderAnimateView.h"


@interface CRMLoader()
{
    __weak IBOutlet UIImageView *imgView;
    __weak IBOutlet CRMLoaderAnimateView *animateView;
}
@end

@implementation CRMLoader

#pragma mark - 静态变量
static CRMLoader *sharedInstance = nil;

#pragma mark - 开始加载
+ (void)loadingInView:(UIView *)view
{
    //初始化
    [sharedInstance removeFromSuperview];
    NSString *nibName = NSStringFromClass([CRMLoader class]);
    sharedInstance = [[NSBundle mainBundle] loadNibNamed:nibName owner:nil options:nil].firstObject;
    sharedInstance.frame = view.bounds;
    sharedInstance.alpha = 0;
    [view addSubview:sharedInstance];
    [UIView animateWithDuration:0.3 animations:^{
        sharedInstance.alpha = 1;
    }];
    
    //开始加载动画
    [sharedInstance startAnimation];
}

- (void)startAnimation
{
    animateView.layer.cornerRadius = imgView.layer.cornerRadius+2;
    [animateView startAnimation];
}


#pragma mark - 结束加载
+ (void)endLoading
{
    [UIView animateWithDuration:0.3 animations:^{
        sharedInstance.alpha = 0;
    } completion:^(BOOL finished) {
        [sharedInstance removeFromSuperview];
        sharedInstance = nil;
    }];
}

@end
