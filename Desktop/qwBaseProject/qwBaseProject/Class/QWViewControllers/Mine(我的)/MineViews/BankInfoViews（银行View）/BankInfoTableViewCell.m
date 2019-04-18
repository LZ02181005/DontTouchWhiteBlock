//
//  BankInfoTableViewCell.m
//  qwBaseProject
//
//  Created by L.Ronaldo on 2019/4/8.
//  Copyright © 2019 apple. All rights reserved.
//

#import "BankInfoTableViewCell.h"

static NSString * const BankInfoTableViewReuse = @"BankInfoTableViewReuse";

@interface BankInfoTableViewCell()

///标题Label
@property (nonatomic ,strong) UILabel *topicLabel;
///输入的TextField
@property (nonatomic ,strong) UITextField *inputTF;

@end

@implementation BankInfoTableViewCell

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
///页面铺设
- (void)qw_config{
    
    WeakifySelf()
    
    self.topicLabel = Label.fixWH(80,21).fnt(15).color(kCOLOR_33);
    self.inputTF = TextField.fixWH(180,17).fnt(16);
    self.theButton = Button.fixWH(70,16).fnt(11).color(kHEX(@"#BCBCBC")).str(@"点击获取");
    
    [self.contentView addSubview:self.topicLabel];
    [self.contentView addSubview:self.inputTF];
    [self.contentView addSubview:self.theButton];
    
    [self.topicLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView.mas_left).offset(20);
        make.top.mas_equalTo(self.contentView.mas_top).offset(18);
        make.bottom.mas_equalTo(self.contentView.mas_bottom).offset(-18);
    }];
    
    [self.inputTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView.mas_left).offset(115);
        make.centerY.mas_equalTo(self.topicLabel.mas_centerY);
    }];
    
    [self.theButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.topicLabel.mas_centerY);
        make.right.mas_equalTo(self.contentView.mas_right).offset(-20);
    }];
   
    [[self.inputTF rac_textSignal] subscribeNext:^(NSString * _Nullable x) {
        !weakSelf.callBack ? : weakSelf.callBack(self.inputTF.text);
    }];
}

#pragma mark - Public

+ (instancetype) showBankCardRecognizeCellWithTableView:(UITableView *)tableView andIndexPath:(NSIndexPath *)indexPath andType:(BankInfoTableViewCellType)type{
    BankInfoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:BankInfoTableViewReuse];
    if (!cell) {
        cell = [[BankInfoTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:BankInfoTableViewReuse];
    }
    cell.type = type;
    return cell;
}

#pragma mark - Event

#pragma mark - ViewDataSource

#pragma mark - ViewDelegate

#pragma mark - RefreshViewDelegate

#pragma mark - Set & Get

- (void)setType:(BankInfoTableViewCellType)type{
    _type = type;
    switch (_type) {
        
        case BankInfoTableViewCellTypeNormal:
            {
                self.theButton.hidden = YES;
            }
            break;
        case BankInfoTableViewCellTypeWithJT:
            {
                self.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
                self.inputTF.userInteractionEnabled = NO;
                self.theButton.hidden = YES;
            }
            break;
        case BankInfoTableViewCellTypeWithButton:
            {
                self.theButton.hidden = NO;
            }
            break;
    }
}

- (void)setDict:(NSMutableDictionary *)dict{
    self.topicLabel.text = dict[@"topic"];
    self.inputTF.placeholder = dict[@"placeHolder"];
}

@end
