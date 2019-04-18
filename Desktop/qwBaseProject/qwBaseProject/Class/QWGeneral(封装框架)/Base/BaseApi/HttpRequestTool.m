//
//  HttpRequestTool.m
//  AFNetworkingTool
//
//  Created by 崔露凯 on 15/9/25.
//  Copyright © 2015年 崔露凯. All rights reserved.
//

#import "HttpRequestTool.h"
#import "HttpRequestService.h"
#import "UserDefaultsUtil.h"
#import <AFNetworking.h>


@interface HttpRequestTool ()


@property (nonatomic, strong) AFNetworkReachabilityManager *reachabilityManage;


@end


@implementation HttpRequestTool {
    
    NSMutableDictionary *_requestList;
    
}

+ (HttpRequestTool *)shareManage {
    
    static HttpRequestTool *httpRequestTool = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        httpRequestTool = [[super alloc] init];
        
    });
    return httpRequestTool;
}

- (instancetype)init {
    if (self = [super init]) {
        _requestList = [NSMutableDictionary dictionary];
        
        _requestApiType = HttpRequestApiTypeUser;
    }
    return self;
}

- (NSTimeInterval)timeOut {
    if (_timeOut == 0) {
        _timeOut = 15;
    }
    return _timeOut;
}

- (void)asynCheckNetworkStatus:(MiniNetworkStatusCallback)networkBlock {
    
    AFNetworkReachabilityManager *reachabilityManage = [AFNetworkReachabilityManager sharedManager];
    [reachabilityManage startMonitoring];
    [reachabilityManage setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        
        if (status == AFNetworkReachabilityStatusUnknown) {
            networkBlock(MiniNetworkStatusUnknown);
        }
        else if (status == AFNetworkReachabilityStatusNotReachable) {
            networkBlock(MiniNetworkStatusNotReachable);
        }
        else if (status == AFNetworkReachabilityStatusReachableViaWWAN) {
            networkBlock(MiniNetworkStatusReachableViaWWAN);
        }
        else if (status == AFNetworkReachabilityStatusReachableViaWiFi) {
            networkBlock(MiniNetworkStatusReachableViaWifi);
        }
    }];
    
    _reachabilityManage = reachabilityManage;
}

- (void)asynGetWithBaseUrl:(NSString *)baseUrl apiMethod:(NSString *)apiMethod parameters:(NSDictionary *)params success:(MiniHttpRequestServiceSuccess)successBlock failure:(MiniHttpRequestServiceFailure)failure {
    
    HttpRequestObject *requestObj = [[HttpRequestObject alloc] init];
    if (baseUrl) {
        requestObj.requestUrl = baseUrl;
    }
    else {
       requestObj.requestUrl = kHttpServiceDomain;
    }
    requestObj.requestTimeout = self.timeOut;
    requestObj.requestParams = params;
    requestObj.apiMethod = apiMethod;
    requestObj.requestMethod = MiniRequestMethodGet;
    requestObj.responseType = MiniRequestResponseTypeJSON;
    requestObj.successBlock = successBlock;
    requestObj.failureBlock = failure;
    _requestList[apiMethod] = requestObj;
    
    [HttpRequestService asynRequest:requestObj success:^(id responseObj) {
        [_requestList removeObjectForKey:apiMethod];
        successBlock(responseObj);
        
    } failure:^(NSError *error) {
        [_requestList removeObjectForKey:apiMethod];
        failure(error);
    }];
    
}




- (void)asynPostWithBaseUrl:(NSString *)baseUrl apiMethod:(NSString *)apiMethod parameters:(NSDictionary *)params success:(MiniHttpRequestServiceSuccess)successBlock failure:(MiniHttpRequestServiceFailure)failure {

    HttpRequestObject *requestObj = [[HttpRequestObject alloc] init];
    
//    if (baseUrl) {
//        requestObj.requestUrl = baseUrl;
//    }
//    else {
//        requestObj.requestUrl = kHttpServiceDomain ;
//    }
    if (baseUrl) {
        requestObj.requestUrl = [NSString stringWithFormat:@"%@%@",kHttpDomain,baseUrl];
    }
    
    
    requestObj.requestTimeout = self.timeOut;
    requestObj.requestParams = params;
    requestObj.apiMethod = apiMethod;
    requestObj.requestMethod = MiniRequestMethodPost;
    requestObj.responseType = MiniRequestResponseTypeJSON;
    requestObj.successBlock = successBlock;
    requestObj.failureBlock = failure;
    _requestList[apiMethod] = requestObj;
    

    [HttpRequestService asynRequest:requestObj success:^(id responseObj) {
        
        
        // 判断是否为Session失效
        if ([kPASS_NULL_TO_NIL(responseObj[@"code"]) integerValue] == 40011) { // 若Session过期,  则不回调block
            
            [UserDefaultsUtil setUserDefaultName:@""];
            [UserDefaultsUtil setUserDefaultPassword:@""];
            [UserDefaultsUtil setUserDefaultCookie:@""];
            successBlock(responseObj);
            
        }
        else {
            
//            if ([[responseObj objectForKey:@"code"] integerValue]) { // code != 0
//            }
            
            successBlock(responseObj);
        }
        
        [_requestList removeObjectForKey:apiMethod];
        

    } failure:^(NSError *error) {
        
        [_requestList removeObjectForKey:apiMethod];
        failure(error);
        
    }];
}

- (void)asynPostUploadWithUrl:(NSString *)baseurl apiMethod:(NSString *)apiMethod parameters:(NSDictionary *)parameters fileData:(NSData *)data success:(MiniHttpRequestServiceSuccess)success failure:(MiniHttpRequestServiceFailure)failure {
    
    HttpRequestObject *requestObj = [[HttpRequestObject alloc] init];
    if (baseurl)
    {
        requestObj.requestUrl = baseurl;
    }
    else
    {
        requestObj.requestUrl = kHttpServiceDomain;
    }
    requestObj.requestTimeout = self.timeOut;
    requestObj.requestParams = parameters;
    requestObj.apiMethod = apiMethod;
    requestObj.requestMethod = MiniRequestMethodPost;
    requestObj.responseType = MiniRequestResponseTypeJSON;
    requestObj.successBlock = success;
    requestObj.failureBlock = failure;
    _requestList[apiMethod] = requestObj;
    
    [HttpRequestService uploadRequest:requestObj
                             fileData:data
                              success:^(id responseObj){
                                  [_requestList removeObjectForKey:apiMethod];
                                  success(responseObj);
                              }
                              failure:^(NSError *error){
                                  [_requestList removeObjectForKey:apiMethod];
                                  failure(error);
                              }];

    
   
    
    
    
}

- (void)resumeRequestWithApiMethid:(NSString*)apiMethod {
    
    HttpRequestObject *requestObj = _requestList[apiMethod];
    [requestObj.requestOperation resume];
}

- (void)suspendRequestWithApiMethid:(NSString*)apiMethod {
    
    HttpRequestObject *requestObj = _requestList[apiMethod];
    [requestObj.requestOperation suspend];
}

- (void)cancleRequestWithApiMethod:(NSString *)apiMethod {
    
    HttpRequestObject *requestObj = _requestList[apiMethod];
    [HttpRequestService cancleRequest:requestObj];
    [_requestList removeObjectForKey:apiMethod];
}

- (void)cancleAllRequest {
    
    for (NSString *apiMethod in [_requestList allKeys]) {
        HttpRequestObject *requestObj = _requestList[apiMethod];
        [HttpRequestService cancleRequest:requestObj];
        [_requestList removeObjectForKey:apiMethod];
    }
}

@end
