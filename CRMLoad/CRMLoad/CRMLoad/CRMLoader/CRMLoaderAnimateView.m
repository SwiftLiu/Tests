//
//  CRMLoaderAnimateView.m
//  CRMLoad
//
//  Created by FineexMac on 16/3/31.
//  Copyright © 2016年 iOS_Liu. All rights reserved.
//

#import "CRMLoaderAnimateView.h"

typedef NS_ENUM(NSInteger, CRMAnimation) {
    CRMAnimationTopRight,
    CRMAnimationBottomRight,
    CRMAnimationBottomLeft,
    CRMAnimationTopLeft
};

static NSString *kRotateAnimationKey = @"rotate";
static NSString *kMoveAnimationKey = @"move";

#define DefaultDuration 2.0l
#define DefaultColor [UIColor colorWithRed:96/255.l green:184/255.l blue:250/255.l alpha:1].CGColor

@interface CRMLoaderAnimateView ()
{
    CRMAnimation animLoc;
    //旋转
    CALayer *rotateBaseLayer;
    CALayer *rotateSubLayer;
    CABasicAnimation *rotateAnim;
    
    //开始旋转到开始平移的时间
    double beginMoveDuration;
    
    //平移
    CALayer *moveFirstBaseLayer;
    CALayer *moveFirstSubLayer;
    CALayer *moveLastBaseLayer;
    CALayer *moveLastSubLayer;
    CABasicAnimation *moveAnim;
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
    //旋转基础图层
    rotateBaseLayer = [CALayer layer];
    rotateBaseLayer.masksToBounds = YES;
    [self.layer insertSublayer:rotateBaseLayer atIndex:0];
    //旋转子图层
    rotateSubLayer = [CALayer layer];
    rotateSubLayer.anchorPoint = CGPointMake(0.5, 0.5);
    [rotateBaseLayer addSublayer:rotateSubLayer];
    
    //平移基础图层
    moveFirstBaseLayer = [CALayer layer];
    moveFirstBaseLayer.masksToBounds = YES;
    moveFirstBaseLayer.anchorPoint = CGPointZero;
    [self.layer insertSublayer:moveFirstBaseLayer atIndex:0];
    //平移子图层
    moveFirstSubLayer = [CALayer layer];
    moveFirstSubLayer.backgroundColor = DefaultColor;
    [moveFirstBaseLayer addSublayer:moveFirstSubLayer];
    //平移基础图层
    moveLastBaseLayer = [CALayer layer];
    moveLastBaseLayer.masksToBounds = YES;
    moveLastBaseLayer.anchorPoint = CGPointZero;
    [self.layer insertSublayer:moveLastBaseLayer atIndex:0];
    //平移子图层
    moveLastSubLayer = [CALayer layer];
    moveLastSubLayer.backgroundColor = DefaultColor;
    [moveLastBaseLayer addSublayer:moveLastSubLayer];
    
#pragma mark 测试临时代码*****************************
    self.layer.masksToBounds = NO;
//    rotateBaseLayer.masksToBounds = NO;
//    rotateBaseLayer.backgroundColor = [UIColor redColor].CGColor;
//    moveFirstBaseLayer.backgroundColor = [UIColor grayColor].CGColor;
//    moveLastBaseLayer.backgroundColor = [UIColor grayColor].CGColor;
//    moveFirstSubLayer.backgroundColor = [UIColor greenColor].CGColor;
//    moveLastSubLayer.backgroundColor = [UIColor greenColor].CGColor;
//    moveFirstBaseLayer.masksToBounds = NO;
//    moveLastBaseLayer.masksToBounds = NO;
#pragma mark
}


#pragma mark - 开始动画
- (void)startAnimation
{
    CGFloat r = self.layer.cornerRadius;
    CGFloat l = self.layer.bounds.size.width - r*2;
    beginMoveDuration = DefaultDuration*M_PI_2*r/l;//旋转90度后开始平移
    //旋转
    rotateBaseLayer.bounds = CGRectMake(0, 0, r, r);
    rotateSubLayer.frame = CGRectMake(-r, 0, r*2, r*2);
    rotateSubLayer.contents = RotateImgWithAngle(l/r+M_PI_2, r);
    rotateAnim = RotateAnimation(0, l/r + M_PI);
    rotateAnim.duration = (1+M_PI_2*r/l)*DefaultDuration;
    rotateAnim.delegate = self;
    
    //平移
    moveFirstBaseLayer.bounds = CGRectMake(0, 0, l, r);
    moveLastBaseLayer.bounds  = moveFirstBaseLayer.bounds;
    moveFirstSubLayer.frame  = CGRectMake(-l, 0, l, r);
    moveLastSubLayer.frame = moveFirstSubLayer.frame;
    moveAnim = MoveAnimation(CGPointMake(-l*.5, r*.5), CGPointMake(l*1.5, r*.5));
    moveAnim.beginTime = CACurrentMediaTime() + beginMoveDuration;
    
    //开始动画
    [self animate:YES];
}


