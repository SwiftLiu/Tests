//
//  ViewController.m
//  IsCircle
//
//  Created by FineexMac on 15/12/14.
//  Copyright © 2015年 LPiOS. All rights reserved.
//

#import "ViewController.h"
#import "DrawContext.h"

@interface ViewController ()
{
    
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    DrawContext *view = [DrawContext new];
    view.backgroundColor = [UIColor whiteColor];
    view.frame = self.view.bounds;
    [self.view addSubview:view];

}



@end
