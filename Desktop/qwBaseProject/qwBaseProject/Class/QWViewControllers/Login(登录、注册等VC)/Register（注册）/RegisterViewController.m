//
//  RegisterViewController.m
//  qwBaseProject
//
//  Created by L.Ronaldo on 2019/3/29.
//  Copyright © 2019 apple. All rights reserved.
//

#import "RegisterViewController.h"
#import "YSBaseWebViewController.h"
#import "LoginView.h"
#import "RegisterApi.h"

@interface RegisterViewController ()
///控件
///手机号
@property (nonatomic ,strong) LoginView *phoneView;
///验证码
@property (nonatomic ,strong) LoginView *verdyCodeView;
///设置密码
@property (nonatomic ,strong) LoginView *setPswView;
///同意按钮
@property (nonatomic ,strong) UIButton *agreeBtn;

///数据
///手机号
@property (nonatomic ,copy) NSString *phoneNum;
///设置密码
@property (nonatomic ,copy) NSString *setPsword;
///验证码
@property (nonatomic ,copy) NSString *verdyCode;
///同意状态
@property (nonatomic ,assign) BOOL  agreeStatus;
///倒计时时间
@property (nonatomic ,assign) int time;
///计时器
@property (nonatomic ,assign) RACDisposable *disposable;

@end

@implementation RegisterViewController

#warning 成功之后的跳回还没做

#pragma mark - Lazy

- (LoginView *)phoneView{
    if (!_phoneView) {
        _phoneView = [LoginView showSmallViewWithType:LoginViewTypePhone];
    }
    return _phoneView;
}

- (LoginView *)verdyCodeView{
    if (!_verdyCodeView) {
        _verdyCodeView = [LoginView showSmallViewWithType:LoginViewTypeVerdyCode];
    }
    return _verdyCodeView;
}

- (LoginView *)setPswView{
    if (!_setPswView) {
        _setPswView = [LoginView showSmallViewWithType:LoginViewTypeSetPwd];
    }
    return _setPswView;
}



#pragma mark - init

#pragma mark - Life Cycle/**


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.agreeStatus = YES;
    self.navigationController.navigationBarHidden = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = kWhiteColor;
    //设置UI
    [self qw_config];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBarHidden = NO;
}

#pragma mark - Private

