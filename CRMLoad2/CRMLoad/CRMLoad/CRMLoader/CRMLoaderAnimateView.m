//
//  CRMLoaderAnimateView.m
//  CRMLoad
//
//  Created by FineexMac on 16/3/31.
//  Copyright © 2016年 iOS_Liu. All rights reserved.
//

#import "CRMLoaderAnimateView.h"

typedef NS_ENUM(NSInteger, CRMAnimation) {
    CRMAnimationTopLeft,
    CRMAnimationTopRight,
    CRMAnimationBottomRight,
    CRMAnimationBottomLeft,
};

static NSString *kRotateAnimationKey = @"rotate";
static NSString *kMoveAnimationKey = @"move";

#define DefaultDuration 5.0l
#define DefaultColor [UIColor colorWithRed:96/255.l green:184/255.l blue:250/255.l alpha:1].CGColor

@interface CRMLoaderAnimateView ()
{
    CALayer *rotateSubLayer;
    CABasicAnimation *rotateAnim;
    CRMAnimation animLoc;
}
@end

@implementation CRMLoaderAnimateView

#pragma mark - 重写
- (instancetype)init
{
    self = [super init];
    if (self) {
        [self initialize];
    }
    return self;
}

- (void)awakeFromNib
{
    [self initialize];
}

- (void)initialize
{
    self.layer.masksToBounds = YES;
}



#pragma mark - 开始动画
- (void)startAnimation
{
    CGFloat r = self.layer.cornerRadius;
    CGFloat l = self.layer.bounds.size.width - r*2;
    CGFloat s = M_PI*r*2 + l*4;
    //平移视图
    for (int i=0; i<4; i++) {
        CALayer *moveLayer = [CALayer layer];
        moveLayer.masksToBounds = YES;
        [self.layer insertSublayer:moveLayer atIndex:0];
        CALayer *moveSubLayer = [CALayer layer];
        moveSubLayer.backgroundColor = DefaultColor;
        moveSubLayer.anchorPoint = CGPointZero;
        [moveLayer addSublayer:moveSubLayer];
        
#pragma mark 测试临时代码*****************************
        self.layer.masksToBounds = NO;
//        moveLayer.masksToBounds = NO;
//        moveLayer.backgroundColor = [UIColor yellowColor].CGColor;
//        moveSubLayer.backgroundColor = [UIColor greenColor].CGColor;
#pragma mark
        
        //尺寸位置
        CABasicAnimation *moveAnimation;
        switch (i) {
            case 0:
                moveLayer.frame = CGRectMake(r,   0, l, r);
                moveSubLayer.frame = CGRectMake(-l, 0, l, r);
                moveAnimation = MoveAnimation(moveSubLayer.frame.origin, CGPointMake(s-l, 0));
                break;
            case 1:
                moveLayer.frame = CGRectMake(l+r, r, r, l);
                moveSubLayer.frame = CGRectMake(0, -l, r, l);
                moveAnimation = MoveAnimation(moveSubLayer.frame.origin, CGPointMake(0, s-l));
                break;
            case 2:
                moveLayer.frame = CGRectMake(r, l+r, l, r);
                moveSubLayer.frame = CGRectMake(l, 0, l, r);
                moveAnimation = MoveAnimation(moveSubLayer.frame.origin, CGPointMake(l-s, 0));
                break;
            case 3:
                moveLayer.frame = CGRectMake(0, r, r, l);
                moveSubLayer.frame = CGRectMake(0, l, r, l);
                moveAnimation = MoveAnimation(moveSubLayer.frame.origin, CGPointMake(0, l-s));
                break;
            default:
                break;
        }
        
        CFTimeInterval beginTime = CACurrentMediaTime() + i * DefaultDuration/4.0l;//延时执行
        moveAnimation.beginTime = beginTime + DefaultDuration*M_PI_2*r/s;
        [moveSubLayer addAnimation:moveAnimation forKey:kMoveAnimationKey];
    }

    //旋转视图
    CALayer *rotateLayer = [CALayer layer];
    rotateLayer.masksToBounds = YES;
    rotateLayer.frame = CGRectMake(0, 0, r, r);
    [self.layer insertSublayer:rotateLayer atIndex:0];

    rotateSubLayer = [CALayer layer];
    rotateSubLayer.frame = CGRectMake(0, 0, r*2, r*2);
    rotateSubLayer.anchorPoint = CGPointMake(0.5, 0.5);
    rotateSubLayer.contents = RotateImg(l/r + M_PI_2, M_PI, r);
    [rotateLayer addSublayer:rotateSubLayer];
    
    rotateAnim = RotateAnimation(0, l/r + M_PI);
    rotateAnim.delegate = self;
    [rotateSubLayer addAnimation:rotateAnim forKey:kRotateAnimationKey];
    
#pragma mark 测试临时代码*****************************
//    rotateLayer.masksToBounds = NO;
//    rotateLayer.backgroundColor = [UIColor yellowColor].CGColor;
#pragma mark
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    animLoc = (animLoc + 1) % 4;
    [CATransaction setDisableActions:YES];//关闭隐式动画
    CGFloat r = self.layer.cornerRadius;
    CGFloat l = self.layer.bounds.size.width - r*2;
    switch (animLoc) {
        case CRMAnimationTopLeft:
            rotateSubLayer.superlayer.frame = CGRectMake(0, 0, r, r);
            break;
        case CRMAnimationTopRight:
            rotateSubLayer.superlayer.frame = CGRectMake(l+r, 0, r, r);
            break;
        case CRMAnimationBottomRight:
            rotateSubLayer.superlayer.frame = CGRectMake(l+r, l+r, r, r);
            break;
        case CRMAnimationBottomLeft:
            rotateSubLayer.superlayer.frame = CGRectMake(0, l+r, r, r);
            break;
        default:
            break;
    }
    rotateSubLayer.superlayer.affineTransform = CGAffineTransformRotate(CGAffineTransformIdentity, M_PI_2 * animLoc);
    [rotateSubLayer removeAnimationForKey:kRotateAnimationKey];
    [rotateSubLayer addAnimation:rotateAnim forKey:kRotateAnimationKey];
}

