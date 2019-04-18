//
//  FirstVCApis.h
//  qwBaseProject
//
//  Created by L.Ronaldo on 2019/4/18.
//  Copyright © 2019 apple. All rights reserved.
//

#import "BaseApi.h"

NS_ASSUME_NONNULL_BEGIN

@interface FirstVCApis : BaseApi
///获取首页信息
- (void)getUserInfosWithSuccessCallBack:(ApiRequestCallBack)callback;

@end

NS_ASSUME_NONNULL_END
