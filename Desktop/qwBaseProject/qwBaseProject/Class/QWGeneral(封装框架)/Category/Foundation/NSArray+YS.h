//
//  NSArray+YS.h
//  SY
//
//  Created by Magic-Yu on 2017/12/6.
//  Copyright © 2017年 Magic-Yu. All rights reserved.
//



@interface NSArray (YS)


/**
 将数组里面元素的某个属性提取出来组成一个新数组

 @param key 元素名
 @return 实例对象
 */
- (NSArray *)ys_sortWithKey:(NSString *)key;


/**
 不可变数组添加元素

 @param array 要添加的数组
 */
- (NSArray *)ys_addObjectsFromArray:(NSArray *)array;


/**
 数组筛选

 @param filterBlock 筛选block
 @return 筛选结果
 */
- (NSArray *)ys_filterArrayWithBlock:(BOOL(^)(id obj))filterBlock;


@end
