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
#import "HotFreshModel.h"
#import "HomeCollectionCell.h"

#import "HomeWebVC.h"
#import "ProductDetailVC.h"

#import "UIBarButtonItem+Extension.h"
#import "QRCodeVC.h"
#import "HomeSearchVC.h"

@interface HomeVC ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
{
    /** collectionView */
    UICollectionView *homeCollectionView;
}
/** 顶部View */
@property (nonatomic,strong) HomeHeaderView *headView;

/** 轮播图和下面四个下家伙的模型 */
@property (nonatomic,strong) HeadReosurce *headData;
/** 热点模型 */
@property (nonatomic,strong) HotFreshModel *hotFreshData;

/** tableView第一组数据源 */
@property (nonatomic, strong) NSArray *activitiesArr;

/** tableView第二组数据源 */
@property (nonatomic, strong) NSArray *goodsArr;


/** <#注释#> */
@property (nonatomic,strong) NSMutableArray<CALayer *> *animationLayers;
/** <#注释#> */
@property (nonatomic,strong) NSMutableArray<CALayer *> *animationBigLayers;
@end

@implementation HomeVC

static NSString *const KHomeCellIdentifier = @"KHomeCellIdentifier";
static NSString *const KHomeHeaderIdentifier = @"Hearder";
static NSString *const KHomeFooterIdentifier = @"Footer";

#pragma mark - lazy
- (NSArray *)activitiesArr{
    if (_activitiesArr == nil) {
        _activitiesArr = [NSArray arrayWithArray:[Activities objectArrayWithKeyValuesArray:_headData.data.activities]];
    }
    return _activitiesArr;
}

- (NSArray *)goodsArr{
    if (_goodsArr == nil) {
        _goodsArr = [NSArray arrayWithArray:[HotGoods objectArrayWithKeyValuesArray:_hotFreshData.data]];
    }
    return _goodsArr;
}


#pragma mark - HomeVC声明周期
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = MGRGBColor(235, 235, 235);
    // 导航栏
    [self setUpNavigationItem];
    
    // 通知
    [self addObserverNotification];
    
    // 主界面
    [self setUpHomeCollectionView];
    
    // 主界面的头部
    [self setUpHomeHeaderView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

#pragma mark - 导航栏
- (void)setUpNavigationItem{
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:[UIImage imageNamed:@"icon_black_scancode"] highImage:nil norColor:[UIColor whiteColor] selColor:MGProductBackGray title:@"扫一扫" target:self action:@selector(scanClick)];

    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithImage:[UIImage imageNamed:@"icon_search"] highImage:nil norColor:[UIColor whiteColor] selColor:MGProductBackGray title:@"搜 索" target:self action:@selector(searchClick)];
}

/**
 *  扫一扫
 */
- (void)scanClick{
    [self.navigationController presentViewController:[UIStoryboard storyboardWithName:@"QRCode" bundle:nil].instantiateInitialViewController animated:YES completion:nil];
}

/**
 *  搜索功能
 */
- (void)searchClick{
    [self.navigationController pushViewController:[[HomeSearchVC alloc] init] animated:YES];
}

#pragma mark - HomeHeaderView
- (void)setUpHomeHeaderView {
    HomeHeaderView *headView = [[HomeHeaderView alloc] initWithFrame:CGRectMake(0, 0, MGSCREEN_width, 230)];
    [homeCollectionView addSubview:headView];
    _headView = headView;
    [self loadHeadData];
}

/**
 *  加载数据
 */
- (void)loadHeadData{
        // 1.首页焦点按钮
        NSDictionary *focusDict = [self loadDataWithStr:@"首页焦点按钮"];
        _headView.headData = [HeadReosurce objectWithKeyValues:focusDict];
        self.headData = _headView.headData;
        
        // 2.首页新鲜热卖
        NSDictionary *freshDict = [self loadDataWithStr:@"首页新鲜热卖"];
        self.hotFreshData = [HotFreshModel objectWithKeyValues:freshDict];
        
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            [homeCollectionView reloadData];
        }];
}

