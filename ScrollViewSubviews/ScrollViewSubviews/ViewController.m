//
//  ViewController.m
//  ScrollViewSubviews
//
//  Created by FineexMac on 15/12/29.
//  Copyright © 2015年 LPiOS. All rights reserved.
//

#import "ViewController.h"
#import "JTSScrollIndicator.h"
#import "UIScrollView+LPScrollIndicator.h"

@interface ViewController ()
{
    
    __weak IBOutlet UIScrollView *scroll;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    scroll.contentSize = CGSizeMake(500, 500);
    
}

@end
