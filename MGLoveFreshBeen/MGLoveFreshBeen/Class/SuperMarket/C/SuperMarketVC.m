//
//  SuperMarketVC.m
//  MGLoveFreshBeen
//
//  Created by ming on 16/7/12.
//  Copyright © 2016年 ming. All rights reserved.
//

#import "SuperMarketVC.h"
#import "SuperMarketModel.h"
#import "ProductsCell.h"
#import "CategoryCell.h"
#import "SupermarketHeadView.h"

#import "ProductDetailVC.h"


@interface SuperMarketVC ()<UITableViewDataSource,UITableViewDelegate>

/** 商品TableView */
@property (weak, nonatomic) IBOutlet UITableView *productsTableView;
/** 分类TableView */
@property (weak, nonatomic) IBOutlet UITableView *categoryTableView;
/** 数据源 */
@property (nonatomic,strong) SuperMarket *superMarketData;
/** 商品数据源 */
@property (nonatomic,strong) NSMutableArray *goodsArr;

/** 记录左边TableView点击的位置 */
@property (nonatomic,strong) NSIndexPath *categortsSelectedIndexPath;


/** 记录右边边TableView是否滚动到某个头部 */
@property (nonatomic, assign) BOOL isScrollDown;
/** 记录右边边TableView是否滚动到的位置的Y坐标 */
@property (nonatomic, assign) CGFloat lastOffsetY;
/** 记录右边边TableView是否滚动到某个头部 */
@property (nonatomic,strong) NSIndexPath *productIndexPath;

@end

@implementation SuperMarketVC
#pragma mark - lazy

#pragma mark - 声明周期
- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = YES;
    
    // 1.初始化子控件
    [self setupTableView];
    
    // 2.加载数据
    [self loadSupermarketData];
    
    // 3.通知
    [self addNotication];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

- (void)setupTableView{
    self.categoryTableView.showsVerticalScrollIndicator = YES;
    self.categoryTableView.separatorInset = UIEdgeInsetsZero;
    if ([self.categoryTableView respondsToSelector:@selector(layoutMargins)]) {
        self.categoryTableView.layoutMargins = UIEdgeInsetsZero;
    }
    
//    CGPoint orgin = self.productsTableView.orgin ;
//    orgin.y = MGNavHeight;
//    self.productsTableView.orgin = orgin;
    
    [self.productsTableView registerClass:[SupermarketHeadView class] forHeaderFooterViewReuseIdentifier:@"MGKSupermarketHeadView"];
}

#pragma mark - 加载数据
- (void)loadSupermarketData {
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSString *path = [[NSBundle mainBundle] pathForResource:@"supermarket" ofType: nil];
        
        NSData *data = [NSData dataWithContentsOfFile:path];
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        NSString *str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        [str stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
        
        //////////////////////////// 分类 ///////////////////////////
        self.superMarketData = [SuperMarket objectWithKeyValues:dict];
        
        //////////////////////////// 商品 ///////////////////////////
        _goodsArr = [NSMutableArray array];
        
        ProductstModel *productsModel = self.superMarketData.data.products;
        for (CategoriesModel *cModel in self.superMarketData.data.categories) {
            NSArray *goodsArr = (NSArray *)[productsModel valueForKeyPath:[cModel valueForKey:@"id"]];
            [self.goodsArr addObject:goodsArr];
        }
        
        // 回到主线程
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.categoryTableView reloadData];
            // 默认选中第一个
            [self.categoryTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:YES scrollPosition:UITableViewScrollPositionMiddle];
            
            [self.productsTableView reloadData];
        });
    });
}


#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if (tableView == self.productsTableView) { // 右边tableView 👉➡️
        return self.superMarketData.data.categories.count;
    }else{  // 左边tableView 👈⬅️
        return 1;
    }
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView == self.categoryTableView) { // 左边tableView 👈⬅️
        return self.superMarketData.data.categories.count;
    }else{  // 右边tableView 👉➡️
        if (self.goodsArr.count > 0) {
            NSArray *arr = self.goodsArr[section];
            return arr.count;
        }
    }
    return 0;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == self.categoryTableView) { // 左边tableView 👈⬅️
        CategoryCell *cell = [CategoryCell categoryCellWithTableView:tableView];
        cell.categoryModel = self.superMarketData.data.categories[indexPath.row];
        return cell;
    }else { // 右边tableView 👉➡️
        ProductsCell *cell = [ProductsCell productsCellWithTableView:tableView];
      
        HotGoods *hotGood = self.goodsArr[indexPath.section][indexPath.row];
        cell.hotGood = hotGood;
        
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (tableView == self.productsTableView) { // 右边tableView 👉➡️
        return 25;
    }else{  // 左边tableView 👈⬅️
        return 0;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == self.categoryTableView) { // 左边tableView 👈⬅️
        return 45;
    }else{  // 右边tableView 👉➡️
        return 100;
    }
}

