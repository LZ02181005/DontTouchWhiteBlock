//
//  UIColor+YS.h
//  KYGF
//
//  Created by Magic-Yu on 2017/8/26.
//  Copyright © 2017年 beyondin. All rights reserved.
//

#import <UIKit/UIKit.h>


/** 项目自定义部分 */
#define kAPP_MAIN_COLOR kHEX(@"#FA653C")
#define kBLUE kHEX(@"#45BFFF")
#define kRED kHEX(@"#FF5F5F")
#define kCOLOR_33 kHEXG(@"#33")
#define kCOLOR_66 kHEXG(@"#66")
#define kCOLOR_99 kHEXG(@"#99")
#define kBACKGROUND_GRAY kHEXG(@"#F4")
#define kLOGINGROUND_GRAY kHEXG(@"EBEBEB")


#define keypath2(OBJ, PATH) \
(((void)(NO && ((void)OBJ.PATH, NO)), # PATH))

/** 项目自定义部分 */


// 创建带透明度的RGB色
#define kRGBA(r, g, b, a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]

// 创建alpha为1的RGB色
#define kRGB(r, g, b) kRGBA(r, g, b, 1)

// 创建alpha为1的灰度色
#define kRGBG(r) kRGB(r, r, r)

#define kALPHA(c, a) [c ys_colorWithAlpha:a]

#define kHEX(h) [UIColor ys_colorWithHexString:h]
#define kHEXG(h) [UIColor ys_colorWithGrayHexString:h]


// 系统颜色
#define kWhiteColor [UIColor whiteColor]
#define kBlackColor [UIColor blackColor]
#define kClearColor [UIColor clearColor]
#define kSystemBlue [UIColor blueColor]

@interface UIColor (YS)


/**
 根据颜色的16进制表示获取

 @param hexString 16进制颜色字符串
 @return 颜色
 */
+ (UIColor *)ys_colorWithHexString:(NSString *)hexString;
+ (UIColor *)ys_colorWithGrayHexString:(NSString *)grayhexString;

/**
 根据颜色创建图片

 @param color 颜色
 @return 图片
 */
+ (UIImage *)ys_createImageWithColor:(UIColor *)color;
+ (UIImage *)ys_createImageWithColor:(UIColor *)color andHeight:(CGFloat)height;


/**
 改变已有颜色的透明度

 @param alpha 透明度
 @return 颜色
 */
- (instancetype)ys_colorWithAlpha:(CGFloat)alpha;



@end
