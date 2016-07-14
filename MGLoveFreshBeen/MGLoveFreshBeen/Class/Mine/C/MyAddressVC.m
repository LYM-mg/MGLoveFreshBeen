//
//  MyAddressVC.m
//  MGLoveFreshBeen
//
//  Created by ming on 16/7/14.
//  Copyright © 2016年 ming. All rights reserved.
//

#import "MyAddressVC.h"
#import "MyAddressCell.h"


#import "EditAddressVC.h"

@interface MyAddressVC ()<UITableViewDataSource,UITableViewDelegate>
/** tableView */
@property (nonatomic,weak) UITableView *tableView;

/** 数据源 */
@property (nonatomic,strong) NSMutableArray *myAddressData;

@end

@implementation MyAddressVC

#pragma mark - lazy   数据源
- (NSMutableArray *)myAddressData{
    if (!_myAddressData) {
        _myAddressData = [NSMutableArray array];
    }
    return _myAddressData;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    // 设置UI
    [self setUpTableView];
    
    [self setUpBottomView];
    
    // 请求数据
    [self loadAddressData];
}


#pragma mark - 私有方法
// 1.tableView
-(void)setUpTableView{
    UIImageView *backImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"v2_store_empty"]];
    [backImageView sizeToFit];
    backImageView.center = CGPointMake(MGSCREEN_width * 0.5, self.view.height * 0.5);
    [self.view addSubview:backImageView];
    
    UILabel *normalLabel = [[UILabel alloc] init];
    normalLabel.text = @"~~~暂时还没有收件地址，请设置收件地址~~~";
    normalLabel.textAlignment = NSTextAlignmentCenter;
    normalLabel.frame = CGRectMake(0, CGRectGetMaxY(backImageView.frame) + MGMargin, MGSCREEN_width, 50);
    [self.view addSubview:normalLabel];
    
    
    CGFloat y =  self.navigationController? MGNavHeight : 0;
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0,y, MGSCREEN_width, MGSCREEN_height - y) style:UITableViewStyleGrouped];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.rowHeight = 44;
    self.tableView = tableView;
    [self.view addSubview:tableView];
}

// 3.底部View setUpBottomView
- (void)setUpBottomView {
    UIView *bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, self.view.height - 60, self.view.width, 60)];
    bottomView.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.7];
    [self.view addSubview:bottomView];
    
    UIButton * addAddressBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    addAddressBtn.width = 200;
    addAddressBtn.height = 48;
    addAddressBtn.center = bottomView.center;
    addAddressBtn.backgroundColor = [UIColor yellowColor];
    [addAddressBtn setTitle:@"+ 增加地址" forState:UIControlStateNormal];
    [addAddressBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [addAddressBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
    addAddressBtn.showsTouchWhenHighlighted = YES;
    [addAddressBtn addTarget:self action:@selector(addAddressBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [bottomView addSubview:addAddressBtn];
}

- (void)addAddressBtnClick {
    [self.navigationController pushViewController:[[EditAddressVC alloc] init] animated:YES];
}


// 2.加载地址数据
- (void)loadAddressData{
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"MyAdress" ofType: nil];

    NSData *data = [[NSData alloc] initWithContentsOfFile:path];
    
    NSDictionary *dictArr = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    
    NSArray *arr = [AddressCellModel objectArrayWithKeyValuesArray:[dictArr valueForKey:@"data"]];
    
    [self.myAddressData addObjectsFromArray:arr];
}

#pragma mark - 数据源
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    self.tableView.hidden = (self.myAddressData.count > 0);
    return self.myAddressData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MyAddressIdentifier"];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MyAddressIdentifier"];
    }
    
    return  cell;
}


#pragma mark - 代理

@end