#pragma mark - UITableViewDelegate
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if ([tableView isEqual:self.productsTableView]) {
        SupermarketHeadView *headView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"MGKSupermarketHeadView"];
        headView.hidden = NO;
        CategoriesModel *categoryModel = self.superMarketData.data.categories[section];
        if (self.superMarketData.data.categories.count > 0 && [categoryModel valueForKey:@"name"] != nil ) {
            headView.titleLabel.text =  [categoryModel valueForKey:@"name"];
        }
        return headView;
    }
    
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == self.categoryTableView) { // 左边tableView 👈⬅️
        self.categortsSelectedIndexPath = indexPath;
        [MGNotificationCenter postNotificationName:MGCategortsSelectedIndexPathNotification object:nil];
    }else{ // 右边tableView 👉➡️  进入商品详情界面
        HotGoods *goods = goods = self.goodsArr[indexPath.section][indexPath.row];
        ProductDetailVC *productDetailVC = [[ProductDetailVC alloc] initWithGoods:goods];
        [self.navigationController pushViewController:productDetailVC animated:YES];
    }
}

#pragma mark - =============== 以下方法用来滚动 滚动  滚动 =================
#pragma mark - 用来滚动滚动滚动
// 头部即将消失
- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section{
    if (tableView == self.productsTableView && !_isScrollDown) { // 右边tableView 👉➡️
        _productIndexPath = [NSIndexPath indexPathForRow:section inSection:0];
        
        [MGNotificationCenter postNotificationName:MGWillDisplayHeaderViewNotification object:nil];
    }
}

// 头部完全消失
- (void)tableView:(UITableView *)tableView didEndDisplayingHeaderView:(nonnull UIView *)view forSection:(NSInteger)section{
    if (tableView == self.productsTableView && _isScrollDown) { // 右边tableView 👉➡️
            _productIndexPath = [NSIndexPath indexPathForRow:(section+1) inSection:0];
            [MGNotificationCenter postNotificationName:MGDidEndDisplayingHeaderViewNotification object:nil];
    }
}


#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (scrollView == self.productsTableView) { // 右边tableView 👉➡️
        self.isScrollDown = (_lastOffsetY < scrollView.contentOffset.y);
        _lastOffsetY = scrollView.contentOffset.y;
    }else{  // 左边tableView 👈⬅️
        return;
    }
}


#pragma mark - 通知
- (void)addNotication{
    __weak typeof(self) weakSelf = self;
    
    // 1.左边选中的通知
    [MGNotificationCenter addObserverForName:MGCategortsSelectedIndexPathNotification object:nil queue:nil usingBlock:^(NSNotification * _Nonnull note) {
        [weakSelf.productsTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:_categortsSelectedIndexPath.row] atScrollPosition:UITableViewScrollPositionNone animated:YES];
    }];
    
    // 2.HeaderView即将消失的通知
    [MGNotificationCenter addObserverForName:MGDidEndDisplayingHeaderViewNotification object:nil queue:nil usingBlock:^(NSNotification * _Nonnull note) {
        [weakSelf.categoryTableView selectRowAtIndexPath:_productIndexPath animated:YES scrollPosition:UITableViewScrollPositionMiddle];
        [weakSelf.categoryTableView scrollToRowAtIndexPath:_productIndexPath atScrollPosition:UITableViewScrollPositionNone animated:YES];
    }];
    
    // 3.HeaderView完全消失的通知
    [MGNotificationCenter addObserverForName:MGWillDisplayHeaderViewNotification object:nil queue:nil usingBlock:^(NSNotification * _Nonnull note) {
        [weakSelf.categoryTableView selectRowAtIndexPath:_productIndexPath animated:YES scrollPosition:UITableViewScrollPositionMiddle];
        [weakSelf.categoryTableView scrollToRowAtIndexPath:_productIndexPath atScrollPosition:UITableViewScrollPositionNone animated:YES];
        
    }];
}

- (void)dealloc{
    [MGNotificationCenter removeObserver:self];
    NSLog(@"%s",__func__);
}

@end


// 获取指定的目录
// NSUserDomainMask,默认手机开发的话，就填该参数
// YES是表示详细目录，如果填NO的话，那么前面的目录默认会用~表示，这个~在电脑可以识别，在手机里面是不能识别的，所以默认也用YES
//    NSString *path2 = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
//
//    // 拼接路径名称
////    NSString *filePath = [path2 stringByAppendingString:@"array.plist"];
//    NSString *filePath = [path2 stringByAppendingPathComponent:@"array.plist"];
//    // MGLog(@"%@",path2);
//    //把数组写入到文件
//    [dict writeToFile:filePath atomically:YES];
