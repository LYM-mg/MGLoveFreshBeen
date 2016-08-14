//
//  AppDelegate.m
//  MGLoveFreshBeen
//
//  Created by ming on 16/7/12.
//  Copyright © 2016年 ming. All rights reserved.
//

#import "AppDelegate.h"
#import "TabBarVC.h"
#import "LYMGuideTool.h"

#import "UMSocial.h"
#import "UMSocialWechatHandler.h"
#import "UMSocialQQHandler.h"
#import "UMSocialSinaSSOHandler.h"

#import "SuperMarketVC.h"

@interface AppDelegate ()<UMSocialUIDelegate>

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // 3DTouch
    [self setup3DTouch:application];
    
    // 短信验证，appKey和appSecret从后台申请得
    [SMSSDK registerApp:@"1611c80d9edc0"
             withSecret:@"ed8256cf1d354ca20772486ee2f2016b"];
    
    // 友盟分享
    [self setupUMSocial];
    
    // 设置根控制器
    self.window = [[UIWindow alloc]  initWithFrame:[UIScreen mainScreen].bounds];
    
    self.window.rootViewController = [LYMGuideTool chooseRootViewController];
    
    [self.window makeKeyAndVisible];
    
    return YES;
}

#pragma mark - 3DTouch
- (void)setup3DTouch:(UIApplication *)application{
    if (ISIOS9) {
        // 创建标签的ICON图标。
        UIApplicationShortcutIcon *firstItemIcon = [UIApplicationShortcutIcon iconWithType:UIApplicationShortcutIconTypeAdd];
        // 创建一个标签，并配置相关属性。
        UIMutableApplicationShortcutItem *firstItem = [[UIMutableApplicationShortcutItem alloc]initWithType:@"First" localizedTitle:@"添加" localizedSubtitle:nil icon:firstItemIcon userInfo:nil];
        UIApplicationShortcutIcon *secondItemIcon = [UIApplicationShortcutIcon iconWithType:UIApplicationShortcutIconTypeShare];
        UIMutableApplicationShortcutItem *secondItem = [[UIMutableApplicationShortcutItem alloc]initWithType:@"Second" localizedTitle:@"分享" localizedSubtitle:nil icon:secondItemIcon userInfo:nil];
        
        // 自定义创建标签的ICON图标。
        UIApplicationShortcutIcon *thirdItemIcon = [UIApplicationShortcutIcon iconWithTemplateImageName:@""];
        UIMutableApplicationShortcutItem *thirdItem = [[UIMutableApplicationShortcutItem alloc]initWithType:@"Third" localizedTitle:@"自定义" localizedSubtitle:nil icon:thirdItemIcon userInfo:nil];
        application.shortcutItems = @[firstItem,secondItem,thirdItem];
    }
}

- (void)application:(UIApplication *)application performActionForShortcutItem:(nonnull UIApplicationShortcutItem *)shortcutItem completionHandler:(nonnull void (^)(BOOL))completionHandler{
    if ([shortcutItem.type isEqual:@"add"])
    { MGPS(@"执行添加事件"); }
    else if([shortcutItem.type isEqual:@"share"])
    { MGPS(@"执行分享的操作 ");}
}

#pragma mark - 友盟分享
- (void)setupUMSocial{
    //设置友盟社会化组件appkey
    [UMSocialData setAppKey:MGUmengAppkey];
    
    //打开调试log的开关
    [UMSocialData openLog:NO];
    
    //如果你要支持不同的屏幕方向，需要这样设置，否则在iPhone只支持一个竖屏方向
    [UMSocialConfig setSupportedInterfaceOrientations:UIInterfaceOrientationMaskAll];
    
    //设置微信AppId，设置分享url，默认使用友盟的网址
    [UMSocialWechatHandler setWXAppId:@"wxceb8ec0a6d9dc22a" appSecret:@"a393c1527aaccb95f3a4c88d6d1455f6" url:@"http://www.umeng.com/social"];
    
    // 打开新浪微博的SSO开关
    // 将在新浪微博注册的应用appkey、redirectURL替换下面参数，并在info.plist的URL Scheme中相应添加wb+appkey，如"wb3921700954"，详情请参考官方文档。
    [UMSocialSinaSSOHandler openNewSinaSSOWithAppKey:@"3741778105"
                                              secret:@"f1a443691c88263068c4a33eb37fde1b"
                                         RedirectURL:@"https://github.com/LYM-mg"];

    //    //设置分享到QQ空间的应用Id，和分享url 链接
    [UMSocialQQHandler setQQWithAppId:@"100424468" appKey:@"c7394704798a158208a74ab60104f0ba" url:@"http://www.umeng.com/social"];
    //    //设置支持没有客户端情况下使用SSO授权
    [UMSocialQQHandler setSupportWebView:YES];
    
}

