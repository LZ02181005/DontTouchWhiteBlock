//
//  LoginView.h
//  qwBaseProject
//
//  Created by L.Ronaldo on 2019/3/29.
//  Copyright © 2019 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/**
 *LoginViewTypePhone        手机号
 *LoginviewTypePassWord     密码
 *LoginViewTypeVerdyCode    验证码
 *LoginViewTypeNewPwd       新密码
 *LoginViewTypeSetPwd       设置密码
 *LoginViewTypePwdAgain     重复输入密码
 *LoginViewTypeRealName     真实姓名
 *LoginViewTypeIDCode       身份证号
 *
 */

typedef NS_ENUM(NSInteger, LoginViewType){
    LoginViewTypePhone = 0,
    LoginviewTypePassWord,
    LoginViewTypeVerdyCode,
    LoginViewTypeNewPwd,
    LoginViewTypeSetPwd,
    LoginViewTypePwdAgain,
    LoginViewTypeRealName,
    LoginViewTypeIDCode
};

typedef void(^buttonCallBack)(NSInteger sign);

@interface LoginView : UIView
///输入框
@property (nonatomic, strong)UITextField *inputTF;

@property (nonatomic ,assign)LoginViewType type;
///初始化方法
+ (instancetype)showSmallViewWithType:(LoginViewType)type;

///功能按钮
@property (nonatomic,strong) UIButton *button;

@property (nonatomic ,copy)buttonCallBack callBack;

@end

NS_ASSUME_NONNULL_END
