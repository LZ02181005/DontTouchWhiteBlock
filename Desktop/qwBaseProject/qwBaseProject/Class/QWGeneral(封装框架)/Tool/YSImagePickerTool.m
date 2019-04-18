//
//  YSImagePickerTool.m
//  MeetingOnline
//
//  Created by Magic-Yu on 2018/1/11.
//  Copyright © 2018年 Magic-Yu. All rights reserved.
//

#import "YSImagePickerTool.h"
#import <TZImagePickerController/TZImagePickerController.h>

@implementation YSImagePickerTool

+ (void)ys_selectHeadImage:(void(^)(UIImage *headImage))block{
    
    // 打开图片选择
    TZImagePickerController *imagePicker = [[TZImagePickerController alloc] initWithMaxImagesCount:1 delegate:nil];
    
    // 内部显示拍照
    imagePicker.allowTakePicture = YES;
    // 不能选择视频
    imagePicker.allowPickingVideo = NO;
    // 不能选择原图
    imagePicker.allowPickingOriginalPhoto = NO;
    // 不能选择gif
    imagePicker.allowPickingGif = NO;
    // 裁剪
    imagePicker.allowCrop = YES;
    
    // 裁剪尺寸
    CGFloat y = (kSCREEN_HEIGHT - kSCREEN_WIDTH) * 0.5;
    imagePicker.cropRect = CGRectMake(0, y, kSCREEN_WIDTH, kSCREEN_WIDTH);
    
    // 图片排序 NO则照相按钮排第一
    imagePicker.sortAscendingByModificationDate = NO;
    
//    [[Singleton shareInstance].currentVC presentViewController:imagePicker animated:YES completion:nil];
    
    // 回调
    [imagePicker setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto) {
        
        if (block) {
            block(photos[0]);
        }
    }];
    
}



@end
