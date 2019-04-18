//
//  RegisterApi.m
//  qwBaseProject
//
//  Created by L.Ronaldo on 2019/4/18.
//  Copyright © 2019 apple. All rights reserved.
//

#import "RegisterApi.h"

@implementation RegisterApi

///获取注册验证码
- (void)RegisterSendVerdyCodeWithPhoneNumber:(NSString *)phoneNumber
                          andSuccessCallBack:(ApiRequestCallBack)callback{
    self.callback = callback;
    self.params[@"phone"] = phoneNumber;
    self.params[@"type"] = @"register";
    
    [self doRequestWithBaseUrl:@"api/user/sendSms.htm" SuccessBlock:^(id response) {
        
    }];
}

///注册接口
- (void)RegisterWithPhoneNumber:(NSString *)phoneNumber
                    andPassWord:(NSString *)passWord
                   andVerdyCode:(NSString *)verdyCode
             andSuccessCallBack:(ApiRequestCallBack)callback{
    self.callback = callback;
    self.params[@"loginName"] = phoneNumber;
    self.params[@"loginPwd"] = [passWord ner_md5];
    self.params[@"client"] = @"ios";
    self.params[@"vcode"] = verdyCode;
    
    [self doRequestWithBaseUrl:@"/api/user/register.htm" SuccessBlock:^(id response) {
        
    }];
}

@end
