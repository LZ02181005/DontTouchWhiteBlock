//
//  LXBannerView.h
//  qwBaseProject
//
//  Created by L.Ronaldo on 2019/4/16.
//  Copyright © 2019 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class LXBannerView;
@protocol BannerViewDelegate <NSObject>

- (void) carouselTouch:(LXBannerView *)carousel atIndex:(NSUInteger)index;

@end

@interface LXBannerView : UIView

///点击的回调block
@property (nonatomic ,copy) void(^bannerTouchBlock)(NSUInteger index);
@property (nonatomic ,weak) id<BannerViewDelegate> delegate;

- (instancetype)initWithFrame:(CGRect)frame;

/**
 *  轮播图url数组
 */
- (void) setupWithArray:(NSArray *)array;

/**
 *  本地图片数组
 */
- (void) setupWithLocalArray:(NSArray *)array;

/**
 *  类初始化方法
 */

+ (instancetype)initWithFrame:(CGRect)frame
                    withArray:(NSArray *)array
                     hasTimer:(BOOL)hastimer
                     interval:(NSUInteger)inter;

+ (instancetype)initWithFrame:(CGRect)frame
                     hasTimer:(BOOL)hastimer
                     interval:(NSUInteger)inter
                  placeHolder:(UIImage *)image;

@end

NS_ASSUME_NONNULL_END
