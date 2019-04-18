//
//  NSURL+YS.m
//  MToy
//
//  Created by Magic-Yu on 2017/11/6.
//  Copyright © 2017年 beyondin. All rights reserved.
//

#import "NSURL+YS.h"
#import "YSAppConfig.h"

@implementation NSURL (YS)

/**
 判断是否有前缀并进行添加
 
 @param string urlStr
 @return url实例
 */
+ (instancetype)ys_urlWithDomainStr:(NSString *)string{
    
    if (![string hasPrefix:@"http"]) {
        string = [NSString stringWithFormat:@"%@%@", kHttpDomain, string];
    }
    
    
    return [NSURL URLWithString:string];
    
}

@end
