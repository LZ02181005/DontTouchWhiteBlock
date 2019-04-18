//
//  BankInfoTableViewCell.h
//  qwBaseProject
//
//  Created by L.Ronaldo on 2019/4/8.
//  Copyright © 2019 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, BankInfoTableViewCellType) {
    BankInfoTableViewCellTypeNormal,
    BankInfoTableViewCellTypeWithJT,
    BankInfoTableViewCellTypeWithButton
};

typedef void(^callBackString)(NSString *callBack);

@interface BankInfoTableViewCell : UITableViewCell

///数据dict
@property (nonatomic ,copy) NSMutableDictionary *dict;

///验证码按钮
@property (nonatomic ,strong) UIButton *theButton;

///cell的类型
@property (nonatomic ,assign) BankInfoTableViewCellType type;
///初始化方法
+ (instancetype) showBankCardRecognizeCellWithTableView:(UITableView *)tableView andIndexPath:(NSIndexPath *)indexPath andType:(BankInfoTableViewCellType)type;

///回调block
@property (nonatomic ,copy) callBackString callBack;

@end

NS_ASSUME_NONNULL_END
