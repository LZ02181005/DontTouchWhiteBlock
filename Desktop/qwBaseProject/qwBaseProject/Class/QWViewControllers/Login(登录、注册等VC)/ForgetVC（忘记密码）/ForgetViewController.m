//
//  ForgetViewController.m
//  qwBaseProject
//
//  Created by L.Ronaldo on 2019/3/29.
//  Copyright © 2019 apple. All rights reserved.
//

#import "ForgetViewController.h"
#import "LoginView.h"

@interface ForgetViewController ()
//控件
///手机号View
@property (nonatomic ,strong) LoginView *phoneView;
///新密码View
@property (nonatomic ,strong) LoginView *passWordView;
///再次输入密码View
@property (nonatomic ,strong) LoginView *againPsdView;
///验证码View
@property (nonatomic ,strong) LoginView *verdyCodeView;

//数据

///手机号码
@property (nonatomic ,copy) NSString *phoneNumber;
///新密码
@property (nonatomic ,copy) NSString *passWord;
///再次输入密码
@property (nonatomic ,copy) NSString *againPassWord;
///验证码
@property (nonatomic ,copy) NSString *verdyCode;
///倒计时时间
@property (nonatomic ,assign) int time;
///计时器
@property (nonatomic ,assign) RACDisposable *disposable;
@end

@implementation ForgetViewController

#pragma mark - Lazy

-(LoginView *)phoneView{
    if (!_phoneView) {
        _phoneView = [LoginView showSmallViewWithType:LoginViewTypePhone];
    }
    return _phoneView;
}

-(LoginView *)passWordView{
    if (!_passWordView) {
        _passWordView = [LoginView showSmallViewWithType:LoginViewTypeNewPwd];
    }
    return _passWordView;
}

- (LoginView *)againPsdView{
    if (!_againPsdView) {
        _againPsdView = [LoginView showSmallViewWithType:LoginViewTypePwdAgain];
    }
    return _againPsdView;
}

- (LoginView *)verdyCodeView{
    if (!_verdyCodeView) {
        _verdyCodeView = [LoginView showSmallViewWithType:LoginViewTypeVerdyCode];
    }
    return _verdyCodeView;
}

#pragma mark - init

#pragma mark - Life Cycle


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.bgColor(kWhiteColor);
    self.title = @"忘记密码";
    [self qw_config];
    
    [self setBackButton];
    
}

#pragma mark - Private
//铺设页面
- (void)qw_config{
    WeakifySelf()
    self.phoneView.fixWH(276, 50);
    [[self.phoneView.inputTF rac_textSignal] subscribeNext:^(NSString * _Nullable x) {
        weakSelf.phoneNumber = self.phoneView.inputTF.text;
    }];
    
    self.passWordView.fixWH(276, 50);
    [[self.passWordView.inputTF rac_textSignal] subscribeNext:^(NSString * _Nullable x) {
        weakSelf.passWord = self.passWordView.inputTF.text;
    }];
    
    
    self.againPsdView.fixWH(276, 50);
    [[self.againPsdView.inputTF rac_textSignal] subscribeNext:^(NSString * _Nullable x) {
        weakSelf.againPassWord = self.againPsdView.inputTF.text;
    }];
    
    [[self.againPsdView.button rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        
    }];
    
    self.verdyCodeView.fixWH(276, 50);
    [[self.verdyCodeView.inputTF rac_textSignal] subscribeNext:^(NSString * _Nullable x) {
        weakSelf.verdyCode = self.verdyCodeView.inputTF.text;
    }];
    
    [[self.passWordView.button rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        
    }];
    
    UIButton *button = Button.fixWH(276, 48).borderRadius(24).bgColor(kAPP_MAIN_COLOR).str(@"同意绑定").color(kWhiteColor).onClick(^{
        [weakSelf changePassWordConfirm];
    });
    
    [self.view addSubview:self.phoneView];
    [self.view addSubview:self.passWordView];
    [self.view addSubview:self.againPsdView];
    [self.view addSubview:self.verdyCodeView];
    [self.view addSubview:button];
    
    [self.phoneView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view).offset(kIS_X ? 124 : 104);
        make.centerX.mas_equalTo(self.view.mas_centerX);
    }];
    
    [self.passWordView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.phoneView.mas_bottom).offset(40);
        make.centerX.mas_equalTo(self.phoneView.mas_centerX);
    }];
    
    
    [self.againPsdView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.passWordView.mas_bottom).offset(40);
        make.centerX.mas_equalTo(self.passWordView.mas_centerX);
    }];
    
    [self.verdyCodeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.againPsdView.mas_bottom).offset(40);
        make.centerX.mas_equalTo(self.againPsdView.mas_centerX);
    }];
    
    [[self.verdyCodeView.button rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        WeakifySelf()
        x.enabled = false;
        
        
        if (self.phoneView.inputTF.text.length == 11) {
            
            [self getVerdyCode];
            
            
            self.time = 60;
            self.disposable = [[RACSignal interval:1.0 onScheduler:[RACScheduler mainThreadScheduler]] subscribeNext:^(NSDate * _Nullable x) {
                self.time --;
                NSString *title = self.time > 0 ?[NSString stringWithFormat:@"在%d秒后重试",self.time]: @"发送验证码";
                [weakSelf.verdyCodeView.button setTitle:title forState:UIControlStateNormal | UIControlStateDisabled];
                weakSelf.verdyCodeView.button.enabled = (self.time == 0) ? YES : NO;
                if (self.time == 0) {
                    [self.disposable dispose];
                }
            }];
        }else{
            [HUDTools showError:@"手机格式不正确，请检查后再次发送" inview:self.view];
        }
        
    }];
    
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.verdyCodeView.mas_bottom).offset(40);
        make.centerX.mas_equalTo(self.verdyCodeView.mas_centerX);
    }];
}

- (void)setBackButton{
    WeakifySelf()
    UIButton *backButton = Button.fixWH(20, 30).img(@"icon_back").bgColor(kBlackColor).onClick(^{
        [weakSelf.navigationController popViewControllerAnimated:YES];
    });
    [backButton setImage:[UIImage imageNamed:@"icon_back"] forState:UIControlStateNormal];
    [backButton setImage:[UIImage imageNamed:@"icon_back"] forState:UIControlStateHighlighted];
    // 让按钮内部的所有内容左对齐
    backButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [backButton addTarget:self action:@selector(backBarButtonItemAction) forControlEvents:UIControlEventTouchUpInside];
    backButton.contentEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0); // 这里微调返回键的位置可以让它看上去和左边紧贴
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
}

#pragma mark - Public

#pragma mark - Event
//返回
- (void)backBarButtonItemAction{
    [self.navigationController popViewControllerAnimated:YES];
}
//修改新密码
- (void)changePassWordConfirm{
    if (self.phoneNumber.length < 11) {
        [HUDTools showError:@"手机号码格式不正确，请确认后再试" inview:self.view];
        return;
    }
    if (self.passWord.length < 6) {
        [HUDTools showError:@"设置密码不能小于6位" inview:self.view];
        return;
    }
    if (![self.againPassWord isEqualToString:self.passWord]) {
        [HUDTools showMessage:@"重复密码输入不正确" inView:self.view];
        return;
    }
    
    NSLog(@"更改密码");
}
///获取验证码

- (void)getVerdyCode{
    
}

#pragma mark - ViewDataSource

#pragma mark - ViewDelegate

#pragma mark - RefreshViewDelegate

#pragma mark - Set & Get


@end
