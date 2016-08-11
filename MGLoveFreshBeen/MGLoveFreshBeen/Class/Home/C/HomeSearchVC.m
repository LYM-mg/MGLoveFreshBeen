//
//  HomeSearchVC.m
//  MGLoveFreshBeen
//
//  Created by ming on 16/8/11.
//  Copyright © 2016年 ming. All rights reserved.
//

#import "HomeSearchVC.h"
#import "HotSearchView.h"


// 搜索ViewController
#define MGSearchViewControllerHistorySearchArray @"MGSearchViewControllerHistorySearchArray"

@interface HomeSearchVC ()<UIScrollViewDelegate,UISearchBarDelegate>
{
    UIScrollView *contentScrollView;
    UISearchBar *searchBar;
    UIButton *cleanHistoryBtn;
    
    HotSearchView *hotSearchView;
    HotSearchView *historySearchView;
}
@end

@implementation HomeSearchVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    // 0.创建ScrollView
    [self buildContentScrollView];
    
    // 1.创建searchBar
    [self buildSearchBar];
    
    // 2.创建清除搜索历史按钮
    [self buildCleanHistorySearchButton];
    
    // 3.创建热门搜索View  加载数据
    [self loadHotSearchButtonData];
    
    // 4.创建历史搜索View   加载数据
    [self loadHistorySearchButtonData];
    
    // 5.创建显示数据的界面 （tableView或者collectionView 是具体情况而定）
    
}


#pragma mark - 私有方法  创建UI
/**
 *  创建ScrollView
 */
- (void)buildContentScrollView {
    contentScrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    contentScrollView.backgroundColor = self.view.backgroundColor;
    contentScrollView.alwaysBounceVertical = YES;
    contentScrollView.delegate = self;
    [self.view addSubview:contentScrollView];;
}

/**
 *  创建搜索框
 */
- (void)buildSearchBar {
    searchBar = [[UISearchBar alloc] init];
    searchBar.frame = CGRectMake(0, 0, MGSCREEN_width * 0.85, 25);
    searchBar.placeholder = @"请输入商品名称";
    searchBar.barTintColor = [UIColor whiteColor];
    searchBar.keyboardType = UIKeyboardTypeDefault;
    
    /**
        UISearchBarStyleProminent,  // used my Mail, Messages and Contacts
        UISearchBarStyleMinimal
    */
    searchBar.searchBarStyle = UISearchBarStyleProminent;
    searchBar.barTintColor = [UIColor lightGrayColor];
    searchBar.tintColor = [UIColor grayColor];
    searchBar.prompt = @"你可以这么搜";
    
//    for (UIView *subsView in searchBar.subviews) {
//        NSLog(@"%@",subsView);
//        for (UIView *subView in subsView.subviews)
//        {
//            if ([subView isKindOfClass: [NSClassFromString(@"UISearchBarTextField") class]]) {
//                subView.height = 45;
//                subView.width = MGSCREEN_width * 0.85;
//                subView.layer.masksToBounds = YES;
//                subView.layer.cornerRadius = 6;
//                subView.layer.borderWidth = 1.5;
//                subView.layer.borderColor = MGRGBColor(100, 100, 100).CGColor;
//            }
//        }
//    }
    searchBar.delegate = self;
    self.navigationItem.titleView = searchBar;
    [self.navigationController.navigationBar setBarTintColor:[UIColor orangeColor]];
}

/**
 *  创建清空搜索历史按钮
 */
- (void)buildCleanHistorySearchButton {
    cleanHistoryBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [cleanHistoryBtn setTitle:@"清空🔍历史" forState: UIControlStateNormal];
    [cleanHistoryBtn setTitleColor:[UIColor redColor] forState: UIControlStateNormal];
    cleanHistoryBtn.titleLabel.font = MGFont(14);
    cleanHistoryBtn.backgroundColor = self.view.backgroundColor;
    cleanHistoryBtn.layer.cornerRadius = 5;
    cleanHistoryBtn.layer.borderColor = MGRGBColor(200, 200, 200).CGColor;
    cleanHistoryBtn.layer.borderWidth = 0.5;
    cleanHistoryBtn.hidden = YES;
    [cleanHistoryBtn addTarget:self action:@selector(cleanSearchHistorySearch) forControlEvents:UIControlEventTouchUpInside];
    [contentScrollView addSubview:cleanHistoryBtn];
}

/**
 *  热门搜索View ➕ 数据
 */