//旋转（循环）
- (void)animate:(BOOL)first
{
    //①关闭隐式动画
    [CATransaction setDisableActions:YES];
    //②切换位置和方向
    CGRect rotateFrame = rotateBaseLayer.frame;
    CGFloat x = self.layer.bounds.size.width-rotateFrame.size.width;
    CGFloat y = self.layer.bounds.size.height-rotateFrame.size.height;
    CGFloat a = self.layer.cornerRadius;
    CGFloat b = self.layer.bounds.size.width;
    CALayer *moveLayer;
    switch (animLoc) {
        case CRMAnimationTopRight:
            rotateFrame.origin = CGPointMake(x, 0);
            moveLastBaseLayer.affineTransform = CGAffineTransformRotate(CGAffineTransformIdentity, M_PI_2);
            moveLastBaseLayer.frame = CGRectMake(b, a, a, b-a*2);
            moveLayer = moveLastSubLayer;
            break;
        case CRMAnimationBottomRight:
            rotateFrame.origin = CGPointMake(x, y);
            moveFirstBaseLayer.affineTransform = CGAffineTransformRotate(CGAffineTransformIdentity, M_PI);
            moveFirstBaseLayer.frame = CGRectMake(b-a, b, b-a*2, a);
            moveLayer = moveFirstSubLayer;
            break;
        case CRMAnimationBottomLeft:
            rotateFrame.origin = CGPointMake(0, y);
            moveLastBaseLayer.affineTransform = CGAffineTransformRotate(CGAffineTransformIdentity, M_PI_2+M_PI);
            moveLastBaseLayer.frame = CGRectMake(0, b-a, a, b-a*2);
            moveLayer = moveLastSubLayer;
            break;
        case CRMAnimationTopLeft:
            rotateFrame.origin = CGPointZero;
            moveFirstBaseLayer.affineTransform = CGAffineTransformRotate(CGAffineTransformIdentity, 0);
            moveFirstBaseLayer.frame = CGRectMake(a, 0, b-a*2, a);
            moveLayer = moveFirstSubLayer;
            break;
        default:
            break;
    }
    rotateBaseLayer.frame = rotateFrame;
    rotateBaseLayer.affineTransform = CGAffineTransformRotate(CGAffineTransformIdentity, M_PI_2*animLoc);
    
    //③开始动画
    [rotateSubLayer removeAnimationForKey:kRotateAnimationKey];
    [rotateSubLayer addAnimation:rotateAnim forKey:kRotateAnimationKey];
//    [moveFirstSubLayer removeAnimationForKey:kMoveAnimationKey];
//    moveAnimation.timeOffset = first ? DefaultDuration : 0;
//    [moveFirstSubLayer addAnimation:moveAnimation forKey:kMoveAnimationKey];
    moveAnim.beginTime = CACurrentMediaTime() + beginMoveDuration;
    [moveLayer removeAnimationForKey:kMoveAnimationKey];
    [moveLayer addAnimation:moveAnim forKey:kMoveAnimationKey];
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    animLoc = (animLoc + 1) % 4;
    [self animate:NO];
}


#pragma mark -
//创建平移动画
CABasicAnimation *MoveAnimation(CGPoint from, CGPoint to) {
    CABasicAnimation *move = [CABasicAnimation animation];
    move.keyPath = @"position";
    move.duration = DefaultDuration*2;
    move.fromValue = [NSValue valueWithCGPoint:from];
    move.toValue = [NSValue valueWithCGPoint:to];
    move.repeatCount = 1;
    move.autoreverses = NO;
    return move;
}

//创建旋转动画
CABasicAnimation *RotateAnimation(CGFloat from, CGFloat to) {
    CABasicAnimation *rotate = [CABasicAnimation animation];
    rotate.keyPath = @"transform.rotation.z";
    rotate.fromValue = @(from);
    rotate.toValue = @(to);
    rotate.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    rotate.repeatCount = 1;
    return rotate;
}

//绘制旋转图形
id RotateImgWithAngle(CGFloat angle,CGFloat r) {
    CGSize size = CGSizeMake(r*2, r*2);
    UIGraphicsBeginImageContextWithOptions(size, NO, [UIScreen mainScreen].scale);
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextScaleCTM(ctx, 1, -1);
    CGContextTranslateCTM(ctx, 0, -size.height);
    CGContextSetFillColorWithColor(ctx, DefaultColor);
    CGPoint o = CGPointMake(size.width/2.0l, size.height/2.0l);
    CGContextAddArc(ctx, o.x, o.y, r, M_PI_2, M_PI_2+angle, NO);
    CGContextAddLineToPoint(ctx, o.x, o.y);
    CGContextDrawPath(ctx, kCGPathFill);
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    CGContextRelease(ctx);
    UIGraphicsEndImageContext();
    return (__bridge id _Nullable)(img.CGImage);
}
@end
