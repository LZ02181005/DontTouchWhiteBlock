//
//  RealNameInfoTableViewCell.h
//  qwBaseProject
//
//  Created by L.Ronaldo on 2019/4/11.
//  Copyright © 2019 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface RealNameInfoTableViewCell : UITableViewCell

///预设dict
@property (nonatomic ,strong) NSMutableDictionary *preInstallDic;
///初始化方法
+ (instancetype)showRealNameInfoCellWithTableView:(UITableView *)tableView andIndexPath:(NSIndexPath *)indexPath;

@end

NS_ASSUME_NONNULL_END
