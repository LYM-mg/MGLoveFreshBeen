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

@interface OrderVC ()<UITableViewDataSource,UITableViewDelegate>
/** 订单数据源 */
@property (nonatomic,strong) NSArray *orderData;
/** tableView */
@property (nonatomic,weak) UITableView *tableView;
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
    self.view.backgroundColor = [UIColor whiteColor];
    
   UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    self.tableView.rowHeight = 160;
    self.tableView = tableView;
    [self.view addSubview:self.tableView];
    
    // 注册
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([OrderCell class]) bundle:nil] forCellReuseIdentifier:KOrderCellIdentifier];
    
    
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
    return 160;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 10;
}


#pragma mark <UITableViewDelegate>
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}


@end
