//
//  ImgBrowserView.m
//  ImgBrowser
//
//  Created by FineexMac on 15/12/10.
//  Copyright © 2015年 LPiOS. All rights reserved.
//

#import "ImgBrowserView.h"

#define AnimationDuration 0.3
#define Scale 0.8


@interface ImgBrowserView ()

@property (strong, nonatomic) UIView *backgroudView;
@property (strong, nonatomic) UIImageView *imgView;

@end



@implementation ImgBrowserView

#pragma mark - 初始化
- (instancetype)init
{
    self = [super init];
    if (self) {
        [self initUserInterface];
        [self initGesture];
    }
    return self;
}

- (void)initUserInterface
{
    self.frame = CGRectMake(50, 50, 200, 200);
    self.backgroundColor = [UIColor redColor];
    self.windowLevel = UIWindowLevelAlert;
    self.hidden = NO;
    
    //背景视图
    _backgroudView = [UIView new];
    _backgroudView.backgroundColor = [UIColor blackColor];
    _backgroudView.clipsToBounds = YES;
    [self addSubview:_backgroudView];
    
    //图片容器
    _imgView = [UIImageView new];
    _imgView.userInteractionEnabled = YES;
    _imgView.clipsToBounds = YES;
    [_backgroudView addSubview:_imgView];
}

//手势
- (void)initGesture
{
    //点击window
    UITapGestureRecognizer *tapWindow = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(exitBrowser)];
    [self addGestureRecognizer:tapWindow];
    
    //长按window
    UILongPressGestureRecognizer *longTapWindow = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longTapWindow)];
    [self addGestureRecognizer:longTapWindow];
    
    //拉伸
    UIPinchGestureRecognizer *pinchImgView = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(pinchImgView:)];
    [_imgView addGestureRecognizer:pinchImgView];
    
    //拖拽
    UIPanGestureRecognizer *panImgView = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panImgView:)];
    [_imgView addGestureRecognizer:panImgView];
}

//点击window 退出浏览
- (void)exitBrowser
{
    CGPoint center = _backgroudView.center;
    CGSize size = self.frame.size;
    [UIView animateWithDuration:AnimationDuration animations:^{
        _backgroudView.bounds = CGRectMake(0, 0, size.width*Scale, size.height*Scale);
        _backgroudView.center = center;
        _backgroudView.alpha = 0.5;
    } completion:^(BOOL finished) {
        [self resignKeyWindow];
    }];
}


//展示
- (void)show
{
    [self makeKeyAndVisible];
    
    CGSize size = self.frame.size;
    CGPoint center = CGPointMake(size.width/2.l, size.height/2.l);
    _backgroudView.bounds = CGRectMake(0, 0, size.width*Scale, size.height*Scale);
    _backgroudView.center = center;
    _backgroudView.alpha = 0.5;
    [UIView animateWithDuration:AnimationDuration animations:^{
        _backgroudView.bounds = self.bounds;
        _backgroudView.center = center;
        _backgroudView.alpha = 1;
    }];
}


#pragma mark - 直接打开单张图片
+ (void)showImg:(UIImage *)img;
{
    ImgBrowserView *browser = [ImgBrowserView new];
    browser.imgView.image = img;
    [browser show];
}

@end
