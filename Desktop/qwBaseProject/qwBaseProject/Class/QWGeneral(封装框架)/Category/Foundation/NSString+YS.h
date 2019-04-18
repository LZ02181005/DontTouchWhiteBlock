//
//  NSString+YS.h
//  KYGF
//
//  Created by Magic-Yu on 2017/9/26.
//  Copyright © 2017年 beyondin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (YS)


/**
 NSString 转 NSDate

 @param format 格式
 @return date
 */
- (NSDate *)dateWithFormat:(NSString *)format;

/**
 NSDate 转 NSString

 @param date date
 @param format 格式
 @return 回调
 */
+ (NSString *)ys_stringWithDate:(NSDate *)date format:(NSString *)format;



/**
 时间戳转NSString

 @param timestamp 时间戳
 @param format 格式
 @return 字符串
 */
+ (NSString *)ys_stringWithTimestamp:(NSTimeInterval)timestamp format:(NSString *)format;



/**
 时间戳转NSString

 @param timestamp 时间戳
 @return 字符串 一小时前, 昨天 ,前天, 2011-11-11
 */
+ (NSString *)ys_timeDesWithTimestamp:(NSTimeInterval)timestamp format:(NSString *)format;


/**
 判断一个urlStr 时候包涵http的头,若无则拼接Domian

 @return 添加后的字符串
 */
- (NSString *)dealDomainPrefix;


/**
 反序列化Json

 @return Json
 */
- (id)ys_deserializeMessageJSON;

/**
 pinyin

 @return pinyin
 */
- (NSString *)pinyin;

/**
 字典&数组转模型

 @param obj 字典&数组
 @return json
 */
+ (NSString *)ys_object2Json:(id)obj;


/**
 json转字典

 @return 字典
 */
- (NSDictionary *)ys_dictByJsonString;



/**
 json合并

 @param json1 json1
 @param json2 json2
 @return 合并结果
 */
+ (NSString *)ys_addJsonWithJson1:(NSString *)json1 json2:(NSString *)json2;

/**
 移除最后一个字符

 @return 实例
 */
- (NSString *)ys_removeLast;


/**
 数字转字符串  1,100 -> 1.1k  12,300,000 -> 12.3m

 @param num 数组
 @return 字符
 */
+ (NSString *)ys_num2str:(CGFloat)num;


/**
 去除空格回车

 @return 处理后数据
 */
- (NSString *)ys_removeWhite;

/** 域名完整化 */
- (NSString *)ys_urlWithDomain;

+ (NSString *)stringDic:(NSDictionary *)dic;

NSString * String(NSString *format, ...);

@end
