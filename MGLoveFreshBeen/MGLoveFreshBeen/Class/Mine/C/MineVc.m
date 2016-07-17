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
#import "CouponVC.h"
#import "MessageVC.h"

#import "MyAddressVC.h"
#import "MyShopVC.h"


#import "HelpVC.h"
#import "IdeaVC.h"

#import "UMSocial.h"


@interface MineVC ()<UITableViewDataSource,UITableViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
/** tableView */
@property (nonatomic,weak) MineHeadView *headView;

/** tableView */
@property (nonatomic,weak) UITableView *tableView;

/** 数据源 */
@property (nonatomic,strong) NSArray *mineData;

/** 是否有人发布意见 */
@property (nonatomic, assign) BOOL  iderVCSendIderSuccess;

@end

CGFloat headViewHeight = 150;

@implementation MineVC
#pragma mark - lazy   数据源
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
    // 通知
    [[NSNotificationCenter defaultCenter] addObserverForName:@"sendIdeaSussessNotification" object:nil queue:nil usingBlock:^(NSNotification * _Nonnull note) {
        self.iderVCSendIderSuccess = YES;
    }];
    
    [self setUpHeaderView];
    
    [self setUpTableView];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    if (_iderVCSendIderSuccess) { // 是否有人提交意见
        MGPS(@"客服🐯哥已经收到你的意见了,我们会改进的,放心吧~~")
        _iderVCSendIderSuccess = false;
    }
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
    _headView = headView;
    headView.frame = CGRectMake(0, 0, MGSCREEN_width, headViewHeight);
    [self.view addSubview:headView];
    
    UITapGestureRecognizer *iconViewTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(iconViewTapClick)];
    [headView.iconView.iconImageView addGestureRecognizer:iconViewTap];
}

- (void)iconViewTapClick{
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"请选择照片来源" message:nil preferredStyle:UIAlertControllerStyleAlert];
     // 相机
    UIAlertAction *cameraAction = [UIAlertAction actionWithTitle:@"相机" style:UIAlertActionStyleDefault  handler:^(UIAlertAction * _Nonnull action) {
         [self openCamera:UIImagePickerControllerSourceTypeCamera];
    }];
    
    // 相册
    UIAlertAction *photoAction = [UIAlertAction actionWithTitle:@"相册" style:UIAlertActionStyleDefault  handler:^(UIAlertAction * _Nonnull action) {
        [self openCamera:UIImagePickerControllerSourceTypePhotoLibrary];
    }];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    
    [alertVC addAction:cameraAction];
    [alertVC addAction:photoAction];
    [alertVC addAction:cancelAction];
    [self.navigationController presentViewController:alertVC animated:YES completion:nil];
}
/**
 *  打开照相机/打开相册
 */
- (void)openCamera:(UIImagePickerControllerSourceType)type{
    if (![UIImagePickerController isSourceTypeAvailable:type]){
         MGPE(@"Camera不可用");
        return;
    }
    
    UIImagePickerController *ipc = [[UIImagePickerController alloc] init];
    ipc.sourceType = type;
    ipc.delegate = self;
    [self presentViewController:ipc animated:YES completion:nil];
}

#pragma mark - UIImagePickerControllerDelegate
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    
    //1.获取用户选中的图片
    UIImage *selectedImg =  info[UIImagePickerControllerOriginalImage];
    
    //2.设置图片
    [self.headView.iconView.iconImageView setImage:selectedImg];
    
    //3.隐藏当前图片选择控制器
    [self dismissViewControllerAnimated:YES completion:NULL];
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
        OrderVC *orderVC = [[OrderVC alloc] init];
        [self.navigationController pushViewController:orderVC animated:YES];
    };
    tableHead.CouponBtnClickBlock = ^{
        CouponVC *couponVC = [[CouponVC alloc] init];
        [self.navigationController pushViewController:couponVC animated:YES];
    };
    tableHead.messageBtnClickBlock = ^{
        MessageVC *messageVC = [[MessageVC alloc] init];
        [self.navigationController pushViewController:messageVC animated:YES];
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
        return 2;
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
    cell.imageView.image =[UIImage imageNamed:imageName];
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
             [self.navigationController pushViewController:[[MyAddressVC alloc] init] animated:YES];
        } else { // 我的店铺
            [self.navigationController pushViewController:[[MyShopVC alloc] init] animated:YES];
        }
    } else if (1 == indexPath.section) { // 把爱鲜蜂分享给好友
        [self shareToFriend];
    } else if (2 == indexPath.section) { // 客服帮助
        if (0 == indexPath.row) {
           [self.navigationController pushViewController:[[HelpVC alloc] init] animated:YES];
        } else if (1 == indexPath.row) { // 意见反馈
            [self.navigationController pushViewController:[[IdeaVC alloc] init] animated:YES];
        }
    }
}

// MARK: - Action
- (void)shareToFriend {
    // 微信
    [UMSocialData defaultData].extConfig.wechatSessionData.url = @"https://github.com/LYM-mg/MGLoveFreshBeen";
    [UMSocialData defaultData].extConfig.wechatSessionData.title = @"mingming";
    
    // 朋友圈
    [UMSocialData defaultData].extConfig.wechatTimelineData.url = @"http://www.jianshu.com/users/57b58a39b70e/latest_articles";
    [UMSocialData defaultData].extConfig.wechatTimelineData.title = @"赶快来关注我吧，支持我";
    
    NSString *shareText = @"小明OC全新开源作品,高仿爱鲜蜂,希望可以前来支持“。 https://github.com/LYM-mg/MGLoveFreshBeen";             //分享内嵌文字
    
    //分享内嵌图片
    UIImage *shareImage = [UIImage imageNamed:@"12.png"];
    
    // 分享平台
    NSArray *arr = [NSArray arrayWithObjects:UMShareToSina,UMShareToTencent,UMShareToQQ,UMShareToQzone,UMShareToWechatSession,UMShareToWechatTimeline,UMShareToWechatFavorite, nil];
    
    // 调用快速分享接口
    //调用快速分享接口
    [UMSocialSnsService presentSnsIconSheetView:self
                                         appKey:MGUmengAppkey
                                      shareText:shareText
                                     shareImage:shareImage
                                shareToSnsNames:arr
                                       delegate:nil];
}


//- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
//    if (scrollView.contentOffset.y > MGNavHeight) {
//        [UIView animateWithDuration:0.5 animations:^{
//            [self.navigationController setNavigationBarHidden:NO animated:YES];
//        }];
//    }else{
//        [self.navigationController setNavigationBarHidden:YES animated:YES];
//    }
//}

@end

@implementation MineCellModel

@end
