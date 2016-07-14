
#import "BaseController.h"

@interface BaseController ()

@end

@implementation BaseController


- (void)viewDidLoad
{
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.page = 1;//默认为1
    
    // 添加点按手势
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onTap)];
    tap.delegate=self;
    [self.view addGestureRecognizer:tap];
    
}

- (void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated{

    [super viewWillDisappear:animated];
    [self.view endEditing:YES];
}


#pragma mark - Methods
- (BaseController*)pushController:(Class)controller withInfo:(id)info
{
    return [self pushController:controller withInfo:info withTitle:nil withOther:nil];
}
- (BaseController*)pushController:(Class)controller withInfo:(id)info withTitle:(NSString*)title
{
    return [self pushController:controller withInfo:info withTitle:title withOther:nil];
}
- (BaseController*)pushController:(Class)controller withInfo:(id)info withTitle:(NSString*)title withOther:(id)other
{
    return [self pushController:controller withInfo:info withTitle:title withOther:other withModel:NO];
}
- (BaseController*)pushController:(Class)controller withInfo:(id)info withTitle:(NSString*)title withOther:(id)other withModel:(BOOL)animation
{
//    MGLog(@"\n======\nUserInfo:%@\n=======\notherInfo %@\n=======\ncontroller:%@\n==\ntitle:%@\n===\n",info,other,controller,title);
    BaseController *base = [[controller alloc] init];
    if ([(NSObject*)base respondsToSelector:@selector(setUserInfo:)]) {
        base.userInfo = info;
        base.otherInfo = other;
        base.title = title;
        if (animation) {
            //base.isModel  = YES;
            CATransition *transition = [CATransition animation];
            transition.duration = 1.0f;
            transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
            transition.type = kCATransitionFade;
            transition.subtype = kCATransitionFromBottom;
            transition.delegate = self;
            [self.navigationController.view.layer addAnimation:transition forKey:nil];
        }
    }
    base.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:base animated:animation];
    return base;
}


-(void)setRightNavBtn:(NSString *)str withTarget:(SEL)selector
{
    //导航按钮
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithTitle:str style:UIBarButtonItemStylePlain target:self action:selector];
    rightItem.tintColor = [UIColor whiteColor];
    self.navigationItem.rightBarButtonItem = rightItem;
}

-(void)onTap{
    [self.view endEditing:YES];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




@end
