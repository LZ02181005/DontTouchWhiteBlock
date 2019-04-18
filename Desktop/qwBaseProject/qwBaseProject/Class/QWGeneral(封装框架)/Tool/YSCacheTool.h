//
//  YSCacheTool.h
//  LBMall
//
//  Created by Magic-Yu on 2018/3/10.
//  Copyright © 2018年 Magic-Yu. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface YSCacheTool : NSObject

@property (nonatomic, copy) NSString *fileCachePath;

typedef void(^cleanCacheBlock)(void);
+ (CGFloat)folderSizeAtPath;
+ (void)cleanCache:(cleanCacheBlock)block;

@end
