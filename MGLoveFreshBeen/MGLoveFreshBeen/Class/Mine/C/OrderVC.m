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
/** <#注释#> */
@property (nonatomic,weak) UITableView *tableView;
@end

@implementation OrderVC

static NSString * const reuseIdentifier = @"Cell";
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
    self.tableView = tableView;
    [self.view addSubview:self.tableView];
    
    // 注册
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([OrderCell class]) bundle:nil] forCellReuseIdentifier:reuseIdentifier];
    
    
    [self loadOderData];
}

#pragma mark - 加载数据
- (void)loadOderData{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"MyOrders" ofType: nil];
    NSData *data = [NSData dataWithContentsOfFile:path];
    
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    
    MGLog(@"%@",dict);
    self.orderData = [Order objectArrayWithKeyValuesArray:dict[@"data"]];
}



#pragma mark <UITableViewDataSource>
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.orderData.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    OrderCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    
    cell.orderModel = self.orderData[indexPath.row];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 165;
}


#pragma mark <UITableViewDelegate>
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}



/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/

/*
// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
*/

/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/

@end
