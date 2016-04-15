//
//  ReceiveOrderCell.m
//  FineExAPP
//
//  Created by FineexMac on 15/12/3.
//  Copyright © 2015年 FineEX-LF. All rights reserved.
//

#import "ReceiveOrderCell.h"

#define MARGIN 5

@interface ReceiveOrderCell ()
{
    __weak IBOutlet UIImageView *headImgView;
    __weak IBOutlet UILabel *nameLabel;
    __weak IBOutlet UILabel *expressLabel;
    __weak IBOutlet NSLayoutConstraint *expressLabelTop;
    __weak IBOutlet UILabel *memoLabel;
    __weak IBOutlet UILabel *dateLabel;
    __weak IBOutlet UILabel *statusLabel;
    __weak IBOutlet UIImageView *statusImgView;
    __weak IBOutlet UIView *spliteView;
    
    BOOL did;
    
}
@end

@implementation ReceiveOrderCell

- (void)awakeFromNib
{
//    nameLabel.hidden = NO;
//    expressLabelTop.constant = 0;
//    expressLabel.textColor = dateLabel.textColor;
//    statusLabel.hidden = YES;
//    statusImgView.hidden = YES;
//    
//    headImgView.layer.borderWidth = 0.5;
//    
//    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
//    [formatter setDateFormat:@"yyyy-MM-dd hh:mm:ss"];
//    NSString *dateStr = [formatter stringFromDate:[NSDate date]];
//    dateLabel.text = dateStr;
//    
//    memoLabel.text = @"当前：等待发货";
//    statusLabel.text = @"完成";
//    statusLabel.hidden = YES;
//    statusImgView.hidden = NO;
    
    
}

- (void)didMoveToSuperview
{
    //添加背景色
    CALayer *colorLayer = [CALayer layer];
    CGFloat width = self.superview.superview.frame.size.width - MARGIN;
    CGFloat height = self.contentView.frame.size.height - MARGIN*2 + 1;
    colorLayer.frame = CGRectMake(MARGIN, MARGIN, width, height);
    colorLayer.backgroundColor = [UIColor whiteColor].CGColor;
    colorLayer.cornerRadius = 5;
    colorLayer.masksToBounds = YES;
    [self.contentView.layer insertSublayer:colorLayer atIndex:0];
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    for (UIView *sub in self.subviews) {
        if (!did && [NSStringFromClass(sub.class) isEqualToString:@"UITableViewCellDeleteConfirmationView"]) {
            did = YES;
            //改装原删除按钮
            sub.backgroundColor = [UIColor clearColor];
            UIButton *delBtn = sub.subviews.firstObject;
            delBtn.backgroundColor = sub.backgroundColor;
            NSLog(@"%@", delBtn.subviews);
            //添加新按钮样式
            CALayer *deleteLayer = [CALayer new];
            CGFloat height = sub.frame.size.height - MARGIN*2;
            deleteLayer.frame = CGRectMake(MARGIN, MARGIN, 82-MARGIN, height);
            deleteLayer.backgroundColor = [UIColor greenColor].CGColor;
            deleteLayer.cornerRadius = 5;
            deleteLayer.masksToBounds = YES;
            [delBtn.layer insertSublayer:deleteLayer atIndex:0];
            
            break;
        }
    }
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    did = NO;
}


@end
