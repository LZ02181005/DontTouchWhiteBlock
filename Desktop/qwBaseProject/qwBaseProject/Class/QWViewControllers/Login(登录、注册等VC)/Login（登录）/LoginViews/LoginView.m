//
//  LoginView.m
//  qwBaseProject
//
//  Created by L.Ronaldo on 2019/3/29.
//  Copyright © 2019 apple. All rights reserved.
//

#import "LoginView.h"

@interface LoginView()<UITextFieldDelegate>

///允许明文的bool值
@property (nonatomic ,assign) BOOL  isSecurity;

@end

@implementation LoginView

#pragma mark - Lazy

#pragma mark - init

- (instancetype)initWithType:(LoginViewType)type{
    if (self = [super init]) {
        [self qw_config];
        self.type = type;
        self.isSecurity = YES;
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame WithType:(LoginViewType)type{
    if (self = [super initWithFrame:frame]) {
        [self qw_config];
        self.type = type;
    }
    return self;
}
#pragma mark - Life Cycle

#pragma mark - Private

- (void)qw_config{
    self.inputTF = TextField.fixWH(225 ,22).color(kCOLOR_33).fnt(14);
    self.inputTF.delegate = self;
    
    
    UIView *line = View.fixWH(276 ,1).bgColor(kHEX(@"#707070"));
    WeakifySelf()
    self.button = Button.fixWH(100, 22).color(kHEX(@"#FA653C")).onClick(^{
        !weakSelf.callBack ? : weakSelf.callBack(1);
    }).fnt(15);
    self.button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    
    [self addSubview:self.inputTF];
    [self addSubview:self.button];
    [self addSubview:line];
    
    [self.inputTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.mas_top);
        make.left.mas_equalTo(self.mas_left).offset(11);
    }];
    
    [self.button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right);
        make.centerY.equalTo(self.inputTF.mas_centerY);
    }];
    
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.inputTF.mas_bottom);
        make.left.mas_equalTo(self.mas_left);
        make.bottom.mas_equalTo(self.mas_bottom);
    }];
}

#pragma mark - Public

+ (instancetype)showSmallViewWithType:(LoginViewType)type{
    LoginView *theView = [[LoginView alloc] initWithType:type];
    theView.type = type;
    
    return theView;
}

#pragma mark - Event

- (void)isSecurtyText:(UIButton *)button{
    ///设置反状态并直接显示相反的状态
    if ((self.isSecurity = !_isSecurity)) {
        self.button.img(@"隐藏密码");
        self.inputTF.secureTextEntry = self.isSecurity;
    }else{
        self.button.img(@"显示密码");
        self.inputTF.secureTextEntry = self.isSecurity;
    }
}

#pragma mark - ViewDataSource

#pragma mark - ViewDelegate

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if (self.type == LoginViewTypePhone) {
        if (textField == self.inputTF) {
            //这里的if时候为了获取删除操作,如果没有次if会造成当达到字数限制后删除键也不能使用的后果.
            if (range.length == 1 && string.length == 0) {
                return YES;
            }
            //so easy
            else if (self.type == LoginViewTypePhone && self.inputTF.text.length >= 11) {
                self.inputTF.text = [textField.text substringToIndex:11];
                return NO;
            }
        }
    }else if (self.type == LoginviewTypePassWord){
        if (textField == self.inputTF) {
            //这里的if时候为了获取删除操作,如果没有次if会造成当达到字数限制后删除键也不能使用的后果.
            if (range.length == 1 && string.length == 0) {
                return YES;
            }
            else if (self.type == LoginviewTypePassWord && self.inputTF.text.length >= 16) {
                self.inputTF.text = [textField.text substringToIndex:16];
                return NO;
            }
        }
    }
    return YES;
}


#pragma mark - RefreshViewDelegate

#pragma mark - Set & Get

-(void)setType:(LoginViewType)type{
    _type = type;
    switch (_type) {
        
        case LoginViewTypePhone:
            {
                self.inputTF.placeholder = @"请输入手机号";
                self.button.hidden = YES;
            }
            break;
        case LoginviewTypePassWord:
            {
                self.inputTF.placeholder = @"请输入密码";
                self.inputTF.secureTextEntry = YES;
                self.button.hidden = YES;
            }
            break;
        case LoginViewTypeVerdyCode:
            {
                self.inputTF.placeholder = @"请输入验证码";
                self.button.str(@"点击获取");
            }
            break;
        case LoginViewTypeNewPwd:
            {
                self.inputTF.placeholder = @"请输入新密码（9-16位）";
                self.inputTF.secureTextEntry = self.isSecurity;
                [self.button addTarget:self action:@selector(isSecurtyText:) forControlEvents:UIControlEventTouchUpInside];
                self.button.img(@"隐藏密码");
            }
            break;
        case LoginViewTypeSetPwd:
            {
                self.inputTF.placeholder = @"请设置密码";
                self.inputTF.secureTextEntry = YES;
            }
            break;
        case LoginViewTypePwdAgain:
            {
                self.inputTF.placeholder = @"请再次输入密码";
                self.inputTF.secureTextEntry = self.isSecurity;
                self.button.img(@"隐藏密码");
                [self.button addTarget:self action:@selector(isSecurtyText:) forControlEvents:UIControlEventTouchUpInside];
            }
            break;
        case LoginViewTypeRealName:
            {
                self.inputTF.placeholder = @"请输入真实姓名";
            }
            break;
        case LoginViewTypeIDCode:
            {
                self.inputTF.placeholder = @"请输入身份证号";
            }
            break;
    }
}


@end
