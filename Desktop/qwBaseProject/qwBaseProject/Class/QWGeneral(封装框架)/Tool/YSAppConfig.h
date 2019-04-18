//
//  YSAppConfig.h
//  KYGF
//
//  Created by Magic-Yu on 2017/9/9.
//  Copyright © 2017年 beyondin. All rights reserved.
//

#import <Foundation/Foundation.h>

// iOS开发通用Const

@interface YSAppConfig : NSObject

+ (instancetype)sharedManager;

// 服务器配置
extern NSString * const kHttpDomain;            // 项目地址
extern NSString * const kHttpServiceDomain;     // 项目接口地址
extern NSString * const kHttpImageService;      // 项目图片上传地址

// 盐
extern NSString * const kMd5Salt;

// 接口appid
extern NSString * const kSEAVER_APP_ID;
extern NSString * const kAPI_NAME;

// 通知
extern NSString * const kNotificationAlipay;
extern NSString * const kNotificationWxpay;
extern NSString * const kNotificationLogin;
extern NSString * const kNotificationLogout;

extern NSString * const kNotificationRefreshLocationList;

// 支付方式字符串

// S
extern NSString * const kScheme;

// 第三方信息
extern NSString * const kBUGLYKEY;      // Bugly
extern NSString * const kPGYKEY;        // Pgy
extern NSString * const kUMAPPKEY;      // UMKey
extern NSString * const kWXAPPKEY;      // WXKey
extern NSString * const kWXSECRET;      // WXS
extern NSString * const kQQAPPKEY;      // QQKey
extern NSString * const kQQSECRET;      // QQS
extern NSString * const kWBAPPKEY;      // WBKey
extern NSString * const kWBSECRET;      // WBS
extern NSString * const kJPUSHKEY;      // 极光推送key


// 复用key
extern NSString * const cellReuseIdentifier;    // Cell
extern NSString * const headerReuseIdentifier;  // header
extern NSString * const footerReuseIdentifier;  // footer


@end
