//
//  RegisterApi.h
//  qwBaseProject
//
//  Created by L.Ronaldo on 2019/4/18.
//  Copyright © 2019 apple. All rights reserved.
//

#import "BaseApi.h"

NS_ASSUME_NONNULL_BEGIN

@interface RegisterApi : BaseApi

///获取注册验证码
- (void)RegisterSendVerdyCodeWithPhoneNumber:(NSString *)phoneNumber
                          andSuccessCallBack:(ApiRequestCallBack)callback;
///注册接口
- (void)RegisterWithPhoneNumber:(NSString *)phoneNumber
                    andPassWord:(NSString *)passWord
                   andVerdyCode:(NSString *)verdyCode
             andSuccessCallBack:(ApiRequestCallBack)callback;
@end

NS_ASSUME_NONNULL_END
