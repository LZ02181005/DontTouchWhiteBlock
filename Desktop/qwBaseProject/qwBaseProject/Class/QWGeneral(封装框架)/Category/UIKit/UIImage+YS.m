//
//  UIImage+YS.m
//  KYGF
//
//  Created by Magic-Yu on 2017/10/17.
//  Copyright © 2017年 beyondin. All rights reserved.
//

#import "UIImage+YS.h"
#import <Accelerate/Accelerate.h>

@implementation UIImage (YS)

+ (UIImage *)ys_blurImage:(UIImage *)image withBlurNumber:(CGFloat)blur{
    
    if (!image) {
        return nil;
    }
    
    if (blur < 0.f || blur > 1.f) {
        blur = 0.5f;
    }
    
    int boxSize     = (int)(blur * 100); //100为最大模糊程度
    boxSize         = boxSize - (boxSize % 2) + 1;
    CGImageRef img  = image.CGImage;
    
    vImage_Buffer     inBuffer, outBuffer;
    vImage_Error      error;
    
    //从CGImage中获取数据
    CGDataProviderRef inProvider = CGImageGetDataProvider(img);
    CFDataRef inBitmapData       = CGDataProviderCopyData(inProvider);
    
    //设置从CGImage获取对象的属性
    void *pixelBuffer;
    inBuffer.width      = CGImageGetWidth(img);
    inBuffer.height     = CGImageGetHeight(img);
    inBuffer.rowBytes   = CGImageGetBytesPerRow(img);
    inBuffer.data       = (void*)CFDataGetBytePtr(inBitmapData);
    pixelBuffer         = malloc(CGImageGetBytesPerRow(img) * CGImageGetHeight(img));
    if(!pixelBuffer)
        NSLog(@"No pixelbuffer");
    outBuffer.data      = pixelBuffer;
    outBuffer.width     = CGImageGetWidth(img);
    outBuffer.height    = CGImageGetHeight(img);
    outBuffer.rowBytes  = CGImageGetBytesPerRow(img);
    error = vImageBoxConvolve_ARGB8888(&inBuffer,
                                       &outBuffer,
                                       NULL,
                                       0,
                                       0,
                                       boxSize,
                                       boxSize,
                                       NULL,
                                       kvImageEdgeExtend);
    if (error) {
        NSLog(@"error from convolution %ld", error);
    }
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef ctx = CGBitmapContextCreate( outBuffer.data,
                                             outBuffer.width,
                                             outBuffer.height,
                                             8,
                                             outBuffer.rowBytes,
                                             colorSpace,
                                             kCGImageAlphaNoneSkipLast);
    CGImageRef imageRef  = CGBitmapContextCreateImage (ctx);
    UIImage *returnImage = [UIImage imageWithCGImage:imageRef];
    
    //清除;
    CGContextRelease(ctx);
    CGColorSpaceRelease(colorSpace);
    free(pixelBuffer);
    CFRelease(inBitmapData);
    CGImageRelease(imageRef);
    
    return returnImage;
}



