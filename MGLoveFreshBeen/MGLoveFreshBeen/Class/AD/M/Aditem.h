//
//  Aditem.h
//  MGLoveFreshBeen
//
//  Created by ming on 16/7/19.
//  Copyright © 2016年 ming. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Aditem : NSObject

/** 图片URL */
@property (nonatomic,copy) NSString *w_picurl;
/** 点击图片的回调网址 */
@property (nonatomic,copy) NSString *ori_curl;
/** 宽 */
@property (nonatomic, assign) NSInteger w;
/** 高 */
@property (nonatomic, assign) NSInteger h;

@end
