//
//  LoginViewController.m
//  qwBaseProject
//
//  Created by L.Ronaldo on 2019/3/29.
//  Copyright © 2019 apple. All rights reserved.
//

#import "LoginViewController.h"
#import "LoginView.h"
#import "RegisterViewController.h"
#import "ForgetViewController.h"
#import "loginApi.h"
#import "QWMainTabbarController.h"
#import "GlobalAccess.h"


@interface LoginViewController ()
///控件
@property (nonatomic ,strong) LoginView *phoneView;
@property (nonatomic ,strong) LoginView *pswdView;

///数据

@property (nonatomic ,copy) NSString *phoneNum;

@property (nonatomic ,copy) NSString *passWord;

@end

@implementation LoginViewController

#pragma mark - Lazy

-(LoginView *)phoneView{
    if (!_phoneView) {
        _phoneView = [LoginView showSmallViewWithType:LoginViewTypePhone];
        }
    return _phoneView;
}

-(LoginView *)pswdView{
    if (!_pswdView) {
        _pswdView = [LoginView showSmallViewWithType:LoginviewTypePassWord];
    }
    return _pswdView;
}

#pragma mark - init

#pragma mark - Life Cycle

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = kWhiteColor;
    ///铺设UI
    [self qw_config];
   
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBarHidden = NO;
}


#pragma mark - Private

- (void)qw_config{
    WeakifySelf()
    UIImageView *iconImg = ImageView.fixWH(60, 60);
    
    self.phoneView.fixWH(276, 40);
    [[self.phoneView.inputTF rac_textSignal] subscribeNext:^(NSString * _Nullable x) {
        weakSelf.phoneNum = weakSelf.phoneView.inputTF.text;
    }];
    
    self.pswdView.fixWH(276, 40);
    [[self.pswdView.inputTF rac_textSignal] subscribeNext:^(NSString * _Nullable x) {
        weakSelf.passWord = weakSelf.pswdView.inputTF.text;
    }];
    
    UIButton *loginBtn = Button.fixWH(276, 47).color(kWhiteColor).bgColor(kAPP_MAIN_COLOR).onClick(^{
        [weakSelf loginEvent];
    }).str(@"登录").borderRadius(23);
    
    UIButton *registerBtn = Button.fixWH(60, 20).color(kAPP_MAIN_COLOR).bgColor(kWhiteColor).onClick(^{
        [weakSelf registerEvent];
    }).fnt(15).str(@"注册");
    
    UIButton *forgetBtn = Button.fixWH(80, 20).color(kAPP_MAIN_COLOR).bgColor(kWhiteColor).onClick(^{
        [weakSelf forgetEvent];
    }).fnt(15).str(@"忘记密码");
    
    [self.view addSubview:iconImg];
    [self.view addSubview:self.phoneView];
    [self.view addSubview:self.pswdView];
    [self.view addSubview:loginBtn];
    [self.view addSubview:registerBtn];
    [self.view addSubview:forgetBtn];
    
    
    [iconImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).offset(85);
        make.centerX.equalTo(self.view.mas_centerX);
    }];
    
    [self.phoneView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(iconImg.mas_bottom).offset(67);
        make.centerX.equalTo(iconImg.mas_centerX);
    }];

    [self.pswdView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.phoneView.mas_bottom).offset(84);
        make.centerX.equalTo(self.phoneView.mas_centerX);
    }];
    
    [loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.pswdView.mas_bottom).offset(56);
        make.centerX.equalTo(self.pswdView.mas_centerX);
    }];
    
    [registerBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(50);
        make.top.equalTo(loginBtn.mas_bottom).offset(32);
    }];
    
    [forgetBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view.mas_right).offset(-49);
        make.centerY.equalTo(registerBtn.mas_centerY);
    }];
}


#pragma mark - Public

#pragma mark - Event
///登录事件
- (void)loginEvent{
    if (self.phoneNum.length < 11) {
        [HUDTools showError:@"手机号码格式不正确，请确认后再试" inview:self.view];
        return;
    }
    if (self.passWord.length < 6) {
        [HUDTools showError:@"请检查密码格式" inview:self.view];
        return;
    }

    
    [[loginApi new] loginWithUserName:self.phoneNum passWord:self.passWord result:^(id resultData, NSInteger code) {
        if ([resultData[@"code"] integerValue] == 200) {
            [HUDTools showSuccessWithoutView:@"登录成功"];
            setToken(((NSDictionary *)(resultData[@"data"]))[@"token"]);
            setUserId(((NSDictionary *)(resultData[@"data"]))[@"userId"]);
            [UIApplication sharedApplication].delegate.window.rootViewController = [QWMainTabbarController new];
        }
    }];
    
    
}
///跳转到注册页面
- (void)registerEvent{
    RegisterViewController *registerVC  = [RegisterViewController new];
    [self.navigationController pushViewController:registerVC animated:YES];
}

///跳转忘记密码页面

- (void)forgetEvent{
    ForgetViewController *forgetVC = [ForgetViewController new];
    [self.navigationController pushViewController:forgetVC animated:YES];
}

#pragma mark - ViewDataSource

#pragma mark - ViewDelegate

#pragma mark - RefreshViewDelegate

#pragma mark - Set & Get

@end
