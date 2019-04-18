//
//  UIView+YS.m
//  KYGF
//
//  Created by Magic-Yu on 2017/8/26.
//  Copyright © 2017年 beyondin. All rights reserved.
//

#import "UIView+YS.h"
#import <objc/runtime.h>
//#import "YSUserCenterViewController.h"

@implementation UIView (YS)

- (CGFloat)ys_top
{
    return self.frame.origin.y;
}

- (void)setYs_top:(CGFloat)ys_top{
    CGRect frame = self.frame;
    frame.origin.y = ys_top;
    self.frame = frame;
}


- (CGFloat)ys_right
{
    return self.frame.origin.x + self.frame.size.width;
}

- (void)setYs_right:(CGFloat)ys_right{
    CGRect frame = self.frame;
    frame.origin.x = ys_right - self.frame.size.width;
    self.frame = frame;
}

- (CGFloat)ys_bottom
{
    return self.frame.origin.y + self.frame.size.height;
}

- (void)setYs_bottom:(CGFloat)ys_bottom{
    CGRect frame = self.frame;
    frame.origin.y = ys_bottom - self.frame.size.height;
    self.frame = frame;
}


- (CGFloat)ys_left
{
    return self.frame.origin.x;
}

- (void)setYs_left:(CGFloat)ys_left{
    CGRect frame = self.frame;
    frame.origin.x = ys_left;
    self.frame = frame;
}

- (CGFloat)ys_width
{
    return self.frame.size.width;
}

- (void)setYs_width:(CGFloat)ys_width{
    CGRect frame = self.frame;
    frame.size.width = ys_width;
    self.frame = frame;
}
- (void)setYs_centerX:(CGFloat)ys_centerX{
    CGPoint  center=self.center;
    center.x = ys_centerX;
    self.center=center;
}

-(CGFloat)ys_centerX
{
    return self.center.x;
}


- (void)setYs_centerY:(CGFloat)ys_centerY{
    CGPoint center = self.center;
    center.y = ys_centerY;
    self.center = center;
}

-(CGFloat)ys_centerY
{
    return self.center.y;
}

- (CGFloat)ys_height
{
    return self.frame.size.height;
}

- (void)setYs_height:(CGFloat)ys_height{
    CGRect frame = self.frame;
    frame.size.height = ys_height;
    self.frame = frame;
}


/** 构造并设置背景色 */
+ (instancetype)ys_createWithBackgroudColor:(UIColor *)color{
    
    UIView *view = [UIView new];
    
    view.backgroundColor = color;
    
    return view;
}

/** UIView subview 递归 */
- (void)searchSubViewsWithBlock:(void(^) (UIView *subView))block{
    
    for (int i = 0; i < self.subviews.count; i++) {
        
        UIView * subView = self.subviews[i];
        
        [subView searchSubViewsWithBlock:block];

        block(subView);

        
    }
    
}



- (void)ys_clickScaleAnimation
{
    // 点击动画
    [self ys_clickScaleAnimationWithBlock:nil];
    
}

- (void)ys_clickScaleAnimationWithBlock:(void(^)(void))block
{
    // 点击动画
    [UIView animateWithDuration:0.1 animations:^{
        self.layer.transform = CATransform3DMakeScale(0.95, 0.95, 1);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.1 animations:^{
            self.layer.transform = CATransform3DMakeScale(1, 1, 1);
        } completion:^(BOOL finished) {
            if (block) {
                block();
            }
        }];
    }];
}

- (void)ys_cornerBySide:(UIRectCorner)corner andLength:(CGFloat)length
{
    /** 单边圆角 */
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:corner cornerRadii:CGSizeMake(length, length)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = self.bounds;
    maskLayer.path = maskPath.CGPath;
    self.layer.mask = maskLayer;
    
}

/**
 *  设置部分圆角(相对布局)
 *
 *  @param corners 需要设置为圆角的角 UIRectCornerTopLeft | UIRectCornerTopRight | UIRectCornerBottomLeft | UIRectCornerBottomRight | UIRectCornerAllCorners
 *  @param radii   需要设置的圆角大小 例如 CGSizeMake(20.0f, 20.0f)
 *  @param rect    需要设置的圆角view的rect
 */
- (void)ys_addRoundedCorners:(UIRectCorner)corners
                   withRadii:(CGSize)radii
                    viewRect:(CGRect)rect {
    
    UIBezierPath* rounded = [UIBezierPath bezierPathWithRoundedRect:rect byRoundingCorners:corners cornerRadii:radii];
    CAShapeLayer* shape = [[CAShapeLayer alloc] init];
    [shape setPath:rounded.CGPath];
    
    self.layer.mask = shape;
}


