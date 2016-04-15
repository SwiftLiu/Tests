//
//  ViewController.m
//  LPPageViewController
//
//  Created by FineexMac on 16/1/27.
//  Copyright © 2016年 LPiOS. All rights reserved.
//

#import "ViewController.h"
#import "TestPageViewController.h"
#import "AViewController.h"
#import "BViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)next:(id)sender {
    TestPageViewController *vc = [TestPageViewController new];
    [self presentViewController:vc animated:YES completion:nil];
}

@end
