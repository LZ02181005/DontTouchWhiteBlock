//
//  FirstMiddleView.m
//  qwBaseProject
//
//  Created by L.Ronaldo on 2019/4/17.
//  Copyright © 2019 apple. All rights reserved.
//

#import "FirstMiddleView.h"

@interface FirstMiddleView()

///图片1
@property (nonatomic ,strong) UIImageView *FirstImageView;
///标签1
@property (nonatomic ,strong) UILabel *FirstLabel;

///图片2
@property (nonatomic ,strong) UIImageView *SecondImageView;
///标签2
@property (nonatomic ,strong) UILabel *SecondLabel;

///图片3
@property (nonatomic ,strong) UIImageView *ThirdImageView;
///标签3
@property (nonatomic ,strong) UILabel *ThirdLabel;

@end

@implementation FirstMiddleView

#pragma mark - Lazy

#pragma mark - init

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self qw_config];
    }
    return self;
}

#pragma mark - Life Cycle

#pragma mark - Private

-(void)qw_config{
    self.FirstImageView = ImageView.fixWH(59, 59).img(@"安全");
    self.SecondImageView = ImageView.fixWH(59, 59).img(@"材料");
    self.ThirdImageView = ImageView.fixWH(59, 59).img(@"高效");
    
    self.FirstLabel = Label.fixWH(64, 21).color(kCOLOR_33).fnt(16).str(@"安全可靠").centerAlignment;
    self.SecondLabel = Label.fixWH(64, 21).color(kCOLOR_33).fnt(16).str(@"材料简单").centerAlignment;
    self.ThirdLabel = Label.fixWH(64, 21).color(kCOLOR_33).fnt(16).str(@"高效审核").centerAlignment;
    
    [self addSubview:self.FirstImageView];
    [self addSubview:self.FirstLabel];
    [self addSubview:self.SecondImageView];
    [self addSubview:self.SecondLabel];
    [self addSubview:self.ThirdImageView];
    [self addSubview:self.ThirdLabel];
    
    [self.FirstImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.mas_left).offset(38);
        make.top.mas_equalTo(self.mas_top).offset(13);
    }];
    
    [self.FirstLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.FirstImageView.mas_centerX);
        make.top.mas_equalTo(self.FirstImageView.mas_bottom).offset(11);
        make.bottom.mas_equalTo(self.mas_bottom).offset(-16);
    }];
    
    
    
}

#pragma mark - Public

#pragma mark - Event

#pragma mark - ViewDataSource

#pragma mark - ViewDelegate

#pragma mark - RefreshViewDelegate

#pragma mark - Set & Get

@end
