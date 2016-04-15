//
//  LPAlertView.m
//  FineExCourierAPP
//
//  Created by FineexMac on 15/8/28.
//  Copyright (c) 2015年 FineEX-LF. All rights reserved.
//

#import "LPCustomHUD.h"

@implementation LPCustomHUD

+ (void)show:(NSString *)msg
{
    double time = msg.length/20.0l + 1;
    [LPCustomHUD show:msg time:time];
}

+ (void)show:(NSString *)msg time:(NSTimeInterval)timeInterval
{
    UIView *view = [[UIApplication sharedApplication].delegate window];
    [LPCustomHUD show:msg inView:view time:timeInterval];
}


+ (void)show:(NSString *)msg inView:(UIView *)view time:(NSTimeInterval)timeInterval
{
    LPCustomHUD *alertView = [LPCustomHUD new];
    alertView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.1];
    alertView.frame = view.bounds;
    [view addSubview:alertView];
    
    UIView *baseView = [UIView new];
    baseView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.8];
    baseView.alpha = 0;
    baseView.clipsToBounds = YES;
    baseView.layer.cornerRadius = 5;
    baseView.userInteractionEnabled = YES;
    [alertView addSubview:baseView];
    
    UILabel *label = [UILabel new];
    label.numberOfLines = 0;
    label.text = msg;
    label.textColor = [UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:1];
    label.font = [UIFont systemFontOfSize:16];
    label.textAlignment = NSTextAlignmentCenter;
    [baseView addSubview:label];
    
    //位置大小
    CGFloat margin = 18;
    CGSize maxSize = CGSizeMake(alertView.bounds.size.width *.65, alertView.bounds.size.height *.65);
    CGSize size = CGSizeMake(maxSize.width-margin*2, maxSize.height-margin*2);
    NSDictionary *attributes = @{NSFontAttributeName : label.font};
    label.bounds = [msg boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil];
    baseView.bounds = CGRectMake(0, 0, label.bounds.size.width+margin*2, label.bounds.size.height+margin*2);
    label.center = CGPointMake(CGRectGetMidX(baseView.bounds), CGRectGetMidY(baseView.bounds));
    baseView.center = CGPointMake(CGRectGetMidX(alertView.bounds), CGRectGetMidY(alertView.bounds));
    
    //动画
    NSTimeInterval duration = 0.3;
    [UIView animateWithDuration:duration animations:^{
        baseView.alpha = 1;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:duration delay:timeInterval-duration*2 options:(UIViewAnimationOptionCurveEaseInOut) animations:^{
            baseView.alpha = 0;
        } completion:^(BOOL finished) {
            [alertView removeFromSuperview];
        }];
    }];
}


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self removeFromSuperview];
}

@end
