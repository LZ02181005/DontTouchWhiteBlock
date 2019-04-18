//
//  YSBaseWebViewController.h
//  GoFish
//
//  Created by Magic-Yu on 2018/3/12.
//  Copyright © 2018年 Magic-Yu. All rights reserved.
//

#import "YSBaseWebViewController.h"
#import "YSBaseViewController.h"
#import <WebKit/WebKit.h>
/**宏定义
 * 依次为屏幕宽，屏幕高，X适配，RAC封装，导航栏高度，X的屏幕高度
 */
#define kSCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define kSCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
#define kX(n) (kIS_X? (n + 22) : n)
#define RACObserve(TARGET, KEYPATH) _RACObserve(TARGET, KEYPATH)
#define kNAV_HEIGHT (kIS_X? 86 : 64)
#define kIS_X [UIScreen mainScreen].bounds.size.height == 812


@interface YSBaseWebViewController : YSBaseViewController
@property (nonatomic, copy) NSString *url;
- (void)handleWebViewEvent:(WKScriptMessage*)message;
@end
