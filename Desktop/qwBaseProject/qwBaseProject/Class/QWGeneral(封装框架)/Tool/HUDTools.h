//
//  HUDTools.h
//  PictureHouseKeeper
//
//  Created by 李亚军 on 16/8/19.
//  Copyright © 2016年 zyyj. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MBProgressHUD/MBProgressHUD.h>

typedef NS_ENUM(NSInteger,YJProgressMode){
    YSProgressModeOnlyText,           //文字
    YSProgressModeLoading,              //加载菊花
    YSProgressModeCircleLoading,         //加载圆形
    YSProgressModeSuccess,             //成功
    YSProgressModeError = 10
};

@interface HUDTools : NSObject

/*===============================   属性   ================================================*/

@property (nonatomic,strong) MBProgressHUD  *hud;


/*===============================   方法   ================================================*/

+(instancetype)shareinstance;

//显示
+(void)show:(NSString *)msg inView:(UIView *)view mode:(YJProgressMode )myMode;

//隐藏
+(void)hide;

//只显示文字
+(void)showOnlyText:(NSString *)msg inView:(UIView *)view;

//显示进度菊花
+(void)showProgress:(NSString *)msg inView:(UIView *)view;

//显示成功提示
+(void)showSuccess:(NSString *)msg inview:(UIView *)view;

//显示错误提示
+(void)showError:(NSString *)msg inview:(UIView *)view;

//显示提示（1秒后消失）
+(void)showMessage:(NSString *)msg inView:(UIView *)view;

//显示提示（N秒后消失）
+(void)showMessage:(NSString *)msg inView:(UIView *)view afterDelayTime:(NSInteger)delay;

//在最上层显示window
+(void)showMsgWithoutView:(NSString *)msg;
+(void)showErrorWithoutView:(NSString *)msg;
+(void)showSuccessWithoutView:(NSString *)msg;
@end
