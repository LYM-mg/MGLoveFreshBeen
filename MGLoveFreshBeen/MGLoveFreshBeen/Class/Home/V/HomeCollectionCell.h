//
//  HomeCollectionCell.h
//  MGLoveFreshBeen
//
//  Created by ming on 16/7/18.
//  Copyright © 2016年 ming. All rights reserved.
//

#import <UIKit/UIKit.h>


@class Activities,HotGoods;

@interface HomeCollectionCell : UICollectionViewCell

/** HotFreshModel */
@property (nonatomic,strong) Activities *Activity;

@property (nonatomic,strong) HotGoods *goodModel;
@end
