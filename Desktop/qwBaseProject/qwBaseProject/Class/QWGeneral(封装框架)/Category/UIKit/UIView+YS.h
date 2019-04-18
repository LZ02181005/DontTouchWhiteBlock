//
//  UIView+YS.h
//  KYGF
//
//  Created by Magic-Yu on 2017/8/26.
//  Copyright © 2017年 beyondin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (YS)



typedef void (^GestureActionBlock)(UIGestureRecognizer *ges);

@property (nonatomic, assign) CGFloat ys_top;
@property (nonatomic, assign) CGFloat ys_bottom;
@property (nonatomic, assign) CGFloat ys_right;
@property (nonatomic, assign) CGFloat ys_left;
@property (nonatomic, assign) CGFloat ys_width;
@property (nonatomic, assign) CGFloat ys_height;

@property(nonatomic,assign)CGFloat ys_centerX;
@property(nonatomic,assign)CGFloat ys_centerY;


- (void)ys_addPanGesture;

- (void)ys_removeGesture;

/** 单击手势 */
- (void)ys_tapGesture:(GestureActionBlock)block;

/** 构造并设置背景色 */
+ (instancetype)ys_createWithBackgroudColor:(UIColor *)color;

/** xib创建 */
+ (instancetype)ys_createViewFromXib;

/** nib创建 */
+ (UINib *)ys_createViewFromNib;

/**
 添加多个子视图

 @param subviews 视图数组
 */
- (void)ys_addSubviews:(NSArray *)subviews;

/** 点击动画 */
- (void)ys_clickScaleAnimation;
- (void)ys_clickScaleAnimationWithBlock:(void(^)(void))block;

/** 高性能圆角 */
- (void)ys_cornerBySide:(UIRectCorner)corner andLength:(CGFloat)length;

- (void)ys_setRadius:(CGFloat)radius;

/**
 *  设置部分圆角(相对布局)
 *
 *  @param corners 需要设置为圆角的角 UIRectCornerTopLeft | UIRectCornerTopRight | UIRectCornerBottomLeft | UIRectCornerBottomRight | UIRectCornerAllCorners
 *  @param radii   需要设置的圆角大小 例如 CGSizeMake(20.0f, 20.0f)
 *  @param rect    需要设置的圆角view的rect
 */
- (void)ys_addRoundedCorners:(UIRectCorner)corners
                   withRadii:(CGSize)radii
                    viewRect:(CGRect)rect;

- (UIViewController *)ys_getCurrentVC;

/** UIView subview 递归 */
- (void)searchSubViewsWithBlock:(void(^) (UIView *subView))block;

/** xib添加属性 */
@property (nonatomic, assign)IBInspectable CGFloat cornerRadius;
@property (nonatomic, assign)IBInspectable CGFloat borderWidth;
@property (nonatomic, strong)IBInspectable UIColor *borderColor;

- (void)ys_setUserId:(NSInteger)Id;



@end