- (void)loadHotSearchButtonData{
     __weak typeof(self) weakSelf = self;
   
    NSString *pathStr = [[NSBundle mainBundle] pathForResource:@"SearchProduct" ofType:nil];
    NSData *data = [NSData dataWithContentsOfFile:pathStr];
    if (data != nil) {
        NSDictionary *dict=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        NSArray *hotSearchArr = [NSArray array];
        hotSearchArr = [[dict objectForKey:@"data"] objectForKey:@"hotquery"];

        if (hotSearchArr.count > 0) {
            hotSearchView = [[HotSearchView alloc] initWithFrame:CGRectMake(MGMargin, MGMargin, self.view.width - 20, 100) searchTitleText:@"热门搜索" searchButtonTitleTexts:hotSearchArr searchButton:^(UIButton *btn) {
                NSString *str = [btn titleForState:UIControlStateNormal];
                searchBar.text = str;
                [weakSelf writeHistorySearchToUserDefault:str];
                [weakSelf loadProductsWithKeyword:str];
            }];
            
            hotSearchView.height = hotSearchView.searchHeight;
            hotSearchView.backgroundColor = [UIColor orangeColor];
            [contentScrollView addSubview:hotSearchView];
        }
    }
}

/**
 *  历史搜索View ➕ 数据
 */
- (void)loadHistorySearchButtonData {
    __weak typeof(self) weakSelf = self;

    // 移除之前创建historySearchView
    if (historySearchView != nil) {
        [historySearchView removeFromSuperview];
        historySearchView = nil;
    }
    
    NSArray *historySearchArr = [[NSUserDefaults standardUserDefaults] objectForKey:MGSearchViewControllerHistorySearchArray];
    if (historySearchArr.count > 0) {
        historySearchView = [[HotSearchView alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(hotSearchView.frame) + 20, self.view.width - 20, 0) searchTitleText:@"历史记录" searchButtonTitleTexts:historySearchArr searchButton:^(UIButton *btn) {
            NSString *str = [btn titleForState:UIControlStateNormal];
            searchBar.text = str;
            [weakSelf loadProductsWithKeyword:str];
        }];
        historySearchView.height = historySearchView.searchHeight;
        historySearchView.backgroundColor = [UIColor cyanColor];
        [contentScrollView addSubview:historySearchView];
        [self updateCleanHistoryButton:NO];
    }
}

/**
 *  更新清除历史按钮位置和隐藏状态
 */
- (void)updateCleanHistoryButton:(BOOL)hidden {
    if (historySearchView != nil) {
        cleanHistoryBtn.frame = CGRectMake(0.1 * MGSCREEN_width, CGRectGetMaxY(historySearchView.frame) + 20, MGSCREEN_width * 0.8, 40);
    }
    cleanHistoryBtn.hidden = hidden;
}

#pragma mark - Action 操作
/**
 *  清除历史搜索
 */
- (void)cleanSearchHistorySearch{
    NSArray *historySearch = [[NSUserDefaults standardUserDefaults] objectForKey:MGSearchViewControllerHistorySearchArray];
    NSMutableArray *historyArr;
    if (historyArr == nil) {
        historyArr = [NSMutableArray arrayWithArray:historySearch];
    }

    [historyArr removeAllObjects];
    [[NSUserDefaults standardUserDefaults] setObject:historyArr forKey: MGSearchViewControllerHistorySearchArray];
    [self loadHistorySearchButtonData];
    [self updateCleanHistoryButton:YES];
}

/**
 *  写入搜索历史数组 并保存到本地
 */
- (void)writeHistorySearchToUserDefault:(NSString *)str {
    NSArray *historySearch = (NSMutableArray *)[[NSUserDefaults standardUserDefaults] objectForKey:MGSearchViewControllerHistorySearchArray];
    
    NSMutableArray *historyArr;
    if (historyArr == nil) {
        historyArr = [NSMutableArray arrayWithArray:historySearch];
    }
    for (NSString *text in historyArr) {
        if ([text isEqualToString:str]) {
            return;
        }
    }
    
    [historyArr insertObject:str atIndex:0];
    [[NSUserDefaults standardUserDefaults] setValue:historyArr forKey:MGSearchViewControllerHistorySearchArray];
    [self loadHistorySearchButtonData];
}


/**
 *  加载数据
 */
- (void)loadProductsWithKeyword:(NSString *)keyWord {
    if (keyWord == nil || keyWord.length == 0) {
        return;
    }
    
    /**
     *  模拟加载数据
     */
    UIImageView *backImageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
    backImageView.image = [UIImage imageNamed:@"guide_35_4"];
    [self.view addSubview:backImageView];
    contentScrollView.hidden = YES;
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [UIView animateWithDuration:1.0 animations:^{
            backImageView.alpha = 0.0;
            backImageView.transform = CGAffineTransformMakeScale(1.3, 1.3);
            contentScrollView.hidden = NO;
        } completion:^(BOOL finished) {
            [backImageView removeFromSuperview];
        }];
    });
}


#pragma mark - <UISearchBarDelegate>
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar4{
    // 1。写入搜索历史
    [self writeHistorySearchToUserDefault:searchBar4.text];
    
    // 2.根据关键字去搜索
    [self loadProductsWithKeyword:searchBar4.text];

}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    if (searchText.length == 0) {
//        searchCollectionView.hidden = YES;
//        yellowShopCar.hidden = YES;
    }
}

#pragma mark - <UIScrollViewDelegate>
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [searchBar endEditing:NO];
}

@end
