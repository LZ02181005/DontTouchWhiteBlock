//
//  NetWorkTool.m
//  qwBaseProject
//
//  Created by L.Ronaldo on 2019/4/10.
//  Copyright © 2019 apple. All rights reserved.
//

#import "NetWorkTool.h"

@implementation NetWorkTool

#pragma 数据申请方法

- (void) AFNetWorkMethodPostWithUrl:(NSString *)url
                     andWithBodyDic:(NSDictionary *)bodyDic
                     andWithformDic:(NSDictionary *)formDic
                             result:(successBlock)callback{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    [manager.responseSerializer setAcceptableContentTypes:[NSSet    setWithObjects:@"text/html", @"application/json", @"text/json",   @"text/javascript",@"text/html",@"text/css", @"text/plain", @"application/x-javascript", @"application/javascript",nil]];
    
    [manager POST:url parameters:bodyDic progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}

@end
