//
//  UILabel+YS.m
//  KYGF
//
//  Created by Magic-Yu on 2017/8/30.
//  Copyright © 2017年 beyondin. All rights reserved.
//

#import "UILabel+YS.h"
#import <objc/runtime.h>




@implementation UILabel (YS)

+ (UILabel *)ys_labelWithTextColor:(UIColor *)textColor
                          textFont:(CGFloat)textFont
                              text:(NSString *)text{
    
    UILabel *label = [[UILabel alloc] init];
    label.text = text;
    label.textColor = textColor;
    
    
    return label;
    
}

+ (UILabel *)ys_labelWithTextColor:(UIColor *)textColor
                      boldTextFont:(CGFloat)textFont
                              text:(NSString *)text{
    UILabel *label = [[UILabel alloc] init];
    label.text = text;
    label.textColor = textColor;
    
    
    return label;
}









@end
