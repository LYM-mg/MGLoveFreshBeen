//
//  MineVC.h
//  MGLoveFreshBeen
//
//  Created by ming on 16/7/12.
//  Copyright © 2016年 ming. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MineVC : UIViewController

@end

@interface MineCellModel : NSObject
/** MineCell的标题 */
@property (nonatomic,copy) NSString *title;
/** MineCell的图片名称 */
@property (nonatomic,copy) NSString *iconName;

@end