//
//  MineFirstTableViewCell.m
//  qwBaseProject
//
//  Created by L.Ronaldo on 2019/4/2.
//  Copyright © 2019 apple. All rights reserved.
//

#import "MineFirstTableViewCell.h"

static NSString * const MineFirstReuse = @"MineFirstReuse";

@interface MineFirstTableViewCell()

///图标
@property (nonatomic ,strong) UIImageView *iconImgV;
///标题
@property (nonatomic ,strong) UILabel *topicLabel;

@end

@implementation MineFirstTableViewCell

#pragma mark - Lazy

#pragma mark - init

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self qw_config];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    }
    return self;
}

#pragma mark - Life Cycle

#pragma mark - Private

- (void)qw_config{
    self.iconImgV = ImageView.fixWH(20, 24);
    self.topicLabel = Label.fixWH(100, 21).fnt(16).color(kCOLOR_33);
    UIView *line = View.fixWH(375,1).bgColor(kWhiteColor);
    
    UIImageView *jiantouImgV = ImageView.fixWH(10, 15);
    
    [self.contentView addSubview:self.iconImgV];
    [self.contentView addSubview:self.topicLabel];
    [self.contentView addSubview:jiantouImgV];
    
    id horView = HorStack(@22, self.iconImgV, @22,self.topicLabel, NERSpring,jiantouImgV, @20);
    VerStack(NERSpring,
             horView,
             NERSpring,
             line).embedIn(self.contentView);
}

#pragma mark - Public

+ (instancetype)showMineFirstTableViewCellWithTableView:(UITableView *)tableView andIndexPath:(NSIndexPath *)indexPath{
    MineFirstTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MineFirstReuse];
    if (!cell) {
        cell = [[MineFirstTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:MineFirstReuse];
    }
    return cell;
}

#pragma mark - Event

#pragma mark - ViewDataSource

#pragma mark - ViewDelegate

#pragma mark - RefreshViewDelegate

#pragma mark - Set & Get

-(void)setDataDict:(NSDictionary *)dataDict{
    self.iconImgV.img(dataDict[@"icon"]);
    self.topicLabel.text = dataDict[@"topic"];
}

@end
