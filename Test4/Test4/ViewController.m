//
//  ViewController.m
//  Test4
//
//  Created by FineexMac on 16/3/17.
//  Copyright © 2016年 iOS_Liu. All rights reserved.
//

#import "ViewController.h"
#import "TestClass.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSLog(@"%@", [TestClass share]);
    NSLog(@"%@", [TestClass share]);
}


@end
