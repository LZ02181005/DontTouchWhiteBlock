//
//  HttpRequestService.m
//  AFNetworkingTool
//
//  Created by 崔露凯 on 15/9/25.
//  Copyright © 2015年 崔露凯. All rights reserved.
//

#import "HttpRequestService.h"
#import "AFNetworking.h"
#import "HttpLogger.h"
#import "UserDefaultsUtil.h"

@implementation HttpRequestService

+ (void)asynRequest:(HttpRequestObject *)requestObj success:(MiniHttpRequestServiceSuccess)success failure:(MiniHttpRequestServiceFailure)failure {

    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer.timeoutInterval = requestObj.requestTimeout;
    [manager.requestSerializer setValue:[NSString stringDic:requestObj.requestParams] forHTTPHeaderField:@"signMsg"];

    
    //GET
    if (requestObj.requestMethod == MiniRequestMethodGet) {
        
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json",@"text/javascript",@"text/html", nil];
        
        [manager.requestSerializer setValue:[NSString stringDic:requestObj.requestParams] forHTTPHeaderField:@"signMsg"];
        
        requestObj.requestOperation = [manager GET:requestObj.requestUrl parameters:requestObj.requestParams success:^(NSURLSessionDataTask *task, id responseObject) {
            
            [HttpLogger logDebugInfoWithResponse:task.response apiName:requestObj.apiMethod resposeString:responseObject request:task.originalRequest error:nil];
            if (responseObject) {
                success(responseObject);
            }
            else {
                success(nil);
            }
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            [HttpLogger logDebugInfoWithResponse:task.response apiName:requestObj.apiMethod resposeString:nil request:task.originalRequest error:error];
            failure(error);
        }];
        [HttpLogger logDebugInfoWithRequest:requestObj.requestOperation.originalRequest apiName:requestObj.apiMethod requestParams:requestObj.requestParams httpMethod:@"GET"];
    }
    //POST
    else if (requestObj.requestMethod == MiniRequestMethodPost) {
    
        manager.requestSerializer = [AFHTTPRequestSerializer serializer];
        manager.responseSerializer = [AFJSONResponseSerializer serializer];
        
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json",@"text/javascript",@"text/html", nil];
      
        [manager.requestSerializer setValue:[NSString stringDic:requestObj.requestParams] forHTTPHeaderField:@"signMsg"];
        [[GlobalAccess getToken] isEqualToString:@""] ? : [manager.requestSerializer setValue:[GlobalAccess getToken] forHTTPHeaderField:@"token"];
        requestObj.requestOperation = [manager POST:requestObj.requestUrl parameters:requestObj.requestParams success:^(NSURLSessionDataTask *task, id responseObject) {
            
            [HttpLogger logDebugInfoWithResponse:task.response apiName:requestObj.apiMethod resposeString:responseObject request:task.originalRequest error:nil];
            
            //保存登陆cookie
            NSArray *cookieList = [NSHTTPCookieStorage sharedHTTPCookieStorage].cookies;
            for (NSHTTPCookie *cookie in cookieList) {

                NSDictionary *properties = cookie.properties;
                if ([properties[@"Name"] isEqualToString:@"PHPSESSID"]) {
//                    [[NSUserDefaults standardUserDefaults] setObject:properties[@"Values"] forKey:@"kUserDeaufaultCookie"];
                    [UserDefaultsUtil setUserDefaultCookie:properties[@"Value"]];
//                    NSLog(@"%@", properties[@"Value"]);
                    break;
                }
                
            }
            if (responseObject) {
                success(responseObject);
            }
            else {
                success(nil);
            }
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            
            [HttpLogger logDebugInfoWithResponse:task.response apiName:requestObj.apiMethod resposeString:nil request:task.originalRequest error:error];
            failure(error);
        }];
        [HttpLogger logDebugInfoWithRequest:requestObj.requestOperation.originalRequest apiName:requestObj.apiMethod requestParams:requestObj.requestParams httpMethod:@"POST"];
    }
}


