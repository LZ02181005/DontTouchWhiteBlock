//
//  UINavigationController+YS.m
//  KYGF
//
//  Created by Magic-Yu on 2017/8/26.
//  Copyright © 2017年 beyondin. All rights reserved.
//

#import "UINavigationController+YS.h"

#import <objc/runtime.h>

@implementation UINavigationController (YS)

- (BOOL)ys_popToVC:(NSString *)className{
    
    // 倒序遍历
    [self.viewControllers enumerateObjectsWithOptions:NSEnumerationReverse usingBlock:^(UIViewController * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        if ([obj isKindOfClass:NSClassFromString(className)]) {
            
            [self popToViewController:obj animated:YES];
            
        }
        
    }];
    
    return NO;
}

- (void)ys_popTimes:(NSUInteger)times{
    
    
    if (times <= 0 || times > self.viewControllers.count - 1) {
        return;
    }
    
    UIViewController *vc = self.viewControllers[self.viewControllers.count - 1 - times];
    
    [self popToViewController:vc animated:YES];
    
    
}

- (void)ys_popWithoutViewController:(NSString *)viewController{
    
    [self ys_popWithoutViewControllers:@[viewController]];
    
}

- (void)ys_popWithoutViewControllers:(NSArray<NSString *> *)viewControllers{
    
    __block UIViewController *vc;
    [self.viewControllers enumerateObjectsWithOptions:NSEnumerationReverse usingBlock:^(__kindof UIViewController * _Nonnull viewController, NSUInteger idx, BOOL * _Nonnull stop) {
        vc = viewController;
        __block BOOL isContain = NO;
        if (vc != [self.viewControllers lastObject]) { // 排除当前视图
            
            [viewControllers enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                if ([viewController isKindOfClass:NSClassFromString(obj)]) {
                    isContain = YES;
                    *stop = YES;
                }
            }];
            
            if (!isContain) {
                *stop = YES;
            }
        }
    }];
    
    [self popToViewController:vc animated:YES];
    
    
}


- (void)deleteWithVCNames:(NSArray<NSString *> *)vcNames{
 
    NSMutableArray *tmp = [self.viewControllers mutableCopy];
    
    [tmp enumerateObjectsWithOptions:NSEnumerationReverse usingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        // 倒序删除
        [vcNames enumerateObjectsUsingBlock:^(NSString * _Nonnull name, NSUInteger idx, BOOL * _Nonnull stop) {
            
            if ([obj isKindOfClass:[NSClassFromString(name) class]]) {
                [tmp removeObject:obj];
            }
            
        }];
        
    }];
    
    self.viewControllers = [tmp copy];
    
}

+ (void)load{
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        // 交换方法
        Method originMethod = class_getClassMethod([self class], @selector(pushViewController:animated:));
        Method swizzleMethod = class_getClassMethod([self class], @selector(ys_pushViewController:animated:));
        method_exchangeImplementations(originMethod, swizzleMethod);
        
    });
    
}

- (void)ys_pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    // 关闭手势
    self.interactivePopGestureRecognizer.enabled = NO;
    
    [self ys_pushViewController:self animated:animated];
}





@end
