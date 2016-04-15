//
//  ViewController.m
//  CRMLoad
//
//  Created by FineexMac on 16/3/30.
//  Copyright © 2016年 iOS_Liu. All rights reserved.
//

#import "ViewController.h"
#import "CRMLoader.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [CRMLoader loadingInView:self.view];
}



@end
