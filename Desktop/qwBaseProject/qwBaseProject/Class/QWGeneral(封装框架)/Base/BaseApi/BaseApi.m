//
//  BaseApi.m
//  AFNetworkingTool
//
//  Created by 崔露凯 on 15/11/15.
//  Copyright © 2015年 崔露凯. All rights reserved.
//

#import "BaseApi.h"
#import "Singleton.h"

@implementation BaseApi

// Api列表
+ (void)ys_requestWithApiName:(NSString *)apiName callback:(ApiRequestCallBack)callback{
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    
    HttpRequestTool *tool = [HttpRequestTool shareManage];
    tool.requestApiType = HttpRequestApiTypeUser;
    
    [tool asynPostWithBaseUrl:@"api/user/login.htm"
                    apiMethod:apiName
                   parameters:dict
                      success:^(id responseObj) {
                          
                          if ([responseObj[@"code"] integerValue] == 0) {
                              // 成功回调
                              callback(kPASS_NULL_TO_NIL(responseObj[@"data"]), 0);
                          }
                          else {
                              // 失败回调
                              callback(responseObj, [responseObj[@"code"] integerValue]);
                              
                          }
                      }
                      failure:^(NSError *error) {
                          // 失败回调
                          callback(nil, 1);
                          
                      }];
    
}



- (NSDictionary *)publicParameters
{
    
    self.params[@"appid"] = kSEAVER_APP_ID;
    self.params[@"PHPSESSID"] = [Singleton shareInstance].phpSessionId;
    self.params[@"signMsg"] = [BaseApi doSign:self.params];
    
    return self.params;
    
}

// 签名
+ (NSString *)doSign:(NSDictionary *)params
{
    // 排序遍历字典
    NSMutableString *signStr = [self getDictionaryOfSortStringWithDict:params].mutableCopy;
    
    [signStr appendString:kMd5Salt];
    NSString *md5Str = [HttpSign doMD5:signStr];
    
    return md5Str;
    
}

+ (void)cancelAllRequest
{
    [[HttpRequestTool shareManage] cancleAllRequest];
}

/**
 字典转化为字符串
 
 @return 字符串
 */
+ (NSString *)getDictionaryOfSortStringWithDict:(NSDictionary *)dict{
    
    NSArray *keyArr = [dict allKeys];
    NSArray *arrrayordered =  [keyArr sortedArrayUsingComparator:^NSComparisonResult(NSString *obj1, NSString *obj2) {
        return [obj1 compare:obj2];
    }];
    NSMutableString *muString = [NSMutableString string];
    for (int i = 0; i < arrrayordered.count; i++) {
        NSString *key = [arrrayordered objectAtIndex:i];
        if (i == arrrayordered.count-1) {
            [muString appendFormat:@"%@=%@",key,[dict valueForKey:key]];
        } else
        {
            [muString appendFormat:@"%@=%@&",key,[dict valueForKey:key]];
        }
    }
    return muString;
    
}



- (void)doRequestWithSuccessBlock:(void (^)(id))callback{
    
    HttpRequestTool *tool = [HttpRequestTool shareManage];
    
    [tool asynPostWithBaseUrl:@"api/user/login.htm"
                    apiMethod:@""
                   parameters:[self publicParameters]
                      success:^(id responseObj) {
        if ([responseObj[@"code"] integerValue] == 0){
            
            
            if (callback) {
                callback(responseObj[@"data"]);
            }
            
            if (self.callback) {
                self.callback(kPASS_NULL_TO_NIL(responseObj[@"data"]), 0);
            }
            
            
        }else{
            
            if (self.callback) {
                self.callback(responseObj , [responseObj[@"code"] integerValue]);
            }
            
        }
        
    } failure:^(NSError *error) {
        if (self.callback) {
            NSMutableDictionary *temp = [NSMutableDictionary dictionary];
            temp[@"error_msg"] = error.localizedDescription;
            self.callback(temp, 424242);
        }
        
    }];
    
}

- (void)doRequestWithBaseUrl:(NSString *)baseUrl SuccessBlock:(void (^)(id))callback{
    
    HttpRequestTool *tool = [HttpRequestTool shareManage];
    
    [tool asynPostWithBaseUrl:baseUrl
                    apiMethod:@""
                   parameters:[self publicParameters]
                      success:^(id responseObj) {
                          if ([responseObj[@"code"] integerValue] == 0){
                              
                              
                              if (callback) {
                                  callback(responseObj[@"data"]);
                              }
                              
                              if (self.callback) {
                                  self.callback(kPASS_NULL_TO_NIL(responseObj[@"data"]), 0);
                              }
                              
                              
                          }else{
                              
                              if (self.callback) {
                                  self.callback(responseObj , [responseObj[@"code"] integerValue]);
                              }
                              
                          }
                          
                      } failure:^(NSError *error) {
                          if (self.callback) {
                              NSMutableDictionary *temp = [NSMutableDictionary dictionary];
                              temp[@"error_msg"] = error.localizedDescription;
                              self.callback(temp, 424242);
                          }
                          
                      }];
    
}

- (NSMutableDictionary *)params{
    if(!_params){
        _params = [NSMutableDictionary dictionary];
        
    }
    return _params;
}

@end

