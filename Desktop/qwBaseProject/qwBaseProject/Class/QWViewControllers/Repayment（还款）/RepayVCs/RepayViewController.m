//
//  RepayViewController.m
//  qwBaseProject
//
//  Created by L.Ronaldo on 2019/3/28.
//  Copyright © 2019 apple. All rights reserved.
//

#import "RepayViewController.h"
#import "QWBaseTableView.h"

@interface RepayViewController ()<UITableViewDelegate, UITableViewDataSource>

///主要的tableView
@property (nonatomic ,strong) QWBaseTableView *mainTableView;
///数据源
@property (nonatomic ,strong) NSMutableArray *dataSource;
///标题Label
@property (nonatomic ,strong) UILabel *topicLabel;



@end

@implementation RepayViewController

#pragma mark - Lazy

- (QWBaseTableView *)mainTableView{
    if (!_mainTableView) {
        _mainTableView = [[QWBaseTableView alloc] initWithFrame:CGRectMake(0, 55, kSCREEN_WIDTH, kSCREEN_HEIGHT - 100) style:UITableViewStylePlain];
        _mainTableView.delegate = self;
        _mainTableView.dataSource = self;
        _mainTableView.bgColor(kWhiteColor);
        _mainTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _mainTableView.scrollsToTop = NO;
        _mainTableView.scrollEnabled = NO;
    }
    return _mainTableView;
}

#pragma mark - init

#pragma mark - Life Cycle

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"收款";
    self.view.backgroundColor = kWhiteColor;
    
    [self qw_config];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

#pragma mark - Private

- (void)qw_config{
    
}

#pragma mark - Public

#pragma mark - Event

#pragma mark - ViewDataSource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [UITableViewCell new];
}

#pragma mark - ViewDelegate

#pragma mark - RefreshViewDelegate

#pragma mark - Set & Get
@end
