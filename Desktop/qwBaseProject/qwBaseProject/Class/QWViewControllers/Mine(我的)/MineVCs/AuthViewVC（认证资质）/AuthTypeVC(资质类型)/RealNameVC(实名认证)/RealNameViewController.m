//
//  RealNameViewController.m
//  qwBaseProject
//
//  Created by L.Ronaldo on 2019/4/11.
//  Copyright © 2019 apple. All rights reserved.
//

#import "RealNameViewController.h"
#import "RealNameTableViewCell.h"
#import "RealNameInfoTableViewCell.h"

@interface RealNameViewController ()<UITableViewDelegate, UITableViewDataSource>

///主要tableView
@property (nonatomic ,strong) UITableView *mainTableView;

///预设数组1
@property (nonatomic ,strong) NSArray *preInstallRealCellArr;
///预设数组2
@property (nonatomic ,strong) NSArray *preInstallRealInfoArr;

@end

@implementation RealNameViewController

#pragma mark - Lazy

- (UITableView *)mainTableView{
    if (!_mainTableView) {
        _mainTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kSCREEN_WIDTH, kSCREEN_HEIGHT) style:UITableViewStylePlain];
        _mainTableView.delegate = self;
        _mainTableView.dataSource = self;
        _mainTableView.estimatedSectionHeaderHeight = 30;
        _mainTableView.tableFooterView = [UIView new];
        _mainTableView.scrollsToTop = NO;
        _mainTableView.scrollEnabled = NO;
    }
    return _mainTableView;
}

-(NSArray *)preInstallRealCellArr{
    if (!_preInstallRealCellArr) {
        _preInstallRealCellArr = @[@{@"topic" : @"人脸识别",
                                     @"image" : @"人脸识别"},
                                   @{@"topic" : @"身份证正面",
                                     @"image" : @"身份证正面(1)"},
                                   @{@"topic" : @"身份证反面",
                                     @"image" : @"身份证正面(1)(1)"}];
    }
    return _preInstallRealCellArr;
}

- (NSArray *)preInstallRealInfoArr{
    if (!_preInstallRealInfoArr) {
        _preInstallRealInfoArr = @[@{@"topic" : @"真实姓名",
                                     @"placeHolder" : @"请输入真实姓名"},
                                   @{@"topic" : @"身份证号",
                                     @"placeHolder" : @"请输入18位身份证号"},
                                   @{@"topic" : @"确认姓名",
                                     @"placeHolder" : @"请输入真实姓名"}];
    }
    return _preInstallRealInfoArr;
}

#pragma mark - init

#pragma mark - Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = kWhiteColor;
    self.title = @"实名认证";
    
    [self.view addSubview:self.mainTableView];
}

#pragma mark - Private

#pragma mark - Public

#pragma mark - Event

#pragma mark - ViewDataSource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.section) {
        case 0:
        {
            RealNameTableViewCell *cell = [RealNameTableViewCell showRealNameTableViewCellWithTableView:tableView andIndexPath:indexPath];
            cell.preInstallDict = self.preInstallRealCellArr[indexPath.row];
            cell.callBack = ^(NSInteger sign) {
                
            };
            return cell;
        }
            break;
        case 1:
        {
            RealNameInfoTableViewCell *cell = [RealNameInfoTableViewCell showRealNameInfoCellWithTableView:tableView andIndexPath:indexPath];
            cell.preInstallDic = self.preInstallRealInfoArr[indexPath.row];
            return cell;
        }
            break;
    }
    return [UITableViewCell new];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}

#pragma mark - ViewDelegate

#pragma mark - RefreshViewDelegate

#pragma mark - Set & Get


@end
