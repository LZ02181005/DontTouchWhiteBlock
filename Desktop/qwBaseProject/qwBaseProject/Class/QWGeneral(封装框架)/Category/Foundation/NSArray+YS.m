//
//  NSArray+YS.m
//  SY
//
//  Created by Magic-Yu on 2017/12/6.
//  Copyright © 2017年 Magic-Yu. All rights reserved.
//

#import "NSArray+YS.h"

@implementation NSArray (YS)

- (NSArray *)ys_sortWithKey:(NSString *)key{
    
    NSMutableArray *tmp = [NSMutableArray array];
    
    [self enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        id value;
        if ([obj isKindOfClass:[NSDictionary class]]) {
            value = [obj objectForKey:key];
        }else{
            value = [obj valueForKey:key];
        }
        
        if (value) {
            [tmp addObject:value];
        }
    }];
    
    return [tmp copy];
}

- (NSArray *)ys_addObjectsFromArray:(NSArray *)array{
    
    NSMutableArray *tmp = [self mutableCopy];
    [tmp addObjectsFromArray:array];
    return [tmp copy];
    
  
}

- (NSArray *)ys_filterArrayWithBlock:(BOOL(^)(id obj))filterBlock{
    
    NSMutableArray *tmp = [@[] mutableCopy];
    
    [self enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
       
        if (filterBlock && filterBlock(obj)) {
            [tmp addObject:obj];
        }
        
    }];
    
    return [tmp copy];
    
}


@end
