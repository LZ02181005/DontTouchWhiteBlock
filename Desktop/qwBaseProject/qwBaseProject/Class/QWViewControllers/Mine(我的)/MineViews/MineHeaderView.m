//
//  MineHeaderView.m
//  qwBaseProject
//
//  Created by L.Ronaldo on 2019/4/1.
//  Copyright © 2019 apple. All rights reserved.
//

#import "MineHeaderView.h"

@interface MineHeaderView()


#warning 还没有取数据

///控件
///会员级别Label
@property (nonatomic ,strong) UILabel *levelLabel;
///手机号Label
@property (nonatomic ,strong) UILabel *phoneLabel;

///数据

@end

@implementation MineHeaderView

#pragma mark - Lazy

#pragma mark - init

-(instancetype)init{
    if (self = [super init]) {
        [self qw_config];
    }
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self qw_config];
    }
    return self;
}

#pragma mark - Life Cycle

#pragma mark - Private

- (void)qw_config{
    UIImageView *backGroundImgV = ImageView.fixWH(375, 178).img(@"背景");
    
    UILabel *topicLabel = Label.fixWH(100,23).fnt(20).str(@"个人中心").color(kWhiteColor).centerAlignment;
    
    UIImageView *headIcon = ImageView.fixWH(61, 61);
    
    UILabel *nameLabel = Label.fixWH(150, 17).fnt(16).color(kWhiteColor).leftAlignment;
    
    self.levelLabel = Label.fixWH(100, 14).fnt(14).color(kWhiteColor).str(@"会员级别：").leftAlignment;
    
    self.phoneLabel = Label.fixWH(200, 14).fnt(14).color(kWhiteColor).leftAlignment;
    
    [self addSubview:backGroundImgV];
    [backGroundImgV addSubview:topicLabel];
    [backGroundImgV addSubview:headIcon];
    [backGroundImgV addSubview:nameLabel];
    [backGroundImgV addSubview:self.levelLabel];
    [backGroundImgV addSubview:self.phoneLabel];
    
    [backGroundImgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.mas_top);
        make.left.mas_equalTo(self.mas_left);
        make.right.mas_equalTo(self.mas_right);
        make.bottom.mas_equalTo(self.mas_bottom);
    }];
    
    [topicLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(backGroundImgV.mas_top).offset(31);
        make.centerX.mas_equalTo(backGroundImgV.mas_centerX);
    }];
    
    [headIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(topicLabel.mas_bottom).offset(21);
        make.left.mas_equalTo(backGroundImgV.mas_left).offset(40);
    }];
    
    [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(headIcon.mas_top);
        make.left.mas_equalTo(headIcon.mas_right).offset(25);
    }];
    
    [self.levelLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(nameLabel.mas_left);
        make.top.mas_equalTo(nameLabel.mas_bottom).offset(8);
    }];
    
    [self.phoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.levelLabel.mas_left);
        make.top.mas_equalTo(self.levelLabel.mas_bottom).offset(8);
    }];
}

#pragma mark - Public

+ (instancetype)InitandshowMineHeaderView{
    MineHeaderView *theView = [[MineHeaderView alloc] init];
    return theView;
}

#pragma mark - Event

#pragma mark - ViewDataSource

#pragma mark - ViewDelegate

#pragma mark - RefreshViewDelegate

#pragma mark - Set & Get

@end
