//
//  FirstViewController.m
//  qwBaseProject
//
//  Created by L.Ronaldo on 2019/3/27.
//  Copyright © 2019 apple. All rights reserved.
//

#import "FirstViewController.h"
#import "LXBannerView.h"
#import "FirstVCApis.h"

@interface FirstViewController ()

@end

@implementation FirstViewController

#pragma mark - Lazy

#pragma mark - init

#pragma mark - Life Cycle

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self qw_getRemoteData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"首页";
    self.view.backgroundColor = kWhiteColor;
    
    [self qw_config];
}

#pragma mark - Private

- (void)qw_config{
    LXBannerView *bannerView = [[LXBannerView alloc] initWithFrame:CGRectMake(0, 0, kSCREEN_WIDTH, 135)];
    
}

-(void)qw_getRemoteData{
    [[FirstVCApis new] getUserInfosWithSuccessCallBack:^(id resultData, NSInteger code) {
        
    }];
}

#pragma mark - Public

#pragma mark - Event

#pragma mark - ViewDataSource

#pragma mark - ViewDelegate

#pragma mark - RefreshViewDelegate

#pragma mark - Set & Get

@end
