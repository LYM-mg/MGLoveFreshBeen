
#import <UIKit/UIKit.h>
#import "HttpTool.h"
#import "NSString+Helper.h"
#import "MJExtension.h"
#import <ShareSDK/ShareSDK.h>
#import "TimeFormatTools.h"
#import "UIImageView+WebCache.h"
#import "UIButton+WebCache.h"
#import "GuideView.h"
#import "ShareView.h"
@interface BaseController : UIViewController<UIGestureRecognizerDelegate,ShareViewDelegate>

@property (nonatomic,strong) id  userInfo;
@property (nonatomic,strong) id  otherInfo;
@property (nonatomic,assign) int  page;
@property (nonatomic,retain) GuideView *guideView;
@property (nonatomic,retain) ShareView *shareView;
- (BaseController*)pushController:(Class)controller withInfo:(id)info;
- (BaseController*)pushController:(Class)controller withInfo:(id)info withTitle:(NSString*)title;
- (BaseController*)pushController:(Class)controller withInfo:(id)info withTitle:(NSString*)title withOther:(id)other;
- (BaseController*)pushController:(Class)controller withInfo:(id)info withTitle:(NSString*)title withOther:(id)other withModel:(BOOL)isModel;
-(void)setRightNavBtn:(NSString*)str withTarget:(SEL)sel;
- (void)showGuideView;
@end
