//
//  RealNameTableViewCell.m
//  qwBaseProject
//
//  Created by L.Ronaldo on 2019/4/11.
//  Copyright © 2019 apple. All rights reserved.
//

#import "RealNameTableViewCell.h"

static NSString * const NameRealNameTableReuse = @"NameRealNameTableReuse";

@interface RealNameTableViewCell()

///标题Label
@property (nonatomic ,strong) UILabel *topicLabel;
///虚线框
@property (nonatomic ,strong) UIView *dottedLine;
///中间的image
@property (nonatomic ,strong) UIImageView *middleImageV;

@end

@implementation RealNameTableViewCell

#pragma mark - Lazy

#pragma mark - init

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self qw_config];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

#pragma mark - Life Cycle

#pragma mark - Private

-(void)qw_config{
    WeakifySelf()
    self.topicLabel = Label.fixWH(100, 20).fnt(16).color(kCOLOR_33).leftAlignment;
    
    self.dottedLine = View.fixWH(196, 103).bgColor(kWhiteColor);
    CAShapeLayer *border = [CAShapeLayer layer];
    border.strokeColor = kCOLOR_99.CGColor;
    border.path = [UIBezierPath bezierPathWithRect:self.dottedLine.bounds].CGPath;
    border.frame = self.dottedLine.bounds;
    border.lineWidth = 0.5f;
    [self.dottedLine.layer addSublayer:border];
    [self.dottedLine ys_tapGesture:^(UIGestureRecognizer *ges) {
        !weakSelf.callBack ? : weakSelf.callBack(1);
    }];
    
    self.middleImageV = ImageView.bgColor(kWhiteColor);
    self.middleImageV.contentMode = UIViewContentModeScaleAspectFit;
    
    [self.contentView addSubview:self.dottedLine];
    [self.contentView addSubview:self.topicLabel];
    [self.contentView addSubview:self.middleImageV];
    
    [self.dottedLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.contentView.mas_top).offset(20);
        make.bottom.mas_equalTo(self.contentView.mas_bottom).offset(-20);
        make.right.mas_equalTo(self.contentView.mas_right).offset(-42);
    }];
    
    [self.topicLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.dottedLine.mas_centerY);
        make.left.mas_equalTo(self.contentView.mas_left).offset(20);
    }];
    
    [self.middleImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.dottedLine.mas_centerX);
        make.centerY.mas_equalTo(self.dottedLine.mas_centerY);
    }];
}

#pragma mark - Public

+ (instancetype)showRealNameTableViewCellWithTableView:(UITableView *)tableView andIndexPath:(NSIndexPath *)indexPath{
    RealNameTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NameRealNameTableReuse];
    if (!cell) {
        cell = [[RealNameTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NameRealNameTableReuse];
    }
    return cell;
}

#pragma mark - Event

#pragma mark - ViewDataSource

#pragma mark - ViewDelegate

#pragma mark - RefreshViewDelegate

#pragma mark - Set & Get

-(void)setPreInstallDict:(NSDictionary *)preInstallDict{
    self.topicLabel.text = preInstallDict[@"topic"];
    self.middleImageV.img(preInstallDict[@"image"]);
}

@end
