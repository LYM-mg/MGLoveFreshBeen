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
@property (nonatomic,weak) UITableView *addressTableView;

/** 数据源 */
@property (nonatomic,strong) NSMutableArray *myAddressData;

/** 当前的索引 */
@property (nonatomic,assign) long addressIndexRow;

/** 选中地址cell的回调 */
@property (nonatomic,strong) void (^selectedAdressCallback)(AddressCellModel *address);
@end

@implementation MyAddressVC

#pragma mark - lazy   数据源
- (NSMutableArray *)myAddressData{
    if (!_myAddressData) {
        _myAddressData = [NSMutableArray array];
    }
    return _myAddressData;
}

- (instancetype)initWithSelectedAdressCallback:(void (^)(AddressCellModel *))selectedAdressCallback{
    if (self = [super initWithNibName:nil bundle:nil]) {
        self.selectedAdressCallback = selectedAdressCallback;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self addObserveNOtification];
    
    // 设置UI
    [self setUpTableView];
    
    [self setUpBottomView];
    
    // 请求数据
    [self loadAddressData];
}
#pragma mark - 通知
- (void)addObserveNOtification{
    __weak typeof(self) weakSelf = self;
    // 1.添加地址
    [MGNotificationCenter addObserverForName:MGAddAddressNotification object:nil queue:nil usingBlock:^(NSNotification *note) {
        AddressCellModel *model = note.userInfo[@"address"];
        [weakSelf.myAddressData insertObject:model atIndex:0];
        [weakSelf.addressTableView reloadData];
    }];
    
    // 2.编辑地址
    [MGNotificationCenter addObserverForName:MGEditAddressNotification object:nil queue:nil usingBlock:^(NSNotification *note) {
        AddressCellModel *model = note.userInfo[@"address"];
        weakSelf.myAddressData[_addressIndexRow] = model;
        [weakSelf.addressTableView reloadData];
    }];
}

- (void)dealloc{
    NSLog(@"dealloc");
    [MGNotificationCenter removeObserver:self];
}

#pragma mark - 私有方法
// 1.tableView
-(void)setUpTableView{
    UIImageView *backImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"v2_store_empty"]];
    backImageView.tag = 2000;
    [backImageView sizeToFit];
    backImageView.center = CGPointMake(MGSCREEN_width * 0.5, self.view.height * 0.5 - 2*MGMargin);
    [self.view addSubview:backImageView];
    
    UILabel *normalLabel = [[UILabel alloc] init];
    normalLabel.tag = 3000;
    normalLabel.text = @"~~~暂时还没有收件地址，请设置收件地址~~~";
    normalLabel.textAlignment = NSTextAlignmentCenter;
    normalLabel.frame = CGRectMake(0, CGRectGetMaxY(backImageView.frame) + MGMargin, MGSCREEN_width, 50);
    [self.view addSubview:normalLabel];
    
    
//    CGFloat y =  self.navigationController? MGNavHeight : 0; CGRectMake(0,0, MGSCREEN_width, MGSCREEN_height - y)
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.rowHeight = 80;
    self.addressTableView = tableView;
    [self.view addSubview:tableView];
    
    [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
}

// 3.底部View setUpBottomView
- (void)setUpBottomView {
    UIView *bottomView = [[UIView alloc] init];
    bottomView.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.7];
    [self.view addSubview:bottomView];
    [bottomView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.bottom.left.right.equalTo(self.view);
        make.height.mas_equalTo(60);
    }];
    
    UIButton * addAddressBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    addAddressBtn.backgroundColor = [UIColor yellowColor];
    [addAddressBtn setTitle:@"+ 增加地址" forState:UIControlStateNormal];
    [addAddressBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [addAddressBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
    addAddressBtn.showsTouchWhenHighlighted = YES;
    [addAddressBtn addTarget:self action:@selector(addAddressBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [bottomView addSubview:addAddressBtn];
    
    [addAddressBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(bottomView);
    }];
}

- (void)addAddressBtnClick {
    [self pushController:[EditAddressVC class] withInfo:nil withTitle:@"添加地址"];
}


// 2.加载地址数据
- (void)loadAddressData{
    __weak typeof(self) weakSelf = self;
    [[[NSOperationQueue alloc] init] addOperationWithBlock:^{
        NSString *path = [[NSBundle mainBundle] pathForResource:@"MyAdress" ofType: nil];
        
        NSData *data = [[NSData alloc] initWithContentsOfFile:path];
        
        NSDictionary *dictArr = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        
        NSArray *arr = [AddressCellModel objectArrayWithKeyValuesArray:[dictArr valueForKey:@"data"]];
        [weakSelf.myAddressData addObjectsFromArray:arr];
        
        // 回到主线程刷新UI
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            [weakSelf.addressTableView reloadData];
        }];
        
    }];
}

- (void)shouldHideThisView{
    UIImageView *ibgV = (UIImageView *)[self.view viewWithTag:2000];
    UILabel *lb = (UILabel *)[self.view viewWithTag:3000];
    ibgV.hidden = self.myAddressData.count>0;
    lb.hidden = self.myAddressData.count>0;
    self.addressTableView.hidden = (self.myAddressData.count <= 0);
}
#pragma mark - 数据源
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    [self shouldHideThisView];
    
    return self.myAddressData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    __weak typeof(self) weakSelf = self;
    // 1创建cell
    MyAddressCell *cell = [MyAddressCell myAddressCellWithTableView:tableView withEditTapClick:^{
        weakSelf.addressIndexRow = indexPath.row;
        [weakSelf pushController:[EditAddressVC class] withInfo:self.myAddressData[indexPath.row] withTitle:@"修改地址"];
    }];
    
    // 2.取得模型赋值
    cell.addressModel = self.myAddressData[indexPath.row];
    
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressClick:)];
    [cell addGestureRecognizer:longPress];
    
    // 3.返回cell
    return  cell;
}

- (void)longPressClick:(UILongPressGestureRecognizer *)longPress{
    if (self.selectedAdressCallback) {
        MyAddressCell *cell = (MyAddressCell *)longPress.view;
        NSIndexPath *indexPath = [self.addressTableView indexPathForCell:cell];
        
        self.selectedAdressCallback(self.myAddressData[indexPath.row]);
        [self.navigationController popViewControllerAnimated:YES];
    }
}

#pragma mark - UITableViewDelegate代理
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"%ld",indexPath.row);
    
//    if (self.selectedAdressCallback) {
//        self.selectedAdressCallback(self.myAddressData[indexPath.row]);
//        [self.navigationController popViewControllerAnimated:YES];
//    }
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"取消选中");
}


@end
