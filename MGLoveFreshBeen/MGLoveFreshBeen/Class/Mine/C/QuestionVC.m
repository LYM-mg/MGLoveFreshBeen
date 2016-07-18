//
//  QuestionVC.m
//  MGLoveFreshBeen
//
//  Created by ming on 16/7/13.
//  Copyright © 2016年 ming. All rights reserved.
// !

#import "QuestionVC.h"
#import "questionCellModel.h"
#import "QuestionCell.h"
#import "QuestionSectionHeader.h"

@interface QuestionVC ()<UITableViewDataSource,UITableViewDelegate>

/** tableView */
//@property (nonatomic,weak) UITableView *tableView;

/** 问题数据源 */
@property (nonatomic,strong) NSArray *questionData;

/** 行高 */
@property (nonatomic, assign) CGFloat cellHeight;

/** Bool */
@property (nonatomic, assign) BOOL isLastExpanded;


@end

@implementation QuestionVC

static NSString *const KQuestionSectionHeader = @"KQuestionSectionHeader";

#pragma mark - lazy
- (NSArray *)questionData{
    if (!_questionData) {
        _questionData = [NSArray array];
        // 串行队列
        dispatch_queue_t queue = dispatch_queue_create("mingming", DISPATCH_QUEUE_SERIAL);
        dispatch_async(queue, ^{
            NSString *path = [[NSBundle mainBundle] pathForResource:@"HelpPlist.plist" ofType: nil];
            NSArray *arrayDict = [NSArray arrayWithContentsOfFile:path];
            
            NSMutableArray *questions = [NSMutableArray array];
            for (NSDictionary *dict in arrayDict) {
                questionCellModel *model = [questionCellModel questionModelWithDict:dict];
                [questions addObject:model];
                 _questionData = questions;
            }
        });
    }
    return _questionData;
}


#pragma mark - 生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"常见问题";
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    // 创建UI
    [self setMianView];
}


#pragma mark - 私有方法
- (void)setMianView {
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = [UIColor whiteColor];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 44;

    [self.tableView registerClass:[QuestionSectionHeader class] forHeaderFooterViewReuseIdentifier:KQuestionSectionHeader];
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.questionData.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    // 取得每一组的头部模型
    questionCellModel *sectionModel = self.questionData[section];
    
    // 展开既有数据，未展开则没有数据
    return sectionModel.isExpanded ? 1 : 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    QuestionCell *cell = [[QuestionCell alloc] init];
    cell.questionModel = self.questionData[indexPath.section];
    
    return cell;
}


#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    questionCellModel *model = self.questionData[indexPath.section];
    
    return [model cellHeight];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 44;
}

/***
 *  每一组的头部
 */
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    QuestionSectionHeader *headerView = (QuestionSectionHeader *)[tableView dequeueReusableHeaderFooterViewWithIdentifier:KQuestionSectionHeader];
   
    __weak typeof(self) weakSelf = self;
    
    /** 头部点击的回调 */
    headerView.sectionHeaderClickBlock = ^(BOOL isExpanded){
        __block CGPoint offset = tableView.contentOffset;
        if (isExpanded) {
            CGFloat offsetY = headerView.frame.origin.y - offset.y;
            if (offsetY > MGSCREEN_height*0.5){
                [UIView animateWithDuration:0.8 animations:^{
                    offset.y = headerView.frame.origin.y;
                    weakSelf.tableView.contentOffset = offset;
                }];
            }
        }else {
            weakSelf.tableView.contentOffset = offset;
        }
        
        [weakSelf.tableView reloadSections:[NSIndexSet indexSetWithIndex:section] withRowAnimation:UITableViewRowAnimationAutomatic];
    };

    headerView.model = self.questionData[section];
    return headerView;
}


@end
