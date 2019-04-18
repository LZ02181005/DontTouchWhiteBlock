//
//  BankInfoViewController.h
//  qwBaseProject
//
//  Created by L.Ronaldo on 2019/4/3.
//  Copyright © 2019 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, BankInfoViewControllerType) {
    ///未认证
    BankInfoViewControllerTypeAnauthed = 0,
    ///已认证
    BankInfoViewControllerTypeAuthed = 1
};

@interface BankInfoViewController : UIViewController

///controller的状态
@property (nonatomic ,assign) BankInfoViewControllerType type;

@end

NS_ASSUME_NONNULL_END
