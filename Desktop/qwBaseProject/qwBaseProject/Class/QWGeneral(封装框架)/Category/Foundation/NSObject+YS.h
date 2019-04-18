//
//  NSObject+YS.h
//  MToy
//
//  Created by Magic-Yu on 2017/10/21.
//  Copyright © 2017年 beyondin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (YS)


/**
 声明方法方便子类调用
 */
- (void)qw_config;


/**
 声明方法方便子类调用
 */
- (void)qw_getRemoteData;

/**
 声名方法方便单例调用
 */
- (void)ys_shareInstance;

/* 获取对象的所有属性和属性内容 */
- (NSDictionary *)ys_getAllPropertiesAndVaules;

/* 获取对象的所有属性 */
- (NSArray *)ys_getAllProperties;

/* 获取对象的所有方法 */
- (void)ys_getAllMethods;


@end
