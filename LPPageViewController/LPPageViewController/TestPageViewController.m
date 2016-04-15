//
//  TestPageViewController.m
//  LPPageViewController
//
//  Created by FineexMac on 16/1/28.
//  Copyright © 2016年 LPiOS. All rights reserved.
//

#import "TestPageViewController.h"
#import "AViewController.h"
#import "BViewController.h"

@interface TestPageViewController ()

@end

@implementation TestPageViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.leftViewController = [AViewController new];
    self.rightViewController = [BViewController new];
    self.leftMenuTitle = @"左边";
    self.rightMenuTitle = @"右边";
    self.themeColor = [UIColor greenColor];
}

@end
