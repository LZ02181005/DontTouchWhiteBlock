//
//  LogoutApi.m
//  qwBaseProject
//
//  Created by L.Ronaldo on 2019/4/18.
//  Copyright © 2019 apple. All rights reserved.
//

#import "LogoutApi.h"

@implementation LogoutApi
///登出接口
- (void)logoutMethodWithSuccessCallBack:(ApiRequestCallBack)callback{
    self.callback = callback;
    self.params[@"token"] = [GlobalAccess getToken];
    [self doRequestWithBaseUrl:@"api/act/user/logout.htm" SuccessBlock:^(id response) {
        
    }];
}

@end
