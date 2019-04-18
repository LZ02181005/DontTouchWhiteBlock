//
//  UIButton+YS.h
//  KYGF
//
//  Created by Magic-Yu on 2017/8/30.
//  Copyright © 2017年 beyondin. All rights reserved.
//

#import <UIKit/UIKit.h>

// 定义一个枚举（包含了四种类型的button）
typedef NS_ENUM(NSUInteger, YSButtonEdgeInsetsStyle) {
    YSButtonEdgeInsetsStyleTop, // image在上，label在下
    YSButtonEdgeInsetsStyleLeft, // image在左，label在右
    YSButtonEdgeInsetsStyleBottom, // image在下，label在上
    YSButtonEdgeInsetsStyleRight // image在右，label在左
};

@interface UIButton (YS)

/**
 *  设置button的titleLabel和imageView的布局样式，及间距
 *
 *  @param style titleLabel和imageView的布局样式
 *  @param space titleLabel和imageView的间距
 */
- (void)ys_layoutButtonWithEdgeInsetsStyle:(YSButtonEdgeInsetsStyle)style
                           imageTitleSpace:(CGFloat)space;



/**
 添加按钮点击缩放效果
 */
- (void)ys_addAnimation;


/**
 按钮点击block
 */
typedef void (^ActionBlock)(void);
@property (readonly) NSMutableDictionary *event;
- (void)ys_handleControlEvent:(UIControlEvents)controlEvent withBlock:(ActionBlock)block;
- (void)ys_handleControlBlock:(ActionBlock)block;
- (void)ys_addAnimationAndHandleControlBlock:(ActionBlock)block;

/**
 文本button构造方法

 @param title 文本
 @param textcolor 文本颜色
 @param fontSize 文本字体
 @return button
 */
+ (instancetype)ys_buttonWithTextColor:(UIColor *)textcolor
                                  font:(CGFloat)fontSize
                                 title:(NSString *)title;

+ (instancetype)ys_buttonWithTextColor:(UIColor *)textcolor
                                  font:(CGFloat)fontSize
                                 title:(NSString *)title
                       backgroundColor:(UIColor *)backgroundColor;



/************************************ 响应区域 ***********************************************/

/**
 *  同时向按钮的四个方向延伸响应面积
 *
 *  @param size 间距
 */
- (void)ys_setEnlargeEdge:(CGFloat) size;

/**
 *  向按钮的四个方向延伸响应面积
 *
 *  @param top    上间距
 *  @param left   左间距
 *  @param bottom 下间距
 *  @param right  右间距
 */
- (void)ys_setEnlargeEdgeWithTop:(CGFloat) top left:(CGFloat) left bottom:(CGFloat) bottom right:(CGFloat) right;

/** 响应区域 */



@end
