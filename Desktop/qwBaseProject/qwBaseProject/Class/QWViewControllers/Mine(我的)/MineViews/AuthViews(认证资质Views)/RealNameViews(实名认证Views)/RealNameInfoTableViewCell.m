//
//  RealNameInfoTableViewCell.m
//  qwBaseProject
//
//  Created by L.Ronaldo on 2019/4/11.
//  Copyright © 2019 apple. All rights reserved.
//

#import "RealNameInfoTableViewCell.h"

static NSString * const NameRealNameInfoTableViewReuse = @"NameRealNameInfoTableViewReuse";

@interface RealNameInfoTableViewCell()

///标题Label
@property (nonatomic ,strong) UILabel *topicLabel;
///输入TF
@property (nonatomic ,strong) UITextField *inputTextField;

@end

@implementation RealNameInfoTableViewCell

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
    self.topicLabel = Label.fixWH(64, 21).color(kCOLOR_33).fnt(16);
    self.inputTextField = TextField.fixWH(200, 17).fnt(17).color(kCOLOR_33);
    
    [self.contentView addSubview:self.topicLabel];
    [self.contentView addSubview:self.inputTextField];
    
    [self.topicLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView.mas_left).offset(20);
        make.centerY.mas_equalTo(self.contentView.mas_centerY);
    }];
    
    [self.inputTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.topicLabel.mas_right).offset(15);
        make.centerY.mas_equalTo(self.topicLabel.mas_centerY);
    }];
}

#pragma mark - Public

+ (instancetype)showRealNameInfoCellWithTableView:(UITableView *)tableView andIndexPath:(NSIndexPath *)indexPath{
    RealNameInfoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NameRealNameInfoTableViewReuse];
    if (!cell) {
        cell = [[RealNameInfoTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NameRealNameInfoTableViewReuse];
    }
    return cell;
}

#pragma mark - Event

#pragma mark - ViewDataSource

#pragma mark - ViewDelegate

#pragma mark - RefreshViewDelegate

#pragma mark - Set & Get

-(void)setPreInstallDic:(NSMutableDictionary *)preInstallDic{
    self.topicLabel.str(preInstallDic[@"topic"]);
    self.inputTextField.placeholder = preInstallDic[@"placeHolder"];
}


@end
