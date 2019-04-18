//
//  DGActivityIndicatorView+YS.h
//  MToy
//
//  Created by Magic-Yu on 2017/11/18.
//  Copyright © 2017年 beyondin. All rights reserved.
//

#import <DGActivityIndicatorView/DGActivityIndicatorView.h>

@interface DGActivityIndicatorView (YS)



/**
 基本构造方法

 @param view 父视图
 @param size 大小
 @param color 颜色
 @param type 类型
 @return 实例对象
 */
+ (instancetype)showInView:(UIView *)view size:(CGFloat)size color:(UIColor *)color type:(DGActivityIndicatorAnimationType)type;

/**
 基本构造方法

 @param view 父视图
 @param size 大小
 @param color 颜色
 @return 实例对象
 */
+ (instancetype)showInView:(UIView *)view size:(CGFloat)size color:(UIColor *)color;


/**
 简易构造方法(size = 50 color = 主题色)

 @param view 父视图
 */
+ (instancetype)showInView:(UIView *)view;


/**
 简易构造方法(size = 50 color = 主题色)

 @param content 容器 智能识别 V&C
 */
+ (instancetype)showInContent:(id)content;


/**
 隐藏

 @param content 容器
 */
+ (void)hideInContent:(id)content;


/**
 隐藏
 */
+ (void)hideInView:(UIView *)view;


+ (void)showInWindow;

+ (void)hideInWindow;


@end
