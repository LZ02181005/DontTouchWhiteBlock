//
//  MineViewController.m
//  qwBaseProject
//
//  Created by L.Ronaldo on 2019/3/28.
//  Copyright © 2019 apple. All rights reserved.
//

#import "MineViewController.h"
#import "MineHeaderView.h"
#import "MineFirstTableViewCell.h"
#import "BorrowDetailVC（借款详情）/BorrowDetailViewController.h"
#import "AuthViewVC（认证资质）/AuthViewController.h"
#import "BankInfoVC（收款银行）/BankInfoViewController.h"
#import "HelpVC(帮助中心)/HelpViewController.h"
#import "AdviceVC（意见反馈）/AdviceViewController.h"
#import "OptionVC（设置）/OptionViewController.h"


@interface MineViewController ()<UITableViewDelegate, UITableViewDataSource>
///控件
///主tableView
@property (nonatomic ,strong) UITableView *mainTableView;
///假头视图
@property (nonatomic ,strong) MineHeaderView *mineHeaderView;

///数据
@property (nonatomic ,strong) NSArray *dataArray;
///控制器数组
@property (nonatomic ,strong) NSArray *VCArray;
@end

@implementation MineViewController

#pragma mark - Lazy

-(MineHeaderView *)mineHeaderView{
    if (!_mineHeaderView) {
        _mineHeaderView = [MineHeaderView InitandshowMineHeaderView];

    }
    return _mineHeaderView;
}

-(UITableView *)mainTableView{
    if (!_mainTableView) {
        _mainTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, self.mineHeaderView.frame.size.height - 30, kSCREEN_WIDTH, kSCREEN_HEIGHT - self.mineHeaderView.frame.size.height - 30) style:UITableViewStylePlain];
        _mainTableView.delegate = self;
        _mainTableView.dataSource = self;
        _mainTableView.scrollsToTop = NO;
        _mainTableView.scrollEnabled = NO;
        _mainTableView.tableFooterView = [UIView new];
    }
    return _mainTableView;
}

-(NSArray *)dataArray{
    if (!_dataArray) {
        _dataArray = @[@{@"icon":@"借款详情_1",
                         @"topic":@"借款详情"},
                       @{@"icon":@"认证",
                         @"topic":@"资质认证"},
                       @{@"icon":@"收款银行",
                         @"topic":@"收款银行"},
                       @{@"icon":@"帮助中心",
                         @"topic":@"帮助中心"},
                       @{@"icon":@"意见反馈",
                         @"topic":@"意见反馈"},
                       @{@"icon":@"设置",
                         @"topic":@"设置"}];
    }
    return _dataArray;
}

-(NSArray *)VCArray{
    if (!_VCArray) {
        _VCArray = @[@"BorrowDetailViewController",
                     @"AuthViewController",
                     @"BankInfoViewController",
                     @"HelpViewController",
                     @"AdviceViewController",
                     @"OptionViewController"];
    }
    return _VCArray;
}

#pragma mark - init

#pragma mark - Life Cycle

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的";
    self.view.backgroundColor = kHEX(@"#F8F8F8");
    
    [self qw_config];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

#pragma mark - Private

- (void)qw_config{
    self.mineHeaderView.fixWH(375, 178);
    
    self.mainTableView.backgroundColor = kWhiteColor;
    
    [self.view addSubview:self.mineHeaderView];
    [self.view addSubview:self.mainTableView];
    
    [self.mineHeaderView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view.mas_top);
        make.left.mas_equalTo(self.view.mas_left);
    }];
    
    [self.mainTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.mineHeaderView.mas_bottom).offset(-30);
        make.left.mas_equalTo(self.view.mas_left);
        make.right.mas_equalTo(self.view.mas_right);
        make.bottom.mas_equalTo(self.view.mas_bottom);
    }];
    
    self.mainTableView.borderRadius(10);
}

#pragma mark - Public

#pragma mark - Event

#pragma mark - ViewDataSource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    MineFirstTableViewCell *cell = [MineFirstTableViewCell showMineFirstTableViewCellWithTableView:tableView andIndexPath:indexPath];
    cell.dataDict = self.dataArray[indexPath.row];
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 6;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 60;
}

#pragma mark - ViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    id myObj = [NSClassFromString(self.VCArray[indexPath.row]) new];
    kPUSH((UIViewController *)myObj);
}

#pragma mark - RefreshViewDelegate

#pragma mark - Set & Get

@end