- (UIImage *)ys_zipWithMaxSize:(CGFloat)maxSize{
    
    if (self.size.width < maxSize && self.size.height < maxSize) {
        return self;
    }
    
    // 图片压缩
    CGFloat ratio = self.size.width / self.size.height;
    CGSize newSize;
    if (ratio > 1) {
        newSize = CGSizeMake(maxSize, maxSize / ratio);
    }else{
        newSize = CGSizeMake(maxSize * ratio, maxSize);
    }
    UIGraphicsBeginImageContext(newSize);
    [self drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    
    return scaledImage;
}


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
+ (UIImage *)ys_imageQRCodeWithContent:(NSString *)content bigImageSize:(CGFloat)bigImageSize smallImage:(UIImage *)smallImage smallImageSize:(CGFloat)smallImageSize
{
    // 1.将要生成的内容转码为UTF8编码
    NSData *strData = [content dataUsingEncoding:NSUTF8StringEncoding];
    
    // 1.创建一个二维码滤镜
    CIFilter *filter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    
    // 1.1 恢复滤镜默认设置
    [filter setDefaults];
    
    // 2.设置滤镜的输入内容
    // 如果要给滤镜设置输入数据,只能使用KVC设置. key: inputMessage
    // 输入的数据只能传递NSData
    [filter setValue:strData forKey:@"inputMessage"];
    
    // 2.1 设置二维码的纠错率 key: inputCorrectionLevel
    // 纠错率等级: L, M, Q, H
    [filter setValue:@"H" forKey:@"inputCorrectionLevel"];
    
    // 3.直接从二维码滤镜中获取需要的二维码图片
    CIImage *image = [filter outputImage];
    
    // 3.1 默认生成的二维码尺寸为 23x23 ,需要借助位图来处理方法图片, 获取一个高清的图片
    UIImage *newImage = [self ys_createNonInterpolatedUIImageFormCIImage:image withSize:bigImageSize];
    
    // 3.2 判断是否有小图标,如果有小图标,合成小图标
    if (smallImage != nil) {
        newImage = [self ys_createImageBigImage:newImage smallImage:smallImage sizeWH:smallImageSize];
    }
    
    return newImage;
}

/**
 *  根据两个图片,合成一个大图片
 *
 *  @param bigImage   大图的背景图片
 *  @param smallImage 小图标(居中)
 *  @param sizeWH     小图标的尺寸
 *
 *  @return 合成后的图片
 */
+ (UIImage *)ys_createImageBigImage:(UIImage *)bigImage smallImage:(UIImage *)smallImage sizeWH:(CGFloat)sizeWH
{
    CGSize size = bigImage.size;
    
    // 1.开启一个图形山下文
    UIGraphicsBeginImageContext(size);
    
    // 2.绘制大图片
    [bigImage drawInRect:CGRectMake(0, 0, size.width, size.height)];
    
    // 3.绘制小图片
    CGFloat x = (size.width - sizeWH) * 0.5;
    CGFloat y = (size.height - sizeWH) *0.5;
    [smallImage drawInRect:CGRectMake(x, y, sizeWH, sizeWH)];
    
    // 4.取出合成图片
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // 5.关闭图形上下文
    UIGraphicsEndImageContext();
    
    return newImage;
}

/**
 *  根据CIImage生成指定大小的UIImage
 *
 *  @param image CIImage
 *  @param size  图片宽度
 */
+ (UIImage *)ys_createNonInterpolatedUIImageFormCIImage:(CIImage *)image withSize:(CGFloat) size
{
    CGRect extent = CGRectIntegral(image.extent);
    CGFloat scale = MIN(size/CGRectGetWidth(extent), size/CGRectGetHeight(extent));
    
    // 1.创建bitmap;
    size_t width = CGRectGetWidth(extent) * scale;
    size_t height = CGRectGetHeight(extent) * scale;
    CGColorSpaceRef cs = CGColorSpaceCreateDeviceGray();
    CGContextRef bitmapRef = CGBitmapContextCreate(nil, width, height, 8, 0, cs, (CGBitmapInfo)kCGImageAlphaNone);
    CIContext *context = [CIContext contextWithOptions:nil];
    CGImageRef bitmapImage = [context createCGImage:image fromRect:extent];
    CGContextSetInterpolationQuality(bitmapRef, kCGInterpolationNone);
    CGContextScaleCTM(bitmapRef, scale, scale);
    CGContextDrawImage(bitmapRef, extent, bitmapImage);
    
    // 2.保存bitmap到图片
    CGImageRef scaledImage = CGBitmapContextCreateImage(bitmapRef);
    CGContextRelease(bitmapRef);
    CGImageRelease(bitmapImage);
    return [UIImage imageWithCGImage:scaledImage];
}

#pragma mark ----- 图片拉伸
+ (UIImage *)ys_resizableImage:(NSString *)nameImage{
    
    UIImage *image = [UIImage imageNamed:nameImage];
    
    image = [image resizableImageWithCapInsets:UIEdgeInsetsMake(image.size.height * 0.5, image.size.width * 0.5, image.size.height * 0.5 - 1, image.size.width * 0.5 - 1) resizingMode:UIImageResizingModeTile];
    
    return image;
}




+(NSData *)ys_zipNSDataWithImage:(UIImage *)sourceImage{
    //进行图像尺寸的压缩
    CGSize imageSize = sourceImage.size;//取出要压缩的image尺寸
    CGFloat width = imageSize.width;    //图片宽度
    CGFloat height = imageSize.height;  //图片高度
    //1.宽高大于1280(宽高比不按照2来算，按照1来算)
    if (width>1280) {
        if (width>height) {
            CGFloat scale = width/height;
            height = 1280;
            width = height*scale;
        }else{
            CGFloat scale = height/width;
            width = 1280;
            height = width*scale;
        }
        //2.高度大于1280
    }else if(height>1280){
        CGFloat scale = height/width;
        width = 1280;
        height = width*scale;
    }else{
    }
    UIGraphicsBeginImageContext(CGSizeMake(width, height));
    [sourceImage drawInRect:CGRectMake(0,0,width,height)];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    //进行图像的画面质量压缩
    NSData *data=UIImageJPEGRepresentation(newImage, 1.0);
    if (data.length>100*1024) {
        if (data.length>1024*1024) {//1M以及以上
            data=UIImageJPEGRepresentation(newImage, 0.7);
        }else if (data.length>512*1024) {//0.5M-1M
            data=UIImageJPEGRepresentation(newImage, 0.8);
        }else if (data.length>200*1024) {
            //0.25M-0.5M
            data=UIImageJPEGRepresentation(newImage, 0.9);
        }
    }
    return data;
}



@end
