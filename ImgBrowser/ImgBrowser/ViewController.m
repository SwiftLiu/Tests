//
//  ViewController.m
//  ImgBrowser
//
//  Created by FineexMac on 15/12/10.
//  Copyright © 2015年 LPiOS. All rights reserved.
//

#import "ViewController.h"
#import "ImgBrowserView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
}
- (IBAction)show:(id)sender {
//    [ImgBrowserView showImg:[UIImage imageNamed:@"psd"]];
    
    UIWindow *window = [UIWindow new];
    window.frame = CGRectMake(50, 50, 200, 200);
    window.backgroundColor = [UIColor redColor];
    window.alpha = 1;
    window.windowLevel = UIWindowLevelStatusBar;
    [window makeKeyAndVisible];
    
    UIView *view = [UIView new];
    view.frame = window.bounds;
    view.backgroundColor = [UIColor blackColor];
    [window addSubview:view];
}

@end
