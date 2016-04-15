//
//  LPAlertView.h
//  FineExCourierAPP
//
//  Created by FineexMac on 15/8/28.
//  Copyright (c) 2015年 FineEX-LF. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LPCustomHUD : UIView

+ (void)show:(NSString *)msg;
+ (void)show:(NSString *)msg time:(NSTimeInterval)timeInterval;
+ (void)show:(NSString *)msg inView:(UIView *)view time:(NSTimeInterval)timeInterval;

@end
