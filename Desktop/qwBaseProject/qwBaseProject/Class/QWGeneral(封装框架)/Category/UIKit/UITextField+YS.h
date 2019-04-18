//
//  UITextField+YS.h
//  KYGF
//
//  Created by Magic-Yu on 2017/8/31.
//  Copyright © 2017年 beyondin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextField (YS)



/**
 构造方法

 @param placeholder 占位文字
 @param color 文字颜色
 @param fontSize 字体
 @return 实例对象
 */
+ (instancetype)ys_textFieldWithTextColor:(UIColor *)color
                                 textFont:(CGFloat)fontSize
                              placeholder:(NSString *)placeholder;


- (void)setLeftViewWidth:(CGFloat)width;

@end
