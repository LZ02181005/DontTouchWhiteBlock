//
//  QWMoxieManager.h
//  qwBaseProject
//
//  Created by L.Ronaldo on 2019/4/17.
//  Copyright © 2019 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface QWMoxieManager : NSObject
///单例方法
+ (QWMoxieManager *)shareManager;

+(void)moxieOperatorAuthWithFromController:(UIViewController *)controller;

+(void)moxieFundAuthWithFromController:(UIViewController *)controller;

@end

NS_ASSUME_NONNULL_END
