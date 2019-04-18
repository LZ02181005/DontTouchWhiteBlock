//
//  YSImagePickerTool.h
//  MeetingOnline
//
//  Created by Magic-Yu on 2018/1/11.
//  Copyright © 2018年 Magic-Yu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YSImagePickerTool : NSObject



+ (void)ys_selectHeadImage:(void(^)(UIImage *headImage))block;

//- (void)selectImagesWithMaxCount:(void(^)(NSArray<UIImage *> *images))block;

@end
