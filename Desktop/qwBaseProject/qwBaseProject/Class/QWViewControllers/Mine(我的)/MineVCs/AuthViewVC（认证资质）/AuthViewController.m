//
//  AuthViewController.m
//  qwBaseProject
//
//  Created by L.Ronaldo on 2019/4/3.
//  Copyright © 2019 apple. All rights reserved.
//

#import "AuthViewController.h"
#import "AuthInfoTableViewCell.h"
#import "RealNameViewController.h"
#import "RelationViewController.h"
#import "BankInfoViewController.h"
#import "OtherRelationViewController.h"
#import "MoreInfoViewController.h"
#import "QWMoxieManager.h"

@interface AuthViewController ()<UITableViewDelegate, UITableViewDataSource>

///主要的tableView
@property (nonatomic ,strong) UITableView *mainTableView;
///预设数据
@property (nonatomic ,strong) NSArray *preInstallArray;
///跳转的VC名称Array
@property (nonatomic ,strong) NSArray *VCNamesArray;

@end

@implementation AuthViewController

#pragma mark - Lazy

- (UITableView *)mainTableView{
    if (!_mainTableView) {
        _mainTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kSCREEN_WIDTH, kSCREEN_HEIGHT) style:UITableViewStylePlain];
        _mainTableView.delegate = self;
        _mainTableView.dataSource = self;
        _mainTableView.scrollsToTop = NO;
        _mainTableView.scrollEnabled = NO;
        _mainTableView.estimatedSectionFooterHeight = 10;
        _mainTableView.estimatedSectionHeaderHeight = 0;
        _mainTableView.estimatedRowHeight = 44;
    }
    return _mainTableView;
}

- (NSArray *)preInstallArray{
    if (!_preInstallArray) {
        _preInstallArray = @[@[@{@"icon" : @"实名认证",
                                 @"topic" : @"实名认证"},
                               @{@"icon" : @"紧急联系人认证",
                                 @"topic" : @"紧急联系人认证"},
                               @{@"icon" : @"银行卡认证",
                                 @"topic" : @"银行卡认证"},
                               @{@"icon" : @"运营商认证",
                                 @"topic" : @"运营商认证"}],
                             @[@{@"icon" : @"其他联系方式",
                                 @"topic" : @"其他联系方式"},
                               @{@"icon" : @"更多信息认证",
                                 @"topic" : @"更多信息认证"}]];
    }
    return _preInstallArray;
}

- (NSArray *)VCNamesArray{
    if (!_VCNamesArray) {
        _VCNamesArray = @[@[@"RealNameViewController",
                            @"RelationViewController",
                            @"BankInfoViewController",
                            @"RullerViewController"],
                          @[@"OtherRelationViewController",
                            @"MoreInfoViewController"]];
    }
    return _VCNamesArray;
}

#pragma mark - init

#pragma mark - Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.bgColor(kWhiteColor);
    self.title = @"资质认证";
    
    [self qw_config];
    [self ys_getRemoteData];
}

#pragma mark - Private

-(void)qw_config{
    [self.view addSubview:self.mainTableView];
}
#warning - - - 做数据的获取，重要的是认证状态
- (void)ys_getRemoteData{
    
}

#pragma mark - Public

#pragma mark - Event

#pragma mark - ViewDataSource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    AuthInfoTableViewCell *cell = [AuthInfoTableViewCell showAuthTableViewCellWithTableView:tableView andIndexPath:indexPath];
    cell.preInstallDic = self.preInstallArray[indexPath.section][indexPath.row];
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return ((NSArray *)self.preInstallArray[section]).count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.preInstallArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section == 1) {
        return 0.1;
    }
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewAutomaticDimension;
}

#pragma mark - ViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 3) {
        [QWMoxieManager moxieFundAuthWithFromController:self];
        return;
    }
    
    id myObj = [NSClassFromString(self.VCNamesArray[indexPath.section][indexPath.row]) new];
    kPUSH((UIViewController *)myObj);
}

#pragma mark - RefreshViewDelegate

#pragma mark - Set & Get


@end
