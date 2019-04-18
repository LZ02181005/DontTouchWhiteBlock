//
//  UploadImageApi.m
//  ZhiYou
//
//  Created by 崔露凯 on 15/11/24.
//  Copyright © 2015年 崔露凯. All rights reserved.
//

#import "UploadImageApi.h"


@implementation UploadImageApi

+(instancetype)shareMassage{
    static UploadImageApi *uploadApi;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (!uploadApi) {
            uploadApi = [UploadImageApi new];
            uploadApi.baseUrl = kHttpDomain;
        }
    });
    return uploadApi;
}

- (void)uploadImageWithData:(NSData *)imageData callback:(ApiRequestCallBack)callback {
    if (imageData == nil) {
        return;
    }
    
    NSString *uploadImgApi = [NSString stringWithFormat:@"%@/api/uploadImage/appid/1/submit/submit",kHttpDomain];
    HttpRequestTool *adapter = [HttpRequestTool shareManage];
//    adapter.type = UploadTypeImage;
    [adapter asynPostUploadWithUrl:uploadImgApi apiMethod:@"" parameters:nil fileData:imageData success:^(id responseObj) {
        if ([responseObj[@"code"] integerValue] == 0) {
            callback(kPASS_NULL_TO_NIL(responseObj[@"file_path"]),0);
            [[SDImageCache sharedImageCache]storeImageDataToDisk:imageData forKey:responseObj[@"file_path"]];//存储数据
        }
        else {
            callback(responseObj, 1);
        }
    } failure:^(NSError *error) {
        callback(nil, 1);
    }];
    
}

- (void)uploadVideoWithData:(NSData *)videoData callback:(ApiRequestCallBack)callback {
    if (videoData == nil) {
        return;
    }
    NSString *uploadImgApi = [NSString stringWithFormat:@"%@/api/uploadVideo/appid/1/submit/submit",kHttpDomain];

    HttpRequestTool *adapter = [HttpRequestTool shareManage];
   // adapter.type = UploadTypeVideo;
    [adapter asynPostUploadWithUrl:uploadImgApi apiMethod:@"" parameters:nil fileData:videoData success:^(id responseObj) {
        if ([responseObj[@"code"] integerValue] == 0) {
           callback(kPASS_NULL_TO_NIL(responseObj[@"file_path"]),0);
        }
        else {
            callback(responseObj, 1);
        }
    } failure:^(NSError *error) {
        callback(nil, 1);
    }];

}

@end
