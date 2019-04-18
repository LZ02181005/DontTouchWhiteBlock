//
//  YSLoginRegular.h
//  GoFish
//
//  Created by L.Ronaldo on 2018/3/14.
//  Copyright © 2018年 Magic-Yu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YSLoginRegular : NSObject

+ (BOOL)checkTelNumber:(NSString *)telNumber;
+ (BOOL)checkPassWord:(NSString *)passWord;
+ (BOOL)checkUserName:(NSString *)userName;

@end
