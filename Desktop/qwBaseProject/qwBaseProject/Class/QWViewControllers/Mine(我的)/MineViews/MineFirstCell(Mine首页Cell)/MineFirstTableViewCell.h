//
//  MineFirstTableViewCell.h
//  qwBaseProject
//
//  Created by L.Ronaldo on 2019/4/2.
//  Copyright © 2019 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MineFirstTableViewCell : UITableViewCell

///预设字典
@property (nonatomic ,copy) NSDictionary *dataDict;
///初始化方法
+ (instancetype)showMineFirstTableViewCellWithTableView:(UITableView *)tableView andIndexPath:(NSIndexPath *)indexPath;

@end

NS_ASSUME_NONNULL_END
