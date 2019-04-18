//
//  YSNoContentView.m
//  qwBaseProject
//
//  Created by L.Ronaldo on 2019/4/2.
//  Copyright © 2019 apple. All rights reserved.
//

#import "YSNoContentView.h"

@interface YSNoContentView()<UIScrollViewDelegate>

///占位图
@property (nonatomic ,strong) UIImageView *imageView;
///内容描述
@property (nonatomic ,strong) UILabel *topLabel;
///提示点击重新加载
@property (nonatomic ,strong) UILabel *bottomLabel;

@end

@implementation YSNoContentView

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

- (void)qw_config{
    self.backgroundColor = [UIColor whiteColor];
    
    //------- 图片 -------//
    self.imageView = [[UIImageView alloc]init];
    [self addSubview:self.imageView];
    
    //------- 内容描述 -------//
    self.topLabel = [[UILabel alloc]init];
    [self addSubview:self.topLabel];
    self.topLabel.textAlignment = NSTextAlignmentCenter;
    self.topLabel.font = [UIFont systemFontOfSize:14];
    self.topLabel.textColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1/1.0];;
    
    //------- 提示点击重新加载 -------//
    self.bottomLabel = [[UILabel alloc]init];
    [self addSubview:self.bottomLabel];
    self.bottomLabel.textAlignment = NSTextAlignmentCenter;
    self.bottomLabel.font = [UIFont systemFontOfSize:15];
    self.bottomLabel.textColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1/1.0];;
    
    //------- 建立约束 -------//
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self);
        make.centerY.mas_offset(-100);
        
    }];
    
    [self.topLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.imageView.mas_bottom).mas_offset(10);
        make.left.right.mas_offset(0);
        make.height.mas_equalTo(20);
    }];
    
    [self.bottomLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.topLabel.mas_bottom).mas_offset(5);
        make.left.right.mas_offset(0);
        make.height.mas_equalTo(20);
    }];
}

//根据传入的type创建对应的UI
-(void)setType:(NoContentType)type{
    switch (type) {
        
        case NoContentTypeNetwork:
            {
                
            }
            break;
        case NoContentTypeData:
            {
                [self setImage:@"缺省"
                  topLabelText:@"暂无相关数据"
               bottomLabelText:@" "];
            }
            break;
    }
}

/** 设置图片和文字 */
- (void)setImage:(NSString *)imageName topLabelText:(NSString *)topLabelText bottomLabelText:(NSString *)bottomLabelText{
    self.imageView.image = [UIImage imageNamed:imageName];
    self.topLabel.text = topLabelText;
    self.bottomLabel.text = bottomLabelText;
}


#pragma mark - Public

#pragma mark - Event

#pragma mark - ViewDataSource

#pragma mark - ViewDelegate

#pragma mark - RefreshViewDelegate

#pragma mark - Set & Get

@end
