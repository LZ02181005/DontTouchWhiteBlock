//
//  YSAppMacro.h
//  KYGF
//
//  Created by Magic-Yu on 2017/8/26.
//  Copyright © 2017年 beyondin. All rights reserved.
//

#ifndef YSAppMacro_h
#define YSAppMacro_h


// iPX
#define kIS_X [UIScreen mainScreen].bounds.size.height == 812
#define kNAV_HEIGHT (kIS_X? 86 : 64)
#define kX(n) (kIS_X? (n + 22) : n)

// iOS开发通用宏
#define kIMAGE_NAME(x) [UIImage imageNamed:x]
#define kINT2STR(n) [NSString stringWithFormat:@"%ld", n]


// Hud
#define kSHOW_HUD [MBProgressHUD showActivityMessageInWindow:nil];
#define kSHOW_HUD_TEXT(TEXT) [MBProgressHUD showActivityMessageInWindow:TEXT];
#define kSHOW_TIP(MESSAGE) [MBProgressHUD showTipMessageInWindow:MESSAGE timer:2];
#define kSHOW_ERROR(error) kSHOW_TIP(error.userInfo[@"NSLocalizedDescription"]);
#define kHIDE_HUD [MBProgressHUD hideHUD];

#define kSHOW_ACT_IN_VIEW(v) [DGActivityIndicatorView showInContent:v];
#define kHIDE_ACT_IN_VIEW(v) [DGActivityIndicatorView hideInContent:v];
#define kSHOW_ACT_IN_SELF [DGActivityIndicatorView showInContent:self];
#define kHIDE_ACT_IN_SELF [DGActivityIndicatorView hideInContent:self];
#define kSHOW_ACT_IN_WINDOW [DGActivityIndicatorView showInWindow];
#define kHIDE_ACT_IN_WINDOW [DGActivityIndicatorView hideInWindow];

#define kSHOW_SMALLACT_IN_VIEW(v) [DGActivityIndicatorView showInView:v size:40 color:kAPP_MAIN_COLOR type:DGActivityIndicatorAnimationTypeThreeDots];





// xib && nib
#define kNIB(x) [x ys_createViewFromNib]
#define kXIB(x) [x ys_createViewFromXib]


// 如果数据为NULL，设为nil
#define kPASS_NULL_TO_NIL(instance) (([instance isKindOfClass:[NSNull class]]) ? nil : instance)

// 处理nil，为空字符串@""
#define kSTRING_NIL_NULL(x) if(x == nil || [x isKindOfClass:[NSNull class]]){x = @"";}

#define kARRAY_NIL_NULL(x) \
if(x == nil || [x isKindOfClass:[NSNull class] ]) \
{x = @[];}

#define kDICTIONARY_NIL_NULL(x) \
if(x == nil || [x isKindOfClass:[NSNull class] ]) \
{x = @{};}

#define kSHOW_ERROR_MSG [MBProgressHUD showTipMessageInWindow:resultData[@"error_msg"]];

#define kWEAK_SELF  __weak typeof(self) weakSelf = self;

// 屏幕尺寸
#define kSCALE kSCREEN_WIDTH / 375.0
#define kSCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define kSCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
#define kS_W [UIScreen mainScreen].bounds.size.width
#define kS_H [UIScreen mainScreen].bounds.size.height
// 字体
#define kNORMAL_FONT(F)     [UIFont systemFontOfSize:(F)]
#define kBOLD_FONT(F)       [UIFont boldSystemFontOfSize:(F)]


// NSString
#define kINTEGER_TO_STR(x) [NSString stringWithFormat:@"%ld", x]

// 通知
/** 极光推送*/

#define kActiveApplePushNotificaiton @"kActiveApplePushNotificaiton"

// 点击消息后台进入前台
#define kInActiveApplePushNotificaiton  @"kInActiveApplePushNotificaiton"



// __weak
#define kWEAK(obj) __weak typeof(obj) weak = obj;

// keyboard hide
#define kENDEDIT [[UIApplication sharedApplication].keyWindow endEditing:YES];

// present & push & pop
#define kPRESENT(vc) [[Singleton shareInstance].currentVC presentViewController:vc animated:YES completion:nil];
#define kPUSH(vc) [self.navigationController pushViewController:vc animated:YES];
#define kPOP [self.navigationController popViewControllerAnimated:YES];

#define kCHECK_LOGIN \
if (![UserDefaultsUtil getUserDefaultName].length) { \
kPRESENT([YSLoginViewController new]); \
return; \
} \

#define kPOSTNOTI(NOTI) [[NSNotificationCenter defaultCenter] postNotificationName:NOTI object:nil];

// 单例
#define kSINGLWTON_H + (instancetype)shareInstance;\
\
- (instancetype)init __attribute__((unavailable("Disabled. Use +sharedInstance instead")));\
\
+ (instancetype)new __attribute__((unavailable("Disabled. Use +sharedInstance instead")));\
\
- (instancetype)copy __attribute__((unavailable("Disabled. Use +sharedInstance instead")));\

#define kSINGLWTON_M \
\
static id _instance;\
\
+ (instancetype)shareInstance\
{\
\
static dispatch_once_t onceToken;\
dispatch_once(&onceToken, ^{\
_instance = [[self alloc] init];\
[_instance ys_shareInstance];\
});\
\
return _instance;\
}\

#endif /* YSAppMacro_h */
