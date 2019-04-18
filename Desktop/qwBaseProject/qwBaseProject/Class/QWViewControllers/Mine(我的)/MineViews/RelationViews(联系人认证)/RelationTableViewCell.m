//
//  RelationTableViewCell.m
//  qwBaseProject
//
//  Created by L.Ronaldo on 2019/4/13.
//  Copyright © 2019 apple. All rights reserved.
//

#import "RelationTableViewCell.h"
static NSString * const RelationReuse = @"RelationReuse";

@interface RelationTableViewCell()

@end

@implementation RelationTableViewCell

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

- (void)qw_config{
    self.topicLabel = Label.fixWH(100 ,21).color(kBlackColor).fnt(16).leftAlignment;
    self.statusTextField = TextField.fixWH(60, 18).fnt(16).color(kBlackColor).rightAlignment;
    self.statusTextField.userInteractionEnabled = NO;
    self.statusTextField.placeholder = @"请选择";
    
    [self.contentView addSubview:self.topicLabel];
    [self.contentView addSubview:self.statusTextField];
    
    [self.topicLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView.mas_left).offset(20);
        make.top.mas_equalTo(self.contentView.mas_top).offset(18);
        make.bottom.mas_equalTo(self.contentView.mas_bottom).offset(-18);
    }];
    
    [self.statusTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.contentView.mas_right).offset(-44);
        make.centerY.mas_equalTo(self.contentView.mas_centerY);
    }];
}

#pragma mark - Public

+ (instancetype)showRelationTableViewCellWith:(UITableView *)tableView andIndexPath:(NSIndexPath *)indexPath{
    RelationTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:RelationReuse];
    if (!cell) {
        cell = [[RelationTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:RelationReuse];
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
}

@end
