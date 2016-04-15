//
//  ChatBasicCell.h
//  ChatCell
//
//  Created by FineexMac on 15/12/14.
//  Copyright © 2015年 LPiOS. All rights reserved.
//

#import <UIKit/UIKit.h>

#define ChatBasicCellIndentifier @"ChatBasicCell"

@interface ChatBasicCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *nicknameLabel;

@property (assign, nonatomic) CGFloat height;

@end
