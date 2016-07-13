//
//  MessageModel.h
//  MGLoveFreshBeen
//
//  Created by ming on 16/7/14.
//  Copyright © 2016年 ming. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MessageModel : NSObject

@property (nonatomic,copy) NSString *id;

@property (nonatomic, assign) int  type;

@property (nonatomic,copy) NSString * title;
@property (nonatomic,copy) NSString * content;
@property (nonatomic,copy) NSString * link;
@property (nonatomic,copy) NSString * city;
@property (nonatomic,copy) NSString * noticy;
@property (nonatomic,copy) NSString * send_time;

// 辅助参数
@property (nonatomic, assign) CGFloat subTitleViewHeightNomarl;
@property (nonatomic, assign) CGFloat cellHeight;
@property (nonatomic, assign) CGFloat subTitleViewHeightSpread;
@end
