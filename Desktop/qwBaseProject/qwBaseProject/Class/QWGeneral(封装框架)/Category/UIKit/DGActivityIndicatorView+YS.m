//
//  DGActivityIndicatorView+YS.m
//  MToy
//
//  Created by Magic-Yu on 2017/11/18.
//  Copyright © 2017年 beyondin. All rights reserved.
//

#import "DGActivityIndicatorView+YS.h"

@implementation DGActivityIndicatorView (YS)



+ (instancetype)showInView:(UIView *)view size:(CGFloat)size color:(UIColor *)color type:(DGActivityIndicatorAnimationType)type{
    
    kENDEDIT
    
    // 加载动画
    DGActivityIndicatorView *activityIndicatorView = [[DGActivityIndicatorView alloc] initWithType:type tintColor:color size:size];
    [view addSubview:activityIndicatorView];
    [activityIndicatorView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(size, size));
    }];
    [activityIndicatorView startAnimating];
    
    
    return activityIndicatorView;
}

+ (instancetype)showInView:(UIView *)view size:(CGFloat)size color:(UIColor *)color{
    return [DGActivityIndicatorView showInView:view size:size color:color type:DGActivityIndicatorAnimationTypeLineScale];
}

+ (instancetype)showInView:(UIView *)view{
    return [DGActivityIndicatorView showInView:view size:50 color:kAPP_MAIN_COLOR];
}

+ (instancetype)showInContent:(id)content{
    
    if ([content isKindOfClass:[UIViewController class]]) {
        UIViewController *vc = content;
        return [DGActivityIndicatorView showInView:vc.view size:50 color:kAPP_MAIN_COLOR];
    }else if ([content isKindOfClass:[UIView class]]){
        UIView *view = content;
        return [DGActivityIndicatorView showInView:view size:50 color:kAPP_MAIN_COLOR];
    }else{
        return nil;
    }
    
}

+ (void)hideInContent:(id)content{
    if ([content isKindOfClass:[UIViewController class]]) {
        UIViewController *vc = content;
        [DGActivityIndicatorView hideInView:vc.view];
    }else if ([content isKindOfClass:[UIView class]]){
        UIView *view = content;
        [DGActivityIndicatorView hideInView:view];
    }
}

+ (void)hideInView:(UIView *)view{
    [view.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:[DGActivityIndicatorView class]]) {
            DGActivityIndicatorView *v = obj;
            [v stopAnimating];
            [v removeFromSuperview];
            v = nil;
            *stop = YES;
        }
    }];
}


+ (void)showInWindow{
    
    UIApplication *app = [UIApplication sharedApplication];
    //开启－忽略用户的操作事件
    [app beginIgnoringInteractionEvents];
    
    [DGActivityIndicatorView showInView:[UIApplication sharedApplication].keyWindow];
   

}

+ (void)hideInWindow{
    
    UIApplication *app = [UIApplication sharedApplication];
    //关闭－忽略用户的操作事件
    [app endIgnoringInteractionEvents];
    
    [DGActivityIndicatorView hideInView:[UIApplication sharedApplication].keyWindow];
    
   
}

@end
