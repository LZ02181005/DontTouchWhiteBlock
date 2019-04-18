//
//  MineHeaderView.h
//  qwBaseProject
//
//  Created by L.Ronaldo on 2019/4/1.
//  Copyright © 2019 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MineHeaderView : UIView

///会员星级数
@property (nonatomic ,assign) NSInteger level;

///初始化方法

+ (instancetype)InitandshowMineHeaderView;

@end

NS_ASSUME_NONNULL_END
