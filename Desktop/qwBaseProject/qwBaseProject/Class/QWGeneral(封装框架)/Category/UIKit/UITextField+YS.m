//
//  UITextField+YS.m
//  KYGF
//
//  Created by Magic-Yu on 2017/8/31.
//  Copyright © 2017年 beyondin. All rights reserved.
//

#import "UITextField+YS.h"

@implementation UITextField (YS)

+ (instancetype)ys_textFieldWithTextColor:(UIColor *)color
                                 textFont:(CGFloat)fontSize
                              placeholder:(NSString *)placeholder
{
    
    UITextField *textField = [UITextField new];
    textField.placeholder = placeholder;
    textField.textColor = color;
    
    return textField;
}

- (void)setLeftViewWidth:(CGFloat)width{
    
    self.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, width, 0)];
    self.leftViewMode = UITextFieldViewModeAlways;
    
}



@end
