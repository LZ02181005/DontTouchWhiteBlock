//
//  AuthInfoTableViewCell.h
//  qwBaseProject
//
//  Created by L.Ronaldo on 2019/4/10.
//  Copyright © 2019 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
///type不在初始化的时候就给
typedef NS_ENUM(NSInteger, AuthInfoTableViewCellType) {
    ///未认证
    AuthInfoTableViewCellTypeUnAuthed,
    ///已认证
    AuthInfoTableViewCellTypeAuthed
};

NS_ASSUME_NONNULL_BEGIN

@interface AuthInfoTableViewCell : UITableViewCell

///预设的Dict
@property (nonatomic ,strong) NSDictionary *preInstallDic;

///当前状态
@property (nonatomic ,assign) AuthInfoTableViewCellType  type;
///初始化状态
+ (instancetype)showAuthTableViewCellWithTableView:(UITableView *)tableView andIndexPath:(NSIndexPath *)indexPath;

@end

NS_ASSUME_NONNULL_END
