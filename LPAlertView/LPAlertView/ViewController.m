//
//  ViewController.m
//  LPAlertView
//
//  Created by FineexMac on 16/1/26.
//  Copyright © 2016年 LPiOS. All rights reserved.
//

#import "ViewController.h"
#import "LPAlertView.h"
#import "PayPsdView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIScrollView *s = [UIScrollView new];
    
}


- (IBAction)alert:(id)sender {
    [LPAlertView showForkWithTitle:@"客服电话" message:@"400-820-3341" leftTitle:nil rightTitle:@"拨打" leftBlock:^{
        NSLog(@"左按钮");
    } rightBlock:nil];

}

- (IBAction)pay:(id)sender {
    [PayPsdView showTitle:@"支付邮费" amount:2.34 confirmBlock:^(NSString *payPsd) {
        NSLog(@"支付完成");
    }];
}
@end
