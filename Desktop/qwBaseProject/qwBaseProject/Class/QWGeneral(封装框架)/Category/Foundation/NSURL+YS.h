//
//  NSURL+YS.h
//  MToy
//
//  Created by Magic-Yu on 2017/11/6.
//  Copyright © 2017年 beyondin. All rights reserved.
//

#import <Foundation/Foundation.h>

#define kUrl(x) [NSURL ys_urlWithDomainStr:x]

@interface NSURL (YS)

/**
 判断是否有前缀并进行添加

 @param string urlStr
 @return url实例
 */
+ (instancetype)ys_urlWithDomainStr:(NSString *)string;


@end
