//
//  MessageVC.m
//  MGLoveFreshBeen
//
//  Created by ming on 16/7/14.
//  Copyright © 2016年 ming. All rights reserved.
//

#import "MessageVC.h"
#import "MessageModel.h"
#import "MessageCell.h"

enum {
  System = 0,
  User = 1
}UserMessageType;

@interface MessageVC ()<UITableViewDelegate,UITableViewDataSource>
{
    UISegmentedControl *segment;
    UITableView *_leftView;
    UITableView *_rightnView;
}

/** 数据源 */
@property (nonatomic,strong) NSArray *messageData;

@end

@implementation MessageVC
#pragma mark - lazy   数据源
- (NSArray *)messageData{
    if (!_messageData) {
        _messageData = [NSArray array];
        NSString *path = [[NSBundle mainBundle] pathForResource:@"SystemMessage" ofType: nil];
        
        NSData *data = [NSData dataWithContentsOfFile:path];
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        NSString *str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        [str stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];

        _messageData = [MessageModel objectArrayWithKeyValuesArray:dict[@"data"]];
    }
    return _messageData;
}

#pragma mark - 声明周期
- (void)viewDidLoad {
    [super viewDidLoad];
   
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

    
    NSArray *segArr=@[@"系统消息",@"用户消息"];
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
    _leftView=[[UITableView alloc] initWithFrame:(CGRectMake(0, MGNavHeight, MGSCREEN_width, MGSCREEN_height-MGNavHeight))];
    _leftView.delegate = self;
    _leftView.dataSource = self;
    [self.view addSubview:_leftView];
}

// setUpRightView
- (void)setUpRightView{
    _rightnView = [[UITableView alloc] initWithFrame:(CGRectMake(0, MGNavHeight, MGSCREEN_width, MGSCREEN_height- MGNavHeight))];
    _rightnView.backgroundColor=[UIColor greenColor];
    [self.view addSubview:_rightnView];
    _rightnView.tableFooterView = [[UIView alloc] init];
    
    UIImageView *backImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"v2_my_message_empty"]];
    [backImageView sizeToFit];
    backImageView.center = CGPointMake(MGSCREEN_width * 0.5, MGSCREEN_height * 0.2);
    
    [_rightnView addSubview:backImageView];
    UILabel *normalLabel = [[UILabel alloc] init];
    normalLabel.text = @"~~~并没有消息~~~";
    normalLabel.textAlignment = NSTextAlignmentCenter;
    normalLabel.frame = CGRectMake(0, CGRectGetMaxY(backImageView.frame) + MGMargin, MGSCREEN_width, 50);
    [_rightnView addSubview:normalLabel];
}

#pragma mark - segment的target
- (void)selectIndex:(UISegmentedControl *)segmentor{
    if(segmentor.selectedSegmentIndex==0){
        
        [self animationWithView:self.view WithAnimationTransition:(UIViewAnimationTransitionCurlUp)];
        [self.view bringSubviewToFront:_leftView];
        
    }else{
        [self animationWithView:self.view WithAnimationTransition:(UIViewAnimationTransitionCurlDown)];
        [self.view bringSubviewToFront:_rightnView];
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
    return self.messageData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    MessageCell *cell = [MessageCell messageCellWitnTableView:tableView];
    
    cell.model = self.messageData[indexPath.row];
    
    return  cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    MessageModel *model = _messageData[indexPath.row];

    return model.cellHeight;
}

#pragma mark - 代理

@end
