//
//  loginApi.m
//  qwBaseProject
//
//  Created by L.Ronaldo on 2019/4/14.
//  Copyright © 2019 apple. All rights reserved.
//

#import "loginApi.h"

@implementation loginApi

- (void)loginWithUserName:(NSString *)userName
                 passWord:(NSString *)password
                   result:(ApiRequestCallBack)callBack{
    self.callback = callBack;
    
    self.params[kAPI_NAME] = @"";
    self.params[@"loginName"] = userName;
    self.params[@"loginPwd"] = [HttpSign doMD5:password];
    
    [self doRequestWithBaseUrl:@"api/user/login.htm" SuccessBlock:^(id object) {
        
    }];
}

@end
