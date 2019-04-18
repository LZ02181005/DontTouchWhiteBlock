//
//  OptionViewController.m
//  qwBaseProject
//
//  Created by L.Ronaldo on 2019/4/3.
//  Copyright © 2019 apple. All rights reserved.
//

#import "OptionViewController.h"
#import "LogoutApi.h"
#import "LoginViewController.h"

static NSString * const OptionReuse = @"OptionReuse";

@interface OptionViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic ,strong) UITableView *mainTableView;

@end

@implementation OptionViewController

#pragma mark - Lazy

- (UITableView *)mainTableView{
    if (!_mainTableView) {
        _mainTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 0, 0) style:UITableViewStylePlain];
        _mainTableView.delegate = self;
        _mainTableView.dataSource = self;
        _mainTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _mainTableView.scrollsToTop = NO;
        _mainTableView.scrollEnabled = NO;
    }
    return _mainTableView;
}

#pragma mark - init

#pragma mark - Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.bgColor(kHEX(@"#F8F8F8"));
    self.title = @"设置";
    
    [self qw_config];
}

#pragma mark - Private

- (void)qw_config{
    WeakifySelf()
    UIButton *logoutButton = Button.fixWH(375,55).color(kAPP_MAIN_COLOR).str(@"退出登录").onClick(^{
        [weakSelf confirmLogout];
    }).bgColor(kWhiteColor);
    
    [self.view addSubview:self.mainTableView];
    [self.view addSubview:logoutButton];
    [self.mainTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left);
        make.top.mas_equalTo(self.view.mas_top).offset(kIS_X?64 : 44);
        make.right.mas_equalTo(self.view.mas_right);
        make.height.mas_equalTo(140);
    }];
    
    [logoutButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left);
        make.top.mas_equalTo(self.mainTableView.mas_bottom).offset(22);
    }];
}

#pragma mark - Public

#pragma mark - Event

- (void)confirmLogout{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"" message:@"是否确定退出登录" preferredStyle:UIAlertControllerStyleAlert];
    WeakifySelf()
    UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [weakSelf logoutEvent];
    }];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    
    [alert addAction:confirmAction];
    [alert addAction:cancelAction];
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)logoutEvent{
    [[LogoutApi new] logoutMethodWithSuccessCallBack:^(id resultData, NSInteger code) {
        if ([resultData[@"code"] integerValue] == 200) {
            [GlobalAccess resetDefaults];
            [HUDTools showSuccessWithoutView:@"登出成功"];
            [UIApplication sharedApplication].delegate.window.rootViewController = [LoginViewController new];
        }
    }];
}

#pragma mark - ViewDataSource


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
   
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:OptionReuse];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:OptionReuse];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    switch (indexPath.row) {
        case 0:{
            cell.textLabel.text = @"关于我们";
            cell.detailTextLabel.text = [NSString stringWithFormat:@"版本：1.0.0"];
            break;
        }
        case 1:{
            cell.textLabel.text = @"修改支付密码";
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            break;
        }
    }
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 55;
}

#pragma mark - ViewDelegate

#pragma mark - RefreshViewDelegate

#pragma mark - Set & Get



@end
