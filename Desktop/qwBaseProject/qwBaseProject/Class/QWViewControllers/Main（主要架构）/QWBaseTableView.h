//
//  QWBaseTableView.h
//  qwBaseProject
//
//  Created by L.Ronaldo on 2019/4/2.
//  Copyright © 2019 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface QWBaseTableView : UITableView

// 无数据占位图点击的回调函数
@property (copy,nonatomic) void(^noContentViewTapedBlock)(void);

/**
 展示无数据占位图
 
 @param emptyViewType 无数据占位图的类型
 */
- (void)showEmptyViewWithType:(NSInteger)emptyViewType;

/* 移除无数据占位图 */
- (void)removeEmptyView;

@end

NS_ASSUME_NONNULL_END