- (NSDictionary *)loadDataWithStr:(NSString *)str{
    NSString *path = [[NSBundle mainBundle] pathForResource:str ofType: nil];
    
    NSData *data = [NSData dataWithContentsOfFile:path];
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    NSString *uTF8Str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    [uTF8Str stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    return dict;
}

#pragma mark - collectionView
/**
 *  初始化collectionView
 */
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
        collectionView.height = MGSCREEN_height - MGTabBarHeight;
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
    [homeCollectionView registerClass:[HomeCollectionCell class] forCellWithReuseIdentifier:KHomeCellIdentifier];
    
    // 头部和尾部
//    [homeCollectionView registerClass:[HomeCollectionHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:KHomeHeaderIdentifier];
//    [homeCollectionView registerClass:[HomeCollectionHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:KHomeFooterIdentifier];
    
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    if (_headData.data.activities.count <= 0 || _hotFreshData.data.count <= 0)
    {  return 0;  }
    
    return 2;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (_headData.data.activities.count <= 0 || _hotFreshData.data.count <= 0)
    {  return 0; }
    
    // 第一组
    if (0 == section) { return _headData.data.activities.count; }
    // 第二组
    else if (1 == section) { return _hotFreshData.data.count; }
    // 其他
    return 0;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    HomeCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:KHomeCellIdentifier forIndexPath:indexPath];
    
    if (0 == indexPath.section) {
        cell.Activity = self.activitiesArr[indexPath.row];

    } else if (1 == indexPath.section) {
        cell.goodModel = self.goodsArr[indexPath.row];
        
        __weak typeof(self) weakSelf = self;
        cell.addButtonClick = ^(UIImageView *imageView){
            [weakSelf addProductsAnimation:imageView];
        };
    }

    return cell;
}

// 每个item的尺寸
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (0 == indexPath.section) {
        return  CGSizeMake(MGSCREEN_width - MGMargin * 2, 140);
    } else if (1 == indexPath.section) {
        return  CGSizeMake((MGSCREEN_width - MGMargin) * 0.5, 260);
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
    } else if (1 == section) { // 10
        return CGSizeMake(MGSCREEN_width, MGMargin);
    }
    
    return CGSizeZero;
}

// 插入内边距，显示顶部轮播器和四个小家伙
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    if (0 == section) {
        return UIEdgeInsetsMake(_headView.height, 0, 0, 0);
    }
    return UIEdgeInsetsMake(0, 0, MGMargin, 0);;
}
#pragma mark - UICollectionViewDelegate
/**
 *  选中那个cell跳转
 */
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (0 == indexPath.section) {
        NSArray *tmpArr = [NSArray array];
        tmpArr = [Activities objectArrayWithKeyValuesArray:_headData.data.activities];
        Activities *activity = tmpArr[indexPath.row];
        HomeWebVC *webVC = [[HomeWebVC alloc] initWithNavigationTitle:activity.name withUrlStr:activity.customURL];
        [self.navigationController pushViewController:webVC animated:YES];
    } else if (1 == indexPath.section) {
        NSArray *tmpArr2 = [NSArray array];
        tmpArr2 = [HotGoods objectArrayWithKeyValuesArray:_hotFreshData.data];
        ProductDetailVC *productDetailVC = [[ProductDetailVC alloc] initWithGoods:tmpArr2[indexPath.row]];
        [self.navigationController pushViewController:productDetailVC animated:YES];
    }
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
#pragma mark - 通知 (跳转网页)
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
        
        // MGLog(@"%@",[note.userInfo valueForKey:@"index"]);
        
        HomeWebVC *webVC = [[HomeWebVC alloc] initWithNavigationTitle:[_headData.data.focus[index] valueForKeyPath:@"name"] withUrlStr:array[index]];
        [weakSelf.navigationController pushViewController:webVC animated:YES];
    }];
}

- (void)dealloc{
    [MGNotificationCenter removeObserver:self];
}

