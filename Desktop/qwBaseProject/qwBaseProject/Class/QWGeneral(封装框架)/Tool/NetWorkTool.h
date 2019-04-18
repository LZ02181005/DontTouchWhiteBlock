//
//  NetWorkTool.h
//  qwBaseProject
//
//  Created by L.Ronaldo on 2019/4/10.
//  Copyright © 2019 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
///成功的回调
typedef void(^successBlock)(NSURLSessionDataTask * _Nonnull task, id _Nullable responseObject);

@interface NetWorkTool : NSObject

@end

NS_ASSUME_NONNULL_END
