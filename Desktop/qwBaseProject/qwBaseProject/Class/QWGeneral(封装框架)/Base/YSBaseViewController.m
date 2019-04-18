//
//  YSBaseViewController.m
//  MToy
//
//  Created by Magic-Yu on 2017/10/21.
//  Copyright © 2017年 beyondin. All rights reserved.
//

#import "YSBaseViewController.h"


@interface YSBaseViewController ()<UIGestureRecognizerDelegate>

@end

@implementation YSBaseViewController

#pragma mark - 生命周期

- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self p_configUI];
    [self p_setViewEdgeInset];
    
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];

}

- (void)createContentView{
    UIScrollView *scrollview = [UIScrollView new];
    UIView *contentView = [UIView new];
    if (@available(iOS 11.0, *)) {
        scrollview.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        // Fallback on earlier versions
    }
    [self.view insertSubview:scrollview atIndex:0];
    [scrollview addSubview:contentView];
    [scrollview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
    }];
    [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
        make.width.mas_equalTo([UIScreen mainScreen].bounds.size.width);
        make.height.mas_greaterThanOrEqualTo(scrollview).priorityHigh();
    }];
    self.contentView = contentView;
}

#pragma mark - 重写
- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}


#pragma mark - 初始化

- (void)p_configUI{
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.interactivePopGestureRecognizer.delegate = self;
}

- (void)p_setViewEdgeInset {
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.extendedLayoutIncludesOpaqueBars = NO;
    self.automaticallyAdjustsScrollViewInsets = NO;
    
}

#pragma mark - 方法


#pragma mark - 事件

#pragma mark - 网络请求

#pragma mark - 数据源

#pragma mark - 代理

// 手势代理
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    return YES;
}

#pragma mark - Get&Set


@end
