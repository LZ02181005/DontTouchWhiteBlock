//
//  YSLoginRegular.m
//  GoFish
//
//  Created by L.Ronaldo on 2018/3/14.
//  Copyright © 2018年 Magic-Yu. All rights reserved.
//

#import "YSLoginRegular.h"

@implementation YSLoginRegular

+ (BOOL)checkTelNumber:(NSString *)telNumber{
    NSString *pattern = @"^1+[3578]+\\d{9}";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES%@",pattern];
    BOOL isMatch = [pred evaluateWithObject:telNumber];
    return isMatch;
}

+ (BOOL)checkUserName:(NSString *)userName{
    NSString *pattern = @"^[a-zA-Z\u4E00-\u9FA5]{1,20}";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES%@",pattern];
    BOOL isMatch = [pred evaluateWithObject:userName];
    return isMatch;
}

+ (BOOL)checkPassWord:(NSString *)passWord{
    NSString *pattern = @"^(?![0-9]+$)(?![a-zA-Z]+$)[a-zA-Z0-9]{6,18}";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES%@",pattern];
    BOOL isMatch = [pred evaluateWithObject:passWord];
    return  isMatch;
}

@end
