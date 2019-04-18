//
//  GlobalAccess.m
//  MoneyIsGreat
//
//  Created by mac on 2018/11/7.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "GlobalAccess.h"

#define defaults [NSUserDefaults standardUserDefaults]

@implementation GlobalAccess


///存储login
void setLogin(NSString * login){
    [defaults setObject:login forKey:@"login"];
    [defaults synchronize];
}

///存储token
void setToken(NSString * token){
    [defaults setObject:token forKey:@"token"];
    [defaults synchronize];
}

///存储userId
void setUserId(NSNumber * userId){
    [defaults setObject:userId forKey:@"userId"];
    [defaults synchronize];
}

///存储phone
void setPhone(NSString * phone){
    [defaults setObject:phone forKey:@"phone"];
    [defaults synchronize];
}

/**
 存储mchntSsn
 */
void setMchntSsn(NSString * mchntSsn){
    [defaults setObject:mchntSsn forKey:@"mchntSsn"];
    [defaults synchronize];
}

/**
 存储borrowId
 */
void setBorrowId(NSString * borrowId){
    [defaults setObject:borrowId forKey:@"borrowId"];
    [defaults synchronize];
}

/**
 存储用户姓名
 */
void setUserName(NSString * userName){
    [defaults setObject:userName forKey:@"userName"];
    [defaults synchronize];
}

/**
 存储用户身份证号
 */
void setUserIdCardId(NSString * cardId){
    [defaults setObject:cardId forKey:@"userIdCardId"];
    [defaults synchronize];
}

/**
 存储用户身份证号
 */
void setUserchannelName(NSString * channelName){
    [defaults setObject:channelName forKey:@"userchannelName"];
    [defaults synchronize];
}

/**
 存储用户身份证号
 */
void setUserchannelCode(NSString * channelCode){
    [defaults setObject:channelCode forKey:@"userchannelCode"];
    [defaults synchronize];
}

///获取login
+(NSString *)getLogin{
    return [defaults objectForKey:@"login"] == nil ? @"0" : [defaults objectForKey:@"login"];
}

///获取token
+(NSString *)getToken{
    return [defaults objectForKey:@"token"] == nil ? @"" : [defaults objectForKey:@"token"];
}

///获取userId
+(NSNumber *)getUserId{
    return [defaults objectForKey:@"userId"] == nil ? @"" : [defaults objectForKey:@"userId"];
}

///获取phone
+(NSString *)getPhone{
    return [defaults objectForKey:@"phone"] == nil ? @"" : [defaults objectForKey:@"phone"];
}

///存储mchntSsn
+(NSString *)getMchntSsn{
    return [defaults objectForKey:@"mchntSsn"] == nil ? @"" : [defaults objectForKey:@"mchntSsn"];
}

/**
 存储borrowId
 */
+(NSString *)getBorrowId{
    return [defaults objectForKey:@"borrowId"] == nil ? @"" : [defaults objectForKey:@"borrowId"];
}

/**
 获取用户姓名
 */
+(NSString *)getUserName{
    return [defaults objectForKey:@"userName"] == nil ? @"" : [defaults objectForKey:@"userName"];
}

/**
 获取用户身份证号
 */
+(NSString *)getUserIdCardId{
    return [defaults objectForKey:@"userIdCardId"] == nil ? @"" : [defaults objectForKey:@"userIdCardId"];
}

+(NSString *)getChannelName{
    return [defaults objectForKey:@"userchannelName"] == nil ? @"" : [defaults objectForKey:@"userchannelName"];
}

+(NSString *)getChannelCode{
    return [defaults objectForKey:@"userchannelCode"] == nil ? @"" : [defaults objectForKey:@"userchannelCode"];
}
+ (void)resetDefaults {
    NSDictionary *dictionary = [defaults dictionaryRepresentation];
    
    for (NSString * key in [dictionary allKeys]) {
        [defaults removeObjectForKey:key];
        [defaults synchronize];
    }
}

+(BOOL)userIsLogin{
    return [defaults objectForKey:@"token"] == nil ? NO:YES;
}


@end
