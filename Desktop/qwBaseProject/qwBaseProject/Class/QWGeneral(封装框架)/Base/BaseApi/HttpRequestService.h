//
//  HttpRequestService.h
//  AFNetworkingTool
//
//  Created by 崔露凯 on 15/9/25.
//  Copyright © 2015年 崔露凯. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HttpRequestObject.h"


@interface HttpRequestService : NSObject


+ (void)asynRequest:(HttpRequestObject *)requestObj success:(MiniHttpRequestServiceSuccess)success failure:(MiniHttpRequestServiceFailure)failure;

+ (void)uploadRequest:(HttpRequestObject *)requestObj fileData:(NSData *)data success:(MiniHttpRequestServiceSuccess)success failure:(MiniHttpRequestServiceFailure)failure;

+ (void)uploadAacRequest:(HttpRequestObject *)requestObj fileData:(NSData *)data success:(MiniHttpRequestServiceSuccess)success failure:(MiniHttpRequestServiceFailure)failure;

+ (void)cancleRequest:(HttpRequestObject *)requestObj;



+ (void)downloadFileWithUrl:(NSString*)urlStr savaUrl:(NSURL*)saveUrl progress:(void (^)(NSProgress *downloadProgress))progress completionHandler:(void(^)(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error))completionHandler;


@end