+ (void)uploadAacRequest:(HttpRequestObject *)requestObj fileData:(NSData *)data success:(MiniHttpRequestServiceSuccess)success failure:(MiniHttpRequestServiceFailure)failure{
    
    NSError *error = nil;
    AFJSONRequestSerializer *requestSerializer = [AFJSONRequestSerializer serializer];
    NSMutableURLRequest *request = [requestSerializer multipartFormRequestWithMethod:@"POST"
                                                                           URLString:requestObj.requestUrl
                                                                          parameters:requestObj.requestParams
                                                           constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
                                                               
                                                               
                                                               [formData appendPartWithFileData:data name:@"upfile" fileName:@"boris.png" mimeType:@"audio/aac"];
                                                               
                                                               
                                                           }
                                                                               error:&error];
    
    NSURLSessionConfiguration *sessionConfig = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:sessionConfig];
    
    AFHTTPResponseSerializer *responseSerializer = (AFHTTPResponseSerializer *)manager.responseSerializer;
    responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", nil];
    
    
    NSURLSessionUploadTask *uploadTask = [manager uploadTaskWithStreamedRequest:request progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        
        if (error) {
            failure(error);
        } else {
            success(responseObject);
        }
    }];
    
    [uploadTask resume];
    
}

+ (void)uploadRequest:(HttpRequestObject *)requestObj fileData:(NSData *)data success:(MiniHttpRequestServiceSuccess)success failure:(MiniHttpRequestServiceFailure)failure
{
    NSError *error = nil;
    AFJSONRequestSerializer *requestSerializer = [AFJSONRequestSerializer serializer];
    NSMutableURLRequest *request = [requestSerializer multipartFormRequestWithMethod:@"POST"
                                                                           URLString:requestObj.requestUrl
                                                                          parameters:requestObj.requestParams
                                                           constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
                                                               
                                                               [formData appendPartWithFileData:data name:@"upfile" fileName:@"boris.png" mimeType:@"image/png"];
                                                               
                                                               
                                                               
                                                           }
                                                                               error:&error];
    
    NSURLSessionConfiguration *sessionConfig = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:sessionConfig];
    
    AFHTTPResponseSerializer *responseSerializer = (AFHTTPResponseSerializer *)manager.responseSerializer;
    responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", nil];
    
    
    NSURLSessionUploadTask *uploadTask = [manager uploadTaskWithStreamedRequest:request progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
       
        if (error) {
            failure(error);
        } else {
            success(responseObject);
        }
    }];
 
    [uploadTask resume];
}


//+ (void)downloadRequest:(LHGHttpRequestObject *)requestObj downloadURL:(NSURL *)savepath success:(LHGHttpRequestAdapterSuccess)success failure:(LHGHttpRequestAdapterFailure)failure


+ (void)downloadFileWithUrl:(NSString*)urlStr savaUrl:(NSURL*)saveUrl progress:(void (^)(NSProgress *downloadProgress))progress completionHandler:(void(^)(NSURLResponse *response, NSURL *filePath, NSError * error))completionHandler  {

    
    NSURLSessionConfiguration *sessionConfig = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:sessionConfig];
    
    
    AFHTTPResponseSerializer *responseSerializer = (AFHTTPResponseSerializer *)manager.responseSerializer;
    responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"image/jpeg",@"application/vnd.openxmlformats-officedocument.wordprocessingml.document",@"application/msword", @"application/pdf",@"image/jpeg", nil];
    
    
    
    
    NSURL *requestUrl = [NSURL URLWithString:urlStr];
    NSURLRequest *request = [NSURLRequest requestWithURL:requestUrl];
    
     NSURLSessionDownloadTask *downloadTask = [manager downloadTaskWithRequest:request progress:progress destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
        
         
         return saveUrl;
         
     } completionHandler:completionHandler];
    


    [downloadTask resume];
    
    
    
    
}





+ (void)cancleRequest:(HttpRequestObject *)requestObj {

    [requestObj.requestOperation cancel];
    requestObj.successBlock = nil;
    requestObj.failureBlock = nil;
}

@end
