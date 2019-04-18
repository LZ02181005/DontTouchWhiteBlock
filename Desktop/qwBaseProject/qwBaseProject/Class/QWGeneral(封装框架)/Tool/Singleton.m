//
//  Singleton.m
//  AFNetworkingTool
//
//  Created by 崔露凯 on 15/11/15.
//  Copyright © 2015年 崔露凯. All rights reserved.
//

#import "Singleton.h"
#import "UserDefaultsUtil.h"

@implementation Singleton


kSINGLWTON_M


- (NSString *)phpSessionId {

    
    if (_phpSessionId == nil || [_phpSessionId isEqualToString:@""]) {
        NSString *cookie = [UserDefaultsUtil getUsetDefaultCookie];
        if (cookie) {
            _phpSessionId = cookie;
        }
        else {
            _phpSessionId = @"";
        }
    }
    
    return _phpSessionId;
}


- (NSString *)registrationID{
    if (_registrationID.length) {
        return _registrationID;
    }else{
        return @"";
    }
}

@end
