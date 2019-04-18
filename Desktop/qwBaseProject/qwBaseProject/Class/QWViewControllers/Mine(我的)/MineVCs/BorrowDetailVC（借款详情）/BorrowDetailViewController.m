//
//  BorrowDetailViewController.m
//  qwBaseProject
//
//  Created by L.Ronaldo on 2019/4/3.
//  Copyright © 2019 apple. All rights reserved.
//

#import "BorrowDetailViewController.h"
#import "QWBaseTableView.h"

@interface BorrowDetailViewController ()<UITableViewDelegate, UITableViewDataSource>

///主要的tableView                 
@property (nonatomic ,strong) QWBaseTableView *mainTableView;

@end

@implementation BorrowDetailViewController


#pragma mark - Lazy

- (QWBaseTableView *)mainTableView{
    if (!_mainTableView) {
        _mainTableView = [[QWBaseTableView alloc] initWithFrame:CGRectMake(0, 0, 0, 0) style:UITableViewStylePlain];
        _mainTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _mainTableView.delegate = self;
        _mainTableView.dataSource = self;
        _mainTableView.scrollsToTop = NO;
    }
    return _mainTableView;
}

#pragma mark - init

#pragma mark - Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.bgColor(kWhiteColor);
    self.title = @"借款详情";
    [self qw_config];
    [self ys_getRemoteData];
}

#pragma mark - Private
///铺设UI
-(void)qw_config{
    [self.view addSubview:self.mainTableView];
    [self.mainTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view.mas_top).offset(kIS_X? 64 : 44);
        make.left.mas_equalTo(self.view.mas_left);
        make.right.mas_equalTo(self.view.mas_right);
        make.bottom.mas_equalTo(self.view.mas_bottom);
    }];
}

-(void)ys_getRemoteData{
    
}

#pragma mark - Public

#pragma mark - Event

#pragma mark - ViewDataSource

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [UITableViewCell new];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

#pragma mark - ViewDelegate

#pragma mark - RefreshViewDelegate

#pragma mark - Set & Get


@end
