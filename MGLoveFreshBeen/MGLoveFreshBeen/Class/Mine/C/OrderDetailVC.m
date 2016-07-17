//
//  OrderDetailVC.m
//  MGLoveFreshBeen
//
//  Created by ming on 16/7/16.
//  Copyright © 2016年 ming. All rights reserved.
//

#import "OrderDetailVC.h"

@interface OrderDetailVC ()<UITableViewDelegate,UITableViewDataSource>
{
    UISegmentedControl *segment;
    UITableView *_oneView;
    UITableView *_twoView;
}

/** 数据源 */
@property (nonatomic,strong) NSMutableArray *oneData;
/** 数据源 */
@property (nonatomic,strong) NSMutableArray *twoData;

@end

@implementation OrderDetailVC

#pragma mark - lazy
- (NSMutableArray *)oneData{
    if (_oneData == nil) {
        _oneData = [NSMutableArray array];
        for (NSUInteger i = 0; i < 7; i++)
        {
            NSString *title = [NSString stringWithFormat:@"MG明明就是你：row=%ld",i];
            [_oneData addObject:title];
        }
    }
    return _oneData;
}

- (NSMutableArray *)twoData{
    if (_twoData == nil) {
        _twoData = [NSMutableArray array];
        for (NSUInteger j = 0; j < 23; j++)
        {
            NSString *title = [NSString stringWithFormat:@"商品详情：row=%ld", j];
            [_twoData addObject:title];
        }

    }
    return _twoData;
}

#pragma mark - 声明周期
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = MGBackGray;
    
    [self setMainView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

#pragma mark - 私有方法
#pragma mark - setMainView
- (void)setMainView{
    // 右边View
    [self setUpRightView];
    
    // 左边View
    [self setUpLefttView];
    
    
    NSArray *segArr=@[@"订单状态",@"订单详情"];
    //设置segment
    segment=[[UISegmentedControl alloc] initWithItems:segArr];
    segment.frame=CGRectMake(MGSCREEN_width/2-266/4, 25, 266/2, 30);
    [segment addTarget:self action:@selector(selectIndex:) forControlEvents:(UIControlEventValueChanged)];
    segment.layer.borderColor=[UIColor whiteColor].CGColor;
    segment.tintColor=[UIColor orangeColor];
    NSDictionary *dics = [NSDictionary dictionaryWithObject:[UIFont systemFontOfSize:15.0f] forKey:NSFontAttributeName];
    [segment setTitleTextAttributes:dics forState:UIControlStateNormal];
    segment.selectedSegmentIndex = 0;
    self.navigationItem.titleView  = segment;
}

// setUpLefttView
- (void)setUpLefttView{
    _oneView =[[UITableView alloc] initWithFrame:(CGRectMake(0, 0, MGSCREEN_width, MGSCREEN_height-MGNavHeight))];
    _oneView.delegate = self;
    _oneView.dataSource = self;
    [self.view addSubview:_oneView];
}

// setUpRightView
- (void)setUpRightView{
    _twoView = [[UITableView alloc] initWithFrame:(CGRectMake(0, 0, MGSCREEN_width, MGSCREEN_height- MGNavHeight))];
    _twoView.backgroundColor = [UIColor greenColor];
    _twoView.delegate = self;
    _twoView.dataSource = self;
    [self.view addSubview:_twoView];
    _twoView.tableFooterView = [[UIView alloc] init];
}

#pragma mark - segment的target
- (void)selectIndex:(UISegmentedControl *)segmentor{
    if(segmentor.selectedSegmentIndex==0){
        
        [self animationWithView:self.view WithAnimationTransition:(UIViewAnimationTransitionFlipFromLeft)];
        [self.view bringSubviewToFront:_oneView];
        
    }else{
        [self animationWithView:self.view WithAnimationTransition:(UIViewAnimationTransitionFlipFromRight)];
        [self.view bringSubviewToFront:_twoView];
    }
}
#pragma mark - 翻转动画
- (void)animationWithView:(UIView *)view WithAnimationTransition:(UIViewAnimationTransition) transition
{
    [UIView animateWithDuration:0.5f animations:^{
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        [UIView setAnimationTransition:transition forView:view cache:YES];
    }];
}


#pragma mark - 数据源
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if ([tableView isEqual:_oneView]) {
        return self.oneData.count;
    }else{
        return self.twoData.count;;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    NSString *const cellsIdentifier = @"cellsIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellsIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellsIdentifier];
    }
    
    if ([tableView isEqual:_oneView]) {
       cell.textLabel.text = self.oneData[indexPath.row];
    }else{
        cell.textLabel.text = self.twoData[indexPath.row];
    }
    
    return  cell;
}




@end
