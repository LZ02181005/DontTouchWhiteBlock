//
//  YSAppConfig.m
//  KYGF
//
//  Created by Magic-Yu on 2017/9/9.
//  Copyright © 2017年 beyondin. All rights reserved.
//

#import "YSAppConfig.h"

@implementation YSAppConfig

+ (instancetype)sharedManager {
    
    static YSAppConfig *g_singleton = nil;
    static dispatch_once_t once;
    
    dispatch_once(&once, ^{
        g_singleton = [[super alloc] init];
    });
    return g_singleton;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}


// 服务器配置
NSString * const kHttpDomain              = @"http://47.97.114.90:8088/zb-api/";
NSString * const kHttpServiceDomain       = @"http://47.97.114.90:8088/zb-api/";
NSString * const kHttpImageService        = @"http://47.97.114.90:8088/zb-api/";

// 盐
NSString * const kMd5Salt                 = @"&H2S@b&S(1D%a2l(K8^j9@s7&k&a2*_=";

// 接口appid
NSString * const kSEAVER_APP_ID            = @"1";
NSString * const kAPI_NAME                 = @"api_name";


// 通知
NSString * const kNotificationAlipay         = @"";  // 支付宝回调通知
NSString * const kNotificationWxpay          = @"";   // 微信支付回调通知
NSString * const kNotificationLogin          = @"kNotificationLogin";  // 登录通知
NSString * const kNotificationLogout         = @"kNotificationLogout";

NSString * const kNotificationRefreshLocationList = @"kNotificationRefreshLocationList";

// 支付方式字符串

// S
NSString * const kScheme = @"YSYS";

// 第三方信息
NSString * const kBUGLYKEY  = @"bb670089c2";
NSString * const kPGYKEY    = @"de7a8ff32e994275b974c38dbf9d7ed1";
NSString * const kUMAPPKEY  = @"";
NSString * const kWXAPPKEY  = @"";
NSString * const kWXSECRET  = @"";
NSString * const kQQAPPKEY  = @"";
NSString * const kQQSECRET  = @"";
NSString * const kWBAPPKEY  = @"";
NSString * const kWBSECRET  = @"";
NSString * const kJPUSHKEY  = @"";// 极光id


// 复用key
NSString * const cellReuseIdentifier = @"cellReuseIdentifier";      // Cell
NSString * const headerReuseIdentifier = @"headerReuseIdentifier";  // header
NSString * const footerReuseIdentifier = @"footerReuseIdentifier";  // footer



@end
