//
//  YSBaseViewController.h
//  MToy
//
//  Created by Magic-Yu on 2017/10/21.
//  Copyright © 2017年 beyondin. All rights reserved.
//
//
// @class YSBaseViewController
// @abstract 控制器基类
// @discussion 侧滑返回手势
//


#import <UIKit/UIKit.h>


@interface YSBaseViewController : UIViewController

// 创建与self.view 等大的scrollview 并在上添加一个view 布满scrollview的contentSize
- (void)createContentView;

@property (nonatomic, strong) UIView *contentView;

@end
