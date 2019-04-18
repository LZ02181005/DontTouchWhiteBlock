//
//  loginApi.h
//  qwBaseProject
//
//  Created by L.Ronaldo on 2019/4/14.
//  Copyright © 2019 apple. All rights reserved.
//

#import "BaseApi.h"

NS_ASSUME_NONNULL_BEGIN

@interface loginApi : BaseApi

- (void)loginWithUserName:(NSString *)userName
                 passWord:(NSString *)password
                   result:(ApiRequestCallBack)callBack;

@end

NS_ASSUME_NONNULL_END