/**
 这里处理新浪微博SSO授权之后跳转回来，和微信分享完成之后跳转回来
 */
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    return  [UMSocialSnsService handleOpenURL:url wxApiDelegate:nil];
}

/**
 这里处理新浪微博SSO授权进入新浪微博客户端后进入后台，再返回原来应用
 */
- (void)applicationDidBecomeActive:(UIApplication *)application {
    [UMSocialSnsService applicationDidBecomeActive];
}

/**
 各个页面执行授权完成、分享完成、或者评论完成时的回调函数
 
 @param response 返回`UMSocialResponseEntity`对象，`UMSocialResponseEntity`里面的viewControllerType属性可以获得页面类型
 */
-(void)didFinishGetUMSocialDataInViewController:(UMSocialResponseEntity *)response{
    // 其他平台 UMShareToTencent,UMShareToRenren,UMShareToDouban,
    NSArray *arr = [NSArray arrayWithObjects:UMShareToSina,UMShareToTencent,UMShareToQQ,UMShareToQzone,UMShareToWechatSession,UMShareToWechatTimeline,UMShareToWechatFavorite, nil];
    
    //这里你可以把分享平台UMShareToSina换成其他平台
    [[UMSocialDataService defaultDataService] postSNSWithTypes:arr content:@"ming" image:nil location:nil urlResource:nil presentedController:self.window.rootViewController completion:^(UMSocialResponseEntity *response) {
        if (response.responseCode == UMSResponseCodeSuccess) {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"成功" message:@"分享成功" delegate:nil cancelButtonTitle:@"好" otherButtonTitles: nil];
            [alertView show];
        } else {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"抱歉" message:@"分享失败" delegate:nil cancelButtonTitle:@"好" otherButtonTitles: nil];
            [alertView show];
        }
    }];
}

- (void)applicationWillResignActive:(UIApplication *)application {
   
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    
}


- (void)applicationWillTerminate:(UIApplication *)application {
  
    [self saveContext];
}

#pragma mark - Core Data stack

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

- (NSURL *)applicationDocumentsDirectory {
    
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

- (NSManagedObjectModel *)managedObjectModel {
    
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"MGLoveFreshBeen" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    // The persistent store coordinator for the application. This implementation creates and returns a coordinator, having added the store for the application to it.
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    // Create the coordinator and store
    
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"MGLoveFreshBeen.sqlite"];
    NSError *error = nil;
    NSString *failureReason = @"There was an error creating or loading the application's saved data.";
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        // Report any error we got.
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        dict[NSLocalizedDescriptionKey] = @"Failed to initialize the application's saved data";
        dict[NSLocalizedFailureReasonErrorKey] = failureReason;
        dict[NSUnderlyingErrorKey] = error;
        error = [NSError errorWithDomain:@"YOUR_ERROR_DOMAIN" code:9999 userInfo:dict];
        // Replace this with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return _persistentStoreCoordinator;
}


- (NSManagedObjectContext *)managedObjectContext {
    // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.)
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (!coordinator) {
        return nil;
    }
    _managedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
    [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    return _managedObjectContext;
}

#pragma mark - Core Data Saving support

- (void)saveContext {
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        NSError *error = nil;
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}

@end
