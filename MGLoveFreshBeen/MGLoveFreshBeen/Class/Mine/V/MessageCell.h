//
//  MessageCell.h
//  MGLoveFreshBeen
//
//  Created by ming on 16/7/14.
//  Copyright © 2016年 ming. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MessageModel;

@interface MessageCell : UITableViewCell
/** 模型 */
@property (nonatomic,strong) MessageModel *model;

+ (instancetype)messageCellWitnTableView:(UITableView *)tableView;
@end
