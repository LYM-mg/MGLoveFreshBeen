//
//  LYMSaveTool.h
//  MGLoveFreshBeen
//
//  Created by ming on 15/10/28.
//  Copyright (c) 2014年 ming. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LYMSaveTool : NSObject

// 存储
+ (void)setObject:(id)value forKey:(NSString *)defaultName;

// 读取
+ (id)objectForKey:(NSString *)defaultName;


@end
