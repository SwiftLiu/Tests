//
//  ViewController.m
//  test3
//
//  Created by FineexMac on 15/12/31.
//  Copyright © 2015年 LPiOS. All rights reserved.
//

#import "ViewController.h"

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
- (IBAction)press:(id)sender {
    //1035209312
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString: @"itms-apps://itunes.apple.com/us/app/id1035209312?mt=8"]];
}

@end
