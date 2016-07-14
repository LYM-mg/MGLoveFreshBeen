
#import <UIKit/UIKit.h>
#import "MJExtension.h"
#import "UIImageView+WebCache.h"
#import "UIButton+WebCache.h"

@interface BaseController : UIViewController<UIGestureRecognizerDelegate>

@property (nonatomic,strong) id  userInfo;
@property (nonatomic,strong) id  otherInfo;
@property (nonatomic,assign) int  page;

- (BaseController*)pushController:(Class)controller withInfo:(id)info;
- (BaseController*)pushController:(Class)controller withInfo:(id)info withTitle:(NSString*)title;
- (BaseController*)pushController:(Class)controller withInfo:(id)info withTitle:(NSString*)title withOther:(id)other;
- (BaseController*)pushController:(Class)controller withInfo:(id)info withTitle:(NSString*)title withOther:(id)other withModel:(BOOL)isModel;
-(void)setRightNavBtn:(NSString*)str withTarget:(SEL)sel;
@end
