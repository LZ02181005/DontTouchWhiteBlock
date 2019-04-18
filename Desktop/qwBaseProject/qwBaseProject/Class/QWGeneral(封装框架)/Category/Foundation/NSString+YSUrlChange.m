//
//  NSString+YSUrlChange.m
//  DFCJlst
//
//  Created by ios开发 on 2017/12/4.
//  Copyright © 2017年 ios开发. All rights reserved.
//

#import "NSString+YSUrlChange.h"

@implementation NSString (YSUrlChange)

- (NSString *)URLEncodedString
{
    
    NSString *encodedString = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,(CFStringRef)self,(CFStringRef)@"!$&'()*+,-./:;=?@_~%#[]",NULL,kCFStringEncodingUTF8));
    return encodedString;
    
}
@end
