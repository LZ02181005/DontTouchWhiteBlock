//
//  GlobalAccess.h
//  MoneyIsGreat
//
//  Created by mac on 2018/11/7.
//  Copyright © 2018年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GlobalAccess : NSObject

/**
 存储login
 */
void setLogin(NSString * login);

/**
 存储token
 */
void setToken(NSString * token);

/**
 存储userId
 */
void setUserId(NSNumber * userId);

/**
 存储phone
 */
void setPhone(NSString * phone);

/**
 存储mchntSsn
 */
void setMchntSsn(NSString * mchntSsn);

/**
 存储borrowId
 */
void setBorrowId(NSString * borrowId);

/**
 存储用户姓名
 */
void setUserName(NSString * userName);

/**
 存储用户身份证
 */
void setUserIdCardId(NSString * cardId);

/**
 存储渠道名
 */
void setUserchannelName(NSString * channelName);

/**
 存储渠道吗
 */
void setUserchannelCode(NSString * channelCode);


/**
 获取login
 */
+(NSString *)getLogin;

/**
 获取token
 */
+(NSString *)getToken;

/**
 获取userId
 */
+(NSNumber *)getUserId;

/**
 获取phone
 */
+(NSString *)getPhone;

/**
 存储mchntSsn
 */
+(NSString *)getMchntSsn;

/**
 存储borrowId
 */
+(NSString *)getBorrowId;

/**
 获取存储姓名
 */
+(NSString *)getUserName;

/**
 获取身份证卡号
 */
+(NSString *)getUserIdCardId;

/**
 获取渠道名
 */
+(NSString *)getChannelName;

/**
 获取渠道吗
 */
+(NSString *)getChannelCode;

/**
 清空本地缓存
 */
+ (void)resetDefaults;

/**
 用户是否登录
 */
+ (BOOL)userIsLogin;

@end
