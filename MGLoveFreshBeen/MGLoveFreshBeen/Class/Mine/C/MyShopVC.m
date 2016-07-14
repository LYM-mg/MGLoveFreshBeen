
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
    UIImageView *backImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"v2_store_empty"]];
    [backImageView sizeToFit];
    backImageView.center = CGPointMake(MGSCREEN_width * 0.5,self.view.height * 0.5);
    [self.view addSubview:backImageView];
    
    UILabel *normalLabel = [[UILabel alloc] init];
    normalLabel.text = @"~~~暂时没有收藏店铺信息~~~";
    normalLabel.textAlignment = NSTextAlignmentCenter;
    normalLabel.frame = CGRectMake(0, CGRectGetMaxY(backImageView.frame) + MGMargin, MGSCREEN_width, 50);
    [self.view addSubview:normalLabel];

    
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
