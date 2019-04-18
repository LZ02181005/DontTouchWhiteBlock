//
//  HUDTools.m
//  PictureHouseKeeper
//
//  Created by  on 16/8/19.
//  Copyright © 2016年 zyyj. All rights reserved.
//

#import "HUDTools.h"
#import "MBProgressHUD+Padding.h"

@implementation HUDTools

+(instancetype)shareinstance{
    
    static HUDTools *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[HUDTools alloc] init];
    });
    
    return instance;
    
}
#pragma mark - HUD样式处理
+(void)show:(NSString *)msg inView:(UIView *)view mode:(YJProgressMode)myMode{
    if (!view) {
        view = [UIApplication sharedApplication].keyWindow;
    }
    //如果已有弹框，先消失
    if ([HUDTools shareinstance].hud != nil) {
        [[HUDTools shareinstance].hud hideAnimated:YES];
        [HUDTools shareinstance].hud = nil;
    }
    
    //4\4s屏幕避免键盘存在时遮挡
    if ([UIScreen mainScreen].bounds.size.height == 480) {
        [view endEditing:YES];
    }
    
    [HUDTools shareinstance].hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    //[HUDTools shareinstance].hud.dimBackground = YES;    //是否显示透明背景
    [HUDTools shareinstance].hud.bezelView.color = [UIColor blackColor];
    [[HUDTools shareinstance].hud setMargin:10];
    [[HUDTools shareinstance].hud setRemoveFromSuperViewOnHide:YES];
    [HUDTools shareinstance].hud.detailsLabel.text = msg;
    [HUDTools shareinstance].hud.contentColor = [UIColor whiteColor];
 
    //处理弹框大小
    [HUDTools shareinstance].hud.minSize = CGSizeMake(300, 150);
    [HUDTools shareinstance].hud.detailsLabel.font = [UIFont systemFontOfSize:14];
    [[HUDTools shareinstance].hud updatePaddingConstraints];
    switch ((NSInteger)myMode) {
        case YSProgressModeOnlyText:
            [HUDTools shareinstance].hud.mode = MBProgressHUDModeText;
            break;

        case YSProgressModeLoading:
            [HUDTools shareinstance].hud.mode = MBProgressHUDModeIndeterminate;
            break;

        case YSProgressModeCircleLoading:
            [HUDTools shareinstance].hud.mode = MBProgressHUDModeDeterminate;
            break;

        case YSProgressModeSuccess:
            [HUDTools shareinstance].hud.mode = MBProgressHUDModeCustomView;
            [HUDTools shareinstance].hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_right_white"]];
            break;
       
        case YSProgressModeError:
            [HUDTools shareinstance].hud.mode = MBProgressHUDModeCustomView;
            [HUDTools shareinstance].hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_close_white"]];
            break;
        default:
            break;
    }
}



+(void)hide{
    if ([HUDTools shareinstance].hud != nil) {
        [[HUDTools shareinstance].hud hideAnimated:YES];
    }
}


+(void)showMessage:(NSString *)msg inView:(UIView *)view{
    [self show:msg inView:view mode:YSProgressModeOnlyText];
    [[HUDTools shareinstance].hud hideAnimated:YES afterDelay:1.0];
}


+(void)showOnlyText:(NSString *)msg inView:(UIView *)view{
    [self show:msg inView:view mode:YSProgressModeOnlyText];
    [[HUDTools shareinstance].hud hideAnimated:YES afterDelay:1.0];

}

+(void)showMessage:(NSString *)msg inView:(UIView *)view afterDelayTime:(NSInteger)delay{
    [self show:msg inView:view mode:YSProgressModeOnlyText];
    [[HUDTools shareinstance].hud hideAnimated:YES afterDelay:delay];
}

+(void)showSuccess:(NSString *)msg inview:(UIView *)view{
    [self show:msg inView:view mode:YSProgressModeSuccess];
    [[HUDTools shareinstance].hud hideAnimated:YES afterDelay:1.0];
    
}

+(void)showError:(NSString *)msg inview:(UIView *)view{
    [self show:msg inView:view mode:YSProgressModeError];
    [[HUDTools shareinstance].hud hideAnimated:YES afterDelay:1.0];
    
}

+(void)showProgress:(NSString *)msg inView:(UIView *)view{
    [self show:msg inView:view mode:YSProgressModeLoading];
}



+(void)showMsgWithoutView:(NSString *)msg{
    UIWindow *view = [UIApplication sharedApplication].keyWindow;
    [self show:msg inView:view mode:YSProgressModeOnlyText];
    [[HUDTools shareinstance].hud hideAnimated:YES afterDelay:1.0];
    
}


+(void)showSuccessWithoutView:(NSString *)msg{
    UIWindow *view = [UIApplication sharedApplication].keyWindow;
    [self show:msg inView:view mode:YSProgressModeSuccess];
    [[HUDTools shareinstance].hud hideAnimated:YES afterDelay:1.0];
    
}

+(void)showErrorWithoutView:(NSString *)msg{
    UIWindow *view = [UIApplication sharedApplication].keyWindow;
    [self show:msg inView:view mode:YSProgressModeError];
    [[HUDTools shareinstance].hud hideAnimated:YES afterDelay:1.0];
    
}


@end