#pragma mark - 商品到购物车动画
// MARK: 商品添加到购物车动画
- (void)addProductsAnimation:(UIImageView *)imageView {
    
    if (self.animationLayers == nil)
    {
        self.animationLayers = [NSMutableArray array];
    }
    
    CGRect frame = [imageView convertRect:imageView.bounds toView:self.view];
    CALayer *transitionLayer = [CALayer layer];
    transitionLayer.frame = frame;
    transitionLayer.contents = imageView.layer.contents;
    [self.view.layer addSublayer:transitionLayer];
    [self.animationLayers addObject:transitionLayer];
    
    CGPoint p1 = transitionLayer.position;
    CGPoint p3 = CGPointMake( self.view.width - self.view.width / 4 -  self.view.width / 8 - 6, self.view.layer.bounds.size.height - 40);
    
    CAKeyframeAnimation *positionAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, nil, p1.x, p1.y);
    CGPathAddCurveToPoint(path, nil, p1.x, p1.y - 30, p3.x, p1.y - 30, p3.x, p3.y);
    positionAnimation.path = path;
    
    CABasicAnimation *opacityAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    opacityAnimation.fromValue = @(1);
    opacityAnimation.toValue = @(0.9);
    opacityAnimation.fillMode = kCAFillModeForwards;
    opacityAnimation.removedOnCompletion = YES;
    
    CABasicAnimation *transformAnimation = [CABasicAnimation animationWithKeyPath:@"transform"];
    transformAnimation.fromValue = [NSValue valueWithCATransform3D:CATransform3DIdentity];
    transformAnimation.toValue = [NSValue valueWithCATransform3D:CATransform3DScale(CATransform3DIdentity, 0.2, 0.2, 1)];
    
    CAAnimationGroup *groupAnimation = [CAAnimationGroup animation];
    groupAnimation.animations = @[positionAnimation, transformAnimation, opacityAnimation];
    groupAnimation.duration = 0.8;
    groupAnimation.delegate = self;
    
    [transitionLayer addAnimation:groupAnimation  forKey: @"cartParabola"];
}


// MARK: - 添加商品到右下角购物车动画
- (void)addProductsToBigShopCarAnimation:(UIImageView *)imageView{
    if (_animationBigLayers == nil) {
        _animationBigLayers = [NSMutableArray array];
    }
    
    CGRect frame = [imageView convertRect:imageView.bounds toView:self.view];
    CALayer *transitionLayer = [CALayer layer];
    transitionLayer.frame = frame;
    transitionLayer.contents = imageView.layer.contents;
    [self.view.layer addSublayer:transitionLayer];
    [self.animationBigLayers addObject:transitionLayer];
    
    CGPoint p1 = transitionLayer.position;
    CGPoint p3 = CGPointMake(self.view.width - 40, self.view.layer.bounds.size.height - 40);
    
    CAKeyframeAnimation *positionAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, nil, p1.x, p1.y);
    CGPathAddCurveToPoint(path, nil, p1.x, p1.y - 30, p3.x, p1.y - 30, p3.x, p3.y);
    positionAnimation.path = path;
    
    CABasicAnimation *opacityAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    opacityAnimation.fromValue = @(1);
    opacityAnimation.toValue = @(0.9);
    opacityAnimation.fillMode = kCAFillModeForwards;
    opacityAnimation.removedOnCompletion = YES;
    
    CABasicAnimation *transformAnimation = [CABasicAnimation animationWithKeyPath:@"transform"];
    transformAnimation.fromValue = [NSValue valueWithCATransform3D:CATransform3DIdentity];
    transformAnimation.toValue = [NSValue valueWithCATransform3D:CATransform3DScale(CATransform3DIdentity, 0.2, 0.2, 1)];
    
    CAAnimationGroup *groupAnimation = [CAAnimationGroup animation];
    groupAnimation.animations = @[positionAnimation, transformAnimation, opacityAnimation];
    groupAnimation.duration = 0.8;
    groupAnimation.delegate = self;
    
   [transitionLayer addAnimation:groupAnimation  forKey: @"BigShopCarAnimation"];
}


- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    if (self.animationLayers.count > 0) {
        CALayer *transitionLayer = self.animationLayers[0];
        transitionLayer.hidden = YES;
        [transitionLayer removeFromSuperlayer];
        [self.animationLayers removeObjectAtIndex:0];
        [self.view.layer removeAnimationForKey:@"cartParabola"];
    }
    
    if (self.animationBigLayers.count > 0) {
        CALayer *transitionLayer = self.animationLayers[0];
        transitionLayer.hidden = YES;
        [transitionLayer removeFromSuperlayer];
        [self.animationLayers removeObjectAtIndex:0];
        [self.view.layer removeAnimationForKey:@"BigShopCarAnimation"];
    }

}



@end
