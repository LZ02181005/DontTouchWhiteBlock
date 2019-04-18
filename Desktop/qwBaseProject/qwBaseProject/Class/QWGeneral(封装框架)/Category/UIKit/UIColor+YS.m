//
//  UIColor+YS.m
//  KYGF
//
//  Created by Magic-Yu on 2017/8/26.
//  Copyright © 2017年 beyondin. All rights reserved.
//

#import "UIColor+YS.h"



@implementation UIColor (YS)

+ (UIColor *)ys_colorWithHexString:(NSString *)hexString {
    
    NSString *cString = [[hexString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    
    if ([cString length] < 6)
    {
        return [UIColor whiteColor];
    }
    
    if ([cString hasPrefix:@"#"]) {
        cString = [cString substringFromIndex:1];
    }
    
    
    if ([cString length] != 6)
    {
        return [UIColor whiteColor];
    }
    
    NSRange range;
    range.location = 0;
    range.length = 2;
    NSString *rString = [cString substringWithRange:range];
    
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    UIColor *resultColor = kRGB(r, g, b);
    
    return resultColor;
}

+ (UIColor *)ys_colorWithGrayHexString:(NSString *)grayhexString{
    grayhexString = [grayhexString stringByReplacingOccurrencesOfString:@"#" withString:@""];
    grayhexString = [[grayhexString stringByAppendingString:grayhexString] stringByAppendingString:grayhexString];
    grayhexString = [NSString stringWithFormat:@"#%@", grayhexString];
    
    return [UIColor ys_colorWithHexString:grayhexString];
    
}


+ (UIImage *)ys_createImageWithColor:(UIColor *)color{
    return [self ys_createImageWithColor:color andHeight:1.0];
}

+ (UIImage *)ys_createImageWithColor:(UIColor *)color andHeight:(CGFloat)height{
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}




+ (UIColor *)ys_colorWithUIColor:(UIColor *)color alpha:(CGFloat)alpha {
    
    const CGFloat *components = CGColorGetComponents(color.CGColor);
    
    CGFloat r = components[0];
    CGFloat g = components[1];
    CGFloat b = components[2];
    
    return [UIColor colorWithRed:r green:g blue:b alpha:alpha];
}

- (instancetype)ys_colorWithAlpha:(CGFloat)alpha{
    CGFloat components[3];
    [self getRGBComponents:components forColor:self];
    
    CGFloat r = components[0];
    CGFloat g = components[1];
    CGFloat b = components[2];
    
    return kRGBA(r, g, b, alpha);
    
}



/**
 *  指定颜色，获取颜色的RGB值
 *
 *  @param components RGB数组
 *  @param color      颜色
 */
- (void)getRGBComponents:(CGFloat [3])components forColor:(UIColor *)color {
    CGColorSpaceRef rgbColorSpace = CGColorSpaceCreateDeviceRGB();
    unsigned char resultingPixel[4];
    CGContextRef context = CGBitmapContextCreate(&resultingPixel, 1, 1, 8, 4, rgbColorSpace, 1);
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, CGRectMake(0, 0, 1, 1));
    CGContextRelease(context);
    CGColorSpaceRelease(rgbColorSpace);
    for (int component = 0; component < 3; component++) {
        components[component] = resultingPixel[component] / 255.0f;
    }
}

@end
