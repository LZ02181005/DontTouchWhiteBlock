//
//  HttpRequestTool.h
//  AFNetworkingTool
//
//  Created by 崔露凯 on 15/9/25.
//  Copyright © 2015年 崔露凯. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HttpRequestObject.h"

/**
 Api接口类别，
 HttpRequestApiTypeUser:用户信息类接口
 HttpRequestApiTypeMsg:用户消息类接口
 HttpRequestApiTypeGroup:用户群组消息类接口

 */
typedef NS_ENUM(NSUInteger,HttpRequestApiType ) {
    HttpRequestApiTypeUser,
    HttpRequestApiTypeMsg,
    HttpRequestApiTypeGroup,
} ;

@interface HttpRequestTool : NSObject

@property (nonatomic, copy) NSString *baseUrl;

@property (nonatomic, assign) NSTimeInterval timeOut; // 默认60s

@property (nonatomic, assign) HttpRequestApiType requestApiType;// Api接口类别 默认 HttpRequestApiTypeUser

+ (HttpRequestTool*)shareManage;

/**
 *获取网络状态
 * networkBlock异步网络状态回调
 */
- (void)asynCheckNetworkStatus:(MiniNetworkStatusCallback)networkBlock;
/**
 *  POST请求
 *
 *  @param baseUrl      请求url默认为nil
 *  @param apiMethod    方法名
 *  @param params       参数字典
 *  @param successBlock 请求成功回调
 *  @param failure      失败回调
 */
- (void)asynPostWithBaseUrl:(NSString *)baseUrl apiMethod:(NSString *)apiMethod parameters:(NSDictionary *)params success:(MiniHttpRequestServiceSuccess)successBlock failure:(MiniHttpRequestServiceFailure)failure;

/**
 *  GET请求
 *
 *  @param baseUrl      请求url默认为nil
 *  @param apiMethod    方法名
 *  @param params       参数字典
 *  @param successBlock 请求成功回调
 *  @param failure      失败回调
 */
- (void)asynGetWithBaseUrl:(NSString *)baseUrl apiMethod:(NSString *)apiMethod parameters:(NSDictionary *)params success:(MiniHttpRequestServiceSuccess)successBlock failure:(MiniHttpRequestServiceFailure)failure;

/**
 *  Post上传文件
 *
 *  @param baseurl    请求url（默认为nil）
 *  @param apiMethod  接口名
 *  @param parameters 接口参数
 *  @param data       文件data
 *  @param success    成功回调
 *  @param failure    失败回调
 */
- (void)asynPostUploadWithUrl:(NSString *)baseurl apiMethod:(NSString *)apiMethod parameters:(NSDictionary *)parameters fileData:(NSData *)data success:(MiniHttpRequestServiceSuccess)success failure:(MiniHttpRequestServiceFailure)failure;


- (void)cancleRequestWithApiMethod:(NSString*)apiMethod;

- (void)cancleAllRequest;


@end