- (void)qw_config{
    WeakifySelf()
    UIButton *backButton = Button.fixWH(20, 30).img(@"icon_back").bgColor(kBlackColor).onClick(^{
        [weakSelf.navigationController popViewControllerAnimated:YES];
    });
    
    UIImageView *iconImg = ImageView.fixWH(60, 60).img(@"");
    
    self.phoneView.fixWH(276, 40);
    [[self.phoneView.inputTF rac_textSignal] subscribeNext:^(NSString * _Nullable x) {
        weakSelf.phoneNum = self.phoneView.inputTF.text;
    }];
    
    self.verdyCodeView.fixWH(276, 40);
    [[self.verdyCodeView.inputTF rac_textSignal] subscribeNext:^(NSString * _Nullable x) {
        weakSelf.verdyCode = self.verdyCodeView.inputTF.text;
    }];
    
    self.setPswView.fixWH(276, 40);
    [[self.setPswView.inputTF rac_textSignal] subscribeNext:^(NSString * _Nullable x) {
        weakSelf.setPsword = self.setPswView.inputTF.text;
    }];
    
    UIButton *registerButton = Button.fixWH(276, 47).color(kWhiteColor).bgColor(kAPP_MAIN_COLOR).str(@"注册").onClick(^{
        [weakSelf registerEvent];
    }).borderRadius(23);
    
    self.agreeBtn = Button.fixWH(14, 14).onClick(^{
        [weakSelf changeBtnStatus];
    }).img(@"勾选");
    
    UILabel *agreeLabel = Label.fixWH(180, 18).color(kAPP_MAIN_COLOR).fnt(12).str(@"注册即同意《用户注册协议》").onClick(^{
        [weakSelf jumpToRegisterAgreement];
    });
    
    [self.view addSubview:backButton];
    [self.view addSubview:iconImg];
    [self.view addSubview:self.phoneView];
    [self.view addSubview:self.verdyCodeView];
    [self.view addSubview:self.setPswView];
    [self.view addSubview:registerButton];
    [self.view addSubview:self.agreeBtn];
    [self.view addSubview:agreeLabel];
    
    [backButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).offset(20);
        make.top.mas_equalTo(self.view.mas_top).offset(kIS_X? 84 : 20);
    }];
    
    [iconImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view.mas_top).offset(85);
        make.centerX.mas_equalTo(self.view.mas_centerX);
    }];
    
    [self.phoneView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(iconImg.mas_bottom).offset(67);
        make.centerX.mas_equalTo(self.view.mas_centerX);
    }];
    
    [self.verdyCodeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.phoneView.mas_bottom).offset(44);
        make.centerX.mas_equalTo(self.view.mas_centerX);
    }];
    
    [[self.verdyCodeView.button rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        WeakifySelf()
        x.enabled = false;
        
        
        if (self.phoneView.inputTF.text.length == 11) {
            
            [self getVerdyCodeWithPhoneNumber:self.phoneView.inputTF.text];
            
            
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
    
    [self.setPswView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.verdyCodeView.mas_bottom).offset(44);
        make.centerX.mas_equalTo(self.view.mas_centerX);
    }];
    
    [registerButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.setPswView.mas_bottom).offset(56);
        make.centerX.mas_equalTo(self.view.mas_centerX);
    }];
    
    [self.agreeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(registerButton.mas_bottom).offset(31);
        make.left.mas_equalTo(self.view.mas_left).offset(93);
    }];
    
    [agreeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.agreeBtn.mas_right).offset(7);
        make.centerY.mas_equalTo(self.agreeBtn.mas_centerY);
    }];
    
    
    
}

#pragma mark - Public

#pragma mark - Event

///获取验证码

- (void)getVerdyCodeWithPhoneNumber:(NSString *)phoneNum{
    [[RegisterApi new] RegisterSendVerdyCodeWithPhoneNumber:phoneNum andSuccessCallBack:^(id resultData, NSInteger code) {
        if ([resultData[@"code"] integerValue] == 200) {
            [HUDTools showSuccess:@"发送成功" inview:self.view];
        }
    }];
}

//进入用户注册协议

- (void)jumpToRegisterAgreement{
    //用户协议H5页面
    YSBaseWebViewController *webView = [YSBaseWebViewController new];
    webView.url = @"https://www.baidu.com";
    [self.navigationController pushViewController:webView animated:YES];
}

//改变同意按钮的状态
- (void)changeBtnStatus{
    self.agreeStatus = !self.agreeStatus;
    _agreeStatus ? self.agreeBtn.img(@"勾选") :self.agreeBtn.img(@"");
}

- (void)registerEvent{
    if (self.phoneNum.length < 11) {
        [HUDTools showError:@"手机号码格式不正确，请确认后再试" inview:self.view];
        return;
    }
    if (self.setPsword.length < 6) {
        [HUDTools showError:@"请检查密码格式" inview:self.view];
        return;
    }if (self.verdyCode.length < 4) {
        [HUDTools showError:@"请检查验证码格式" inview:self.view];
        return;
    }
    if (!self.agreeStatus) {
        [HUDTools showMessage:@"需要同意注册协议" inView:self.view];
        return;
    }
    [[RegisterApi new] RegisterWithPhoneNumber:self.phoneNum
                                   andPassWord:self.setPsword
                                  andVerdyCode:self.verdyCode
                            andSuccessCallBack:^(id resultData, NSInteger code)
     {
         if ([resultData[@"code"] integerValue] == 200) {
             [HUDTools showSuccess:@"注册成功" inview:self.view];
         }
         [self.navigationController popViewControllerAnimated:YES];
     }];
    
}

#pragma mark - ViewDataSource

#pragma mark - ViewDelegate

#pragma mark - RefreshViewDelegate

#pragma mark - Set & Get

@end
