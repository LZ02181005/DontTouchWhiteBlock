//
//  RelationViewController.m
//  qwBaseProject
//
//  Created by L.Ronaldo on 2019/4/11.
//  Copyright © 2019 apple. All rights reserved.
//

#import "RelationViewController.h"
#import "RelationTableViewCell.h"
#import "RelationPickerView.h"

#import <ContactsUI/ContactsUI.h>
#import <AddressBookUI/AddressBookUI.h>
#import <AddressBook/AddressBook.h>
///判断系统版本是否大于iOS9
#define Is_up_Ios_9        [[UIDevice currentDevice].systemVersion floatValue] >= 9.0

@interface RelationViewController ()<UITableViewDelegate, UITableViewDataSource, CNContactPickerDelegate>

///预设数据
@property (nonatomic ,strong) NSArray *preInstallArray;

///主要的tableView
@property (nonatomic ,strong) UITableView *mainTableView;

@end

@implementation RelationViewController

#pragma mark - Lazy

- (UITableView *)mainTableView{
    if (!_mainTableView) {
        _mainTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kSCREEN_WIDTH, kSCREEN_HEIGHT) style:UITableViewStylePlain];
        _mainTableView.scrollsToTop = NO;
        _mainTableView.scrollEnabled = NO;
        _mainTableView.delegate = self;
        _mainTableView.dataSource = self;
        _mainTableView.estimatedSectionHeaderHeight = 30;
        _mainTableView.tableFooterView = [UIView new];
    }
    return _mainTableView;
}

- (NSArray *)preInstallArray{
    if (!_preInstallArray) {
        _preInstallArray = @[@{@"topic" : @"与本人关系"},
                             @{@"topic" : @"紧急联系人"}];
    }
    return _preInstallArray;
}

#pragma mark - init

#pragma mark - Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"紧急联系人认证";
    
    [self.view addSubview:self.mainTableView];
    
}
#pragma mark - Private

#pragma mark - Public

- (void)callAddressBook:(BOOL)isUp_iOS_9{
    if (isUp_iOS_9) {
        CNContactPickerViewController *contactPicker = [[CNContactPickerViewController alloc] init];
        contactPicker.delegate = self;
    }
}

#pragma mark - Event

#pragma mark - ViewDataSource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    RelationTableViewCell *cell = [RelationTableViewCell showRelationTableViewCellWith:tableView andIndexPath:indexPath];
    cell.preInstallDict = self.preInstallArray[indexPath.row];
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}

#pragma mark - ViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    RelationTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    switch (indexPath.section) {
        case 0:
            {   WeakifySelf()
                indexPath.row == 1 ? : [RelationPickerView showWithMessageArray:@[@"父亲", @"母亲", @"配偶"] RelationCallBack:^(NSString * _Nonnull topic) {
                    cell.statusTextField.text = topic;
                }];
            }
            break;
            
        case 1:
            {
                indexPath.row == 1 ? : [RelationPickerView showWithMessageArray:@[@"同事",@"朋友"] RelationCallBack:^(NSString * _Nonnull topic) {
                    cell.statusTextField.text = topic;
                }];
            }
            break;
    }
}

#pragma mark - RefreshViewDelegate

#pragma mark - Set & Get




@end
