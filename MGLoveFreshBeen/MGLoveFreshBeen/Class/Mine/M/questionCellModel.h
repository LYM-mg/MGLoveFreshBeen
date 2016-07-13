//
//  questionCellModel.h
//  MGLoveFreshBeen
//
//  Created by ming on 16/7/13.
//  Copyright © 2016年 ming. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface questionCellModel : NSObject
/** 标题 */
@property (nonatomic,copy) NSString *title;

/** 标题下的数组 */
@property (nonatomic,strong) NSArray *texts;


/**  是否是展开的 */
@property (nonatomic, assign) BOOL isExpanded;

/**  cellHeight */
@property (nonatomic, assign) CGFloat cellHeight;;

/**  每一组cellHeight */
@property (nonatomic,strong) NSMutableArray *everyRowHeight;


+ (instancetype)questionModelWithDict:(NSDictionary *)dict;

- (instancetype)initWithDict:(NSDictionary *)dict;

@end
