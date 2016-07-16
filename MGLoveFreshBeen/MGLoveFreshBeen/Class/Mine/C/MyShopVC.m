
//
//  MyShopVC.m
//  MGLoveFreshBeen
//
//  Created by ming on 16/7/14.
//  Copyright © 2016年 ming. All rights reserved.
//

#import "MyShopVC.h"

@interface MyShopVC ()<UITableViewDataSource,UITableViewDelegate>
/** tableView */
@property (nonatomic,weak) UITableView *tableView;

/** 数据源 */
@property (nonatomic,strong) NSMutableArray *myShopData;

@end

@implementation MyShopVC

#pragma mark - lazy   数据源
- (NSMutableArray *)myShopData{
    if (!_myShopData) {
        _myShopData = [NSMutableArray array];
        //        NSString *path = [[NSBundle mainBundle] pathForResource:@"MinePlist.plist" ofType: nil];
        //
        //        NSArray *arr = [NSArray arrayWithContentsOfFile:path];
        //        _myShopData = [MineCellModel objectArrayWithKeyValuesArray:arr];
    }
    return _myShopData;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
   [self setUpMainView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setUpMainView{
    UIView *contentView = [UIView new];
    [self.view addSubview:contentView];
    [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(self.view);
        make.height.mas_equalTo(200);
        make.center.mas_equalTo(self.view).mas_equalTo(CGPointMake(0, -MGMargin));
    }];
    
    UIImageView *backImageView = [[UIImageView alloc] init];
    backImageView.image = [UIImage imageNamed:@"v2_store_empty"];
    [contentView addSubview:backImageView];
    [backImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(100);
        make.center.mas_equalTo(contentView).mas_equalTo(CGPointMake(0, -2*MGMargin));
    }];
    
    UILabel *normalLabel = [[UILabel alloc] init];
    normalLabel.text = @"~~~暂时没有收藏店铺信息~~~";
    normalLabel.textAlignment = NSTextAlignmentCenter;
    [contentView addSubview:normalLabel];
    [normalLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(30);
        make.left.right.mas_equalTo(contentView);
        make.bottom.mas_equalTo(contentView.mas_bottom).offset(-2*MGMargin);
    }];

    
    [self setUpTableView];
}

// 2.tableView
-(void)setUpTableView{
    CGFloat y =  self.navigationController? MGNavHeight : 0;
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0,y, MGSCREEN_width, MGSCREEN_height - y) style:UITableViewStyleGrouped];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.rowHeight = 44;
    tableView.hidden = YES;
    self.tableView = tableView;
    [self.view addSubview:tableView];
    tableView.tableFooterView = [[UIView alloc] init];
}



#pragma mark - 数据源
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    self.tableView.hidden = (self.myShopData.count <= 0);
    return self.myShopData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MyShopIdentifier"];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MyShopIdentifier"];
    }
    
    return  cell;
}


#pragma mark - 代理



@end
