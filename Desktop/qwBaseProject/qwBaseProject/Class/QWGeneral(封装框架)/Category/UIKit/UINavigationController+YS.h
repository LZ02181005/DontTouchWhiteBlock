//
//  UINavigationController+YS.h
//  KYGF
//
//  Created by Magic-Yu on 2017/8/26.
//  Copyright © 2017年 beyondin. All rights reserved.
//

#import <UIKit/UIKit.h>



@interface UINavigationController (YS)



/**
 跳转至指定(类型)控制器

 @param className 类型名字
 */
- (BOOL)ys_popToVC:(NSString *)className;


/**
 跳转忽略类型

 @param viewControllers 类型字符串数组
 */
- (void)ys_popWithoutViewControllers:(NSArray<NSString *> *)viewControllers;


/**
 跳转忽略类型

 @param viewController 类型字符串
 */
- (void)ys_popWithoutViewController:(NSString *)viewController;


/**
 连续pop多次

 @param times pop次数(1和pop相同, 2位pop2次...)
 */
- (void)ys_popTimes:(NSUInteger)times;


/**
 删除指定控制器

 @param vcNames 控制器名
 */
- (void)deleteWithVCNames:(NSArray<NSString *> *)vcNames;


@end
