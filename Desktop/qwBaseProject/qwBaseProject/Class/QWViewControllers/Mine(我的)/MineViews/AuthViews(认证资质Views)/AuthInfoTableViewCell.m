//
//  AuthInfoTableViewCell.m
//  qwBaseProject
//
//  Created by L.Ronaldo on 2019/4/10.
//  Copyright © 2019 apple. All rights reserved.
//

#import "AuthInfoTableViewCell.h"

static NSString * const AuthInfoCellReuse = @"AuthInfoCellReuse";

@interface AuthInfoTableViewCell()

///cell的图标
@property (nonatomic ,strong) UIImageView *icon;
///topic的标签
@property (nonatomic ,strong) UILabel *topicLabel;
///状态Label
@property (nonatomic ,strong) UILabel *statusLabel;

@end

@implementation AuthInfoTableViewCell

#pragma mark - Lazy

#pragma mark - init

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self qw_config];
        self.selectionStyle = UITableViewCellStyleDefault;
        self.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    }
    return self;
}

#pragma mark - Life Cycle

#pragma mark - Private

-(void)qw_config{
    self.icon = ImageView.fixWH(18, 18);
    self.topicLabel = Label.fixWH(100, 18).fnt(14).color(kCOLOR_33);
    self.statusLabel = Label.fixWH(40, 11).fnt(11).rightAlignment;
    
    [self.contentView addSubview:self.icon];
    [self.contentView addSubview:self.topicLabel];
    [self.contentView addSubview:self.statusLabel];
    
    [self.icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView.mas_left).offset(15);
        make.top.mas_equalTo(self.contentView.mas_top).offset(11);
        make.bottom.mas_equalTo(self.contentView.mas_bottom).offset(-11);
    }];
    
    [self.topicLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.icon.mas_left).offset(23);
        make.centerY.mas_equalTo(self.icon.mas_centerY);
    }];
    
    [self.statusLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.contentView.mas_right).offset(-44);
        make.centerY.mas_equalTo(self.topicLabel.mas_centerY);
    }];
}

#pragma mark - Public

+ (instancetype)showAuthTableViewCellWithTableView:(UITableView *)tableView andIndexPath:(NSIndexPath *)indexPath{
    AuthInfoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:AuthInfoCellReuse];
    if (!cell) {
        cell = [[AuthInfoTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:AuthInfoCellReuse];
    }
    return cell;
}

#pragma mark - Event

#pragma mark - ViewDataSource

#pragma mark - ViewDelegate

#pragma mark - RefreshViewDelegate

#pragma mark - Set & Get

-(void)setPreInstallDic:(NSDictionary *)preInstallDic{
    self.icon.img(preInstallDic[@"icon"]);
    self.topicLabel.text = preInstallDic[@"topic"];
}

-(void)setType:(AuthInfoTableViewCellType)type{
    switch (type) {
        
        case AuthInfoTableViewCellTypeUnAuthed:
            {
                self.statusLabel.color(kAPP_MAIN_COLOR);
            }
            break;
        case AuthInfoTableViewCellTypeAuthed:
            {
                self.topicLabel.color(kHEX(@"#BCBCBC"));
            }
            break;
    }
}
@end
