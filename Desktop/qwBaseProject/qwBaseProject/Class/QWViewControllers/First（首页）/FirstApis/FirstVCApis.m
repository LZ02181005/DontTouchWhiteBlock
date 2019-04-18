//
//  FirstVCApis.m
//  qwBaseProject
//
//  Created by L.Ronaldo on 2019/4/18.
//  Copyright © 2019 apple. All rights reserved.
//

#import "FirstVCApis.h"

@implementation FirstVCApis

- (void)getUserInfosWithSuccessCallBack:(ApiRequestCallBack)callback{
    self.callback = callback;
    self.params[@"token"] = [GlobalAccess getToken];
    self.params[@"userId"] = [GlobalAccess getUserId];
    
    [self doRequestWithBaseUrl:@"api/borrow/findIndex.htm" SuccessBlock:^(id responseObj) {
        
    }];
}

@end
