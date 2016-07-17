//
//  HomeVC.m
//  MGLoveFreshBeen
//
//  Created by ming on 16/7/12.
//  Copyright © 2016年 ming. All rights reserved.
//

#import "HomeVC.h"
#import "HomeCollectionHeaderView.h"
#import "HomeHeaderView.h"
#import "HeadReosurce.h"

#import "HomeWebVC.h"

@interface HomeVC ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
{
    /** collectionView */
    UICollectionView *homeCollectionView;
}
/** 数据 */
@property (nonatomic, strong) NSMutableArray *dataArr;
/** 顶部View */
@property (nonatomic,strong) HomeHeaderView *headView;

/** 模型 */
@property (nonatomic,strong) HeadReosurce *headData;

@end

@implementation HomeVC

static NSString *const KHomeCellIdentifier = @"KHomeCellIdentifier";
static NSString *const KHomeHeaderIdentifier = @"Hearder";
static NSString *const KHomeFooterIdentifier = @"Footer";

#pragma mark - HomeVC声明周期
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = MGProductBackGray;
    
    // 通知
    [self addObserverNotification];
    
    [self setUpHomeCollectionView];
    
    
    [self setUpHomeHeaderView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

#pragma mark - HomeHeaderView
- (void)setUpHomeHeaderView {
    HomeHeaderView *headView = [[HomeHeaderView alloc] initWithFrame:CGRectMake(0, 0, MGSCREEN_width, 230)];
    [homeCollectionView addSubview:headView];
    _headView = headView;
    [self loadHeadData];
}

- (void)loadHeadData{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"首页焦点按钮" ofType: nil];
    
    NSData *data = [NSData dataWithContentsOfFile:path];
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    NSString *str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    [str stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    
    _headView.headData = [HeadReosurce objectWithKeyValues:dict];
    self.headData = _headView.headData;
}

#pragma mark - collectionView
/// 初始化collectionView
- (void)setUpHomeCollectionView{
    // 1.创建layout
    UICollectionViewFlowLayout *layout = ({
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.minimumInteritemSpacing = MGSmallMargin;
        layout.minimumLineSpacing = 8;
        layout.sectionInset = UIEdgeInsetsMake(0, MGMargin, 0, MGMargin);
        layout;
    });
    
    // 2.创建CollectionView
    UICollectionView *collectionView = ({
        UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
        collectionView.backgroundColor = [UIColor clearColor];
        collectionView.dataSource = self;
        collectionView.delegate = self;
        collectionView.showsHorizontalScrollIndicator = NO;
        collectionView.showsVerticalScrollIndicator = NO;
        collectionView;
    });
    [self.view addSubview:collectionView];
    homeCollectionView = collectionView;
    
    // 3.注册
    // cell
    [homeCollectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:KHomeCellIdentifier];
    // 头部和尾部
//    [homeCollectionView registerClass:[HomeCollectionHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:KHomeHeaderIdentifier];
//    [homeCollectionView registerClass:[HomeCollectionHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:KHomeFooterIdentifier];
    
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 2;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 9;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:KHomeCellIdentifier forIndexPath:indexPath];

    
    cell.backgroundColor = MGRandomColor;
    
    return cell;
}

// 每个item的尺寸
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (0 == indexPath.section) {
        return  CGSizeMake(MGSCREEN_width - MGMargin * 2, 140);
    } else if (1 == indexPath.section) {
        return  CGSizeMake((MGSCREEN_width - MGMargin * 2) * 0.5 - 4, 250);
    }
    return CGSizeZero;
}

// 头部的尺寸
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    if (0 == section) { // 10
        return CGSizeMake(MGSCREEN_width, MGMargin);
    } else if (1 == section) { // 20
        return CGSizeMake(MGSCREEN_width, MGMargin * 2);
    }
    
    return CGSizeZero;
}

// 尾部的尺寸
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section{
    if (0 == section) { // 10
        return CGSizeMake(MGSCREEN_width, MGMargin);
    } else if (1 == section) { // 50
        return CGSizeMake(MGSCREEN_width, MGMargin * 5);
    }
    
    return CGSizeZero;
}

#pragma mark - UICollectionViewDelegate
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
   return  UIEdgeInsetsMake(_headView.height, 0, 0, 0);
}


//- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
//    if (1 == indexPath.section && kind == UICollectionElementKindSectionHeader) { // 头部
//       HomeCollectionHeaderView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:KHomeHeaderIdentifier  forIndexPath:indexPath];
//        return headerView;
//    }
//    else if (1 == indexPath.section && kind == UICollectionElementKindSectionFooter){ // 尾部
//        HomeCollectionFooterView *footerView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:KHomeFooterIdentifier forIndexPath:indexPath];
//        
//        return footerView;
//    }
//    return  nil;
//}
#pragma mark - 通知
- (void)addObserverNotification{
    // 解决循环引用
      __weak typeof(self) weakSelf = self;

    // hotView点击
    [MGNotificationCenter addObserverForName:MGHotPanClickNotification object:nil queue:nil usingBlock:^(NSNotification * note) {
        
        NSInteger item = ([[note.userInfo valueForKeyPath:@"tag"] integerValue] - 20);
        
         HomeWebVC *webVC = [[HomeWebVC alloc] initWithNavigationTitle:[_headData.data.icons[item] valueForKeyPath:@"name"] withUrlStr:[_headData.data.icons[item] valueForKeyPath:@"customURL"]];
            [weakSelf.navigationController pushViewController:webVC animated:YES];
       
    }];
    
    
    // 轮播器图片被点击的通知
    [MGNotificationCenter addObserverForName:MGCarouseViewImageClickNotification object:nil queue:nil usingBlock:^(NSNotification *note) {
        
        NSString *path = [[NSBundle mainBundle] pathForResource:@"FocusURL.plist" ofType: nil];
    
        NSArray *array = [NSArray arrayWithContentsOfFile:path];
        
        NSInteger index = [[note.userInfo valueForKey:@"index"] integerValue];
        
        MGLog(@"%@",[note.userInfo valueForKey:@"index"]);
        
        HomeWebVC *webVC = [[HomeWebVC alloc] initWithNavigationTitle:[_headData.data.focus[index] valueForKeyPath:@"name"] withUrlStr:array[index]];
        [weakSelf.navigationController pushViewController:webVC animated:YES];
    }];
}

- (void)dealloc{
    [MGNotificationCenter removeObserver:self];
    MGLogFunc;
}

@end
