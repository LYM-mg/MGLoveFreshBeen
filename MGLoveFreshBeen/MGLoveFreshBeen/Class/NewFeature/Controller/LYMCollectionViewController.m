//
//  LYMCollectionViewController.m
//  MGLoveFreshBeen
//
//  Created by ming on 16/07/18.
//  Copyright (c) 2016年 ming. All rights reserved.
//

#import "LYMCollectionViewController.h"
#import "LYMCollectionViewCell.h"


@interface LYMCollectionViewController ()
/** 保存偏移量 */
@property (nonatomic, assign) CGFloat lastOffsetX;

@property (nonatomic,weak) UIImageView *guideImage;
//@property (nonatomic,weak) UIImageView *guideLineImage;
@property (nonatomic,weak) UIImageView *largeText;
@property (nonatomic,weak) UIImageView *smallText;

@end

@implementation LYMCollectionViewController

/// 创建LYMCollectionViewController
- (instancetype)init{
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
 
    // 初始化UICollectionViewFlowLayout
    [self setUpCollectionViewLayout:flowLayout];
    
    return [self initWithCollectionViewLayout:flowLayout];
}

/// 初始化UICollectionViewFlowLayout
- (void)setUpCollectionViewLayout:(UICollectionViewFlowLayout *)flowLayout{
    // 1.设置每一个item的大小
    flowLayout.itemSize = [UIScreen mainScreen].bounds.size;
    
    // 2.设置每一行的间距
     flowLayout.minimumLineSpacing = 0;
    
    // 3.设置每一列的间距
    flowLayout.minimumInteritemSpacing = 0;
    
    // 4.设置每一组的间距
    //    flowLayout.sectionInset = UIEdgeInsetsMake(100, 0, 0, 0);
    
    // 5.设置滚动方向  （此处是水平滚动）
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;

}


- (void)viewDidLoad {
    [super viewDidLoad];
    // 1.初始化lastOffsetX
    self.lastOffsetX = 0;
    
    // 2.初始化collectionView
    [self setUpcollectionView];
    
    // 3.给collectionView添加子控件
    [self setUpChildView];
}

/// 给collectionView添加子控件
- (void)setUpChildView{
    // 1.添加Guide大图
    UIImageView *guideimage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"guide1"]];
    guideimage.centerX = self.collectionView.centerX;
    _guideImage = guideimage;
    [self.collectionView addSubview:guideimage];
    
    // 2.添加Guide引导线
    UIImageView *guideLineImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"guideLine"]];
    guideLineImage.x -= 175;
    [self.collectionView addSubview:guideLineImage];
    
    // 3/添加大图
    UIImageView *largeText = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"guideLargeText1"]];
    largeText.centerX = self.collectionView.centerX;
    largeText.centerY = self.collectionView.frame.size.height*0.7;
    _largeText = largeText;
    [self.collectionView addSubview:largeText];
    
    // 4.添加小图
    UIImageView *smallText = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"guideSmallText1"]];
    smallText.centerX = self.collectionView.centerX;
    smallText.centerY = self.collectionView.frame.size.height*0.80;
    _smallText = smallText;
    [self.collectionView addSubview:smallText];
}

static NSString * ID = @"Cell";
/// 初始化collectionView
- (void)setUpcollectionView{
    
    // 0.注册  必须要注册。还要自定义cell
    [self.collectionView registerClass:[LYMCollectionViewCell class] forCellWithReuseIdentifier:ID];
    
    // 1.设置背景颜色
    self.collectionView.backgroundColor = [UIColor whiteColor];
    
    // 2.不要弹簧效果
    self.collectionView.bounces = NO;
    
    // 3.取消水平滚动条
    self.collectionView.showsHorizontalScrollIndicator = NO;
    
    // 4.开启分页显示
    self.collectionView.pagingEnabled = YES;

}

#pragma mark <UICollectionViewDataSource>
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 4;
}

- (LYMCollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    
    LYMCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
    
    NSString *imageName = [NSString stringWithFormat:@"guide%ldBackground",indexPath.item+1];
    
    cell.image = [UIImage imageNamed:imageName];
    
    [cell setIndexPath:indexPath withCount:4];
    
    return cell;
}

#pragma mark <UICollectionViewDelegate>
/**
 *   计算滚动范围 切换图片
 */
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    // 1.获取当前的偏移量
    CGFloat currentOffsetX = scrollView.contentOffset.x;
    
    // 2.计算偏移差
    CGFloat delta = currentOffsetX - _lastOffsetX;
    
    _guideImage.x += 2 * delta;
    _largeText.x += 2 * delta;
    _smallText.x += 2 * delta;
    
    [UIView animateWithDuration:0.25 animations:^{
        _guideImage.x -= delta;
        _largeText.x -= delta;
        _smallText.x -= delta;
    }];
    _lastOffsetX = currentOffsetX;
    
    // 3.滚动切换图片
    NSInteger page = currentOffsetX/self.view.width + 1;
    
    NSString *guideImageName = [NSString stringWithFormat:@"guide%ld",page];
    NSString *largeTextImage = [NSString stringWithFormat:@"guideLargeText%ld",page];

    NSString *smallTextImage = [NSString stringWithFormat:@"guideSmallText%ld",page];
    
    _guideImage.image = [UIImage imageNamed:guideImageName];
    _largeText.image = [UIImage imageNamed:largeTextImage];
    _smallText.image = [UIImage imageNamed:smallTextImage];
}

@end
