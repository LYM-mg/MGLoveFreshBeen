//
//  HelpVC.m
//  MGLoveFreshBeen
//
//  Created by ming on 16/7/13.
//  Copyright © 2016年 ming. All rights reserved.
//

#import "HelpVC.h"
#import "QuestionVC.h"

@interface HelpVC ()<UITableViewDataSource,UITableViewDelegate>

/** tableView */
@property (nonatomic,weak) UITableView *tableView;

@end

@implementation HelpVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, MGSCREEN_width, self.view.height) style:UITableViewStyleGrouped];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.rowHeight = 50;
    self.tableView = tableView;
    [self.view addSubview:tableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *const KHelpCellID = @"KHelpCellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:KHelpCellID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:KHelpCellID];
    }
    if (indexPath.row == 0) {
        cell.textLabel.text = @"客服电话";
        cell.detailTextLabel.text = @"13750526790";
    }else{
        cell.accessoryType = UITableViewCellAccessoryDetailButton;
        cell.textLabel.text = @"常见问题";
    }
    
    return cell;
}


#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        NSString *phoneNum = [tableView cellForRowAtIndexPath:indexPath].detailTextLabel.text;
        UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"确定要拨打电话" message:phoneNum preferredStyle:UIAlertControllerStyleActionSheet];
        UIAlertAction *phoneAction = [UIAlertAction actionWithTitle:@"拨打" style:UIAlertActionStyleDestructive  handler:^(UIAlertAction * _Nonnull action) {
            /// 1.第一种打电话(拨打完电话回不到原来的应用，会停留在通讯录里，而且是直接拨打，不弹出提示)
//            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel:%@",phoneAction]]];
            
            /// 2.第二种打电话(打完电话后还会回到原来的程序，也会弹出提示，推荐这种)
            UIWebView *callWebview = [[UIWebView alloc] init];
            [callWebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[[NSMutableString alloc] initWithFormat:@"tel:%@",phoneNum]]]];
            [self.view addSubview:callWebview];
            
            /// 3.第三种打电话(这种方法也会回去到原来的程序里（注意这里的telprompt），也会弹出提示)
//            NSMutableString* str=[[NSMutableString alloc] initWithFormat:@"telprompt://%@",@"186xxxx6979"];
//            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
        }];
        
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
           
        }];
    
        [alertVC addAction:phoneAction];
        [alertVC addAction:cancelAction];
        [self.navigationController presentViewController:alertVC animated:YES completion:nil];
    }else{
        [self.navigationController pushViewController:[[QuestionVC alloc] init] animated:YES];
    }
}

@end
