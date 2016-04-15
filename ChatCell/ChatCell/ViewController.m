//
//  ViewController.m
//  ChatCell
//
//  Created by FineexMac on 15/12/14.
//  Copyright © 2015年 LPiOS. All rights reserved.
//

#import "ViewController.h"
#import "ChatBasicCell.h"

@interface ViewController ()<UITableViewDataSource, UITableViewDelegate>
{
    __weak IBOutlet UITableView *_tableView;
    UITableView *chatTableView;
    
    NSMutableArray *chatTableCellHeights;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    chatTableCellHeights = [NSMutableArray array];
    
    chatTableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    chatTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    chatTableView.delegate = self;
    chatTableView.dataSource = self;
    [self.view addSubview:chatTableView];
    UINib *nib = [UINib nibWithNibName:@"ChatBasicCell" bundle:nil];
    [chatTableView registerNib:nib forCellReuseIdentifier:ChatBasicCellIndentifier];
}

#pragma mark - <UITableViewDataSource, UITableViewDelegate>
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat height = [chatTableCellHeights[indexPath.row]?:@0 doubleValue];
    NSLog(@"=====%.0lf", height);
    return height;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ChatBasicCell *cell = [tableView dequeueReusableCellWithIdentifier:ChatBasicCellIndentifier forIndexPath:indexPath];
    if (chatTableCellHeights.count < indexPath.row+1) {
        NSLog(@"=C====%.0lf", cell.height);
        [chatTableCellHeights addObject:[NSNumber numberWithDouble:cell.height]];
    }
    return cell;
}


@end
