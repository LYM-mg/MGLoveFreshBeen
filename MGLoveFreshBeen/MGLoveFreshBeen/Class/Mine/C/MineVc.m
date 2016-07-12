//
//  MineVC.m
//  MGLoveFreshBeen
//
//  Created by ming on 16/7/12.
//  Copyright © 2016年 ming. All rights reserved.
//

#import "MineVC.h"
#import "MineHeadView.h"
#import "TableHeadView.h"

#import "SettingVC.h"
#import "OrderVC.h"



@interface MineVC ()<UITableViewDataSource,UITableViewDelegate>

/** tableView */
@property (nonatomic,weak) UITableView *tableView;

/** 数据源 */
@property (nonatomic,strong) NSArray *mineData;
@end

CGFloat headViewHeight = 150;

@implementation MineVC
- (NSArray *)mineData{
    if (!_mineData) {
        _mineData = [NSArray array];
        NSString *path = [[NSBundle mainBundle] pathForResource:@"MinePlist.plist" ofType: nil];
        
        NSArray *arr = [NSArray arrayWithContentsOfFile:path];
        _mineData = [MineCellModel objectArrayWithKeyValuesArray:arr];
    }
    return _mineData;
}


#pragma mark - 生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpHeaderView];
    
    [self setUpTableView];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

#pragma mark - 初始化UI
// 1.头部
-(void)setUpHeaderView{
    __weak typeof(self) weakSelf = self;

    MineHeadView *headView =  [[MineHeadView alloc] initWithFrame:CGRectZero setUpButtonClick:^{
        SettingVC *settingVc = [[SettingVC alloc] init];
        [weakSelf.navigationController pushViewController:settingVc  animated:YES];
    }];
    headView.frame = CGRectMake(0, 0, MGSCREEN_width, headViewHeight);
    [self.view addSubview:headView];
}

// 2.tableView
-(void)setUpTableView{
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, headViewHeight, MGSCREEN_width, MGSCREEN_height - headViewHeight) style:UITableViewStyleGrouped];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.rowHeight = 44;
    self.tableView = tableView;
    [self.view addSubview:tableView];
    
    TableHeadView *tableHead = [TableHeadView tableHeadView];
    tableHead.frame = CGRectMake(0, 0, MGSCREEN_width, 70);
    tableView.tableHeaderView = tableHead;
    
    /// 我的订单/优惠券/我的消息 回调
    tableHead.orderBtnClickBlock = ^{
        OrderVC *order = [[OrderVC alloc] init];
        [self.navigationController pushViewController:order animated:YES];
    };
    tableHead.CouponBtnClickBlock = ^{
        
    };
    tableHead.messageBtnClickBlock = ^{
        
    };
}


#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 2;
    }else if (section == 1){
        return 1;
    }else{
        return 3;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *const KMineCellID = @"KMineCellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:KMineCellID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:KMineCellID];
    }
    
    // 设置数据
    NSString *text = nil;
    NSString *imageName = nil;
    if (0 == indexPath.section) {
        MineCellModel *model = self.mineData[indexPath.row];
        text = model.title;
        imageName = model.iconName;
        
    } else if (1 == indexPath.section) {
        MineCellModel *model = self.mineData[2];
        text = model.title;
        imageName = model.iconName;
    } else {
        if (indexPath.row == 0) {
            MineCellModel *model = self.mineData[3];
            text = model.title;
            imageName = model.iconName;
        } else {
            MineCellModel *model = self.mineData[4];
            text = model.title;
            imageName = model.iconName;
        }
    }
    
    cell.textLabel.text = text;
    [cell.imageView sd_setImageWithURL:[NSURL URLWithString:imageName]];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (0 == indexPath.section) {
        if (0 == indexPath.row) { // 我的收获地址
            
        } else { // 我的店铺
         
        }
    } else if (1 == indexPath.section) { // 把爱鲜蜂分享给好友
       
    
    } else if (2 == indexPath.section) { // 客服帮助
        if (0 == indexPath.row) {
          
        } else if (1 == indexPath.row) { // 意见反馈
        
        }
    }
}


@end

@implementation MineCellModel

@end
