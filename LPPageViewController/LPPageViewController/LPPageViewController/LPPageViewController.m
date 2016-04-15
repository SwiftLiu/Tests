//
//  LPPageViewController.m
//  LPPageViewController
//
//  Created by FineexMac on 16/1/27.
//  Copyright © 2016年 LPiOS. All rights reserved.
//

#import "LPPageViewController.h"
#import "LPPageViewMenu.h"

@interface LPPageViewController ()<UIScrollViewDelegate>
{
    LPPageViewMenu *menuView;
    UIScrollView *pageScrollView;
    
    dispatch_once_t onceToken;
}
@end

@implementation LPPageViewController

#pragma mark - 界面
- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    dispatch_once(&onceToken, ^{
        CGSize size = self.view.frame.size;
        //菜单
        menuView = [LPPageViewMenu menu];
        menuView.width = size.width;
        [self.view addSubview:menuView];
        
        //滚动视图
        pageScrollView = [UIScrollView new];
        CGFloat y = CGRectGetMaxY(menuView.frame);
        pageScrollView.frame = CGRectMake(0, y, size.width, size.height - y);
        pageScrollView.delegate = self;
        pageScrollView.bounces = NO;
        pageScrollView.pagingEnabled = YES;
        pageScrollView.contentSize = CGSizeMake(pageScrollView.frame.size.width * 2, pageScrollView.frame.size.height);
        [self.view addSubview:pageScrollView];
        
        //关联（点击菜单视图左右按钮执行动画）
        menuView.scollView = pageScrollView;
        
        //重设置
        [self setThemeColor:_themeColor];
        [self setLeftMenuTitle:_leftMenuTitle];
        [self setRightMenuTitle:_rightMenuTitle];
        [self setLeftViewController:_leftViewController];
        [self setRightViewController:_rightViewController];
    });
}


#pragma mark - 设置界面
- (void)setThemeColor:(UIColor *)themeColor
{
    _themeColor = themeColor;
    if (themeColor && menuView) {
        menuView.themeColor = themeColor;
    }
}

- (void)setLeftMenuTitle:(NSString *)leftMenuTitle
{
    _leftMenuTitle = leftMenuTitle;
    if (menuView) {
        menuView.leftTitle = leftMenuTitle;
    }
}

- (void)setRightMenuTitle:(NSString *)rightMenuTitle
{
    _rightMenuTitle = rightMenuTitle;
    if (menuView) {
        menuView.rightTitle = rightMenuTitle;
    }
}

- (void)setLeftViewController:(UIViewController *)leftViewController
{
    _leftViewController = leftViewController;
    if (leftViewController && pageScrollView) {
        [self addChildViewController:leftViewController];
        leftViewController.view.frame = CGRectMake(0, 0, pageScrollView.frame.size.width, pageScrollView.frame.size.height);
        [pageScrollView addSubview:leftViewController.view];
    }
}

- (void)setRightViewController:(UIViewController *)rightViewController
{
    _rightViewController = rightViewController;
    if (rightViewController && pageScrollView) {
        [self addChildViewController:rightViewController];
        CGSize size = pageScrollView.frame.size;
        rightViewController.view.frame = CGRectMake(size.width, 0, size.width, size.height);
        [pageScrollView addSubview:rightViewController.view];
    }
}



#pragma mark - <UIScrollViewDelegate>
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat offset = scrollView.contentOffset.x;
    CGFloat progress = offset / (scrollView.contentSize.width/2.l);
    [menuView animateViewProgress:progress];
}

//开始拖拽
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    menuView.userInteractionEnabled = NO;
}

//结束拖拽
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    menuView.userInteractionEnabled = YES;
}

@end
