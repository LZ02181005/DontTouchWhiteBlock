


//
//  RelationPickerView.m
//  qwBaseProject
//
//  Created by L.Ronaldo on 2019/4/13.
//  Copyright © 2019 apple. All rights reserved.
//

#import "RelationPickerView.h"

@interface RelationPickerView()<UIPickerViewDelegate, UIPickerViewDataSource>

///背景View
@property (nonatomic ,strong) UIView *bgView;
///头视控制图
@property (nonatomic ,strong) UIView *headerView;
///完成按钮
@property (nonatomic ,strong) UIButton *doneButton;
///取消按钮
@property (nonatomic ,strong) UIButton *cancelButton;
///选取页面
@property (nonatomic ,strong) UIPickerView *RelationPickerView;

///回调block
@property (nonatomic ,copy) void(^callBackWithTopic)(NSString *topic);

///姓名
@property (nonatomic ,copy) NSString *ContactName;

@end

@implementation RelationPickerView

#pragma mark - Lazy

- (UIView *)bgView
{
    if (_bgView == nil) {
        _bgView = [[UIView alloc] initWithFrame:CGRectMake(0, kSCREEN_HEIGHT - 220, kSCREEN_WIDTH, 220)];
        _bgView.backgroundColor = kWhiteColor;
        [_bgView ys_tapGesture:nil];  // 手势拦截
    }
    return _bgView;
}

- (UIView *)headerView
{
    if (_headerView == nil) {
        _headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kSCREEN_WIDTH, 40)];
        _headerView.backgroundColor = kWhiteColor;
    }
    return _headerView;
}

- (UIButton *)cancelButton
{
    if (_cancelButton == nil) {
        _cancelButton = [UIButton ys_buttonWithTextColor:[UIColor lightGrayColor] font:16 title:@"取消"];
        _cancelButton.frame = CGRectMake(0, 0, 60, 40);
        [_cancelButton ys_handleControlBlock:^{
            [self tap];
        }];
    }
    return _cancelButton;
}

- (UIButton *)doneButton{
    if (_doneButton == nil) {
        _doneButton = [UIButton ys_buttonWithTextColor:[UIColor lightGrayColor] font:16 title:@"确定"];
        _doneButton.frame = CGRectMake(kSCREEN_WIDTH - 60, 0, 60 , 40);
        WeakifySelf()
        [_doneButton ys_tapGesture:^(UIGestureRecognizer *ges) {
            !weakSelf.callBackWithTopic ? : weakSelf.callBackWithTopic(weakSelf.ContactName);
            [weakSelf tap];
        }];
    }
    return _doneButton;
}

- (UIPickerView *)RelationPickerView{
    if (!_RelationPickerView) {
        _RelationPickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 40, kSCREEN_WIDTH, 220 - 40)];
        _RelationPickerView.delegate = self;
        _RelationPickerView.dataSource = self;
        _RelationPickerView.showsSelectionIndicator = YES;
        _RelationPickerView.bgColor(kWhiteColor);
    }
    return _RelationPickerView;
}



#pragma mark - init

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self qw_config];
    }
    return self;
}

- (instancetype)init{
    if (self = [super init]) {
        [self qw_config];
    }
    return self;
}

#pragma mark - Life Cycle

#pragma mark - Private

-(void)qw_config{
    
    self.backgroundColor = [UIColor colorWithRed:111/ 256.0 green:111 / 256.0 blue:111 / 256.0 alpha:0.3];
    
    // 点击隐藏
    [self ys_tapGesture:^(UIGestureRecognizer *ges) {
        [self tap];
    }];
    
    [self addSubview:self.bgView];
    [self.bgView addSubview:self.headerView];
    [self.headerView addSubview:self.doneButton];
    [self.headerView addSubview:self.cancelButton];
    [self.bgView addSubview:self.RelationPickerView];
}

#pragma mark - Public

+ (void)showWithMessageArray:(NSArray *)messageArray RelationCallBack:(void(^)(NSString *topic))callBack{
    RelationPickerView *relationPV = [[RelationPickerView alloc] initWithFrame:CGRectMake(0, 0, kSCREEN_WIDTH, kSCREEN_HEIGHT)];
    relationPV.callBackWithTopic = callBack;
    relationPV.objectArray = messageArray;
    [[UIApplication sharedApplication].keyWindow addSubview:relationPV];
}

#pragma mark - Event
///隐藏方法
- (void)tap{
    
    [UIView animateWithDuration:0.2 animations:^{
        self.alpha = 0.0f;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
    
}

#pragma mark - ViewDataSource

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return self.objectArray.count;
}

- (NSString *)pickerView:(UIPickerView *)pickerView
             titleForRow:(NSInteger)row
            forComponent:(NSInteger)component{
    return self.objectArray[row];
}


#pragma mark - ViewDelegate

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    UILabel *pickerLabel = (UILabel *)view;
    if (!pickerLabel) {
        pickerLabel = Label.bgColor([UIColor clearColor]).fnt(14).centerAlignment;
        pickerLabel.adjustsFontSizeToFitWidth = YES;
    }
    pickerLabel.text = self.objectArray[row];
    return pickerLabel;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    self.ContactName = self.objectArray[row];
}

#pragma mark - RefreshViewDelegate

#pragma mark - Set & Get

@end
