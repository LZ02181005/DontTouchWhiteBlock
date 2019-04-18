//
//  Singleton.h
//  AFNetworkingTool
//
//  Created by 崔露凯 on 15/11/15.
//  Copyright © 2015年 崔露凯. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YSAppMacro.h"
@class YSUserModel;

// 系统工具单例

@interface Singleton : NSObject

kSINGLWTON_H

#define kUSER [Singleton shareInstance].user
#define kCVC [Singleton shareInstance].currentVC

@property (nonatomic, copy) NSString *phpSessionId;          // session

@property (nonatomic, copy) NSString *registrationID;        // 极光推送的jpush_reg_id

@property (nonatomic, weak) UIViewController *currentVC;   // 当前控制器

@property (nonatomic, strong) YSUserModel *user;



@end
