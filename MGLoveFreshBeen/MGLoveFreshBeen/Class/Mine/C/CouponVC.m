//
//  CouponVC.m
//  MGLoveFreshBeen
//
//  Created by ming on 16/7/16.
//  Copyright © 2016年 ming. All rights reserved.
//

#import "CouponVC.h"
#import "CouponCell.h"

#import "CouponRuleVC.h"

@interface CouponVC ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *_couponTableView;
}

/** 数据源 */
@property (nonatomic,strong) NSMutableArray *useCouponData;
/** 数据源 */
@property (nonatomic,strong) NSMutableArray *unUseCouponData;
@end

@implementation CouponVC

#pragma mark - lazy
- (NSMutableArray *)useCouponData{
    if (_useCouponData == nil) {
        _useCouponData = [NSMutableArray array];
    }
    return _useCouponData;
}

- (NSMutableArray *)unUseCouponData{
    if (_unUseCouponData == nil) {
        _unUseCouponData = [NSMutableArray array];
    }
    return _unUseCouponData;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"优惠券";
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setupRightNavigationItem];
    
    [self setupMainView];
    
    [self loadCouponData];
}

#pragma mark - 私有方法
#pragma mark 布局控件
- (void)setupMainView {
    _couponTableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _couponTableView.delegate = self;
    _couponTableView.dataSource = self;
    _couponTableView.rowHeight = 130;
    _couponTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _couponTableView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_couponTableView];
}

- (void)setupRightNavigationItem {
    //导航按钮
    UIBarButtonItem *regulationsItem = [[UIBarButtonItem alloc] initWithTitle:@"使用规则" style:UIBarButtonItemStylePlain target:self action:@selector(regulationsClick
)];
    regulationsItem.tintColor = [UIColor orangeColor];
    self.navigationItem.rightBarButtonItem = regulationsItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loadCouponData {
    [[[NSOperationQueue alloc] init] addOperationWithBlock:^{
        NSString *path = [[NSBundle mainBundle] pathForResource:@"MyCoupon" ofType: nil];
        
        NSData *data = [NSData dataWithContentsOfFile:path];
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        NSString *str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        [str stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
        
        NSArray *tempArr = [Coupon objectArrayWithKeyValuesArray:dict[@"data"]];
        
        for (Coupon *coupon in tempArr) {
            switch (coupon.status) {
                case 0:
                    [self.useCouponData addObject:coupon];
                    break;
                default:
                    [self.unUseCouponData addObject:coupon];
                    break;
            }
        }
        
        // 回到主线程刷新UI
       [[NSOperationQueue mainQueue] addOperationWithBlock:^{
          [_couponTableView reloadData];
       }];
    }];
}

#pragma mark - <UITableViewDataSource>
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if (self.useCouponData.count > 0 && self.unUseCouponData.count > 0) {
        return 2;
    } else if (self.useCouponData.count > 0 || self.unUseCouponData.count > 0) {
        return 1;
    }
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (self.useCouponData.count > 0 && self.unUseCouponData.count > 0) {
        if (0 == section) {
            return self.useCouponData.count;
        } else {
            return self.unUseCouponData.count;
        }
    }
    
    if (self.useCouponData.count > 0) {
        return self.useCouponData.count;
    }
    
    if (self.unUseCouponData.count > 0) {
        return  self.unUseCouponData.count;
    }
    return 0;

}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CouponCell *cell = [CouponCell couponCellWithTableView:tableView];
    Coupon *couponModel;
    
    if (self.useCouponData.count > 0 && self.unUseCouponData.count > 0) {
        if (0 == indexPath.section) {
            couponModel = self.useCouponData[indexPath.row];
        } else {
            couponModel = self.unUseCouponData[indexPath.row];
        }
    } else if (self.useCouponData.count > 0) {
        couponModel = self.useCouponData[indexPath.row];
    } else if (self.unUseCouponData.count > 0) {
        couponModel = self.unUseCouponData[indexPath.row];
    }

    cell.couponModel = couponModel;
    
    return cell;
}

#pragma mark - <UITableViewDelegate>
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    

}



#pragma mark - rightItemClick
- (void)regulationsClick {
    CouponRuleVC *ruleVC = [[CouponRuleVC alloc] init];
    ruleVC.urlStr = MGCouponUserRuleURLString;
    ruleVC.navigationItem.title = @"使用规则";
    [self.navigationController pushViewController:ruleVC animated:YES];
}

@end
        
#pragma mark - Coupon
@implementation Coupon
+ (NSDictionary *)replacedKeyFromPropertyName{
    return @{
             @"desc":@"description",
             @"ID":@"id"
             };
}

@end
