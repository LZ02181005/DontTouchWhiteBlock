//
//  BankInfoViewController.m
//  qwBaseProject
//
//  Created by L.Ronaldo on 2019/4/3.
//  Copyright © 2019 apple. All rights reserved.
//

#import "BankInfoViewController.h"
#import "BankInfoTableViewCell.h"

@interface BankInfoViewController ()<UITableViewDelegate,UITableViewDataSource,UIPickerViewDelegate,UIPickerViewDataSource>

///主要的tableView
@property (nonatomic ,strong) UITableView *mainTabelView;

///预设的数据数组（未绑定）
@property (nonatomic ,strong) NSArray *preinstallArray;
///预设的数据数组（已绑定）
@property (nonatomic ,strong) NSArray *preInstallAuthedArray;

@end

@implementation BankInfoViewController

#pragma mark - Lazy

- (UITableView *)mainTabelView{
    if (!_mainTabelView) {
        _mainTabelView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kSCREEN_WIDTH, kSCREEN_HEIGHT) style:UITableViewStylePlain];
        _mainTabelView.bgColor(kWhiteColor);
        _mainTabelView.delegate = self;
        _mainTabelView.dataSource = self;
        _mainTabelView.scrollsToTop = NO;
        _mainTabelView.scrollEnabled = NO;
        _mainTabelView.rowHeight = UITableViewAutomaticDimension;
        _mainTabelView.fixWH(kSCREEN_WIDTH, 400);
    }
    return _mainTabelView;
}

- (NSArray *)preinstallArray{
    if (!_preinstallArray) {
        _preinstallArray = @[@{@"topic" : @"持卡人姓名",
                               @"placeHolder" : @"请输入姓名"},
                             @{@"topic" : @"所属银行",
                               @"placeHolder" : @"请选择所属银行"},
                             @{@"topic" : @"银行卡号",
                               @"placeHolder" : @"请输入银行卡号"},
                             @{@"topic" : @"预留手机号",
                               @"placeHolder" : @"请输入手机号"},
                             @{@"topic" : @"验证码",
                               @"placeHolder" : @"请输入验证码"}];
    }
    return _preinstallArray;
}

- (NSArray *)preInstallAuthedArray{
    if (!_preInstallAuthedArray) {
        _preInstallAuthedArray = @[@{@"topic" : @"所属银行",
                                     @"placeHolder" : @"请选择所属银行"},
                                   @{@"topic" : @"银行卡号",
                                     @"placeHolder" : @"请输入银行卡号"},
                                   @{@"topic" : @"预留手机号",
                                     @"placeHolder" : @"请输入手机号"}];
    }
    return _preInstallAuthedArray;
}

#pragma mark - init

#pragma mark - Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.bgColor(kWhiteColor);
    self.title = @"银行卡认证";
    
    [self qw_config];
}

#pragma mark - Private
///完成页面铺设
- (void)qw_config{
    WeakifySelf()
    UILabel *showLabel = Label.fixWH(200,15).fnt(11).color(kHEX(@"#BCBCBC")).str(@"请绑定持卡人的手机号");
    
    UIButton *bindButton = Button.fixWH(335 ,48).bgColor(kAPP_MAIN_COLOR).color(kWhiteColor).str((_type == BankInfoViewControllerTypeAnauthed)? @"同意绑定": @"解除绑定").onClick(^{
        [weakSelf bindEvent];
    }).fnt(18).borderRadius(24);
    
    [self.view addSubview:self.mainTabelView];
    [self.view addSubview:showLabel];
    [self.view addSubview:bindButton];
    
    [showLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).offset(20);
        make.top.mas_equalTo(self.mainTabelView.mas_bottom).offset(-10);
    }];
    
    [bindButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.top.mas_equalTo(showLabel.mas_bottom).offset(76);
    }];
}

#pragma mark - Public

#pragma mark - Event
///绑定和解绑方法
- (void)bindEvent{
    
}

#pragma mark - ViewDataSource
///TABLEVIEW DATASOURCE
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    BankInfoTableViewCell *cell = [BankInfoTableViewCell showBankCardRecognizeCellWithTableView:tableView andIndexPath:indexPath andType:BankInfoTableViewCellTypeNormal];
   
    switch (_type) {
        
        case BankInfoViewControllerTypeAnauthed:
            {
                if (indexPath.row == 1) {
                    cell.type = BankInfoTableViewCellTypeWithJT;
                    
                }else if (indexPath.row == 4){
                    cell.type = BankInfoTableViewCellTypeWithButton;
                    
                }
                cell.dict = self.preinstallArray[indexPath.row];
            }
            break;
        case BankInfoViewControllerTypeAuthed:
            {
                if (indexPath.row == 0) {
                    cell.type = BankInfoTableViewCellTypeWithJT;
                    cell.userInteractionEnabled = NO;
                    cell.dict = self.preInstallAuthedArray[indexPath.row];
                }
            }
            break;
    }
    cell.callBack = ^(NSString *callBack) {
        
    };
    
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    switch (_type) {
        
        case BankInfoViewControllerTypeAnauthed:
            {
                return  self.preinstallArray.count;
            }
            break;
        case BankInfoViewControllerTypeAuthed:
        {
            return self.preInstallAuthedArray.count;
        }
            break;
    }
}



#pragma mark - ViewDelegate

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (_type == BankInfoViewControllerTypeAnauthed && indexPath.row == 1) {
        UIPickerView *pickerView = [[UIPickerView alloc] initWithFrame:self.view.frame];
        pickerView.delegate = self;
        pickerView.dataSource = self;
    }
}
#pragma mark - RefreshViewDelegate

#pragma mark - Set & Get

@end
