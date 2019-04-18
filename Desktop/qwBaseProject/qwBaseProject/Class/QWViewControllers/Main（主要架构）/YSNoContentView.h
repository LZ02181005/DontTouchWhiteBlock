//
//  YSNoContentView.h
//  qwBaseProject
//
//  Created by L.Ronaldo on 2019/4/2.
//  Copyright © 2019 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, NoContentType) {
    ///无网络
    NoContentTypeNetwork = 1,
    ///无订单
    NoContentTypeData = 0
};

@interface YSNoContentView : UIView

///无数据占位图的类型
@property (nonatomic ,assign) NoContentType  type;

@end

NS_ASSUME_NONNULL_END
