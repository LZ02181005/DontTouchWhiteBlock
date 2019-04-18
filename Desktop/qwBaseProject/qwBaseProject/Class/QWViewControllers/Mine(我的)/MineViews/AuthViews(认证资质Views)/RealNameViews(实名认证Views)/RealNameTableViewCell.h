//
//  RealNameTableViewCell.h
//  qwBaseProject
//
//  Created by L.Ronaldo on 2019/4/11.
//  Copyright © 2019 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^pushToViewController)(NSInteger sign);

@interface RealNameTableViewCell : UITableViewCell

///回调
@property (nonatomic ,copy) pushToViewController callBack;

///预设Dict
@property (nonatomic ,strong) NSDictionary *preInstallDict;
///初始化方法
+ (instancetype)showRealNameTableViewCellWithTableView:(UITableView *)tableView andIndexPath:(NSIndexPath *)indexPath;

@end

NS_ASSUME_NONNULL_END
