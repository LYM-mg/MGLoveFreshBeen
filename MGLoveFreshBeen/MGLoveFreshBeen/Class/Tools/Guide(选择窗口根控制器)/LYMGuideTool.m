
//  LYMGuideTool.m
//  MGLoveFreshBeen
//
//  Created by ming on 15/10/28.
//  Copyright (c) 2014年 ming. All rights reserved.
//

#import "LYMGuideTool.h"
#import "TabBarVC.h"
#import "LYMCollectionViewController.h"
#import "LYMSaveTool.h"

#define LYMversionKey @"version"


@implementation LYMGuideTool

/**
 *  选择窗口根控制器
 *
 *  @return 要返回的控制器
 */
+ (UIViewController *)chooseRootViewController
{
    /// 取得版本号
    // 取得当前版本号(每次下载新的版本，mainBundle里面的版本号都会不一样)
    NSString *currentVersion = [NSBundle mainBundle].infoDictionary[@"CFBundleShortVersionString"];
    // 获取上一次的版本号
    NSString *lastVersion = [LYMSaveTool objectForKey:LYMversionKey];
//    NSString *current = [NSBundle mainBundle].infoDictionary[@"CFBundleShortVersionString"];
    
    /// 判断版本是否有升级
    if ([currentVersion isEqualToString: lastVersion]) {
        // 没有
        // 进入TabBar控制器
        TabBarVC *tabBar = [[TabBarVC alloc] init];
        return tabBar;
    }else
    {
        // 有
        // 保存当前版本号
        [LYMSaveTool setObject:currentVersion forKey:LYMversionKey];
        // 进入新界面控制器
        LYMCollectionViewController *collectionVC = [[LYMCollectionViewController alloc] init];
        
        return collectionVC;
    }
}

@end

/// 第一种方式取得版本号
/*
 
 //    NSString *path = [[NSBundle mainBundle] pathForResource:@"info.plist" ofType:nil];
 //    NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:path];
 //    NSLog(@"--%@",dict);
 
 // 获取当前版本号
 //    NSString *currentVersion = dict[@"CFBundleShortVersionString"];
 */

//    UIViewController *vc = nil;

