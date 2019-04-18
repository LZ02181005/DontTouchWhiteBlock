//
//  UploadImageApi.h
//  ZhiYou
//
//  Created by 崔露凯 on 15/11/24.
//  Copyright © 2015年 崔露凯. All rights reserved.
//

#import "BaseApi.h"

@interface UploadImageApi : BaseApi

@property(nonatomic,copy) NSString *baseUrl;

+(instancetype)shareMassage;
/**
 上传图片Api
 
 @param imageData 图片数据
 @param callback 回调
 */
- (void)uploadImageWithData:(NSData*)imageData callback:(ApiRequestCallBack)callback;


/**
 上传视频Api
 
 @param videoData 视频数据
 @param callback 回调
 */
- (void)uploadVideoWithData:(NSData *)videoData callback:(ApiRequestCallBack)callback;


@end
