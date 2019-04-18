//
//  RelationTableViewCell.h
//  qwBaseProject
//
//  Created by L.Ronaldo on 2019/4/13.
//  Copyright © 2019 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface RelationTableViewCell : UITableViewCell

///初始化方法
+ (instancetype)showRelationTableViewCellWith:(UITableView *)tableView andIndexPath:(NSIndexPath *)indexPath;
///预设Dict
@property (nonatomic ,strong) NSDictionary *preInstallDict;

///标题Label
@property (nonatomic ,strong) UILabel *topicLabel;
///状态TextField
@property (nonatomic ,strong) UITextField *statusTextField;

@end

NS_ASSUME_NONNULL_END
