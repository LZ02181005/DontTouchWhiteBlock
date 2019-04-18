//
//  BaseApi.h
//  AFNetworkingTool
//
//  Created by 崔露凯 on 15/11/15.
//  Copyright © 2015年 崔露凯. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HttpRequestTool.h"
#import "HttpSign.h"


// 请求回调, code = 0 成功， code = 1 失败
typedef void (^ApiRequestCallBack) (id resultData, NSInteger code);
// 参数回调
typedef BOOL(^ParamsBlock)(id request);

@interface BaseApi : NSObject

@property (nonatomic, copy) NSMutableDictionary *params;

@property (nonatomic, copy) ApiRequestCallBack callback;


// Api列表


/**
 无参数无特殊处理的网络请求

 @param apiName apiName
 @param callback 回调
 */
+ (void)ys_requestWithApiName:(NSString *)apiName callback:(ApiRequestCallBack)callback;


/**
 url参数签名（加密）

 @param params 接口参数
 @return 40位大写字母数字
 */
+ (NSString *)doSign:(NSDictionary *)params;


// 取消请求
+ (void)cancelAllRequest;


- (void)doRequestWithSuccessBlock:(void (^)(id))callback;

- (void)doRequestWithBaseUrl:(NSString *)baseUrl SuccessBlock:(void (^)(id))callback;

@end
