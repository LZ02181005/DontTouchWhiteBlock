//
//  NSString+YS.m
//  KYGF
//
//  Created by Magic-Yu on 2017/9/26.
//  Copyright © 2017年 beyondin. All rights reserved.
//

#import "NSString+YS.h"
#import "GlobalAccess.h"

@implementation NSString (YS)


- (NSDate *)dateWithFormat:(NSString *)format{
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:format];
    
    NSDate *date = [formatter dateFromString:self];
    return date;
}

+ (NSString *)ys_stringWithDate:(NSDate *)date format:(NSString *)format{
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:format];
    dateFormatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en"]; //NSLocale(localeIdentifier: "en")
    
    return [dateFormatter stringFromDate:date];
}


+ (NSString *)ys_stringWithTimestamp:(NSTimeInterval)timestamp format:(NSString *)format{
    
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:timestamp];
    
    NSString *time = [NSString ys_stringWithDate:date format:format];
    
    return time;
    
}

+ (NSString *)ys_timeDesWithTimestamp:(NSTimeInterval)timestamp format:(NSString *)format{
    
    NSDate *now = [NSDate date];
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:timestamp];
    
    NSTimeInterval nowtimestamp = now.timeIntervalSince1970;
    
    if ((nowtimestamp - timestamp) < 3600) {  // 一小时内
        return @"刚刚";
    }else if (nowtimestamp - timestamp < 7200){ // 一小时前
        return @"一小时前";
    }else if ([date isToday]){ // 今天
        return @"今天";
    }else if ([date isYesterday]){
        return @"昨天";
    }else{
        return [NSString ys_stringWithDate:date format:format];
    }
    
}

- (NSString *)dealDomainPrefix{
    
    if ([self hasPrefix:@"http"]) {
        return self;
    }
    
    NSString *str = [NSString stringWithFormat:@"%@%@", kHttpDomain, self];
    
    return str;
}

//汉字的拼音
- (NSString *)pinyin{
    
    NSMutableString *str = [self mutableCopy];
    CFStringTransform(( CFMutableStringRef)str, NULL, kCFStringTransformMandarinLatin, NO);
    CFStringTransform((CFMutableStringRef)str, NULL, kCFStringTransformStripDiacritics, NO);
    
    return [str stringByReplacingOccurrencesOfString:@" " withString:@""];
}

+ (NSString *)ys_object2Json:(id)obj{
    
    NSError *error = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:obj options:NSJSONWritingPrettyPrinted error:&error];
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
    return jsonString;
    
}

- (NSDictionary *)ys_dictByJsonString{
    
    if (!self.length) {
        return nil;
    }
    NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding];
    
    NSDictionary *dict = nil;
    if ([data isKindOfClass:[NSData class]])
    {
        NSError *error = nil;
        dict = [NSJSONSerialization JSONObjectWithData:data
                                               options:0
                                                 error:&error];
        if (error) {
            
        }
    }
    return [dict isKindOfClass:[NSDictionary class]] ? dict : nil;
    
    
}

+ (NSString *)ys_addJsonWithJson1:(NSString *)json1 json2:(NSString *)json2{
    
    if (!json2.length) {
        return json1;
    }
    
    NSDictionary *dict1 = [json1 ys_dictByJsonString];
    NSDictionary *dict2 = [json2 ys_dictByJsonString];
    
    NSMutableDictionary *tmpDict = [dict1 mutableCopy];
    
    [tmpDict addEntriesFromDictionary:dict2];
    
    NSString *json = [NSString ys_object2Json:tmpDict];
    
    return json;
    
}


- (NSString *)ys_removeLast{
    
    if (self.length) {
        return [self substringWithRange:NSMakeRange(0, self.length - 1)];
    }else{
        return self;
    }
    
}

+ (NSString *)ys_num2str:(CGFloat)num{
    
    
    if (num) {
        return [NSString stringWithFormat:@"%.0f", num];
    }else if (1000 <= num && num< 1000000){
        
        num = num / 1000.0;
        
        return [NSString stringWithFormat:@"%.1fK", num];
    }else if (1000000 <= num && num < 1000000000){
        num = num / 1000000.0;
        
        return [NSString stringWithFormat:@"%.1fM", num];
    }else{
        num = num / 1000000000.0;
        
        return [NSString stringWithFormat:@"%.1fG", num];
    }
    
    
}

- (NSString *)ys_removeWhite{
    
    return [self stringByReplacingOccurrencesOfString:@" " withString:@""];
    
}

- (NSString *)ys_urlWithDomain{
    
    if (![self hasPrefix:@"http"]) {
        return [NSString stringWithFormat:@"%@%@", kHttpDomain, self];
    }else{
        return self;
    }
    
}

NSString * String(NSString *format, ...)
{
    va_list ap;
    va_start (ap, format);
    
    NSString *body = [[NSString alloc] initWithFormat:format arguments:ap];
    
    va_end (ap);
    
    return body;
}

+ (NSString *)stringDic:(NSDictionary *)dic{
    
    NSMutableDictionary * mDic = [NSMutableDictionary dictionaryWithDictionary:dic];
    //获取字典的所有keys
    NSArray * keys = [mDic allKeys];
    
    NSMutableString * lastStr = [NSMutableString string];
    
    //排序
    keys = [keys sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        return [obj1 compare:obj2 options:NSNumericSearch];
    }];
    //拼接字符串
    for (int j = 0; j < keys.count; j ++){
        NSString *string;
        if (j == 0){
            //拼接时加？
            string = [NSString stringWithFormat:@"%@=%@", keys[j], mDic[keys[j]]];
        }else{
            //拼接时加&
            string = [NSString stringWithFormat:@"|%@=%@", keys[j], mDic[keys[j]]];
        }
        //拼接字符串
        [lastStr appendString:string];
        
    }
    
    if ([GlobalAccess getToken] && [GlobalAccess getToken].length > 0) {
        return [String(@"%@%@%@",LM_API_APPKEY,[GlobalAccess getToken],lastStr) ner_md5];
    }else{
        return [String(@"%@%@",LM_API_APPKEY,lastStr) ner_md5];
    }
}

@end
