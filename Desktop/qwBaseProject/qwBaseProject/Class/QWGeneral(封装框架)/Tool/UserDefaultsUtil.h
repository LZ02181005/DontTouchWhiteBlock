//
//  UserDefaultsUtil.h
//  LetWeCode
//
//  Created by 崔露凯 on 15/10/28.
//  Copyright © 2015年 崔露凯. All rights reserved.
//



#import <Foundation/Foundation.h>

extern NSString * const kACCID;
extern NSString * const kYX_TOKEN;
extern NSString * const kCITYNAME;
extern NSString * const kCITYID;


@interface UserDefaultsUtil : NSObject

kSINGLWTON_H

@property (nonatomic, copy) NSString *cityName;

#pragma mark - 基本方法
+ (BOOL)isContainObjectForKey:(NSString*)key;

+ (void)setObject:(id)object forKey:(NSString*)key;

+ (id)getObjectForKey:(NSString*)key;

+ (void)setBool:(BOOL)boolValue forKey:(NSString*)key;

+ (BOOL)getBoolForKey:(NSString*)key;

+ (void)removeObjectForKey:(NSString*)key;

#pragma mark - 读写Cookie
+ (void)setUserDefaultCookie:(NSString*)cookie;

+ (NSString*)getUsetDefaultCookie;

#pragma mark - 读写用户名密码
+ (void)setUserDefaultName:(NSString*)userName;
+ (NSString*)getUserDefaultName;

+ (void)setUserDefaultPassword:(NSString*)password;
+ (NSString*)getUserDefaultPassword;




@end