//创建平移动画
CABasicAnimation *MoveAnimation(CGPoint from, CGPoint to) {
    CABasicAnimation *move = [CABasicAnimation animation];
    move.keyPath = @"position";
    move.fromValue = [NSValue valueWithCGPoint:from];
    move.toValue = [NSValue valueWithCGPoint:to];
    move.duration = DefaultDuration;
    move.repeatCount = HUGE_VALF;
    move.autoreverses = NO;
    return move;
}

//创建旋转动画
CABasicAnimation *RotateAnimation(CGFloat from, CGFloat to) {
    CABasicAnimation *rotate = [CABasicAnimation animation];
    rotate.keyPath = @"transform.rotation.z";
    rotate.fromValue = @(from);
    rotate.toValue = @(to);
    rotate.duration = DefaultDuration/4.0l;
    rotate.repeatCount = 1;
    rotate.autoreverses = NO;
    return rotate;
}

//绘制旋转图形
id RotateImg(CGFloat angle, CGFloat from, CGFloat r) {
    CGSize size = CGSizeMake(r*2, r*2);
    UIGraphicsBeginImageContextWithOptions(size, NO, [UIScreen mainScreen].scale);
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextScaleCTM(ctx, 1, -1);
    CGContextTranslateCTM(ctx, 0, -size.height);
    CGContextSetFillColorWithColor(ctx, DefaultColor);
    CGPoint o = CGPointMake(size.width/2.0l, size.height/2.0l);
    CGContextAddArc(ctx, o.x, o.y, r, from, from+angle, NO);
    CGContextAddLineToPoint(ctx, o.x, o.y);
    CGContextDrawPath(ctx, kCGPathFill);
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    CGContextRelease(ctx);
    UIGraphicsEndImageContext();
    return (__bridge id _Nullable)(img.CGImage);
}

@end
