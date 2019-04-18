//
//  UILabel+YS.h
//  KYGF
//
//  Created by Magic-Yu on 2017/8/30.
//  Copyright © 2017年 beyondin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (YS)


/**
 label生成

 @param text 文本内容
 @param textColor 文本颜色
 @param textFont 文本字体
 @return label
 */
+ (UILabel *)ys_labelWithTextColor:(UIColor *)textColor
                          textFont:(CGFloat)textFont
                              text:(NSString *)text;


+ (UILabel *)ys_labelWithTextColor:(UIColor *)textColor
                      boldTextFont:(CGFloat)textFont
                              text:(NSString *)text;




@end
