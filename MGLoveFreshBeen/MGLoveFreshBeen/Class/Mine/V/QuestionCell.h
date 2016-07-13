//
//  QuestionCell.h
//  MGLoveFreshBeen
//
//  Created by ming on 16/7/13.
//  Copyright © 2016年 ming. All rights reserved.
//

#import <UIKit/UIKit.h>

@class questionCellModel;

@interface QuestionCell : UITableViewCell

/** 问题 */
@property (nonatomic,weak) UILabel *questionLabel;

/** 模型 */
@property (nonatomic,strong) questionCellModel *model;

@end

@interface MGModel :NSObject
/** text */
@property (nonatomic,copy) NSString *text;
@end