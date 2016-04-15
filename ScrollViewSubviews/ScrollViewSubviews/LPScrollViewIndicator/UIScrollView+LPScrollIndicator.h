//
//  UIScrollView+LPScrollIndicator.h
//  ScrollViewSubviews
//
//  Created by FineexMac on 15/12/29.
//  Copyright © 2015年 LPiOS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIScrollView (LPScrollIndicator)

///添加自定义滚动条(颜色，不滚动时滚动条是否常显示)
- (void)setIndicatorColor:(UIColor *)color keepShow:(BOOL)keepShow;

@end
