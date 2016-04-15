//
//  PayPsdView.h
//  FineExAPP
//
//  Created by FineexMac on 15/9/6.
//  Copyright (c) 2015年 FineEX-LF. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^PayPsdViewConfirmBlock)(NSString *payPsd);

@interface PayPsdView : UIView

//确认处理
@property (strong, nonatomic) PayPsdViewConfirmBlock confirmBlock;
//标题
@property (strong, nonatomic) NSString *title;
//金额
@property (assign, nonatomic) float amount;
//密码长度，默认为6
@property (assign, nonatomic) int psdLenght;

//显示
- (void)show;

//便利显示
+ (void)showTitle:(NSString *)title amount:(float)amount confirmBlock:(PayPsdViewConfirmBlock)block;

@end
