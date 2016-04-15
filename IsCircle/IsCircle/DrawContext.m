//
//  DrawContext.m
//  IsCircle
//
//  Created by FineexMac on 15/12/14.
//  Copyright © 2015年 LPiOS. All rights reserved.
//

#import "DrawContext.h"
#import <QuartzCore/QuartzCore.h>


@interface DrawContext ()
{
    UIBezierPath *path;
    UIButton *button;
    UILabel *label;
}
@end

@implementation DrawContext

- (instancetype)init
{
    self = [super init];
    if (self) {
        path = [[UIBezierPath alloc] init];
        path.lineWidth = 1;
        
        button = [UIButton new];
        button.bounds = CGRectMake(0, 0, 80, 35);
        button.layer.borderColor = [UIColor orangeColor].CGColor;
        button.layer.borderWidth = 1;
        button.layer.cornerRadius = 4;
        [button setTitle:@"擦除" forState:UIControlStateNormal];
        [button setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(reSet) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
        
        label = [UILabel new];
        label.bounds = button.bounds;
        label.textColor = [UIColor redColor];
        label.layer.cornerRadius = 4;
        label.clipsToBounds = YES;
        label.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1];
        label.text = @"绘制";
        label.font = [UIFont systemFontOfSize:15];
        label.textAlignment = NSTextAlignmentCenter;
        [self addSubview:label];
    }
    return self;
}

- (void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
    button.center = CGPointMake(self.bounds.size.width/2.l, CGRectGetMaxY(self.frame) - 30);
    label.center = CGPointMake(button.center.x, button.frame.origin.y - 20);
}

- (void)reSet
{
    [path removeAllPoints];
    label.text = nil;
    [self setNeedsDisplay];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self];
    NSLog(@"起点(%.0lf,%.0lf)", point.x, point.y);
    [path moveToPoint:point];
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self];
    NSLog(@"终点(%.0lf,%.0lf)", point.x, point.y);
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self];
    NSLog(@"路径点(%.0lf,%.0lf)", point.x, point.y);
    [path addLineToPoint:point];
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect
{
    [[UIColor redColor] setStroke];
    [path stroke];
}

@end
