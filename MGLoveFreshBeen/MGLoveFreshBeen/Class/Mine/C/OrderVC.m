//
//  OrderVC.m
//  MGLoveFreshBeen
//
//  Created by ming on 16/7/12.
//  Copyright © 2016年 ming. All rights reserved.
//

#import "OrderVC.h"
#import "OrderCell.h"
#import "OrderCellModel.h"

#import "OrderDetailVC.h"

@interface OrderVC ()<UITableViewDataSource,UITableViewDelegate>
/** 订单数据源 */
@property (nonatomic,strong) NSArray *orderData;
/** tableView */
@property (nonatomic,weak) UITableView *orderTableView;
@end

@implementation OrderVC


#pragma mark - lazy
- (NSArray *)orderData{
    if (!_orderData) {
        _orderData = [NSArray array];
    }
    return _orderData;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"我的订单";
    self.view.backgroundColor = MGRGBColor(220, 220, 220);
    
   UITableView *orderTableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    orderTableView.delegate = self;
    orderTableView.dataSource = self;
    self.orderTableView.rowHeight = 160;
    self.orderTableView = orderTableView;
    self.orderTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    orderTableView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.orderTableView];
    
    // 注册
    [self.orderTableView registerNib:[UINib nibWithNibName:NSStringFromClass([OrderCell class]) bundle:nil] forCellReuseIdentifier:KOrderCellIdentifier];
    
    
    [self loadOderData];
}

#pragma mark - 加载数据
- (void)loadOderData{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"MyOrders" ofType: nil];
    NSData *data = [NSData dataWithContentsOfFile:path];
    
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    
    self.orderData = [Order objectArrayWithKeyValuesArray:dict[@"data"]];
}



#pragma mark <UITableViewDataSource>
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.orderData.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    Order *model = self.orderData[indexPath.row];
    
    OrderCell *cell = [OrderCell OrderCellWithTableView:tableView withImages:model.order_goods];
    
    cell.orderModel = model;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 185.0;
}



#pragma mark <UITableViewDelegate>
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
//    Order *model = self.orderData[indexPath.row];
    OrderDetailVC *orderDetailVC = [[OrderDetailVC alloc] init];
//    OrderDetailVC.model = model;
    [self.navigationController pushViewController:orderDetailVC animated:YES];
}


@end
