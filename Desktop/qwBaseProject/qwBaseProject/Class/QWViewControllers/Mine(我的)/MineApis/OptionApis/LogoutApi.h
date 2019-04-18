//
//  LogoutApi.h
//  qwBaseProject
//
//  Created by L.Ronaldo on 2019/4/18.
//  Copyright © 2019 apple. All rights reserved.
//

#import "BaseApi.h"

NS_ASSUME_NONNULL_BEGIN

@interface LogoutApi : BaseApi

///登出接口
- (void)logoutMethodWithSuccessCallBack:(ApiRequestCallBack)callback;

@end

NS_ASSUME_NONNULL_END
