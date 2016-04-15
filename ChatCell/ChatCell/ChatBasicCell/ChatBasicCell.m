//
//  ChatBasicCell.m
//  ChatCell
//
//  Created by FineexMac on 15/12/14.
//  Copyright © 2015年 LPiOS. All rights reserved.
//

#import "ChatBasicCell.h"

#define DefaultHeadImg [UIImage imageNamed:@"default_head"]

const NSString *BubbleLeftNormalImgName = @"chat_bubble_normal_left";
const NSString *BubbleLeftPressedImgName = @"chat_bubble_pressed_left";
const NSString *BubbleLeftFocusedImgName = @"chat_bubble_focused_left";

const NSString *BubbleRightNormalImgName = @"chat_bubble_normal_right";
const NSString *BubbleRightPressedImgName = @"chat_bubble_pressed_right";
const NSString *BubbleRightFocusedImgName = @"chat_bubble_focused_right";

@interface ChatBasicCell ()
{
    __weak IBOutlet UIImageView *headImgView;
    __weak IBOutlet UIButton *bubbleButton;
    __weak IBOutlet NSLayoutConstraint *bubbleButtonHeight;
    
}
@end

@implementation ChatBasicCell

- (void)awakeFromNib {
    headImgView.layer.cornerRadius = 4;
    
    self.height = 100;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
