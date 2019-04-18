//
//  UIImage+YS.h
//  KYGF
//
//  Created by Magic-Yu on 2017/10/17.
//  Copyright © 2017年 beyondin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (YS)


/**
 高斯模糊
 @param image image
 @param blur (0 - 1 之间)
 @return image
 */
+ (UIImage *)ys_blurImage:(UIImage *)image withBlurNumber:(CGFloat)blur;


/**
 降低分辨率

 @param maxSize 最大边像素
 @return 压缩后的图片
 */
- (UIImage *)ys_zipWithMaxSize:(CGFloat)maxSize;

/**
 *  根据外界传递过来的内容, 生成一个二维码图片, 并且, 可以根据参数, 添加小头像,在生成后的二维码中间
 *
 *  @param content        二维码内容
 *  @param bigImageSize   大图片的尺寸
 *  @param smallImage     小图片
 *  @param smallImageSize 小图片的尺寸
 *
 *  @return 合成后的二维码图片
 */
+ (UIImage *)ys_imageQRCodeWithContent:(NSString *)content bigImageSize:(CGFloat)bigImageSize smallImage:(UIImage *)smallImage smallImageSize:(CGFloat)smallImageSize;


/**
 将一张图片拉伸

 @param nameImage 图片名称
 @return 返回一个拉伸的图片
 */
+ (UIImage *)ys_resizableImage:(NSString *)nameImage;


/**
 对图片进行压缩处理

 @param sourceImage 原图片
 @return 压缩后的图片
 */
+(NSData *)ys_zipNSDataWithImage:(UIImage *)sourceImage;




@end
