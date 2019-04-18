//
//  UserDefaultsUtil.m
//  LetWeCode
//
//  Created by 崔露凯 on 15/10/28.
//  Copyright © 2015年 崔露凯. All rights reserved.
//

#import "UserDefaultsUtil.h"

#define kUserDefaultCookie   @"userDefaultCookie"
#define kUserDefaultUserName @"userDefaultUserName"
#define kUserDefaultPassword @"userDefaultPassword"


NSString * const kACCID    = @"kACCID";
NSString * const kYX_TOKEN = @"kYX_TOKEN";
NSString * const kCITYNAME = @"kCITYNAME";
NSString * const kCITYID   = @"kCITYID";


@implementation UserDefaultsUtil

#pragma mark - 基本方法


+ (BOOL)isContainObjectForKey:(NSString*)key {

    
    if ([[NSUserDefaults standardUserDefaults] objectForKey:key]) {
        return YES;
    }
    return NO;
}

+ (void)setObject:(id)object forKey:(NSString*)key {
    
    
    [[NSUserDefaults standardUserDefaults] setObject:object forKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    
}

+ (id)getObjectForKey:(NSString*)key {

    
    if ([self isContainObjectForKey:key]) {
        
        id object = [[NSUserDefaults standardUserDefaults] objectForKey:key];
        
        if (!object && key == kACCID) {
            object = @"";
        }
        
        return object;
    }

    return nil;
}

+ (void)setBool:(BOOL)boolValue forKey:(NSString*)key
{
    [[NSUserDefaults standardUserDefaults] setBool:boolValue forKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (BOOL)getBoolForKey:(NSString*)key
{
    if ([self isContainObjectForKey:key]) {
        return [[NSUserDefaults standardUserDefaults] boolForKey:key];
    }
    return NO;
}

+ (void)removeObjectForKey:(NSString*)key {

    if ([self isContainObjectForKey:key]) {
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:key];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}

#pragma mark - 读写Cookie
+ (void)setUserDefaultCookie:(NSString*)cookie {
    
    [self setObject:cookie forKey:kUserDefaultCookie];
}

+ (NSString*)getUsetDefaultCookie {
   return [self getObjectForKey:kUserDefaultCookie];
}

#pragma mark - 读写用户名密码
+ (void)setUserDefaultName:(NSString*)userName {
    
    [self setObject:userName forKey:kUserDefaultUserName];
    
}

+ (NSString*)getUserDefaultName {
   return [self getObjectForKey:kUserDefaultUserName];
}

+ (void)setUserDefaultPassword:(NSString*)password {
    [self setObject:password forKey:kUserDefaultPassword];
}

+ (NSString*)getUserDefaultPassword {
    return [self getObjectForKey:kUserDefaultPassword];
}


@end