- (CGFloat)cornerRadius
{
    return [objc_getAssociatedObject(self, @selector(cornerRadius)) floatValue];
}
- (void)setCornerRadius:(CGFloat)cornerRadius
{
    self.layer.cornerRadius = cornerRadius;
    self.layer.masksToBounds = YES;
}


- (CGFloat)borderWidth
{
    return [objc_getAssociatedObject(self, @selector(borderWidth)) floatValue];
}
- (void)setBorderWidth:(CGFloat)borderWidth
{
    self.layer.borderWidth = borderWidth;
    self.layer.masksToBounds = YES;
}


- (UIColor *)borderColor
{
    return objc_getAssociatedObject(self, @selector(borderColor));
}
- (void)setBorderColor:(UIColor *)borderColor
{
    self.layer.borderColor = borderColor.CGColor;
}

- (void)ys_setRadius:(CGFloat)radius
{
    
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:UIRectCornerAllCorners cornerRadii:CGSizeMake(radius, radius)];
    
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc]init];
    //设置大小
    maskLayer.frame = self.bounds;
    //设置图形样子
    maskLayer.path = maskPath.CGPath;
    self.layer.mask = maskLayer;
    
}

static char kActionHandlerTapBlockKey;
static char kActionHandlerTapGestureKey;
//static char kActionHandlerLongPressBlockKey;
//static char kActionHandlerLongPressGestureKey;


//单点击手势
- (void)ys_tapGesture:(GestureActionBlock)block {
    self.userInteractionEnabled = YES;
    UITapGestureRecognizer *gesture = objc_getAssociatedObject(self, &kActionHandlerTapGestureKey);
    if (!gesture) {
        gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleActionForTapGesture:)];
        [self addGestureRecognizer:gesture];
        objc_setAssociatedObject(self, &kActionHandlerTapGestureKey, gesture, OBJC_ASSOCIATION_RETAIN);
    }
    objc_setAssociatedObject(self, &kActionHandlerTapBlockKey, block, OBJC_ASSOCIATION_COPY);
}


- (void)handleActionForTapGesture:(UITapGestureRecognizer *)gesture {
    if (gesture.state == UIGestureRecognizerStateRecognized) {
        GestureActionBlock block = objc_getAssociatedObject(self, &kActionHandlerTapBlockKey);
        if (block) {
            block(gesture);
        }
    }
}

- (UIViewController *)ys_getCurrentVC
{
    UIResponder *responser = [self nextResponder];
    do {
        if ([responser isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)responser;
        }
        responser = [responser nextResponder];
    } while (responser != nil);
    return nil;
}


- (void)ys_addSubviews:(NSArray *)subviews{
    
    [subviews enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
       
        if ([obj isKindOfClass:[UIView class]]) {
            [self addSubview:obj];
        }
        
    }];
    
}

+ (UINib *)ys_createViewFromNib{
    return [UINib nibWithNibName:NSStringFromClass(self.class) bundle:nil];
}

+ (instancetype)ys_createViewFromXib
{
    return [self createViewFromXibName:NSStringFromClass(self.class)];
}


+ (instancetype)createViewFromXibName:(NSString *)xibName
{
    NSArray *nib = [[NSBundle mainBundle] loadNibNamed:xibName owner:self options:nil];
    return [nib objectAtIndex:0];
}


- (void)ys_addPanGesture{
    
    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(didPan:)];
    
    [self addGestureRecognizer:panGesture];
}

- (void)ys_removeGesture{
    
}

- (void)didPan:(UIPanGestureRecognizer *)gesture {
    UIWindow *superView = [UIApplication sharedApplication].delegate.window;
    CGPoint position = [gesture locationInView:superView];
    
    switch (gesture.state) {
        case UIGestureRecognizerStateBegan:
        {
            self.alpha = 0.5;
        }
            break;
            
        case UIGestureRecognizerStateChanged:
        {
            self.center = position;
        }
            break;
            
        case UIGestureRecognizerStateEnded:
        {
            
            [self layoutIfNeeded];
            
            if (self.ys_left < 0) {
                self.ys_left = 0;
            }
            
            if (self.ys_top < 0) {
                self.ys_top = 0;
            }
            
            
            if (self.ys_right > self.superview.ys_width) {
                
                self.ys_right = self.superview.ys_width;
                
            }
            
            if (self.ys_bottom > self.superview.ys_height) {
                self.ys_bottom = self.superview.ys_height;
            }
           
            self.alpha = 1.0f;
        }
            break;
            
        default:
            break;
    }
}

- (void)ys_setUserId:(NSInteger)Id{
    self.onClick(^{
//        YSUserCenterViewController *vc = [YSUserCenterViewController new];
//        vc.ID = Id;
//        kPUSH(vc);
    });
}

@end
